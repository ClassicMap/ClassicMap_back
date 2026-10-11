-- 쇼스타코비치 작품을 출판 단위로 다시 짠다(카탈로그: Op.). 작품 215개(묶음 33, 다악장 67, 낱곡 115),
-- 새 작품 71개, 기존 작품 144개(seed 제목 고침 143개), part 533개, 그 아래 48개,
-- 기존 part 고쳐 씀 11개, 기존 작품 연결 4개. 카탈로그에 대응이 없는 seed 111개는 목록에서 숨긴다.
--
-- 정한 것
--   위키백과 연대순 표(McBurney)를 따른다. 민요 편곡은 뺀다. 영화·무대 음악은 part 없이 두고 「카운터플랜의 노래」는 대목으로 남긴다.
--   319 「왈츠 2번 (재즈 모음곡 2번)」은 <버라이어티 오케스트라 모음곡 1번> 7번 part 로 잇는다(제목은 그대로).
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

-- Op. 1 관현악을 위한 스케르초 F#단조

UPDATE pieces piece
SET piece.title = '관현악을 위한 스케르초 F#단조', piece.title_en = 'Scherzo in F# minor',
    piece.type = 'song', piece.opus_number = 'Op. 1',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13279 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 13279 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 2 8개의 전주곡

UPDATE pieces piece
SET piece.title = '8개의 전주곡', piece.title_en = 'Eight Preludes, Op. 2',
    piece.type = 'album', piece.opus_number = 'Op. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13543 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 13543 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Agitato', part.name_en = 'No. 1. Agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13543 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2c5f6000-335b-4d6c-ac20-5e6b1e4b2533' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c5f6000-335b-4d6c-ac20-5e6b1e4b2533', 1, NULL, 'Agitato', 'No. 1. Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13543 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c5f6000-335b-4d6c-ac20-5e6b1e4b2533'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'No. 2. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13543 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:bf051c27-1951-4ff8-ac03-d269221c198f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf051c27-1951-4ff8-ac03-d269221c198f', 2, NULL, 'Andante', 'No. 2. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13543 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf051c27-1951-4ff8-ac03-d269221c198f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro non troppo e furioso', part.name_en = 'No. 3. Allegro non troppo e furioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13543 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b61685ce-84ee-42ec-847a-76d0b6fcb1c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b61685ce-84ee-42ec-847a-76d0b6fcb1c8', 3, NULL, 'Allegro non troppo e furioso', 'No. 3. Allegro non troppo e furioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13543 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61685ce-84ee-42ec-847a-76d0b6fcb1c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'No. 4. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13543 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f554a9f2-a55e-46d1-9556-487220cca754' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f554a9f2-a55e-46d1-9556-487220cca754', 4, NULL, 'Allegretto', 'No. 4. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13543 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f554a9f2-a55e-46d1-9556-487220cca754'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro molto', part.name_en = 'No. 5. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13543 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8ba59b7f-ba52-4d13-ae42-d91645751c22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ba59b7f-ba52-4d13-ae42-d91645751c22', 5, NULL, 'Allegro molto', 'No. 5. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13543 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ba59b7f-ba52-4d13-ae42-d91645751c22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'No. 6. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13543 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ceffb75e-6a1a-4c2a-aa5a-d706a04d39f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ceffb75e-6a1a-4c2a-aa5a-d706a04d39f2', 6, NULL, 'Andante', 'No. 6. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13543 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceffb75e-6a1a-4c2a-aa5a-d706a04d39f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'No. 7. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13543 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:55b30308-4f10-4778-a5ef-fe33cf26582b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55b30308-4f10-4778-a5ef-fe33cf26582b', 7, NULL, 'Moderato', 'No. 7. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13543 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55b30308-4f10-4778-a5ef-fe33cf26582b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'No. 8. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13543 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:912c6287-487d-4908-93a4-3ef803199d04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:912c6287-487d-4908-93a4-3ef803199d04', 8, NULL, 'Allegretto', 'No. 8. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13543 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:912c6287-487d-4908-93a4-3ef803199d04'
);


-- Op. 3 관현악을 위한 주제와 변주 B♭장조

UPDATE pieces piece
SET piece.title = '관현악을 위한 주제와 변주 B♭장조', piece.title_en = 'Theme and Variations in B♭ major',
    piece.type = 'song', piece.opus_number = 'Op. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1922, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13103 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1922
WHERE piece.id = 13103 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 4 크릴로프의 2개의 우화

UPDATE pieces piece
SET piece.title = '크릴로프의 2개의 우화', piece.title_en = 'Two Fables of Krylov',
    piece.type = 'album', piece.opus_number = 'Op. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1924, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12986 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1924
WHERE piece.id = 12986 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '잠자리와 개미', part.name_en = 'The Dragonfly and the Ant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12986 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:108992f3-9b06-4f25-a9e4-ba24fb91f779' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:108992f3-9b06-4f25-a9e4-ba24fb91f779', 1, NULL, '잠자리와 개미', 'The Dragonfly and the Ant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12986 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:108992f3-9b06-4f25-a9e4-ba24fb91f779'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '당나귀와 꾀꼬리', part.name_en = 'The Ass and the Nightingale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12986 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:919fca8f-f253-4e11-81a4-3ce9a35ac409' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:919fca8f-f253-4e11-81a4-3ce9a35ac409', 2, NULL, '당나귀와 꾀꼬리', 'The Ass and the Nightingale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12986 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:919fca8f-f253-4e11-81a4-3ce9a35ac409'
);


-- Op. 5 3개의 환상적인 춤곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 환상적인 춤곡', 'Three Fantastic Dances', 'album', 'Op. 5', NULL, NULL, 1922, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 환상적인 춤곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e815f4b9-f912-47b1-a218-74e77c93fb1d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e815f4b9-f912-47b1-a218-74e77c93fb1d'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '3개의 환상적인 춤곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e815f4b9-f912-47b1-a218-74e77c93fb1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aee06db9-79ce-3b56-9b30-a9284a688218', 1, NULL, '행진곡 C장조', 'No. 1. March in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '3개의 환상적인 춤곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aee06db9-79ce-3b56-9b30-a9284a688218'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47a0fb59-2678-327a-a849-aaf74b00c9e9', 2, NULL, '왈츠 G장조', 'No. 2. Waltz in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '3개의 환상적인 춤곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47a0fb59-2678-327a-a849-aaf74b00c9e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dafe8b1-edcd-31ee-b113-15ebc5974c85', 3, NULL, '폴카 C장조', 'No. 3. Polka in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '3개의 환상적인 춤곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dafe8b1-edcd-31ee-b113-15ebc5974c85'
);


-- Op. 6 2대의 피아노를 위한 모음곡 F#단조

UPDATE pieces piece
SET piece.title = '2대의 피아노를 위한 모음곡 F#단조', piece.title_en = 'Suite in F# minor for Two Pianos',
    piece.type = 'album', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1922, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12195 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1922
WHERE piece.id = 12195 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12195 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d26fcade-9e24-4152-b4c4-ff3f353432c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d26fcade-9e24-4152-b4c4-ff3f353432c5', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12195 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26fcade-9e24-4152-b4c4-ff3f353432c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '환상적인 춤', part.name_en = 'II. Fantastic Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12195 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1c70d988-82ad-4d25-953e-2a9385cfb9ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c70d988-82ad-4d25-953e-2a9385cfb9ee', 2, 'II', '환상적인 춤', 'II. Fantastic Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12195 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c70d988-82ad-4d25-953e-2a9385cfb9ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '녹턴', part.name_en = 'III. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12195 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:45a1bcba-5a46-4cff-b865-bdd0f1c3ab9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45a1bcba-5a46-4cff-b865-bdd0f1c3ab9b', 3, 'III', '녹턴', 'III. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12195 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45a1bcba-5a46-4cff-b865-bdd0f1c3ab9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레', part.name_en = 'IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12195 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:848a2153-0da5-41f8-b229-56cc963a687d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:848a2153-0da5-41f8-b229-56cc963a687d', 4, 'IV', '피날레', 'IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12195 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:848a2153-0da5-41f8-b229-56cc963a687d'
);


-- Op. 7 관현악을 위한 스케르초 E♭장조

UPDATE pieces piece
SET piece.title = '관현악을 위한 스케르초 E♭장조', piece.title_en = 'Scherzo in E♭ major',
    piece.type = 'song', piece.opus_number = 'Op. 7',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1924, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12272 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1924
WHERE piece.id = 12272 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 8 피아노 3중주 1번 C단조

UPDATE pieces piece
SET piece.title = '피아노 3중주 1번 C단조', piece.title_en = 'Piano Trio No. 1 in C minor',
    piece.type = 'song', piece.opus_number = 'Op. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1923, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13174 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1923
WHERE piece.id = 13174 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 10 교향곡 1번 F단조

UPDATE pieces piece
SET piece.title = '교향곡 1번 F단조', piece.title_en = 'Symphony No. 1 in F minor',
    piece.type = 'album', piece.opus_number = 'Op. 10',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1925, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12853 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1925
WHERE piece.id = 12853 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto – Allegro ma non troppo', part.name_en = 'I. Allegretto – Allegro ma non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12853 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c676932b-83c3-3c2b-8e45-009bea8b7220' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c676932b-83c3-3c2b-8e45-009bea8b7220', 1, 'I', 'Allegretto – Allegro ma non troppo', 'I. Allegretto – Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12853 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c676932b-83c3-3c2b-8e45-009bea8b7220'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12853 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b28ff4d3-4931-36c6-8ca6-ab5d7659ee85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b28ff4d3-4931-36c6-8ca6-ab5d7659ee85', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12853 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b28ff4d3-4931-36c6-8ca6-ab5d7659ee85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento – Largo', part.name_en = 'III. Lento – Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12853 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:83fb2d04-bc44-39fb-9c29-c5da05cdec9b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83fb2d04-bc44-39fb-9c29-c5da05cdec9b', 3, 'III', 'Lento – Largo', 'III. Lento – Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12853 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83fb2d04-bc44-39fb-9c29-c5da05cdec9b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro molto – Lento – Allegro molto', part.name_en = 'IV. Allegro molto – Lento – Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12853 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c16d27f7-1d81-3690-b681-078e36d07d2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c16d27f7-1d81-3690-b681-078e36d07d2d', 4, 'IV', 'Allegro molto – Lento – Allegro molto', 'IV. Allegro molto – Lento – Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12853 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c16d27f7-1d81-3690-b681-078e36d07d2d'
);


-- Op. 11 현악 8중주를 위한 2개의 소품

UPDATE pieces piece
SET piece.title = '현악 8중주를 위한 2개의 소품', piece.title_en = 'Two Pieces for String Octet',
    piece.type = 'album', piece.opus_number = 'Op. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1925, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13667 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1925
WHERE piece.id = 13667 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13667 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:16fdf106-cc45-3666-937b-0e00ff9a7382' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16fdf106-cc45-3666-937b-0e00ff9a7382', 1, NULL, '전주곡', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13667 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16fdf106-cc45-3666-937b-0e00ff9a7382'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '스케르초', part.name_en = 'Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13667 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b905395d-bccb-337d-89f3-4073ee081d19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b905395d-bccb-337d-89f3-4073ee081d19', 2, NULL, '스케르초', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13667 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b905395d-bccb-337d-89f3-4073ee081d19'
);


-- Op. 12 피아노 소나타 1번

UPDATE pieces piece
SET piece.title = '피아노 소나타 1번', piece.title_en = 'Piano Sonata No. 1',
    piece.type = 'album', piece.opus_number = 'Op. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1926, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12063 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1926
WHERE piece.id = 12063 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12063 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4cdd693d-ff15-4003-b61b-68b9cedde2c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cdd693d-ff15-4003-b61b-68b9cedde2c9', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12063 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cdd693d-ff15-4003-b61b-68b9cedde2c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Meno mosso', part.name_en = 'II. Meno mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12063 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:638d4b32-dae5-4185-90a0-7d96fb4ed700' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:638d4b32-dae5-4185-90a0-7d96fb4ed700', 2, 'II', 'Meno mosso', 'II. Meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12063 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:638d4b32-dae5-4185-90a0-7d96fb4ed700'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12063 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:727c9ccb-25c6-4bc5-a4a8-b2dc11dc931f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:727c9ccb-25c6-4bc5-a4a8-b2dc11dc931f', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12063 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:727c9ccb-25c6-4bc5-a4a8-b2dc11dc931f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro – Poco meno mosso', part.name_en = 'IV. Allegro – Poco meno mosso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12063 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:cd4e0b77-f8e4-444f-b794-031d1682a321' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd4e0b77-f8e4-444f-b794-031d1682a321', 4, 'IV', 'Allegro – Poco meno mosso', 'IV. Allegro – Poco meno mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12063 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd4e0b77-f8e4-444f-b794-031d1682a321'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Adagio – Lento', part.name_en = 'V. Adagio – Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12063 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0aa9a23d-0b7b-42ec-b166-a343fe78524a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aa9a23d-0b7b-42ec-b166-a343fe78524a', 5, 'V', 'Adagio – Lento', 'V. Adagio – Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12063 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aa9a23d-0b7b-42ec-b166-a343fe78524a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Allegro – Meno mosso – Moderato – Allegro', part.name_en = 'VI. Allegro – Meno mosso – Moderato – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12063 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:16cdf885-2036-4a24-bce2-c994ee6a6dd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16cdf885-2036-4a24-bce2-c994ee6a6dd8', 6, 'VI', 'Allegro – Meno mosso – Moderato – Allegro', 'VI. Allegro – Meno mosso – Moderato – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12063 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16cdf885-2036-4a24-bce2-c994ee6a6dd8'
);


-- Op. 13 피아노 소품집 <아포리즘>

UPDATE pieces piece
SET piece.title = '피아노 소품집 <아포리즘>', piece.title_en = 'Aphorisms',
    piece.type = 'album', piece.opus_number = 'Op. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1927, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12678 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1927
WHERE piece.id = 12678 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '레치타티보', part.name_en = 'Recitative',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:724e4bbe-b656-32f2-8715-43ca1cb5a02f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:724e4bbe-b656-32f2-8715-43ca1cb5a02f', 1, NULL, '레치타티보', 'Recitative', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:724e4bbe-b656-32f2-8715-43ca1cb5a02f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '세레나데', part.name_en = 'Serenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:178e94cc-bce9-3e74-b774-6ad830cfa260' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:178e94cc-bce9-3e74-b774-6ad830cfa260', 2, NULL, '세레나데', 'Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:178e94cc-bce9-3e74-b774-6ad830cfa260'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '녹턴', part.name_en = 'Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:66095acd-edda-3142-ab3b-c2ed4f4c01fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66095acd-edda-3142-ab3b-c2ed4f4c01fa', 3, NULL, '녹턴', 'Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66095acd-edda-3142-ab3b-c2ed4f4c01fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '엘레지', part.name_en = 'Elegy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:534173f6-676e-37c2-bbda-0e263df695c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:534173f6-676e-37c2-bbda-0e263df695c3', 4, NULL, '엘레지', 'Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:534173f6-676e-37c2-bbda-0e263df695c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '장송 행진곡', part.name_en = 'Funeral March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:aa07db5d-18c9-310f-bb2a-9f365c276903' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa07db5d-18c9-310f-bb2a-9f365c276903', 5, NULL, '장송 행진곡', 'Funeral March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa07db5d-18c9-310f-bb2a-9f365c276903'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '에튀드', part.name_en = 'Etude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5e22b01d-4c88-3ed8-8360-887ee5f3072a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e22b01d-4c88-3ed8-8360-887ee5f3072a', 6, NULL, '에튀드', 'Etude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e22b01d-4c88-3ed8-8360-887ee5f3072a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '죽음의 춤', part.name_en = 'Dance of Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c2358766-0c6a-39ed-aab5-af6c52b68c66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2358766-0c6a-39ed-aab5-af6c52b68c66', 7, NULL, '죽음의 춤', 'Dance of Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2358766-0c6a-39ed-aab5-af6c52b68c66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '카논', part.name_en = 'Canon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6a7d659d-d887-3825-af4f-7e246f64eb07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a7d659d-d887-3825-af4f-7e246f64eb07', 8, NULL, '카논', 'Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a7d659d-d887-3825-af4f-7e246f64eb07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '전설', part.name_en = 'Legend',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:648816b0-0fb7-38b7-b5de-be6efe95ebe3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:648816b0-0fb7-38b7-b5de-be6efe95ebe3', 9, NULL, '전설', 'Legend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:648816b0-0fb7-38b7-b5de-be6efe95ebe3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '자장가', part.name_en = 'Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12678 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:67de8852-3c1c-3de1-95e4-d140389abb0f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67de8852-3c1c-3de1-95e4-d140389abb0f', 10, NULL, '자장가', 'Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12678 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67de8852-3c1c-3de1-95e4-d140389abb0f'
);


-- Op. 14 교향곡 2번 B장조 "10월에 바침"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 B장조 "10월에 바침"', 'Symphony No. 2 in B major "To October"', 'album', 'Op. 14', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 B장조 "10월에 바침"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08bb00db-6491-37e3-b688-8a30cbfa8cdf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08bb00db-6491-37e3-b688-8a30cbfa8cdf'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 2번 B장조 "10월에 바침"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08bb00db-6491-37e3-b688-8a30cbfa8cdf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c04c8778-7c84-44fa-9a53-d450f4dab3d8', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 2번 B장조 "10월에 바침"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c04c8778-7c84-44fa-9a53-d450f4dab3d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bd23d76-31dc-4471-b9e7-e795f7526361', 2, 'II', '♩ = 152', 'II. ♩ = 152', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 2번 B장조 "10월에 바침"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bd23d76-31dc-4471-b9e7-e795f7526361'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1031c87b-084a-4b3d-adfd-7c8cb8ab9740', 3, 'III', 'Poco meno mosso. Allegro molto', 'III. Poco meno mosso. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 2번 B장조 "10월에 바침"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1031c87b-084a-4b3d-adfd-7c8cb8ab9740'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ca9a412-89b3-4731-b793-2d17fc9fe078', 4, 'IV', '합창 "10월에 바침"', 'IV. Chorus "To October"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 2번 B장조 "10월에 바침"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ca9a412-89b3-4731-b793-2d17fc9fe078'
);


-- Op. 15 오페라 <코>

UPDATE pieces piece
SET piece.title = '오페라 <코>', piece.title_en = 'The Nose',
    piece.type = 'song', piece.opus_number = 'Op. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1928, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12212 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1928
WHERE piece.id = 12212 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 15a 오페라 모음곡 <코>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 모음곡 <코>', 'Suite from The Nose', 'song', 'Op. 15a', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 모음곡 <코>'
);


-- Op. 18 영화음악 <신 바빌론>

UPDATE pieces piece
SET piece.title = '영화음악 <신 바빌론>', piece.title_en = 'The New Babylon',
    piece.type = 'song', piece.opus_number = 'Op. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12521 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 12521 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 19 부수음악 <빈대>

UPDATE pieces piece
SET piece.title = '부수음악 <빈대>', piece.title_en = 'The Bedbug',
    piece.type = 'song', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12423 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 12423 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 20 교향곡 3번 E♭장조 "5월 1일"

UPDATE pieces piece
SET piece.title = '교향곡 3번 E♭장조 "5월 1일"', piece.title_en = 'Symphony No. 3 in E♭ major "The First of May"',
    piece.type = 'album', piece.opus_number = 'Op. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13592 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 13592 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto – Allegro', part.name_en = 'I. Allegretto – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13592 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7168ee0d-4b65-4ec6-921d-1fbefd0a1ba7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7168ee0d-4b65-4ec6-921d-1fbefd0a1ba7', 1, 'I', 'Allegretto – Allegro', 'I. Allegretto – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13592 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7168ee0d-4b65-4ec6-921d-1fbefd0a1ba7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13592 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ef994295-dcc3-4837-90e5-e39e6f41c848' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef994295-dcc3-4837-90e5-e39e6f41c848', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13592 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef994295-dcc3-4837-90e5-e39e6f41c848'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13592 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:98df0c46-4633-4142-ad25-3cca030f1908' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98df0c46-4633-4142-ad25-3cca030f1908', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13592 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98df0c46-4633-4142-ad25-3cca030f1908'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Moderato "V pervoye, pervoye maya"', part.name_en = 'IV. Moderato "V pervoye, pervoye maya"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13592 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:08885de1-ebbe-40c0-a5d0-ef09b1949536' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08885de1-ebbe-40c0-a5d0-ef09b1949536', 4, 'IV', 'Moderato "V pervoye, pervoye maya"', 'IV. Moderato "V pervoye, pervoye maya"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13592 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08885de1-ebbe-40c0-a5d0-ef09b1949536'
);


-- Op. 21 일본 시인의 시에 의한 6개의 로망스

UPDATE pieces piece
SET piece.title = '일본 시인의 시에 의한 6개의 로망스', piece.title_en = 'Six Romances on Texts by Japanese Poets',
    piece.type = 'album', piece.opus_number = 'Op. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12975 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 12975 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '사랑', part.name_en = 'Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12975 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:53a895ee-a508-48b2-85ce-06fb9b01b572' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53a895ee-a508-48b2-85ce-06fb9b01b572', 1, NULL, '사랑', 'Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12975 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53a895ee-a508-48b2-85ce-06fb9b01b572'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '자살하기 전에', part.name_en = 'Before Suicide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12975 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f5c83e88-9811-4847-a5fa-08a61dd39636' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5c83e88-9811-4847-a5fa-08a61dd39636', 2, NULL, '자살하기 전에', 'Before Suicide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12975 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5c83e88-9811-4847-a5fa-08a61dd39636'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '무례한 눈길', part.name_en = 'An Immodest Glance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12975 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ec422da0-8c03-44c4-acd4-49009e2190d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec422da0-8c03-44c4-acd4-49009e2190d3', 3, NULL, '무례한 눈길', 'An Immodest Glance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12975 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec422da0-8c03-44c4-acd4-49009e2190d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '처음이자 마지막', part.name_en = 'The First and the Last Time',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12975 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:9f5873fe-3814-4886-8ff3-ab05da699cce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f5873fe-3814-4886-8ff3-ab05da699cce', 4, NULL, '처음이자 마지막', 'The First and the Last Time', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12975 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f5873fe-3814-4886-8ff3-ab05da699cce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '희망 없는 사랑', part.name_en = 'Love Without Hope',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12975 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d371ddb0-595e-4a06-8303-98b9fe9a859b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d371ddb0-595e-4a06-8303-98b9fe9a859b', 5, NULL, '희망 없는 사랑', 'Love Without Hope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12975 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d371ddb0-595e-4a06-8303-98b9fe9a859b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '죽음', part.name_en = 'Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12975 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:51ecc1d4-c284-4f8a-a705-28e2a6b0cd42' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51ecc1d4-c284-4f8a-a705-28e2a6b0cd42', 6, NULL, '죽음', 'Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12975 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51ecc1d4-c284-4f8a-a705-28e2a6b0cd42'
);


-- Op. 22 발레 <황금 시대>

UPDATE pieces piece
SET piece.title = '발레 <황금 시대>', piece.title_en = 'The Golden Age',
    piece.type = 'song', piece.opus_number = 'Op. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1930, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12075 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1930
WHERE piece.id = 12075 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 22a 발레 모음곡 <황금 시대>

UPDATE pieces piece
SET piece.title = '발레 모음곡 <황금 시대>', piece.title_en = 'Suite from The Golden Age',
    piece.type = 'album', piece.opus_number = 'Op. 22a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1930, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12586 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1930
WHERE piece.id = 12586 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12586 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:00a938bc-be44-35ba-ba75-69ead73a118b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00a938bc-be44-35ba-ba75-69ead73a118b', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12586 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00a938bc-be44-35ba-ba75-69ead73a118b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12586 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e87e7f73-26c8-3131-ae6c-f50aa8cca5be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e87e7f73-26c8-3131-ae6c-f50aa8cca5be', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12586 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e87e7f73-26c8-3131-ae6c-f50aa8cca5be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '폴카', part.name_en = 'III. Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12586 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1d4651af-e1bb-33e8-bbc4-20937f4bb44a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d4651af-e1bb-33e8-bbc4-20937f4bb44a', 3, 'III', '폴카', 'III. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12586 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d4651af-e1bb-33e8-bbc4-20937f4bb44a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '춤', part.name_en = 'IV. Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12586 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e02d992b-a42e-3e07-a43d-8664ca213532' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e02d992b-a42e-3e07-a43d-8664ca213532', 4, 'IV', '춤', 'IV. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12586 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e02d992b-a42e-3e07-a43d-8664ca213532'
);


-- Op. 23 드레셀의 오페라 <가련한 콜럼버스>를 위한 2개의 소품

UPDATE pieces piece
SET piece.title = '드레셀의 오페라 <가련한 콜럼버스>를 위한 2개의 소품', piece.title_en = 'Two Pieces for Erwin Dressel''s Opera "Armer Columbus"',
    piece.type = 'album', piece.opus_number = 'Op. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13586 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 13586 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서곡', part.name_en = 'Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13586 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b6805ca7-efc1-421f-9921-c1e02dfb2d60' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6805ca7-efc1-421f-9921-c1e02dfb2d60', 1, NULL, '서곡', 'Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13586 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6805ca7-efc1-421f-9921-c1e02dfb2d60'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '피날레', part.name_en = 'Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13586 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:9e1db1d9-7380-4b06-9ac6-887925acd6cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e1db1d9-7380-4b06-9ac6-887925acd6cc', 2, NULL, '피날레', 'Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13586 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e1db1d9-7380-4b06-9ac6-887925acd6cc'
);


-- Op. 24 부수음악 <총성>

UPDATE pieces piece
SET piece.title = '부수음악 <총성>', piece.title_en = 'The Gunshot',
    piece.type = 'song', piece.opus_number = 'Op. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1929, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12017 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1929
WHERE piece.id = 12017 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 25 부수음악 <처녀지>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <처녀지>', 'Virgin Soil', 'song', 'Op. 25', NULL, NULL, 1930, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <처녀지>'
);


-- Op. 26 영화음악 <홀로>

UPDATE pieces piece
SET piece.title = '영화음악 <홀로>', piece.title_en = 'Alone',
    piece.type = 'song', piece.opus_number = 'Op. 26',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12771 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 12771 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 27 발레 <볼트>

UPDATE pieces piece
SET piece.title = '발레 <볼트>', piece.title_en = 'The Bolt',
    piece.type = 'song', piece.opus_number = 'Op. 27',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12283 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 12283 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 27a 발레 모음곡 <볼트>

UPDATE pieces piece
SET piece.title = '발레 모음곡 <볼트>', piece.title_en = 'Suite from The Bolt (Ballet Suite No. 5)',
    piece.type = 'album', piece.opus_number = 'Op. 27a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12587 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 12587 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서곡', part.name_en = 'I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12587 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5ce3404c-5cf1-43c0-935a-967773c80009' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ce3404c-5cf1-43c0-935a-967773c80009', 1, 'I', '서곡', 'I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12587 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ce3404c-5cf1-43c0-935a-967773c80009'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '관료', part.name_en = 'II. The Bureaucrat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12587 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:84375317-5adf-4355-b03c-13554c701302' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84375317-5adf-4355-b03c-13554c701302', 2, 'II', '관료', 'II. The Bureaucrat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12587 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84375317-5adf-4355-b03c-13554c701302'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '짐마차꾼의 춤', part.name_en = 'III. Dance of the Drayman',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12587 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d8dfca75-0237-4c2d-8a8b-67f61b8d29d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8dfca75-0237-4c2d-8a8b-67f61b8d29d1', 3, 'III', '짐마차꾼의 춤', 'III. Dance of the Drayman', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12587 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8dfca75-0237-4c2d-8a8b-67f61b8d29d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '코젤코프와 친구들의 춤', part.name_en = 'IV. Kozelkov''s Dance with Friends',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12587 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b3128724-46ef-41db-9b1c-a032283bb43d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3128724-46ef-41db-9b1c-a032283bb43d', 4, 'IV', '코젤코프와 친구들의 춤', 'IV. Kozelkov''s Dance with Friends', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12587 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3128724-46ef-41db-9b1c-a032283bb43d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '간주곡', part.name_en = 'V. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12587 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:26bb027d-65c0-4518-9929-cd38dd35de0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26bb027d-65c0-4518-9929-cd38dd35de0e', 5, 'V', '간주곡', 'V. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12587 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26bb027d-65c0-4518-9929-cd38dd35de0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '식민지 노예 여인의 춤', part.name_en = 'VI. Dance of the Colonial Slave Girl',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12587 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:da32f335-d098-4522-8a31-179c3ff5dafe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da32f335-d098-4522-8a31-179c3ff5dafe', 6, 'VI', '식민지 노예 여인의 춤', 'VI. Dance of the Colonial Slave Girl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12587 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da32f335-d098-4522-8a31-179c3ff5dafe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '타협주의자', part.name_en = 'VII. The Conciliator',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12587 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5bc74147-f54b-4656-a0b2-2a4ed747b659' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bc74147-f54b-4656-a0b2-2a4ed747b659', 7, 'VII', '타협주의자', 'VII. The Conciliator', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12587 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bc74147-f54b-4656-a0b2-2a4ed747b659'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '모두의 춤과 아포테오시스', part.name_en = 'VIII. General Dance and Apotheosis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12587 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:77c1f35d-7e72-4791-8401-f6eb25a0c728' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77c1f35d-7e72-4791-8401-f6eb25a0c728', 8, 'VIII', '모두의 춤과 아포테오시스', 'VIII. General Dance and Apotheosis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12587 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77c1f35d-7e72-4791-8401-f6eb25a0c728'
);


-- Op. 28 부수음악 <통치하라, 브리타니아!>

UPDATE pieces piece
SET piece.title = '부수음악 <통치하라, 브리타니아!>', piece.title_en = 'Rule, Britannia!',
    piece.type = 'song', piece.opus_number = 'Op. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12314 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 12314 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 29 오페라 <므첸스크의 맥베스 부인>

UPDATE pieces piece
SET piece.title = '오페라 <므첸스크의 맥베스 부인>', piece.title_en = 'Lady Macbeth of the Mtsensk District',
    piece.type = 'song', piece.opus_number = 'Op. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12092 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 12092 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 30 영화음악 <황금 산맥>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <황금 산맥>', 'Golden Mountains', 'song', 'Op. 30', NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <황금 산맥>'
);


-- Op. 30a 영화 모음곡 <황금 산맥>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <황금 산맥>', piece.title_en = 'Suite from Golden Mountains',
    piece.type = 'album', piece.opus_number = 'Op. 30a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13187 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 13187 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주. Moderato', part.name_en = 'I. Introduction. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13187 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7e1f7cea-72a0-4370-9457-522c905466c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e1f7cea-72a0-4370-9457-522c905466c7', 1, 'I', '서주. Moderato', 'I. Introduction. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13187 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e1f7cea-72a0-4370-9457-522c905466c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '왈츠. Andante', part.name_en = 'II. Waltz. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13187 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:54a1d2a2-9c98-4d64-b0f1-501e27704e1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54a1d2a2-9c98-4d64-b0f1-501e27704e1f', 2, 'II', '왈츠. Andante', 'II. Waltz. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13187 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54a1d2a2-9c98-4d64-b0f1-501e27704e1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '푸가. Largo – Allegro', part.name_en = 'III. Fugue. Largo – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13187 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:846824e4-1390-46a6-844d-d1f2f91ae25f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:846824e4-1390-46a6-844d-d1f2f91ae25f', 3, 'III', '푸가. Largo – Allegro', 'III. Fugue. Largo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13187 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:846824e4-1390-46a6-844d-d1f2f91ae25f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '간주곡. Andante', part.name_en = 'IV. Intermezzo. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13187 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:211d3512-7baf-451c-a608-03ccb392fd9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:211d3512-7baf-451c-a608-03ccb392fd9e', 4, 'IV', '간주곡. Andante', 'IV. Intermezzo. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13187 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:211d3512-7baf-451c-a608-03ccb392fd9e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '장송 행진곡. Largo', part.name_en = 'V. Funeral March. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13187 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5b10c4da-e9e9-4ed5-96be-1c5fa0064ca9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b10c4da-e9e9-4ed5-96be-1c5fa0064ca9', 5, 'V', '장송 행진곡. Largo', 'V. Funeral March. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13187 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b10c4da-e9e9-4ed5-96be-1c5fa0064ca9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '피날레. Largo', part.name_en = 'VI. Finale. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13187 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d55c4121-b892-49a7-b89a-35aadabff8cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d55c4121-b892-49a7-b89a-35aadabff8cc', 6, 'VI', '피날레. Largo', 'VI. Finale. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13187 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d55c4121-b892-49a7-b89a-35aadabff8cc'
);


-- Op. 31 부수음악 <가정된 살인>

UPDATE pieces piece
SET piece.title = '부수음악 <가정된 살인>', piece.title_en = 'Hypothetically Murdered',
    piece.type = 'song', piece.opus_number = 'Op. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12434 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 12434 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 32 부수음악 <햄릿>

UPDATE pieces piece
SET piece.title = '부수음악 <햄릿>', piece.title_en = 'Hamlet (incidental music)',
    piece.type = 'song', piece.opus_number = 'Op. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12165 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 12165 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 32a 부수음악 모음곡 <햄릿>

UPDATE pieces piece
SET piece.title = '부수음악 모음곡 <햄릿>', piece.title_en = 'Suite from Hamlet (incidental music)',
    piece.type = 'album', piece.opus_number = 'Op. 32a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12689 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 12689 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주와 야경', part.name_en = 'I. Introduction and Night Patrol',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:21face86-19ea-466a-8934-aef430731faf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21face86-19ea-466a-8934-aef430731faf', 1, 'I', '서주와 야경', 'I. Introduction and Night Patrol', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21face86-19ea-466a-8934-aef430731faf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '장송 행진곡', part.name_en = 'II. Funeral March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2fcadb39-857e-4b2a-97c4-686f26549d3d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fcadb39-857e-4b2a-97c4-686f26549d3d', 2, 'II', '장송 행진곡', 'II. Funeral March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fcadb39-857e-4b2a-97c4-686f26549d3d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '팡파르와 춤곡', part.name_en = 'III. Flourish and Dance Music',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6cc70e88-e574-45c5-b977-1700ca4b000c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cc70e88-e574-45c5-b977-1700ca4b000c', 3, 'III', '팡파르와 춤곡', 'III. Flourish and Dance Music', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cc70e88-e574-45c5-b977-1700ca4b000c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '사냥', part.name_en = 'IV. The Hunt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2192df72-ede8-4baa-907a-562e37fe38cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2192df72-ede8-4baa-907a-562e37fe38cb', 4, 'IV', '사냥', 'IV. The Hunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2192df72-ede8-4baa-907a-562e37fe38cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '배우들의 판토마임', part.name_en = 'V. Pantomime of the Actors',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c7ddeabe-b79e-4ef3-87cb-fca17673bd3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7ddeabe-b79e-4ef3-87cb-fca17673bd3f', 5, 'V', '배우들의 판토마임', 'V. Pantomime of the Actors', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7ddeabe-b79e-4ef3-87cb-fca17673bd3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '행렬', part.name_en = 'VI. Procession',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4c5f0327-4592-43a3-81ca-486912faabd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c5f0327-4592-43a3-81ca-486912faabd9', 6, 'VI', '행렬', 'VI. Procession', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c5f0327-4592-43a3-81ca-486912faabd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '음악 판토마임', part.name_en = 'VII. Musical Pantomime',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e8b62d36-bd2a-4592-9228-1c64970f0133' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8b62d36-bd2a-4592-9228-1c64970f0133', 7, 'VII', '음악 판토마임', 'VII. Musical Pantomime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8b62d36-bd2a-4592-9228-1c64970f0133'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '연회', part.name_en = 'VIII. Banquet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:cd4fc324-eebc-4f15-a01a-eca3fe9c0b21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd4fc324-eebc-4f15-a01a-eca3fe9c0b21', 8, 'VIII', '연회', 'VIII. Banquet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd4fc324-eebc-4f15-a01a-eca3fe9c0b21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = '오필리아의 노래', part.name_en = 'IX. Ophelia''s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:956cf002-e7dc-48a1-b7e8-1e4f4e2e1f76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:956cf002-e7dc-48a1-b7e8-1e4f4e2e1f76', 9, 'IX', '오필리아의 노래', 'IX. Ophelia''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:956cf002-e7dc-48a1-b7e8-1e4f4e2e1f76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = '자장가', part.name_en = 'X. Cradle Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:689bbe19-9187-4dac-b418-6d5ca55cb6cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:689bbe19-9187-4dac-b418-6d5ca55cb6cb', 10, 'X', '자장가', 'X. Cradle Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:689bbe19-9187-4dac-b418-6d5ca55cb6cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = '레퀴엠', part.name_en = 'XI. Requiem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:296d3462-5380-45d9-8034-d7d5a2399986' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:296d3462-5380-45d9-8034-d7d5a2399986', 11, 'XI', '레퀴엠', 'XI. Requiem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:296d3462-5380-45d9-8034-d7d5a2399986'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = '시합', part.name_en = 'XII. Tournament',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0561634a-6244-48de-84d2-5e4423b73b50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0561634a-6244-48de-84d2-5e4423b73b50', 12, 'XII', '시합', 'XII. Tournament', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0561634a-6244-48de-84d2-5e4423b73b50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = '포틴브라스의 행진곡', part.name_en = 'XIII. Fortinbras''s March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12689 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1970e118-5a07-4178-9ce8-ffefbcce95f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1970e118-5a07-4178-9ce8-ffefbcce95f3', 13, 'XIII', '포틴브라스의 행진곡', 'XIII. Fortinbras''s March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12689 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1970e118-5a07-4178-9ce8-ffefbcce95f3'
);


-- Op. 33 영화음악 <카운터플랜>

UPDATE pieces piece
SET piece.title = '영화음악 <카운터플랜>', piece.title_en = 'Counterplan',
    piece.type = 'song', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12036 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 12036 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 34 24개의 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '24개의 전주곡', '24 Preludes, Op. 34', 'album', 'Op. 34', NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '24개의 전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20f2b3e3-1b4c-4345-9599-c93711997980'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20f2b3e3-1b4c-4345-9599-c93711997980'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20f2b3e3-1b4c-4345-9599-c93711997980'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64137aad-da8c-37b2-8e34-336243a4ac40', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64137aad-da8c-37b2-8e34-336243a4ac40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83aa957b-17ac-3b84-9f71-db6e76bcfeca', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83aa957b-17ac-3b84-9f71-db6e76bcfeca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c879590-6698-33e7-bf97-8bd510ba3910', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c879590-6698-33e7-bf97-8bd510ba3910'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf5ab937-522b-3ac7-9796-7a844c7e52a0', 4, NULL, 'E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf5ab937-522b-3ac7-9796-7a844c7e52a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1746d86-8cc2-3525-ae1f-ffa61999fec5', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1746d86-8cc2-3525-ae1f-ffa61999fec5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6db9881-658a-3673-9317-dc590130f09c', 6, NULL, 'B단조', 'No. 6 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6db9881-658a-3673-9317-dc590130f09c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ca184ca-0ea6-32f9-9ad9-0be238d3cc6f', 7, NULL, 'A장조', 'No. 7 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ca184ca-0ea6-32f9-9ad9-0be238d3cc6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db17d8e3-af3d-3ea9-9331-06e2b7670f48', 8, NULL, 'F#단조', 'No. 8 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db17d8e3-af3d-3ea9-9331-06e2b7670f48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4248a2f5-8607-35a0-bc72-70d84008d336', 9, NULL, 'E장조', 'No. 9 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4248a2f5-8607-35a0-bc72-70d84008d336'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56db6f86-591f-3245-ad74-c2fca5307831', 10, NULL, 'C#단조', 'No. 10 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56db6f86-591f-3245-ad74-c2fca5307831'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3de4a94b-cd00-36b2-a22d-389bbe3bacad', 11, NULL, 'B장조', 'No. 11 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3de4a94b-cd00-36b2-a22d-389bbe3bacad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e953d850-922a-3fcf-8605-917b493dc5bc', 12, NULL, 'G#단조', 'No. 12 in G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e953d850-922a-3fcf-8605-917b493dc5bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab3202cb-ab03-3783-abad-6f45834a6db2', 13, NULL, 'F#단조', 'No. 13 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab3202cb-ab03-3783-abad-6f45834a6db2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4da75ffb-7ec6-3e67-ac71-028ba9692171', 14, NULL, 'E♭단조', 'No. 14 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4da75ffb-7ec6-3e67-ac71-028ba9692171'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:716693e3-c7f5-3f5c-acf7-0a60266e15c2', 15, NULL, 'D♭장조', 'No. 15 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:716693e3-c7f5-3f5c-acf7-0a60266e15c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c4e260f-331a-3cec-8059-99a8fe38e29f', 16, NULL, 'B♭단조', 'No. 16 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c4e260f-331a-3cec-8059-99a8fe38e29f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14e0a640-9136-32c8-a5f7-f37f8a35c1c9', 17, NULL, 'A♭장조', 'No. 17 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14e0a640-9136-32c8-a5f7-f37f8a35c1c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:277f662d-140a-33dc-b1d0-f8c3e5fb8801', 18, NULL, 'F단조', 'No. 18 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:277f662d-140a-33dc-b1d0-f8c3e5fb8801'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fab39b6-98dc-3aab-b235-ec86f56e47e6', 19, NULL, 'E♭장조', 'No. 19 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fab39b6-98dc-3aab-b235-ec86f56e47e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f05807d-4f42-3eee-8084-093cdb1dcce3', 20, NULL, 'C단조', 'No. 20 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f05807d-4f42-3eee-8084-093cdb1dcce3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22010c07-34b3-3fca-8d00-fcd2db79e72d', 21, NULL, 'B♭장조', 'No. 21 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22010c07-34b3-3fca-8d00-fcd2db79e72d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ac44bbf-43ee-3104-a7c5-af49fa7dd252', 22, NULL, 'G단조', 'No. 22 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac44bbf-43ee-3104-a7c5-af49fa7dd252'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:120e960e-ced4-3f93-a070-e7c0cdb3be27', 23, NULL, 'F장조', 'No. 23 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:120e960e-ced4-3f93-a070-e7c0cdb3be27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e7aeb7b-4007-3bbf-b268-90d81ae79d2c', 24, NULL, 'D단조', 'No. 24 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '24개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e7aeb7b-4007-3bbf-b268-90d81ae79d2c'
);


-- Op. 35 피아노 협주곡 1번 C단조

UPDATE pieces piece
SET piece.title = '피아노 협주곡 1번 C단조', piece.title_en = 'Piano Concerto No. 1 in C minor',
    piece.type = 'album', piece.opus_number = 'Op. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1933, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12151 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1933
WHERE piece.id = 12151 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12151 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:48a636b9-ff49-344e-9a31-5c13bf451886' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48a636b9-ff49-344e-9a31-5c13bf451886', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12151 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48a636b9-ff49-344e-9a31-5c13bf451886'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12151 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:251b84a3-4ad8-3a19-a394-57067834153a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:251b84a3-4ad8-3a19-a394-57067834153a', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12151 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:251b84a3-4ad8-3a19-a394-57067834153a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato', part.name_en = 'III. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12151 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:15a890d3-40d0-3943-9b4d-6cb4037f7c34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15a890d3-40d0-3943-9b4d-6cb4037f7c34', 3, 'III', 'Moderato', 'III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12151 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15a890d3-40d0-3943-9b4d-6cb4037f7c34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con brio', part.name_en = 'IV. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12151 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:28fc70dd-7bef-38aa-9718-38ca9a79cf24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28fc70dd-7bef-38aa-9718-38ca9a79cf24', 4, 'IV', 'Allegro con brio', 'IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12151 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28fc70dd-7bef-38aa-9718-38ca9a79cf24'
);


-- Op. 36 영화음악 <신부와 일꾼 발다 이야기>

UPDATE pieces piece
SET piece.title = '영화음악 <신부와 일꾼 발다 이야기>', piece.title_en = 'The Tale of the Priest and of His Workman Balda',
    piece.type = 'song', piece.opus_number = 'Op. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13124 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 13124 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 36a 영화 모음곡 <신부와 일꾼 발다 이야기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 모음곡 <신부와 일꾼 발다 이야기>', 'Suite from The Tale of the Priest and of His Workman Balda', 'song', 'Op. 36a', NULL, NULL, 1935, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 모음곡 <신부와 일꾼 발다 이야기>'
);


-- Op. 37 부수음악 <인간 희극>

UPDATE pieces piece
SET piece.title = '부수음악 <인간 희극>', piece.title_en = 'The Human Comedy',
    piece.type = 'song', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13154 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 13154 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 재즈 모음곡 1번

UPDATE pieces piece
SET piece.title = '재즈 모음곡 1번', piece.title_en = 'Suite for Jazz Orchestra No. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12699 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 12699 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '왈츠. Moderato', part.name_en = 'I. Waltz. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12699 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:00167744-be01-36e1-a0c2-fa53d3b07aa8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00167744-be01-36e1-a0c2-fa53d3b07aa8', 1, 'I', '왈츠. Moderato', 'I. Waltz. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12699 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00167744-be01-36e1-a0c2-fa53d3b07aa8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '폴카. Allegretto', part.name_en = 'II. Polka. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12699 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f611e5b9-58e2-3fac-83c9-ee81c53c857c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f611e5b9-58e2-3fac-83c9-ee81c53c857c', 2, 'II', '폴카. Allegretto', 'II. Polka. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12699 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f611e5b9-58e2-3fac-83c9-ee81c53c857c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '폭스트롯 (블루스). Moderato', part.name_en = 'III. Foxtrot (Blues). Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12699 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:911ecde9-54ea-36c1-b8ac-1d805ec1c5ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:911ecde9-54ea-36c1-b8ac-1d805ec1c5ce', 3, 'III', '폭스트롯 (블루스). Moderato', 'III. Foxtrot (Blues). Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12699 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:911ecde9-54ea-36c1-b8ac-1d805ec1c5ce'
);


-- Op. 39 발레 <맑은 시냇물>

UPDATE pieces piece
SET piece.title = '발레 <맑은 시냇물>', piece.title_en = 'The Limpid Stream',
    piece.type = 'song', piece.opus_number = 'Op. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1935, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12086 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1935
WHERE piece.id = 12086 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 39a 발레 모음곡 <맑은 시냇물>

UPDATE pieces piece
SET piece.title = '발레 모음곡 <맑은 시냇물>', piece.title_en = 'Suite from The Limpid Stream',
    piece.type = 'album', piece.opus_number = 'Op. 39a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1935, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13089 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1935
WHERE piece.id = 13089 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '왈츠', part.name_en = 'I. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13089 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6a2a0c4d-981a-4c1e-8714-085c4e5fad83' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a2a0c4d-981a-4c1e-8714-085c4e5fad83', 1, 'I', '왈츠', 'I. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13089 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a2a0c4d-981a-4c1e-8714-085c4e5fad83'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '러시아 민속춤', part.name_en = 'II. Russian Folk Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13089 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ede1703d-ab3c-4b82-b2cc-ebae94d82b97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ede1703d-ab3c-4b82-b2cc-ebae94d82b97', 2, 'II', '러시아 민속춤', 'II. Russian Folk Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13089 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ede1703d-ab3c-4b82-b2cc-ebae94d82b97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '갤럽', part.name_en = 'III. Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13089 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c825e91b-93fd-4dd5-81d4-d4203a96b3a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c825e91b-93fd-4dd5-81d4-d4203a96b3a8', 3, 'III', '갤럽', 'III. Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13089 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c825e91b-93fd-4dd5-81d4-d4203a96b3a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13089 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7178afc7-e27b-4cb4-b77d-6b251d149a24' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7178afc7-e27b-4cb4-b77d-6b251d149a24', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13089 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7178afc7-e27b-4cb4-b77d-6b251d149a24'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피치카토. Allegretto', part.name_en = 'V. Pizzicato. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13089 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:852c10a1-ebcc-432a-8105-7ae9fd1710e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:852c10a1-ebcc-432a-8105-7ae9fd1710e4', 5, 'V', '피치카토. Allegretto', 'V. Pizzicato. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13089 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:852c10a1-ebcc-432a-8105-7ae9fd1710e4'
);


-- Op. 40 첼로 소나타 D단조

UPDATE pieces piece
SET piece.title = '첼로 소나타 D단조', piece.title_en = 'Cello Sonata in D minor',
    piece.type = 'album', piece.opus_number = 'Op. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13362 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 13362 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo – Largo', part.name_en = 'I. Allegro non troppo – Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13362 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:eb2ff393-1913-3f9a-abc6-0f477249c74d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb2ff393-1913-3f9a-abc6-0f477249c74d', 1, 'I', 'Allegro non troppo – Largo', 'I. Allegro non troppo – Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13362 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb2ff393-1913-3f9a-abc6-0f477249c74d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13362 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2738e5d7-3e3b-3f4c-83ac-a7580458d1bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2738e5d7-3e3b-3f4c-83ac-a7580458d1bb', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13362 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2738e5d7-3e3b-3f4c-83ac-a7580458d1bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13362 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1153a2e2-3734-30c6-984f-58bdba7caed3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1153a2e2-3734-30c6-984f-58bdba7caed3', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13362 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1153a2e2-3734-30c6-984f-58bdba7caed3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13362 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4633bd01-8bea-3897-a1e3-291188adf00c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4633bd01-8bea-3897-a1e3-291188adf00c', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13362 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4633bd01-8bea-3897-a1e3-291188adf00c'
);


-- None 첼로와 피아노를 위한 모데라토

UPDATE pieces piece
SET piece.title = '첼로와 피아노를 위한 모데라토', piece.title_en = 'Moderato for Cello and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1934, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13607 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1934
WHERE piece.id = 13607 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 41a 영화음악 <여자 친구들>

UPDATE pieces piece
SET piece.title = '영화음악 <여자 친구들>', piece.title_en = 'Girl Friends',
    piece.type = 'song', piece.opus_number = 'Op. 41a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1935, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13121 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1935
WHERE piece.id = 13121 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 42 5개의 단편

UPDATE pieces piece
SET piece.title = '5개의 단편', piece.title_en = 'Five Fragments',
    piece.type = 'album', piece.opus_number = 'Op. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1935, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12522 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1935
WHERE piece.id = 12522 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12522 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2df5d4a4-347e-35a3-bacb-25d534772f48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2df5d4a4-347e-35a3-bacb-25d534772f48', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12522 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2df5d4a4-347e-35a3-bacb-25d534772f48'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12522 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:301e1437-5244-3198-afe4-a0eb2186e174' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:301e1437-5244-3198-afe4-a0eb2186e174', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12522 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:301e1437-5244-3198-afe4-a0eb2186e174'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12522 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:9009a51b-7690-328e-9203-d41a0073b5bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9009a51b-7690-328e-9203-d41a0073b5bb', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12522 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9009a51b-7690-328e-9203-d41a0073b5bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Moderato', part.name_en = 'IV. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12522 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6e1b81cc-2542-3b7c-89e5-220440f1566e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e1b81cc-2542-3b7c-89e5-220440f1566e', 4, 'IV', 'Moderato', 'IV. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12522 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e1b81cc-2542-3b7c-89e5-220440f1566e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegretto', part.name_en = 'V. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12522 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:40fa24b6-1ff9-3315-a3a1-95052ee5d58a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40fa24b6-1ff9-3315-a3a1-95052ee5d58a', 5, 'V', 'Allegretto', 'V. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12522 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40fa24b6-1ff9-3315-a3a1-95052ee5d58a'
);


-- Op. 43 교향곡 4번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 C단조', 'Symphony No. 4 in C minor', 'album', 'Op. 43', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '734b1c76-30d0-48de-87cc-82229c6b0e49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '734b1c76-30d0-48de-87cc-82229c6b0e49'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 4번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '734b1c76-30d0-48de-87cc-82229c6b0e49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41302906-8c33-32ff-8592-898f655e430e', 1, 'I', 'Allegretto poco moderato – Presto', 'I. Allegretto poco moderato – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 4번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41302906-8c33-32ff-8592-898f655e430e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e938b44-605d-3c4d-984d-ff20e8af4e10', 2, 'II', 'Moderato con moto', 'II. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 4번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e938b44-605d-3c4d-984d-ff20e8af4e10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c049c0ca-0bb0-3a44-acb1-04dbd583c2d7', 3, 'III', 'Largo – Allegro', 'III. Largo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 4번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c049c0ca-0bb0-3a44-acb1-04dbd583c2d7'
);


-- Op. 44 부수음악 <스페인 만세!>

UPDATE pieces piece
SET piece.title = '부수음악 <스페인 만세!>', piece.title_en = 'Salute to Spain!',
    piece.type = 'song', piece.opus_number = 'Op. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1936, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13675 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1936
WHERE piece.id = 13675 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 45 영화음악 <막심의 귀환>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <막심의 귀환>', 'The Return of Maxim', 'song', 'Op. 45', NULL, NULL, 1937, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <막심의 귀환>'
);


-- Op. 46 푸시킨의 시에 의한 4개의 로망스

UPDATE pieces piece
SET piece.title = '푸시킨의 시에 의한 4개의 로망스', piece.title_en = 'Four Romances on Verses by Pushkin',
    piece.type = 'album', piece.opus_number = 'Op. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1937, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12064 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1937
WHERE piece.id = 12064 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '부활 (Vozrozhdeniye)', part.name_en = 'Vozrozhdeniye',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12064 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6169a44e-695f-4f61-863f-a12373cd3ad2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6169a44e-695f-4f61-863f-a12373cd3ad2', 1, NULL, '부활 (Vozrozhdeniye)', 'Vozrozhdeniye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12064 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6169a44e-695f-4f61-863f-a12373cd3ad2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '서럽게 우는 젊은이를 (Yunoshu, gor''ko rydaya)', part.name_en = 'Yunoshu, gor''ko rydaya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12064 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a1f9e2ce-90d6-4ec9-b1db-75eb7e302f01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1f9e2ce-90d6-4ec9-b1db-75eb7e302f01', 2, NULL, '서럽게 우는 젊은이를 (Yunoshu, gor''ko rydaya)', 'Yunoshu, gor''ko rydaya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12064 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1f9e2ce-90d6-4ec9-b1db-75eb7e302f01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '예감 (Predchuvstviye)', part.name_en = 'Predchuvstviye',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12064 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:12a7113c-6e06-4ff9-b759-b75838c2be49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12a7113c-6e06-4ff9-b759-b75838c2be49', 3, NULL, '예감 (Predchuvstviye)', 'Predchuvstviye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12064 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12a7113c-6e06-4ff9-b759-b75838c2be49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '질투하는 처녀가 꾸짖었네 (Revnivaya deva branila)', part.name_en = 'Revnivaya deva branila',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12064 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:9c22c90a-6826-427b-a96c-9cfec17d4233' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c22c90a-6826-427b-a96c-9cfec17d4233', 4, NULL, '질투하는 처녀가 꾸짖었네 (Revnivaya deva branila)', 'Revnivaya deva branila', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12064 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c22c90a-6826-427b-a96c-9cfec17d4233'
);


-- Op. 47 교향곡 5번 D단조 "혁명"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato – Allegro non troppo – Moderato', part.name_en = 'I. Moderato – Allegro non troppo – Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 317 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b58b24b0-e49d-3102-b970-6eeaff51069d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 317 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d8a46a99-3beb-3136-afb1-f0883399c706' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 317 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ad2f80e7-f3b9-362f-a8b2-da0555a36146' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo', part.name_en = 'IV. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 317 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b1644976-4468-3f16-879f-c64423d90dff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));


-- Op. 48 영화음악 <볼로차예프의 나날>

UPDATE pieces piece
SET piece.title = '영화음악 <볼로차예프의 나날>', piece.title_en = 'Volochayev Days',
    piece.type = 'song', piece.opus_number = 'Op. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1937, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13538 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1937
WHERE piece.id = 13538 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 49 현악 4중주 1번 C장조

UPDATE pieces piece
SET piece.title = '현악 4중주 1번 C장조', piece.title_en = 'String Quartet No. 1 in C major',
    piece.type = 'album', piece.opus_number = 'Op. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1938, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13373 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1938
WHERE piece.id = 13373 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13373 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:68026c05-b60a-3774-aecb-9378373b084a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68026c05-b60a-3774-aecb-9378373b084a', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13373 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68026c05-b60a-3774-aecb-9378373b084a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13373 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ac6b07dc-7cdd-34f1-9c4e-0dcb8629efda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac6b07dc-7cdd-34f1-9c4e-0dcb8629efda', 2, 'II', 'Moderato', 'II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13373 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac6b07dc-7cdd-34f1-9c4e-0dcb8629efda'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto', part.name_en = 'III. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13373 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e5af9301-99df-3678-abbe-80f1cb619691' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5af9301-99df-3678-abbe-80f1cb619691', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13373 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5af9301-99df-3678-abbe-80f1cb619691'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13373 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2cb11151-9736-3a48-8454-de71a26dbdd5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cb11151-9736-3a48-8454-de71a26dbdd5', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13373 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cb11151-9736-3a48-8454-de71a26dbdd5'
);


-- Op. 50a 영화 모음곡 <막심 3부작>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <막심 3부작>', piece.title_en = 'Suite from The Maxim Trilogy',
    piece.type = 'album', piece.opus_number = 'Op. 50a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1938, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13627 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1938
WHERE piece.id = 13627 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주. Moderato', part.name_en = 'I. Introduction. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13627 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f5ae840c-b1ff-4f13-a9ca-6e182311d862' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5ae840c-b1ff-4f13-a9ca-6e182311d862', 1, 'I', '서주. Moderato', 'I. Introduction. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13627 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5ae840c-b1ff-4f13-a9ca-6e182311d862'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '공격. Allegro', part.name_en = 'II. Attack. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13627 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:bb15b73d-191e-42ac-a2ea-a9d7eef7bd6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb15b73d-191e-42ac-a2ea-a9d7eef7bd6f', 2, 'II', '공격. Allegro', 'II. Attack. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13627 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb15b73d-191e-42ac-a2ea-a9d7eef7bd6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '늙은 노동자의 죽음. Adagio', part.name_en = 'III. Death of the Old Worker. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13627 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5d9659d5-3169-49da-a9b4-7e2f4366c347' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d9659d5-3169-49da-a9b4-7e2f4366c347', 3, 'III', '늙은 노동자의 죽음. Adagio', 'III. Death of the Old Worker. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13627 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d9659d5-3169-49da-a9b4-7e2f4366c347'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '왈츠. Allegro sostenuto', part.name_en = 'IV. Waltz. Allegro sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13627 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3701a5ec-4e22-4128-bc92-a10ee479ac16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3701a5ec-4e22-4128-bc92-a10ee479ac16', 4, 'IV', '왈츠. Allegro sostenuto', 'IV. Waltz. Allegro sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13627 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3701a5ec-4e22-4128-bc92-a10ee479ac16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '시위. Allegretto', part.name_en = 'V. Demonstration. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13627 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:72d4446d-dc7a-4da3-a223-7be5776bd666' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72d4446d-dc7a-4da3-a223-7be5776bd666', 5, 'V', '시위. Allegretto', 'V. Demonstration. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13627 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d4446d-dc7a-4da3-a223-7be5776bd666'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '바리케이드 전투. Allegro con brio', part.name_en = 'VI. Struggle at the Barricades. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13627 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f5c58da6-696d-4652-91f9-a5f8ee5029ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5c58da6-696d-4652-91f9-a5f8ee5029ce', 6, 'VI', '바리케이드 전투. Allegro con brio', 'VI. Struggle at the Barricades. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13627 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5c58da6-696d-4652-91f9-a5f8ee5029ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '장송 행진곡. Tempo di marcia funebre', part.name_en = 'VII. Funeral March. Tempo di marcia funebre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13627 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:27afcefd-a823-41a5-8408-c7cf8caa682b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27afcefd-a823-41a5-8408-c7cf8caa682b', 7, 'VII', '장송 행진곡. Tempo di marcia funebre', 'VII. Funeral March. Tempo di marcia funebre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13627 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27afcefd-a823-41a5-8408-c7cf8caa682b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '피날레', part.name_en = 'VIII. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13627 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c3b2ceac-235c-4689-8724-f439ae2d76a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3b2ceac-235c-4689-8724-f439ae2d76a4', 8, 'VIII', '피날레', 'VIII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13627 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3b2ceac-235c-4689-8724-f439ae2d76a4'
);


-- None 재즈 모음곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '재즈 모음곡 2번', 'Suite for Jazz Orchestra No. 2', 'album', NULL, NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '재즈 모음곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a55e71e7-07c8-40ae-ba37-16b3fe5c8831'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a55e71e7-07c8-40ae-ba37-16b3fe5c8831'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '재즈 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a55e71e7-07c8-40ae-ba37-16b3fe5c8831'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-jazz-suite-2:1', 1, 'I', '스케르초', 'I. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '재즈 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-jazz-suite-2:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-jazz-suite-2:2', 2, 'II', '자장가', 'II. Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '재즈 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-jazz-suite-2:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-jazz-suite-2:3', 3, 'III', '세레나데', 'III. Serenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '재즈 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-jazz-suite-2:3'
);


-- Op. 51 영화음악 <친구들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <친구들>', 'Friends', 'song', 'Op. 51', NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <친구들>'
);


-- Op. 52 영화음악 <위대한 시민> 1부

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <위대한 시민> 1부', 'The Great Citizen, Part I', 'song', 'Op. 52', NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <위대한 시민> 1부'
);


-- Op. 54 교향곡 6번 B단조

UPDATE pieces piece
SET piece.title = '교향곡 6번 B단조', piece.title_en = 'Symphony No. 6 in B minor',
    piece.type = 'album', piece.opus_number = 'Op. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1939, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12325 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1939
WHERE piece.id = 12325 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12325 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:42d55796-b89d-3b28-87d7-d1379333ba57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42d55796-b89d-3b28-87d7-d1379333ba57', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12325 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42d55796-b89d-3b28-87d7-d1379333ba57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12325 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5d275a00-225e-32bf-aaaa-1135a52fcf7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d275a00-225e-32bf-aaaa-1135a52fcf7e', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12325 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d275a00-225e-32bf-aaaa-1135a52fcf7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12325 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:933df90e-e150-3d22-91a7-c20c9a1ccac3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:933df90e-e150-3d22-91a7-c20c9a1ccac3', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12325 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:933df90e-e150-3d22-91a7-c20c9a1ccac3'
);


-- Op. 56 영화음악 <어리석은 아기 생쥐 이야기>

UPDATE pieces piece
SET piece.title = '영화음악 <어리석은 아기 생쥐 이야기>', piece.title_en = 'The Story of a Silly Baby Mouse',
    piece.type = 'song', piece.opus_number = 'Op. 56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1939, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12748 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1939
WHERE piece.id = 12748 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 57 피아노 5중주 G단조

UPDATE pieces piece
SET piece.title = '피아노 5중주 G단조', piece.title_en = 'Piano Quintet in G minor',
    piece.type = 'album', piece.opus_number = 'Op. 57',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1940, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13679 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1940
WHERE piece.id = 13679 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡. Lento', part.name_en = 'I. Prelude. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13679 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:398cdca6-ba83-3944-94a7-af22f99fc7a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:398cdca6-ba83-3944-94a7-af22f99fc7a0', 1, 'I', '전주곡. Lento', 'I. Prelude. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13679 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398cdca6-ba83-3944-94a7-af22f99fc7a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가. Adagio', part.name_en = 'II. Fugue. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13679 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a52275af-2ccf-3b20-b8c0-3e23fe3a7c1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a52275af-2ccf-3b20-b8c0-3e23fe3a7c1e', 2, 'II', '푸가. Adagio', 'II. Fugue. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13679 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a52275af-2ccf-3b20-b8c0-3e23fe3a7c1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초. Allegretto', part.name_en = 'III. Scherzo. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13679 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8b012293-5c62-3ba6-9b29-027983f355ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b012293-5c62-3ba6-9b29-027983f355ac', 3, 'III', '스케르초. Allegretto', 'III. Scherzo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13679 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b012293-5c62-3ba6-9b29-027983f355ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '간주곡. Lento', part.name_en = 'IV. Intermezzo. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13679 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f4be92a8-8e97-3128-82aa-e531839bc2df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4be92a8-8e97-3128-82aa-e531839bc2df', 4, 'IV', '간주곡. Lento', 'IV. Intermezzo. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13679 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4be92a8-8e97-3128-82aa-e531839bc2df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레. Allegretto', part.name_en = 'V. Finale. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13679 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fbceeb27-4487-391a-a1a1-d0400e001b9e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbceeb27-4487-391a-a1a1-d0400e001b9e', 5, 'V', '피날레. Allegretto', 'V. Finale. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13679 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbceeb27-4487-391a-a1a1-d0400e001b9e'
);


-- Op. 58a 부수음악 <리어 왕>

UPDATE pieces piece
SET piece.title = '부수음악 <리어 왕>', piece.title_en = 'King Lear (incidental music)',
    piece.type = 'song', piece.opus_number = 'Op. 58a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1940, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13455 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1940
WHERE piece.id = 13455 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 59 영화음악 <코르진키나의 모험>

UPDATE pieces piece
SET piece.title = '영화음악 <코르진키나의 모험>', piece.title_en = 'The Adventures of Korzinkina',
    piece.type = 'song', piece.opus_number = 'Op. 59',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1940, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12059 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1940
WHERE piece.id = 12059 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 60 교향곡 7번 C장조 "레닌그라드"

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 318 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b32ab669-5d35-3406-bfaa-81fd2d3f3131' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato (poco allegretto)', part.name_en = 'II. Moderato (poco allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 318 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f9b35669-bc33-3b24-a40a-136e994b4153' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 318 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d968047d-dadf-325f-824d-69cb6e6575e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro non troppo', part.name_en = 'IV. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 318 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b4a25b84-4acb-30b6-b6dd-c7bdedf50f8d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));


-- Op. 61 피아노 소나타 2번 B단조

UPDATE pieces piece
SET piece.title = '피아노 소나타 2번 B단조', piece.title_en = 'Piano Sonata No. 2 in B minor',
    piece.type = 'album', piece.opus_number = 'Op. 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1943, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13402 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1943
WHERE piece.id = 13402 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13402 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b06484b9-d78a-35fd-bef6-4d3393510b56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b06484b9-d78a-35fd-bef6-4d3393510b56', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13402 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b06484b9-d78a-35fd-bef6-4d3393510b56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Largo', part.name_en = 'II. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13402 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4d06c0bd-97c4-3422-bc30-14dea70ed2f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d06c0bd-97c4-3422-bc30-14dea70ed2f2', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13402 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d06c0bd-97c4-3422-bc30-14dea70ed2f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato con moto', part.name_en = 'III. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13402 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:64f5f676-c7b4-3365-9799-edb35f49c9d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64f5f676-c7b4-3365-9799-edb35f49c9d1', 3, 'III', 'Moderato con moto', 'III. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13402 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64f5f676-c7b4-3365-9799-edb35f49c9d1'
);


-- Op. 62 영국 시인의 시에 의한 6개의 로망스 Op. 62

UPDATE pieces piece
SET piece.title = '영국 시인의 시에 의한 6개의 로망스 Op. 62', piece.title_en = 'Six Romances on Verses by British Poets, Op. 62',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '62',
    piece.composition_year = COALESCE(1942, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12489 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1942
WHERE piece.id = 12489 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sir Walter Raleigh to His Son', part.name_en = 'Sir Walter Raleigh to His Son',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12489 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:bf11413b-f45e-4c6e-abd9-d0971f3d5e09' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf11413b-f45e-4c6e-abd9-d0971f3d5e09', 1, NULL, 'Sir Walter Raleigh to His Son', 'Sir Walter Raleigh to His Son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12489 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf11413b-f45e-4c6e-abd9-d0971f3d5e09'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'O Wert Thou in the Cauld Blast', part.name_en = 'O Wert Thou in the Cauld Blast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12489 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b96776fe-33b8-42a9-9abb-784995fa0ec9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b96776fe-33b8-42a9-9abb-784995fa0ec9', 2, NULL, 'O Wert Thou in the Cauld Blast', 'O Wert Thou in the Cauld Blast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12489 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b96776fe-33b8-42a9-9abb-784995fa0ec9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'MacPherson''s Farewell', part.name_en = 'MacPherson''s Farewell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12489 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c9019c9f-ee7d-4e20-a9c1-3fa27629de3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9019c9f-ee7d-4e20-a9c1-3fa27629de3b', 3, NULL, 'MacPherson''s Farewell', 'MacPherson''s Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12489 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9019c9f-ee7d-4e20-a9c1-3fa27629de3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jenny', part.name_en = 'Jenny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12489 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4e7ba04c-4446-4ce9-b821-ccfae7471aaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7ba04c-4446-4ce9-b821-ccfae7471aaf', 4, NULL, 'Jenny', 'Jenny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12489 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7ba04c-4446-4ce9-b821-ccfae7471aaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sonnet 66', part.name_en = 'Sonnet 66',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12489 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e438751a-4545-43db-b198-5e760921b8dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e438751a-4545-43db-b198-5e760921b8dd', 5, NULL, 'Sonnet 66', 'Sonnet 66', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12489 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e438751a-4545-43db-b198-5e760921b8dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The King''s Campaign', part.name_en = 'The King''s Campaign',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12489 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4e2ff788-6ce0-4d53-b8cd-9212896667f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e2ff788-6ce0-4d53-b8cd-9212896667f5', 6, NULL, 'The King''s Campaign', 'The King''s Campaign', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12489 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e2ff788-6ce0-4d53-b8cd-9212896667f5'
);


-- Op. 63 모음곡 <조국 레닌그라드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모음곡 <조국 레닌그라드>', 'Native Leningrad', 'album', 'Op. 63', NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모음곡 <조국 레닌그라드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0623811e-cc69-474b-b000-95bfe2ae3996'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0623811e-cc69-474b-b000-95bfe2ae3996'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '모음곡 <조국 레닌그라드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0623811e-cc69-474b-b000-95bfe2ae3996'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d115aec-ed60-48ac-8c3f-6412892cd4e8', 1, 'I', '서곡 "1917년 10월". Moderato non troppo', 'I. Overture "October 1917". Moderato non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '모음곡 <조국 레닌그라드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d115aec-ed60-48ac-8c3f-6412892cd4e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4972c65b-7f11-4890-97e2-2ca0b373c05b', 2, 'II', '승리한 10월의 노래. Allegretto', 'II. Song of the Victorious October. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '모음곡 <조국 레닌그라드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4972c65b-7f11-4890-97e2-2ca0b373c05b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fe8049c-0eff-4a73-b9e0-5e467bb721d7', 3, 'III', '젊음의 춤. Moderato – Allegro con brio', 'III. Youth Dance. Moderato – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '모음곡 <조국 레닌그라드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fe8049c-0eff-4a73-b9e0-5e467bb721d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d129c13-7e38-42a4-87d6-0be276011efc', 4, 'IV', '레닌그라드의 노래. Moderato', 'IV. Song of Leningrad. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '모음곡 <조국 레닌그라드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d129c13-7e38-42a4-87d6-0be276011efc'
);


-- Op. 64 영화음악 <조야>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <조야>', 'Zoya', 'song', 'Op. 64', NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <조야>'
);


-- Op. 64a 영화 모음곡 <조야>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <조야>', piece.title_en = 'Suite from Zoya',
    piece.type = 'album', piece.opus_number = 'Op. 64a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12087 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 12087 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주 (조야의 노래)', part.name_en = 'I. Introduction (Song about Zoya)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12087 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:37ac0e98-e447-45f6-8fcc-bfdf58be9814' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37ac0e98-e447-45f6-8fcc-bfdf58be9814', 1, 'I', '서주 (조야의 노래)', 'I. Introduction (Song about Zoya)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12087 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37ac0e98-e447-45f6-8fcc-bfdf58be9814'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '장면 (전투 임무)', part.name_en = 'II. Scene (Combat Mission)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12087 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:96f5ee48-e3e7-4936-9826-1d65365467e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96f5ee48-e3e7-4936-9826-1d65365467e9', 2, 'II', '장면 (전투 임무)', 'II. Scene (Combat Mission)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12087 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96f5ee48-e3e7-4936-9826-1d65365467e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '전주곡 (상실의 비극)', part.name_en = 'III. Prelude (Tragedy of a Loss)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12087 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:30beb6e5-2df6-468c-8b4b-86cb2c8c2c7d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30beb6e5-2df6-468c-8b4b-86cb2c8c2c7d', 3, 'III', '전주곡 (상실의 비극)', 'III. Prelude (Tragedy of a Loss)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12087 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30beb6e5-2df6-468c-8b4b-86cb2c8c2c7d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '행진곡 (영웅의 승리)', part.name_en = 'IV. March (Hero''s Victory)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12087 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:197a6b14-6ce0-4bf8-8e9e-ba8d0ff146b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:197a6b14-6ce0-4bf8-8e9e-ba8d0ff146b7', 4, 'IV', '행진곡 (영웅의 승리)', 'IV. March (Hero''s Victory)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12087 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:197a6b14-6ce0-4bf8-8e9e-ba8d0ff146b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레 (여주인공의 불멸)', part.name_en = 'V. Finale (The Heroine''s Immortality)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12087 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:07fb5824-34cf-4c55-b062-323b315f5b61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07fb5824-34cf-4c55-b062-323b315f5b61', 5, 'V', '피날레 (여주인공의 불멸)', 'V. Finale (The Heroine''s Immortality)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12087 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07fb5824-34cf-4c55-b062-323b315f5b61'
);


-- Op. 65 교향곡 8번 C단조

UPDATE pieces piece
SET piece.title = '교향곡 8번 C단조', piece.title_en = 'Symphony No. 8 in C minor',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1943, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12650 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1943
WHERE piece.id = 12650 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12650 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:68825e45-c46c-3098-8edd-0a1f9706ca96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68825e45-c46c-3098-8edd-0a1f9706ca96', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12650 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68825e45-c46c-3098-8edd-0a1f9706ca96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12650 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:cc8a2074-5b13-39a1-926b-94083bb52c67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc8a2074-5b13-39a1-926b-94083bb52c67', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12650 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc8a2074-5b13-39a1-926b-94083bb52c67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12650 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:18bb7abf-4ac3-36c8-8088-b5f7bb40576b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18bb7abf-4ac3-36c8-8088-b5f7bb40576b', 3, 'III', 'Allegro non troppo', 'III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12650 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18bb7abf-4ac3-36c8-8088-b5f7bb40576b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Largo', part.name_en = 'IV. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12650 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b3bf4be9-530c-3546-9684-bf43ba8c97b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3bf4be9-530c-3546-9684-bf43ba8c97b4', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12650 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3bf4be9-530c-3546-9684-bf43ba8c97b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegretto', part.name_en = 'V. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12650 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:920a74b3-b273-3e68-9482-a2e2a9b27052' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:920a74b3-b273-3e68-9482-a2e2a9b27052', 5, 'V', 'Allegretto', 'V. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12650 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:920a74b3-b273-3e68-9482-a2e2a9b27052'
);


-- Op. 66 무대음악 <러시아의 강>

UPDATE pieces piece
SET piece.title = '무대음악 <러시아의 강>', piece.title_en = 'Russian River',
    piece.type = 'song', piece.opus_number = 'Op. 66',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12135 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 12135 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 67 피아노 3중주 2번 E단조

UPDATE pieces piece
SET piece.title = '피아노 3중주 2번 E단조', piece.title_en = 'Piano Trio No. 2 in E minor',
    piece.type = 'album', piece.opus_number = 'Op. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13693 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 13693 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante – Moderato', part.name_en = 'I. Andante – Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13693 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:83063eff-4d74-3c00-9ab0-59845aed3628' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83063eff-4d74-3c00-9ab0-59845aed3628', 1, 'I', 'Andante – Moderato', 'I. Andante – Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13693 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83063eff-4d74-3c00-9ab0-59845aed3628'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro con brio', part.name_en = 'II. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13693 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:87453bf7-2536-3bdc-9c1e-5a7408568f91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87453bf7-2536-3bdc-9c1e-5a7408568f91', 2, 'II', 'Allegro con brio', 'II. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13693 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87453bf7-2536-3bdc-9c1e-5a7408568f91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13693 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:08fc301f-5ffc-3bde-94f5-2f131f5cf827' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08fc301f-5ffc-3bde-94f5-2f131f5cf827', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13693 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08fc301f-5ffc-3bde-94f5-2f131f5cf827'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto', part.name_en = 'IV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13693 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:089b5ee2-9e32-3090-be0e-9b4d9267572a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:089b5ee2-9e32-3090-be0e-9b4d9267572a', 4, 'IV', 'Allegretto', 'IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13693 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089b5ee2-9e32-3090-be0e-9b4d9267572a'
);


-- Op. 68 현악 4중주 2번 A장조

UPDATE pieces piece
SET piece.title = '현악 4중주 2번 A장조', piece.title_en = 'String Quartet No. 2 in A major',
    piece.type = 'album', piece.opus_number = 'Op. 68',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1944, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12534 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1944
WHERE piece.id = 12534 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서곡. Moderato con moto', part.name_en = 'I. Overture. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12534 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:12514ce1-5e54-3aab-9b13-451ce278c9a7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12514ce1-5e54-3aab-9b13-451ce278c9a7', 1, 'I', '서곡. Moderato con moto', 'I. Overture. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12534 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12514ce1-5e54-3aab-9b13-451ce278c9a7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '레치타티보와 로망스. Adagio', part.name_en = 'II. Recitative and Romance. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12534 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:af5ae6d0-b4a4-32ff-9a6f-0875dffeb0c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af5ae6d0-b4a4-32ff-9a6f-0875dffeb0c2', 2, 'II', '레치타티보와 로망스. Adagio', 'II. Recitative and Romance. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12534 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af5ae6d0-b4a4-32ff-9a6f-0875dffeb0c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '왈츠. Allegro', part.name_en = 'III. Waltz. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12534 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:145ffbae-75d8-3fd2-af93-1dc982641bed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:145ffbae-75d8-3fd2-af93-1dc982641bed', 3, 'III', '왈츠. Allegro', 'III. Waltz. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12534 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:145ffbae-75d8-3fd2-af93-1dc982641bed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '주제와 변주. Adagio', part.name_en = 'IV. Theme and Variations. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12534 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3428e201-b603-3748-b75f-be12d2877407' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3428e201-b603-3748-b75f-be12d2877407', 4, 'IV', '주제와 변주. Adagio', 'IV. Theme and Variations. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12534 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3428e201-b603-3748-b75f-be12d2877407'
);


-- Op. 69 피아노 모음곡 <어린이 노트>

UPDATE pieces piece
SET piece.title = '피아노 모음곡 <어린이 노트>', piece.title_en = 'Children''s Notebook',
    piece.type = 'album', piece.opus_number = 'Op. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1945, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13256 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1945
WHERE piece.id = 13256 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '행진곡', part.name_en = 'March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13256 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a0bfb0d2-36c7-48fe-9fe3-15a882acb975' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0bfb0d2-36c7-48fe-9fe3-15a882acb975', 1, NULL, '행진곡', 'March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13256 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0bfb0d2-36c7-48fe-9fe3-15a882acb975'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '왈츠', part.name_en = 'Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13256 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:23290886-3aa9-420f-a2ef-fabe6fe4bc38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23290886-3aa9-420f-a2ef-fabe6fe4bc38', 2, NULL, '왈츠', 'Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13256 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23290886-3aa9-420f-a2ef-fabe6fe4bc38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '슬픈 이야기', part.name_en = 'A Sad Tale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13256 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ed8bbbaa-2b1c-4811-aefc-f5189ac6b4a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed8bbbaa-2b1c-4811-aefc-f5189ac6b4a1', 3, NULL, '슬픈 이야기', 'A Sad Tale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13256 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed8bbbaa-2b1c-4811-aefc-f5189ac6b4a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '즐거운 이야기', part.name_en = 'A Merry Tale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13256 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b60aac5d-1a07-4626-82c4-9dd38feef845' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b60aac5d-1a07-4626-82c4-9dd38feef845', 4, NULL, '즐거운 이야기', 'A Merry Tale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13256 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60aac5d-1a07-4626-82c4-9dd38feef845'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '곰', part.name_en = 'The Bear',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13256 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2beca82f-e0fe-40be-8558-ead83b06ed2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2beca82f-e0fe-40be-8558-ead83b06ed2d', 5, NULL, '곰', 'The Bear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13256 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2beca82f-e0fe-40be-8558-ead83b06ed2d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '태엽 인형', part.name_en = 'Clockwork Doll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13256 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d8d15fe9-8cf5-42cb-b39b-e8efec139611' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8d15fe9-8cf5-42cb-b39b-e8efec139611', 6, NULL, '태엽 인형', 'Clockwork Doll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13256 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8d15fe9-8cf5-42cb-b39b-e8efec139611'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '생일', part.name_en = 'Birthday',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13256 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0f087dee-7a0d-4f2f-a6d3-682c19795ae3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f087dee-7a0d-4f2f-a6d3-682c19795ae3', 7, NULL, '생일', 'Birthday', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13256 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f087dee-7a0d-4f2f-a6d3-682c19795ae3'
);


-- Op. 70 교향곡 9번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 9번 E♭장조', 'Symphony No. 9 in E♭ major', 'album', 'Op. 70', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 9번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ac3d5b7-1f13-45fb-a0e6-512a92292a21'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ac3d5b7-1f13-45fb-a0e6-512a92292a21'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 9번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ac3d5b7-1f13-45fb-a0e6-512a92292a21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0475b1d4-81bc-3863-952c-d5b7308aab4c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 9번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0475b1d4-81bc-3863-952c-d5b7308aab4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:beaa21e0-c0b6-3564-808f-2689c59a05b3', 2, 'II', 'Moderato', 'II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 9번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:beaa21e0-c0b6-3564-808f-2689c59a05b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c1763a1-2dd1-3b70-bb1f-83799906f239', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 9번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c1763a1-2dd1-3b70-bb1f-83799906f239'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0de5204-8200-3df8-a216-f5188ff4c4d1', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 9번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0de5204-8200-3df8-a216-f5188ff4c4d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a4c469c-22f6-3d44-95e2-bb10a12c2619', 5, 'V', 'Allegretto', 'V. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 9번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a4c469c-22f6-3d44-95e2-bb10a12c2619'
);


-- Op. 71 영화음악 <평범한 사람들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <평범한 사람들>', 'Simple People', 'song', 'Op. 71', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <평범한 사람들>'
);


-- Op. 72 레뷔 <승리의 봄>을 위한 2개의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레뷔 <승리의 봄>을 위한 2개의 노래', 'Two Songs for the Revue "Victorious Spring"', 'song', 'Op. 72', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레뷔 <승리의 봄>을 위한 2개의 노래'
);


-- Op. 73 현악 4중주 3번 F장조

UPDATE pieces piece
SET piece.title = '현악 4중주 3번 F장조', piece.title_en = 'String Quartet No. 3 in F major',
    piece.type = 'album', piece.opus_number = 'Op. 73',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1946, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13313 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1946
WHERE piece.id = 13313 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13313 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:179da67e-8f3c-3db9-874e-c20a79098753' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:179da67e-8f3c-3db9-874e-c20a79098753', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13313 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:179da67e-8f3c-3db9-874e-c20a79098753'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato con moto', part.name_en = 'II. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13313 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1f2340b6-9652-39e5-b48c-0e7d206d2c00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f2340b6-9652-39e5-b48c-0e7d206d2c00', 2, 'II', 'Moderato con moto', 'II. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13313 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f2340b6-9652-39e5-b48c-0e7d206d2c00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro non troppo', part.name_en = 'III. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13313 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ae5a9bc8-8aaa-3fc0-b5fd-321855b9daf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae5a9bc8-8aaa-3fc0-b5fd-321855b9daf4', 3, 'III', 'Allegro non troppo', 'III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13313 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae5a9bc8-8aaa-3fc0-b5fd-321855b9daf4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13313 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:dac68dc2-0fc5-3ea5-bae0-3c14cdfc4d84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dac68dc2-0fc5-3ea5-bae0-3c14cdfc4d84', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13313 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dac68dc2-0fc5-3ea5-bae0-3c14cdfc4d84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Moderato', part.name_en = 'V. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13313 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4d1be2a1-4c3d-3e89-a146-423daee527ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d1be2a1-4c3d-3e89-a146-423daee527ef', 5, 'V', 'Moderato', 'V. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13313 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d1be2a1-4c3d-3e89-a146-423daee527ef'
);


-- Op. 74 칸타타 <조국의 시>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <조국의 시>', 'Poem of the Motherland', 'song', 'Op. 74', NULL, NULL, 1947, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <조국의 시>'
);


-- Op. 75 영화음악 <젊은 근위대>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <젊은 근위대>', 'The Young Guard', 'song', 'Op. 75', NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <젊은 근위대>'
);


-- Op. 75a 영화 모음곡 <젊은 근위대>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <젊은 근위대>', piece.title_en = 'Suite from The Young Guard',
    piece.type = 'song', piece.opus_number = 'Op. 75a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1951, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12897 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1951
WHERE piece.id = 12897 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 76 영화음악 <피로고프>

UPDATE pieces piece
SET piece.title = '영화음악 <피로고프>', piece.title_en = 'Pirogov',
    piece.type = 'song', piece.opus_number = 'Op. 76',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1947, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12318 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1947
WHERE piece.id = 12318 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 76a 영화 모음곡 <피로고프>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <피로고프>', piece.title_en = 'Suite from Pirogov',
    piece.type = 'album', piece.opus_number = 'Op. 76a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1947, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12977 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1947
WHERE piece.id = 12977 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12977 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3652e670-e27e-42a5-9efd-fe8646364eba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3652e670-e27e-42a5-9efd-fe8646364eba', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12977 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3652e670-e27e-42a5-9efd-fe8646364eba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '장면', part.name_en = 'II. Scene',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12977 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:aa3d082e-24bd-4dca-b025-1fe6e2b343c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa3d082e-24bd-4dca-b025-1fe6e2b343c9', 2, 'II', '장면', 'II. Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12977 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa3d082e-24bd-4dca-b025-1fe6e2b343c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '왈츠', part.name_en = 'III. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12977 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d860fc8b-d176-4dc9-9c40-b3abc1b010f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d860fc8b-d176-4dc9-9c40-b3abc1b010f6', 3, 'III', '왈츠', 'III. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12977 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d860fc8b-d176-4dc9-9c40-b3abc1b010f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '스케르초', part.name_en = 'IV. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12977 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:052f7fbc-ddd5-4bd4-834d-413615aaabaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:052f7fbc-ddd5-4bd4-834d-413615aaabaf', 4, 'IV', '스케르초', 'IV. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12977 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:052f7fbc-ddd5-4bd4-834d-413615aaabaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레', part.name_en = 'V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12977 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c70280f9-a59e-45c0-9530-2c999f2656d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c70280f9-a59e-45c0-9530-2c999f2656d6', 5, 'V', '피날레', 'V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12977 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c70280f9-a59e-45c0-9530-2c999f2656d6'
);


-- Op. 77 바이올린 협주곡 1번 A단조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 1번 A단조', piece.title_en = 'Violin Concerto No. 1 in A minor',
    piece.type = 'album', piece.opus_number = 'Op. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1948, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12115 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1948
WHERE piece.id = 12115 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '녹턴. Moderato', part.name_en = 'I. Nocturne. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12115 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:31cb3aba-ce87-3eb3-99d7-da399b1c866d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31cb3aba-ce87-3eb3-99d7-da399b1c866d', 1, 'I', '녹턴. Moderato', 'I. Nocturne. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12115 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31cb3aba-ce87-3eb3-99d7-da399b1c866d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Allegro', part.name_en = 'II. Scherzo. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12115 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:315ce85b-6462-3369-8661-1091fa7e009a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:315ce85b-6462-3369-8661-1091fa7e009a', 2, 'II', '스케르초. Allegro', 'II. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12115 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:315ce85b-6462-3369-8661-1091fa7e009a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '파사칼리아. Andante', part.name_en = 'III. Passacaglia. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12115 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:26873fa9-ac2f-3a67-8e2c-d07f26a10fb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26873fa9-ac2f-3a67-8e2c-d07f26a10fb0', 3, 'III', '파사칼리아. Andante', 'III. Passacaglia. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12115 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26873fa9-ac2f-3a67-8e2c-d07f26a10fb0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '부를레스크. Allegro con brio', part.name_en = 'IV. Burlesque. Allegro con brio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12115 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:afb70919-0bd6-3fb2-ac12-9771ed054291' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afb70919-0bd6-3fb2-ac12-9771ed054291', 4, 'IV', '부를레스크. Allegro con brio', 'IV. Burlesque. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12115 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afb70919-0bd6-3fb2-ac12-9771ed054291'
);


-- Op. 78 영화음악 <미추린>

UPDATE pieces piece
SET piece.title = '영화음악 <미추린>', piece.title_en = 'Michurin',
    piece.type = 'song', piece.opus_number = 'Op. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1948, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13708 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1948
WHERE piece.id = 13708 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 78a 영화 모음곡 <미추린>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <미추린>', piece.title_en = 'Suite from Michurin',
    piece.type = 'album', piece.opus_number = 'Op. 78a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1964, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13297 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1964
WHERE piece.id = 13297 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서곡', part.name_en = 'I. Overture',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1f30786c-ac9b-388a-9c00-25a7a0ab7ee9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f30786c-ac9b-388a-9c00-25a7a0ab7ee9', 1, 'I', '서곡', 'I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f30786c-ac9b-388a-9c00-25a7a0ab7ee9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '겨울의 정원', part.name_en = 'II. The Garden in Winter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:82faa080-2212-376f-be49-3edf4db95887' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82faa080-2212-376f-be49-3edf4db95887', 2, 'II', '겨울의 정원', 'II. The Garden in Winter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82faa080-2212-376f-be49-3edf4db95887'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '회상', part.name_en = 'III. Recollection',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:eebcbe39-29c4-3c98-a67e-8a6a42e8fa05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eebcbe39-29c4-3c98-a67e-8a6a42e8fa05', 3, 'III', '회상', 'III. Recollection', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eebcbe39-29c4-3c98-a67e-8a6a42e8fa05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '미추린의 독백', part.name_en = 'IV. Michurin''s Monologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6c4f8677-1827-3a0b-9883-96672a9e89f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c4f8677-1827-3a0b-9883-96672a9e89f4', 4, 'IV', '미추린의 독백', 'IV. Michurin''s Monologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c4f8677-1827-3a0b-9883-96672a9e89f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레', part.name_en = 'V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fa8d1f3f-01f5-356a-9a5c-85be1c199a62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa8d1f3f-01f5-356a-9a5c-85be1c199a62', 5, 'V', '피날레', 'V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8d1f3f-01f5-356a-9a5c-85be1c199a62'
);


-- Op. 79 연가곡집 <유대 민속시에서>

UPDATE pieces piece
SET piece.title = '연가곡집 <유대 민속시에서>', piece.title_en = 'From Jewish Folk Poetry',
    piece.type = 'album', piece.opus_number = 'Op. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1948, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13634 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1948
WHERE piece.id = 13634 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '죽은 아기를 위한 애가', part.name_en = 'Lament for the Dead Child',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f87f51d4-3f75-4676-b4ec-369a54484490' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f87f51d4-3f75-4676-b4ec-369a54484490', 1, NULL, '죽은 아기를 위한 애가', 'Lament for the Dead Child', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f87f51d4-3f75-4676-b4ec-369a54484490'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '다정한 엄마와 이모', part.name_en = 'The Thoughtful Mother and Aunt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:44d4db81-9fd1-43a4-a85d-0004092adf75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44d4db81-9fd1-43a4-a85d-0004092adf75', 2, NULL, '다정한 엄마와 이모', 'The Thoughtful Mother and Aunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44d4db81-9fd1-43a4-a85d-0004092adf75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '자장가', part.name_en = 'Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b3eaceb4-6784-4f4f-935d-02c9af50eaa3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3eaceb4-6784-4f4f-935d-02c9af50eaa3', 3, NULL, '자장가', 'Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3eaceb4-6784-4f4f-935d-02c9af50eaa3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '긴 이별 앞에서', part.name_en = 'Before a Long Parting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f1dd8cf3-8eac-440a-bc7b-52bbc497ffd4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1dd8cf3-8eac-440a-bc7b-52bbc497ffd4', 4, NULL, '긴 이별 앞에서', 'Before a Long Parting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1dd8cf3-8eac-440a-bc7b-52bbc497ffd4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '경고', part.name_en = 'A Warning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c393fe56-6fe1-4047-baf7-fdb73bcbf4c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c393fe56-6fe1-4047-baf7-fdb73bcbf4c8', 5, NULL, '경고', 'A Warning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c393fe56-6fe1-4047-baf7-fdb73bcbf4c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '버림받은 아버지', part.name_en = 'The Abandoned Father',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:617dd117-d1cb-431a-8305-927a304404b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:617dd117-d1cb-431a-8305-927a304404b4', 6, NULL, '버림받은 아버지', 'The Abandoned Father', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:617dd117-d1cb-431a-8305-927a304404b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '가난의 노래', part.name_en = 'The Song of Misery',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:92283f95-8024-4b36-b0b4-362b3f2c5080' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92283f95-8024-4b36-b0b4-362b3f2c5080', 7, NULL, '가난의 노래', 'The Song of Misery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92283f95-8024-4b36-b0b4-362b3f2c5080'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '겨울', part.name_en = 'Winter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:df278b00-167a-438c-a383-fc2cc1c3cbc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df278b00-167a-438c-a383-fc2cc1c3cbc8', 8, NULL, '겨울', 'Winter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df278b00-167a-438c-a383-fc2cc1c3cbc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '좋은 삶', part.name_en = 'A Good Life',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:43c4ba4f-bfb5-463d-a8cc-3fd94585db1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43c4ba4f-bfb5-463d-a8cc-3fd94585db1e', 9, NULL, '좋은 삶', 'A Good Life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43c4ba4f-bfb5-463d-a8cc-3fd94585db1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '처녀의 노래', part.name_en = 'The Young Girl''s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ef351d95-9b7b-4ec6-b492-632074e582f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef351d95-9b7b-4ec6-b492-632074e582f2', 10, NULL, '처녀의 노래', 'The Young Girl''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef351d95-9b7b-4ec6-b492-632074e582f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '행복', part.name_en = 'Happiness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13634 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e1dc6622-e211-473a-a26f-20bb2f999dc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1dc6622-e211-473a-a26f-20bb2f999dc5', 11, NULL, '행복', 'Happiness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13634 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1dc6622-e211-473a-a26f-20bb2f999dc5'
);


-- Op. 79a 연가곡집 <유대 민속시에서> (관현악 반주)

UPDATE pieces piece
SET piece.title = '연가곡집 <유대 민속시에서> (관현악 반주)', piece.title_en = 'From Jewish Folk Poetry (orchestral version)',
    piece.type = 'album', piece.opus_number = 'Op. 79a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1948, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12823 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1948
WHERE piece.id = 12823 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '죽은 아기를 위한 애가', part.name_en = 'Lament for the Dead Child',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:63d521e0-6965-3ef5-b911-d54fd7de5c08' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63d521e0-6965-3ef5-b911-d54fd7de5c08', 1, NULL, '죽은 아기를 위한 애가', 'Lament for the Dead Child', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63d521e0-6965-3ef5-b911-d54fd7de5c08'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '다정한 엄마와 이모', part.name_en = 'The Thoughtful Mother and Aunt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:71aba1b7-3f6d-35d0-937d-adbea8e4b039' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71aba1b7-3f6d-35d0-937d-adbea8e4b039', 2, NULL, '다정한 엄마와 이모', 'The Thoughtful Mother and Aunt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71aba1b7-3f6d-35d0-937d-adbea8e4b039'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '자장가', part.name_en = 'Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:59785b90-b48a-37ef-aa9a-82593900e134' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59785b90-b48a-37ef-aa9a-82593900e134', 3, NULL, '자장가', 'Lullaby', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59785b90-b48a-37ef-aa9a-82593900e134'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '긴 이별 앞에서', part.name_en = 'Before a Long Parting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:983530ec-daee-3008-b65b-5bc86cf2e09f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:983530ec-daee-3008-b65b-5bc86cf2e09f', 4, NULL, '긴 이별 앞에서', 'Before a Long Parting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:983530ec-daee-3008-b65b-5bc86cf2e09f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '경고', part.name_en = 'A Warning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:270c8bac-d8a5-35d2-9656-9c1042552ee4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:270c8bac-d8a5-35d2-9656-9c1042552ee4', 5, NULL, '경고', 'A Warning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:270c8bac-d8a5-35d2-9656-9c1042552ee4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '버림받은 아버지', part.name_en = 'The Abandoned Father',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:86c28570-79a7-3aca-bf0b-854233adb5a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86c28570-79a7-3aca-bf0b-854233adb5a6', 6, NULL, '버림받은 아버지', 'The Abandoned Father', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86c28570-79a7-3aca-bf0b-854233adb5a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '가난의 노래', part.name_en = 'The Song of Misery',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4fd68970-6528-3235-8899-8e7fe8a5469d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fd68970-6528-3235-8899-8e7fe8a5469d', 7, NULL, '가난의 노래', 'The Song of Misery', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fd68970-6528-3235-8899-8e7fe8a5469d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '겨울', part.name_en = 'Winter',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:13c757bf-2e3a-3ef3-9cda-e2c550d7ebae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13c757bf-2e3a-3ef3-9cda-e2c550d7ebae', 8, NULL, '겨울', 'Winter', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13c757bf-2e3a-3ef3-9cda-e2c550d7ebae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '좋은 삶', part.name_en = 'A Good Life',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:72a9fe38-eb30-3298-8fd4-cd3cf3f246ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72a9fe38-eb30-3298-8fd4-cd3cf3f246ff', 9, NULL, '좋은 삶', 'A Good Life', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72a9fe38-eb30-3298-8fd4-cd3cf3f246ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '처녀의 노래', part.name_en = 'The Young Girl''s Song',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:54020098-a0d6-3a71-8dc7-9a6a64da84fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54020098-a0d6-3a71-8dc7-9a6a64da84fc', 10, NULL, '처녀의 노래', 'The Young Girl''s Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54020098-a0d6-3a71-8dc7-9a6a64da84fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '행복', part.name_en = 'Happiness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12823 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:681434c7-d251-3015-bb36-cf633188ebd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:681434c7-d251-3015-bb36-cf633188ebd8', 11, NULL, '행복', 'Happiness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12823 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:681434c7-d251-3015-bb36-cf633188ebd8'
);


-- Op. 80 영화음악 <엘베강의 만남>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <엘베강의 만남>', 'Meeting on the Elbe', 'song', 'Op. 80', NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <엘베강의 만남>'
);


-- Op. 80a 영화 모음곡 <엘베강의 만남>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 모음곡 <엘베강의 만남>', 'Suite from Meeting on the Elbe', 'song', 'Op. 80a', NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 모음곡 <엘베강의 만남>'
);


-- Op. 81 오라토리오 <숲의 노래>

UPDATE pieces piece
SET piece.title = '오라토리오 <숲의 노래>', piece.title_en = 'Song of the Forests',
    piece.type = 'song', piece.opus_number = 'Op. 81',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1949, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12372 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1949
WHERE piece.id = 12372 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 82 영화음악 <베를린 함락>

UPDATE pieces piece
SET piece.title = '영화음악 <베를린 함락>', piece.title_en = 'The Fall of Berlin',
    piece.type = 'song', piece.opus_number = 'Op. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1949, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12012 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1949
WHERE piece.id = 12012 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 82a 영화 모음곡 <베를린 함락>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 모음곡 <베를린 함락>', 'Suite from The Fall of Berlin', 'song', 'Op. 82a', NULL, NULL, 1949, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 모음곡 <베를린 함락>'
);


-- Op. 83 현악 4중주 4번 D장조

UPDATE pieces piece
SET piece.title = '현악 4중주 4번 D장조', piece.title_en = 'String Quartet No. 4 in D major',
    piece.type = 'album', piece.opus_number = 'Op. 83',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1949, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12890 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1949
WHERE piece.id = 12890 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12890 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fbc415ab-96ef-3199-a645-83e5850b8c00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbc415ab-96ef-3199-a645-83e5850b8c00', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12890 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbc415ab-96ef-3199-a645-83e5850b8c00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino', part.name_en = 'II. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12890 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:11138ad0-35f1-3843-8824-856b0b0b94d2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11138ad0-35f1-3843-8824-856b0b0b94d2', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12890 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11138ad0-35f1-3843-8824-856b0b0b94d2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12890 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7fd4b36e-1ba1-37bd-9df2-0d37d0812eeb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd4b36e-1ba1-37bd-9df2-0d37d0812eeb', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12890 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd4b36e-1ba1-37bd-9df2-0d37d0812eeb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto', part.name_en = 'IV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12890 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:accb8795-f2d9-315a-ba28-60b61f93c0a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:accb8795-f2d9-315a-ba28-60b61f93c0a8', 4, 'IV', 'Allegretto', 'IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12890 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:accb8795-f2d9-315a-ba28-60b61f93c0a8'
);


-- Op. 84 레르몬토프의 시에 의한 2개의 로망스

UPDATE pieces piece
SET piece.title = '레르몬토프의 시에 의한 2개의 로망스', piece.title_en = 'Two Romances on Verses by Lermontov',
    piece.type = 'album', piece.opus_number = 'Op. 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1950, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12597 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1950
WHERE piece.id = 12597 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '발라드', part.name_en = 'Ballad',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12597 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:968f4ec3-1914-4797-8309-66349f7ba85d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:968f4ec3-1914-4797-8309-66349f7ba85d', 1, NULL, '발라드', 'Ballad', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12597 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:968f4ec3-1914-4797-8309-66349f7ba85d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '카프카스의 아침', part.name_en = 'Morning in the Caucasus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12597 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:95d2dfe2-6220-441c-a6aa-573c19764c6d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95d2dfe2-6220-441c-a6aa-573c19764c6d', 2, NULL, '카프카스의 아침', 'Morning in the Caucasus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12597 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95d2dfe2-6220-441c-a6aa-573c19764c6d'
);


-- Op. 85 영화음악 <벨린스키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <벨린스키>', 'Belinsky', 'song', 'Op. 85', NULL, NULL, 1950, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <벨린스키>'
);


-- Op. 85a 영화 모음곡 <벨린스키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 모음곡 <벨린스키>', 'Suite from Belinsky', 'song', 'Op. 85a', NULL, NULL, 1960, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 모음곡 <벨린스키>'
);


-- Op. 86 돌마톱스키의 시에 의한 4개의 노래

UPDATE pieces piece
SET piece.title = '돌마톱스키의 시에 의한 4개의 노래', piece.title_en = 'Four Songs to Words by Dolmatovsky',
    piece.type = 'album', piece.opus_number = 'Op. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1951, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12763 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1951
WHERE piece.id = 12763 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '조국은 듣는다', part.name_en = 'The Homeland Hears',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12763 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:384ce842-3f88-4c35-9c4c-b5b7a97beba1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:384ce842-3f88-4c35-9c4c-b5b7a97beba1', 1, NULL, '조국은 듣는다', 'The Homeland Hears', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12763 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:384ce842-3f88-4c35-9c4c-b5b7a97beba1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '나를 구해 줘', part.name_en = 'Rescue Me',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12763 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4858f929-35e3-4958-8967-0f73968beed0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4858f929-35e3-4958-8967-0f73968beed0', 2, NULL, '나를 구해 줘', 'Rescue Me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12763 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4858f929-35e3-4958-8967-0f73968beed0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '사랑한다, 사랑하지 않는다', part.name_en = 'He Loves Me, He Loves Me Not',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12763 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f537b90f-b040-4502-819d-4b8decc71bc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f537b90f-b040-4502-819d-4b8decc71bc6', 3, NULL, '사랑한다, 사랑하지 않는다', 'He Loves Me, He Loves Me Not', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12763 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f537b90f-b040-4502-819d-4b8decc71bc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '잘 자라, 내 아가 (자장가)', part.name_en = 'Sleep, My Darling Boy (Lullaby)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12763 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4da4adb0-5d33-4156-b3d4-a8e12ed0ad87' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4da4adb0-5d33-4156-b3d4-a8e12ed0ad87', 4, NULL, '잘 자라, 내 아가 (자장가)', 'Sleep, My Darling Boy (Lullaby)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12763 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4da4adb0-5d33-4156-b3d4-a8e12ed0ad87'
);


-- Op. 87 24개의 전주곡과 푸가

UPDATE pieces piece
SET piece.title = '24개의 전주곡과 푸가', piece.title_en = '24 Preludes and Fugues, Op. 87',
    piece.type = 'album', piece.opus_number = 'Op. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1951, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12832 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1951
WHERE piece.id = 12832 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'C장조', part.name_en = 'No. 1 in C major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:edb0dcad-320f-4790-9cf5-a47401fd8e11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edb0dcad-320f-4790-9cf5-a47401fd8e11', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edb0dcad-320f-4790-9cf5-a47401fd8e11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:edb0dcad-320f-4790-9cf5-a47401fd8e11'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d723f03b-e63e-4a73-8f4c-71de48485b4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d723f03b-e63e-4a73-8f4c-71de48485b4d', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:edb0dcad-320f-4790-9cf5-a47401fd8e11'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d723f03b-e63e-4a73-8f4c-71de48485b4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:edb0dcad-320f-4790-9cf5-a47401fd8e11'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:22d7d749-4e25-4adc-abb0-ea9c0685e72e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22d7d749-4e25-4adc-abb0-ea9c0685e72e', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:edb0dcad-320f-4790-9cf5-a47401fd8e11'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22d7d749-4e25-4adc-abb0-ea9c0685e72e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A단조', part.name_en = 'No. 2 in A minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:67a5a3af-2725-435f-8095-12199a26da68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67a5a3af-2725-435f-8095-12199a26da68', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67a5a3af-2725-435f-8095-12199a26da68'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:67a5a3af-2725-435f-8095-12199a26da68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8d8af45a-d4d9-4082-8bc8-600d8e46fe63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d8af45a-d4d9-4082-8bc8-600d8e46fe63', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:67a5a3af-2725-435f-8095-12199a26da68'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d8af45a-d4d9-4082-8bc8-600d8e46fe63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:67a5a3af-2725-435f-8095-12199a26da68'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e2f06dfd-8be1-484c-9a91-29ef2f3a5711' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e2f06dfd-8be1-484c-9a91-29ef2f3a5711', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:67a5a3af-2725-435f-8095-12199a26da68'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2f06dfd-8be1-484c-9a91-29ef2f3a5711'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = 'No. 3 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e3322d6c-8f1a-460d-a428-60b9a9c6d015' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3322d6c-8f1a-460d-a428-60b9a9c6d015', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3322d6c-8f1a-460d-a428-60b9a9c6d015'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e3322d6c-8f1a-460d-a428-60b9a9c6d015'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:168b28b1-70df-4713-8ee6-7e077a8fc8cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:168b28b1-70df-4713-8ee6-7e077a8fc8cd', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e3322d6c-8f1a-460d-a428-60b9a9c6d015'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:168b28b1-70df-4713-8ee6-7e077a8fc8cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e3322d6c-8f1a-460d-a428-60b9a9c6d015'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f841b9bf-860f-43b7-bfec-c4910c15d2bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f841b9bf-860f-43b7-bfec-c4910c15d2bb', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e3322d6c-8f1a-460d-a428-60b9a9c6d015'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f841b9bf-860f-43b7-bfec-c4910c15d2bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'E단조', part.name_en = 'No. 4 in E minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:58760ec9-7155-4c6f-a77a-d9c3d10482f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58760ec9-7155-4c6f-a77a-d9c3d10482f9', 4, NULL, 'E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58760ec9-7155-4c6f-a77a-d9c3d10482f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:58760ec9-7155-4c6f-a77a-d9c3d10482f9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ba5999cc-51cd-43db-b52e-cec091ac6df4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba5999cc-51cd-43db-b52e-cec091ac6df4', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:58760ec9-7155-4c6f-a77a-d9c3d10482f9'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba5999cc-51cd-43db-b52e-cec091ac6df4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:58760ec9-7155-4c6f-a77a-d9c3d10482f9'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3aa308d9-4bbf-4cf6-965a-a730d7301e56' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3aa308d9-4bbf-4cf6-965a-a730d7301e56', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:58760ec9-7155-4c6f-a77a-d9c3d10482f9'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aa308d9-4bbf-4cf6-965a-a730d7301e56'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'D장조', part.name_en = 'No. 5 in D major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:09406310-55e2-4767-bc9d-553aa0a30836' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09406310-55e2-4767-bc9d-553aa0a30836', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09406310-55e2-4767-bc9d-553aa0a30836'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09406310-55e2-4767-bc9d-553aa0a30836'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8b8f98dd-b5a5-4c37-9e96-bec3b36ea17d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b8f98dd-b5a5-4c37-9e96-bec3b36ea17d', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09406310-55e2-4767-bc9d-553aa0a30836'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b8f98dd-b5a5-4c37-9e96-bec3b36ea17d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09406310-55e2-4767-bc9d-553aa0a30836'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:61a4cc19-94f7-4a2a-a47e-3df81cac4452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:61a4cc19-94f7-4a2a-a47e-3df81cac4452', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:09406310-55e2-4767-bc9d-553aa0a30836'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61a4cc19-94f7-4a2a-a47e-3df81cac4452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'B단조', part.name_en = 'No. 6 in B minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8d82579a-6f5a-45a7-a2d9-54fd4daf26e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d82579a-6f5a-45a7-a2d9-54fd4daf26e5', 6, NULL, 'B단조', 'No. 6 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d82579a-6f5a-45a7-a2d9-54fd4daf26e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8d82579a-6f5a-45a7-a2d9-54fd4daf26e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a19e1152-0c08-48e1-b4ab-8f5613c2557c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a19e1152-0c08-48e1-b4ab-8f5613c2557c', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8d82579a-6f5a-45a7-a2d9-54fd4daf26e5'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a19e1152-0c08-48e1-b4ab-8f5613c2557c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8d82579a-6f5a-45a7-a2d9-54fd4daf26e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8134166f-850c-40d3-b090-2a240fc8bf66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8134166f-850c-40d3-b090-2a240fc8bf66', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8d82579a-6f5a-45a7-a2d9-54fd4daf26e5'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8134166f-850c-40d3-b090-2a240fc8bf66'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'A장조', part.name_en = 'No. 7 in A major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1062edd2-8e08-4ee8-a888-0db801247219' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1062edd2-8e08-4ee8-a888-0db801247219', 7, NULL, 'A장조', 'No. 7 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1062edd2-8e08-4ee8-a888-0db801247219'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1062edd2-8e08-4ee8-a888-0db801247219'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c7f8f7a0-228d-40bf-851e-a67fc5ab27e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7f8f7a0-228d-40bf-851e-a67fc5ab27e9', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1062edd2-8e08-4ee8-a888-0db801247219'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7f8f7a0-228d-40bf-851e-a67fc5ab27e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1062edd2-8e08-4ee8-a888-0db801247219'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d625f51c-dfe0-4a61-ad4b-ef45355133ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d625f51c-dfe0-4a61-ad4b-ef45355133ad', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1062edd2-8e08-4ee8-a888-0db801247219'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d625f51c-dfe0-4a61-ad4b-ef45355133ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'F#단조', part.name_en = 'No. 8 in F# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a7982505-abee-450a-9c18-fc405d34c26c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7982505-abee-450a-9c18-fc405d34c26c', 8, NULL, 'F#단조', 'No. 8 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7982505-abee-450a-9c18-fc405d34c26c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a7982505-abee-450a-9c18-fc405d34c26c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1023a4a4-d6cd-4259-a0ed-26ad56b2fa81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1023a4a4-d6cd-4259-a0ed-26ad56b2fa81', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a7982505-abee-450a-9c18-fc405d34c26c'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1023a4a4-d6cd-4259-a0ed-26ad56b2fa81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a7982505-abee-450a-9c18-fc405d34c26c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:73b52135-3591-4b99-b234-54384948927a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73b52135-3591-4b99-b234-54384948927a', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a7982505-abee-450a-9c18-fc405d34c26c'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73b52135-3591-4b99-b234-54384948927a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = 'No. 9 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5078aa63-dc72-484b-88ed-133fd32231e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5078aa63-dc72-484b-88ed-133fd32231e5', 9, NULL, 'E장조', 'No. 9 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5078aa63-dc72-484b-88ed-133fd32231e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5078aa63-dc72-484b-88ed-133fd32231e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e3fe98a7-c808-4633-90f9-95e61a8785a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3fe98a7-c808-4633-90f9-95e61a8785a0', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5078aa63-dc72-484b-88ed-133fd32231e5'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3fe98a7-c808-4633-90f9-95e61a8785a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5078aa63-dc72-484b-88ed-133fd32231e5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fd581d3c-a519-4929-962b-9f586afc33fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd581d3c-a519-4929-962b-9f586afc33fa', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5078aa63-dc72-484b-88ed-133fd32231e5'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd581d3c-a519-4929-962b-9f586afc33fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'C#단조', part.name_en = 'No. 10 in C# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:254ae8d9-ac40-4352-bd5e-f3109488c79e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:254ae8d9-ac40-4352-bd5e-f3109488c79e', 10, NULL, 'C#단조', 'No. 10 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:254ae8d9-ac40-4352-bd5e-f3109488c79e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:254ae8d9-ac40-4352-bd5e-f3109488c79e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a1bc1fd1-180d-4fb2-9080-9c2367731542' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1bc1fd1-180d-4fb2-9080-9c2367731542', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:254ae8d9-ac40-4352-bd5e-f3109488c79e'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1bc1fd1-180d-4fb2-9080-9c2367731542'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:254ae8d9-ac40-4352-bd5e-f3109488c79e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2ba0d1ec-1377-42f2-acea-d84fc1d18c57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ba0d1ec-1377-42f2-acea-d84fc1d18c57', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:254ae8d9-ac40-4352-bd5e-f3109488c79e'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ba0d1ec-1377-42f2-acea-d84fc1d18c57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'B장조', part.name_en = 'No. 11 in B major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c6580ea9-7652-4168-821c-90d64132c7cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6580ea9-7652-4168-821c-90d64132c7cc', 11, NULL, 'B장조', 'No. 11 in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6580ea9-7652-4168-821c-90d64132c7cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6580ea9-7652-4168-821c-90d64132c7cc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:47dedc13-dd11-4ab7-bfa6-b46aacaf5638' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47dedc13-dd11-4ab7-bfa6-b46aacaf5638', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6580ea9-7652-4168-821c-90d64132c7cc'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47dedc13-dd11-4ab7-bfa6-b46aacaf5638'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6580ea9-7652-4168-821c-90d64132c7cc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ab42ca0e-fa0f-468d-b9ce-76c79c439fa1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab42ca0e-fa0f-468d-b9ce-76c79c439fa1', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6580ea9-7652-4168-821c-90d64132c7cc'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab42ca0e-fa0f-468d-b9ce-76c79c439fa1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'G#단조', part.name_en = 'No. 12 in G# minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a01c5334-9cba-453f-bfe8-1ec11b7f48c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a01c5334-9cba-453f-bfe8-1ec11b7f48c5', 12, NULL, 'G#단조', 'No. 12 in G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a01c5334-9cba-453f-bfe8-1ec11b7f48c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a01c5334-9cba-453f-bfe8-1ec11b7f48c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0f6758c2-0119-4241-b0b9-f28326595a90' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f6758c2-0119-4241-b0b9-f28326595a90', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a01c5334-9cba-453f-bfe8-1ec11b7f48c5'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f6758c2-0119-4241-b0b9-f28326595a90'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a01c5334-9cba-453f-bfe8-1ec11b7f48c5'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f4a0b3e1-38b8-4805-9258-1426de7b0d2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4a0b3e1-38b8-4805-9258-1426de7b0d2c', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a01c5334-9cba-453f-bfe8-1ec11b7f48c5'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4a0b3e1-38b8-4805-9258-1426de7b0d2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'F#장조', part.name_en = 'No. 13 in F# major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8573c33b-3efc-4a8c-95d0-e44195b0665e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8573c33b-3efc-4a8c-95d0-e44195b0665e', 13, NULL, 'F#장조', 'No. 13 in F# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8573c33b-3efc-4a8c-95d0-e44195b0665e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8573c33b-3efc-4a8c-95d0-e44195b0665e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:480a00d5-f12f-4d2c-8ca4-31ab851957d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:480a00d5-f12f-4d2c-8ca4-31ab851957d6', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8573c33b-3efc-4a8c-95d0-e44195b0665e'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:480a00d5-f12f-4d2c-8ca4-31ab851957d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8573c33b-3efc-4a8c-95d0-e44195b0665e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ceda5301-c623-4997-816a-de35532cc587' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ceda5301-c623-4997-816a-de35532cc587', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8573c33b-3efc-4a8c-95d0-e44195b0665e'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ceda5301-c623-4997-816a-de35532cc587'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'E♭단조', part.name_en = 'No. 14 in E♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e4e9649a-c12c-4e16-8df1-f5de8f964e11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4e9649a-c12c-4e16-8df1-f5de8f964e11', 14, NULL, 'E♭단조', 'No. 14 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4e9649a-c12c-4e16-8df1-f5de8f964e11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4e9649a-c12c-4e16-8df1-f5de8f964e11'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ac0b4f1e-2bfe-4795-be26-f507496608dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac0b4f1e-2bfe-4795-be26-f507496608dd', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4e9649a-c12c-4e16-8df1-f5de8f964e11'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac0b4f1e-2bfe-4795-be26-f507496608dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4e9649a-c12c-4e16-8df1-f5de8f964e11'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:9abc819e-75a2-41e1-8a68-134bf1c16a1a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9abc819e-75a2-41e1-8a68-134bf1c16a1a', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4e9649a-c12c-4e16-8df1-f5de8f964e11'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9abc819e-75a2-41e1-8a68-134bf1c16a1a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'D♭장조', part.name_en = 'No. 15 in D♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:40bb217a-8235-4e2d-8918-924a41096c2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40bb217a-8235-4e2d-8918-924a41096c2c', 15, NULL, 'D♭장조', 'No. 15 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40bb217a-8235-4e2d-8918-924a41096c2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40bb217a-8235-4e2d-8918-924a41096c2c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:97fd312b-9ddb-464f-927f-aea28d5ca4f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97fd312b-9ddb-464f-927f-aea28d5ca4f2', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40bb217a-8235-4e2d-8918-924a41096c2c'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97fd312b-9ddb-464f-927f-aea28d5ca4f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40bb217a-8235-4e2d-8918-924a41096c2c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e7a73492-3e42-4da7-b661-86b32deacc40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7a73492-3e42-4da7-b661-86b32deacc40', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:40bb217a-8235-4e2d-8918-924a41096c2c'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7a73492-3e42-4da7-b661-86b32deacc40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'B♭단조', part.name_en = 'No. 16 in B♭ minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c373703d-6a9d-4818-9f58-feedf584aff1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c373703d-6a9d-4818-9f58-feedf584aff1', 16, NULL, 'B♭단조', 'No. 16 in B♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c373703d-6a9d-4818-9f58-feedf584aff1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c373703d-6a9d-4818-9f58-feedf584aff1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:26fe9402-4667-4355-be28-9783a80b8f45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:26fe9402-4667-4355-be28-9783a80b8f45', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c373703d-6a9d-4818-9f58-feedf584aff1'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26fe9402-4667-4355-be28-9783a80b8f45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c373703d-6a9d-4818-9f58-feedf584aff1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f4457a99-31ce-4d88-b721-f77cd741f63f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4457a99-31ce-4d88-b721-f77cd741f63f', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c373703d-6a9d-4818-9f58-feedf584aff1'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4457a99-31ce-4d88-b721-f77cd741f63f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'A♭장조', part.name_en = 'No. 17 in A♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e5b52424-7427-4773-a64b-398a4a6019fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5b52424-7427-4773-a64b-398a4a6019fc', 17, NULL, 'A♭장조', 'No. 17 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5b52424-7427-4773-a64b-398a4a6019fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5b52424-7427-4773-a64b-398a4a6019fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b1736562-1e14-414a-958c-c442922e5674' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b1736562-1e14-414a-958c-c442922e5674', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5b52424-7427-4773-a64b-398a4a6019fc'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1736562-1e14-414a-958c-c442922e5674'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5b52424-7427-4773-a64b-398a4a6019fc'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fde609bd-3c6e-47c8-9631-b3c884a90740' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fde609bd-3c6e-47c8-9631-b3c884a90740', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5b52424-7427-4773-a64b-398a4a6019fc'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fde609bd-3c6e-47c8-9631-b3c884a90740'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'F단조', part.name_en = 'No. 18 in F minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:68151ea1-e2ee-4083-9e07-139551447b75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68151ea1-e2ee-4083-9e07-139551447b75', 18, NULL, 'F단조', 'No. 18 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68151ea1-e2ee-4083-9e07-139551447b75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68151ea1-e2ee-4083-9e07-139551447b75'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:18b71165-b191-4b8a-ac6c-314c08d55313' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:18b71165-b191-4b8a-ac6c-314c08d55313', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68151ea1-e2ee-4083-9e07-139551447b75'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18b71165-b191-4b8a-ac6c-314c08d55313'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68151ea1-e2ee-4083-9e07-139551447b75'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4ffd7c34-157e-4282-9e9f-67dc34687c93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ffd7c34-157e-4282-9e9f-67dc34687c93', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:68151ea1-e2ee-4083-9e07-139551447b75'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ffd7c34-157e-4282-9e9f-67dc34687c93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'E♭장조', part.name_en = 'No. 19 in E♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c550e31d-641f-4d96-9818-2263559004fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c550e31d-641f-4d96-9818-2263559004fd', 19, NULL, 'E♭장조', 'No. 19 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c550e31d-641f-4d96-9818-2263559004fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c550e31d-641f-4d96-9818-2263559004fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d398e78d-fd3f-4c7f-91bd-0f22bd3adca6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d398e78d-fd3f-4c7f-91bd-0f22bd3adca6', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c550e31d-641f-4d96-9818-2263559004fd'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d398e78d-fd3f-4c7f-91bd-0f22bd3adca6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c550e31d-641f-4d96-9818-2263559004fd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:16791309-8bff-41e9-87a7-c1d6d718926a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16791309-8bff-41e9-87a7-c1d6d718926a', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c550e31d-641f-4d96-9818-2263559004fd'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16791309-8bff-41e9-87a7-c1d6d718926a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'C단조', part.name_en = 'No. 20 in C minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:44c36736-cd66-4420-a7e5-0570791304ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44c36736-cd66-4420-a7e5-0570791304ae', 20, NULL, 'C단조', 'No. 20 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44c36736-cd66-4420-a7e5-0570791304ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:44c36736-cd66-4420-a7e5-0570791304ae'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:349283da-13b1-46e8-bfeb-767d8fa1f463' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:349283da-13b1-46e8-bfeb-767d8fa1f463', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:44c36736-cd66-4420-a7e5-0570791304ae'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349283da-13b1-46e8-bfeb-767d8fa1f463'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:44c36736-cd66-4420-a7e5-0570791304ae'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fc16d2cd-3ce3-4677-a516-c8803327fabb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc16d2cd-3ce3-4677-a516-c8803327fabb', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:44c36736-cd66-4420-a7e5-0570791304ae'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc16d2cd-3ce3-4677-a516-c8803327fabb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'B♭장조', part.name_en = 'No. 21 in B♭ major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d43baab6-0f81-4d6f-901a-61092276fe49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d43baab6-0f81-4d6f-901a-61092276fe49', 21, NULL, 'B♭장조', 'No. 21 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d43baab6-0f81-4d6f-901a-61092276fe49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d43baab6-0f81-4d6f-901a-61092276fe49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:87f3bd86-e407-4691-ab1b-185dd74b2d54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:87f3bd86-e407-4691-ab1b-185dd74b2d54', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d43baab6-0f81-4d6f-901a-61092276fe49'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87f3bd86-e407-4691-ab1b-185dd74b2d54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d43baab6-0f81-4d6f-901a-61092276fe49'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2648f643-f04f-4322-8ada-6099389bead1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2648f643-f04f-4322-8ada-6099389bead1', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d43baab6-0f81-4d6f-901a-61092276fe49'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2648f643-f04f-4322-8ada-6099389bead1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'G단조', part.name_en = 'No. 22 in G minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:00bf8732-8acb-475b-bb48-7682a2a2ac63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00bf8732-8acb-475b-bb48-7682a2a2ac63', 22, NULL, 'G단조', 'No. 22 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00bf8732-8acb-475b-bb48-7682a2a2ac63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00bf8732-8acb-475b-bb48-7682a2a2ac63'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e26955a6-a5b6-49cd-bbb7-8fec4613066d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e26955a6-a5b6-49cd-bbb7-8fec4613066d', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00bf8732-8acb-475b-bb48-7682a2a2ac63'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e26955a6-a5b6-49cd-bbb7-8fec4613066d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00bf8732-8acb-475b-bb48-7682a2a2ac63'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:49e61998-f794-4fb5-8e9b-50fad0bfea20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49e61998-f794-4fb5-8e9b-50fad0bfea20', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00bf8732-8acb-475b-bb48-7682a2a2ac63'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49e61998-f794-4fb5-8e9b-50fad0bfea20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'F장조', part.name_en = 'No. 23 in F major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4eaba9a8-1c01-47e1-a48e-f7669a344e4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4eaba9a8-1c01-47e1-a48e-f7669a344e4d', 23, NULL, 'F장조', 'No. 23 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4eaba9a8-1c01-47e1-a48e-f7669a344e4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4eaba9a8-1c01-47e1-a48e-f7669a344e4d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8408bd36-1e02-4f87-99ba-931ee2d3fda8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8408bd36-1e02-4f87-99ba-931ee2d3fda8', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4eaba9a8-1c01-47e1-a48e-f7669a344e4d'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8408bd36-1e02-4f87-99ba-931ee2d3fda8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4eaba9a8-1c01-47e1-a48e-f7669a344e4d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:72098650-37d7-4d4d-a6d2-6b086ad863d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72098650-37d7-4d4d-a6d2-6b086ad863d4', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4eaba9a8-1c01-47e1-a48e-f7669a344e4d'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72098650-37d7-4d4d-a6d2-6b086ad863d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'D단조', part.name_en = 'No. 24 in D minor',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:83ea93be-c8e7-4a22-adae-ee4d504bdb52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83ea93be-c8e7-4a22-adae-ee4d504bdb52', 24, NULL, 'D단조', 'No. 24 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83ea93be-c8e7-4a22-adae-ee4d504bdb52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83ea93be-c8e7-4a22-adae-ee4d504bdb52'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4ec64ed8-b440-4078-88bb-fd338b34b7e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ec64ed8-b440-4078-88bb-fd338b34b7e1', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83ea93be-c8e7-4a22-adae-ee4d504bdb52'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ec64ed8-b440-4078-88bb-fd338b34b7e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83ea93be-c8e7-4a22-adae-ee4d504bdb52'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '푸가', part.name_en = 'II. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12832 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:69e2f932-6ed7-4f84-b151-7a702830a052' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69e2f932-6ed7-4f84-b151-7a702830a052', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83ea93be-c8e7-4a22-adae-ee4d504bdb52'
WHERE p.id = 12832 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69e2f932-6ed7-4f84-b151-7a702830a052'
);


-- Op. 88 혁명 시인의 시에 의한 10개의 합창시

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혁명 시인의 시에 의한 10개의 합창시', 'Ten Poems on Texts by Revolutionary Poets of the Late 19th and Early 20th Centuries', 'song', 'Op. 88', NULL, NULL, 1951, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혁명 시인의 시에 의한 10개의 합창시'
);


-- Op. 89 영화음악 <잊을 수 없는 1919년>

UPDATE pieces piece
SET piece.title = '영화음악 <잊을 수 없는 1919년>', piece.title_en = 'The Unforgettable Year 1919',
    piece.type = 'song', piece.opus_number = 'Op. 89',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1951, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12914 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1951
WHERE piece.id = 12914 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 89a 영화 모음곡 <잊을 수 없는 1919년>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <잊을 수 없는 1919년>', piece.title_en = 'Suite from The Unforgettable Year 1919',
    piece.type = 'album', piece.opus_number = 'Op. 89a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1953, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12288 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1953
WHERE piece.id = 12288 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12288 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5db9aaf6-3f71-47c7-a6eb-c969d1a3fcbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5db9aaf6-3f71-47c7-a6eb-c969d1a3fcbf', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12288 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5db9aaf6-3f71-47c7-a6eb-c969d1a3fcbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '로망스', part.name_en = 'II. Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12288 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4f681cdc-9322-452d-aec9-8b654cd90c81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f681cdc-9322-452d-aec9-8b654cd90c81', 2, 'II', '로망스', 'II. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12288 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f681cdc-9322-452d-aec9-8b654cd90c81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '해전 장면', part.name_en = 'III. Scene of the Sea Battle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12288 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e92fc815-b18e-486a-8b49-ba260f24ae8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e92fc815-b18e-486a-8b49-ba260f24ae8e', 3, 'III', '해전 장면', 'III. Scene of the Sea Battle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12288 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e92fc815-b18e-486a-8b49-ba260f24ae8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '스케르초', part.name_en = 'IV. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12288 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6f72787d-6191-486f-ad89-5aa6e463f75f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f72787d-6191-486f-ad89-5aa6e463f75f', 4, 'IV', '스케르초', 'IV. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12288 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f72787d-6191-486f-ad89-5aa6e463f75f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '크라스나야 고르카 공격', part.name_en = 'V. The Assault on Krasnaya Gorka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12288 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4db4ee3a-b665-41bf-b862-977b1f064ee8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4db4ee3a-b665-41bf-b862-977b1f064ee8', 5, 'V', '크라스나야 고르카 공격', 'V. The Assault on Krasnaya Gorka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12288 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4db4ee3a-b665-41bf-b862-977b1f064ee8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '간주곡', part.name_en = 'VI. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12288 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6f51e582-c0b6-4303-b685-05ee07d9382b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f51e582-c0b6-4303-b685-05ee07d9382b', 6, 'VI', '간주곡', 'VI. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12288 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f51e582-c0b6-4303-b685-05ee07d9382b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '피날레', part.name_en = 'VII. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12288 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3b620fb2-a4a9-4242-a53d-6404dc98acac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b620fb2-a4a9-4242-a53d-6404dc98acac', 7, 'VII', '피날레', 'VII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12288 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b620fb2-a4a9-4242-a53d-6404dc98acac'
);


-- Op. 90 칸타타 <조국에 태양이 빛난다>

UPDATE pieces piece
SET piece.title = '칸타타 <조국에 태양이 빛난다>', piece.title_en = 'The Sun Shines over Our Motherland',
    piece.type = 'song', piece.opus_number = 'Op. 90',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1952, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12056 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1952
WHERE piece.id = 12056 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 91 푸시킨의 시에 의한 4개의 독백

UPDATE pieces piece
SET piece.title = '푸시킨의 시에 의한 4개의 독백', piece.title_en = 'Four Monologues on Verses by Pushkin',
    piece.type = 'album', piece.opus_number = 'Op. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1952, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13397 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1952
WHERE piece.id = 13397 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '단편', part.name_en = 'Fragment',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13397 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:65d1ed92-b528-45c8-b2b7-013f74931917' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65d1ed92-b528-45c8-b2b7-013f74931917', 1, NULL, '단편', 'Fragment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13397 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65d1ed92-b528-45c8-b2b7-013f74931917'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '내 이름이 너에게 무슨 뜻이 있으랴', part.name_en = 'What Is My Name to You?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13397 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:632bd866-ef1a-4a8a-b7e1-3828b42d6faf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:632bd866-ef1a-4a8a-b7e1-3828b42d6faf', 2, NULL, '내 이름이 너에게 무슨 뜻이 있으랴', 'What Is My Name to You?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13397 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:632bd866-ef1a-4a8a-b7e1-3828b42d6faf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '시베리아 광산 깊은 곳에', part.name_en = 'In the Depths of the Siberian Mines',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13397 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4cfe5ea4-e151-4607-8c05-5d6a1b070cff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cfe5ea4-e151-4607-8c05-5d6a1b070cff', 3, NULL, '시베리아 광산 깊은 곳에', 'In the Depths of the Siberian Mines', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13397 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cfe5ea4-e151-4607-8c05-5d6a1b070cff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '작별', part.name_en = 'Farewell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13397 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:523036c0-ca94-49e8-96e0-0782a6c6f5e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:523036c0-ca94-49e8-96e0-0782a6c6f5e5', 4, NULL, '작별', 'Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13397 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:523036c0-ca94-49e8-96e0-0782a6c6f5e5'
);


-- Op. 92 현악 4중주 5번 B♭장조

UPDATE pieces piece
SET piece.title = '현악 4중주 5번 B♭장조', piece.title_en = 'String Quartet No. 5 in B♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1952, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13590 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1952
WHERE piece.id = 13590 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro non troppo', part.name_en = 'I. Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13590 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3df28b7f-6102-39ba-86de-0b3b51c0b4f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3df28b7f-6102-39ba-86de-0b3b51c0b4f1', 1, 'I', 'Allegro non troppo', 'I. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13590 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3df28b7f-6102-39ba-86de-0b3b51c0b4f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13590 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:9f3249f3-3539-3630-a551-855a7c845da3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f3249f3-3539-3630-a551-855a7c845da3', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13590 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f3249f3-3539-3630-a551-855a7c845da3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Moderato – Allegretto', part.name_en = 'III. Moderato – Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13590 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:483aa756-470c-3db0-9cca-7568b9cc0d1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:483aa756-470c-3db0-9cca-7568b9cc0d1f', 3, 'III', 'Moderato – Allegretto', 'III. Moderato – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13590 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:483aa756-470c-3db0-9cca-7568b9cc0d1f'
);


-- Op. 93 교향곡 10번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 10번 E단조', 'Symphony No. 10 in E minor', 'album', 'Op. 93', NULL, NULL, 1953, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 10번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1246634-e7d2-4887-9d19-62914e79269d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1246634-e7d2-4887-9d19-62914e79269d'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 10번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1246634-e7d2-4887-9d19-62914e79269d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa26d183-5370-33a4-b981-a58734d4fc30', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 10번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa26d183-5370-33a4-b981-a58734d4fc30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7454b852-6261-3726-b83f-417cada3e653', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 10번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7454b852-6261-3726-b83f-417cada3e653'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:047e395a-b583-366f-9171-ff9dcfe79583', 3, 'III', 'Allegretto – Largo – Più mosso', 'III. Allegretto – Largo – Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 10번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:047e395a-b583-366f-9171-ff9dcfe79583'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:788af57f-8054-3a3f-82c1-34930b4daabe', 4, 'IV', 'Andante – Allegro – L''istesso tempo', 'IV. Andante – Allegro – L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '교향곡 10번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:788af57f-8054-3a3f-82c1-34930b4daabe'
);


-- Op. 94 2대의 피아노를 위한 콘체르티노 A단조

UPDATE pieces piece
SET piece.title = '2대의 피아노를 위한 콘체르티노 A단조', piece.title_en = 'Concertino in A minor for Two Pianos',
    piece.type = 'song', piece.opus_number = 'Op. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1953, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12167 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1953
WHERE piece.id = 12167 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 95 영화음악 <위대한 강들의 노래>

UPDATE pieces piece
SET piece.title = '영화음악 <위대한 강들의 노래>', piece.title_en = 'Song of the Great Rivers',
    piece.type = 'song', piece.opus_number = 'Op. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1954, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13458 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1954
WHERE piece.id = 13458 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 96 축전 서곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축전 서곡 A장조', 'Festive Overture in A major', 'song', 'Op. 96', NULL, NULL, 1954, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축전 서곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f59de04-1804-319a-9f03-ada8f3fedd26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f59de04-1804-319a-9f03-ada8f3fedd26'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '축전 서곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f59de04-1804-319a-9f03-ada8f3fedd26'
);


-- Op. 97 영화음악 <등에>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <등에>', 'The Gadfly', 'song', 'Op. 97', NULL, NULL, 1955, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <등에>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b031128c-f0bf-4c3e-b532-fa3e59510e8e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b031128c-f0bf-4c3e-b532-fa3e59510e8e'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화음악 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b031128c-f0bf-4c3e-b532-fa3e59510e8e'
);


-- Op. 97a 영화 모음곡 <등에>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 모음곡 <등에>', 'Suite from The Gadfly', 'album', 'Op. 97a', NULL, NULL, 1955, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 모음곡 <등에>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c928b9f-80ff-4bbd-a741-98f883fc0fc2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c928b9f-80ff-4bbd-a741-98f883fc0fc2'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c928b9f-80ff-4bbd-a741-98f883fc0fc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:921e1040-f3c9-41cb-a546-04dfe0141da4', 1, 'I', '서곡', 'I. Overture', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:921e1040-f3c9-41cb-a546-04dfe0141da4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f161dc5e-4eed-4edd-ac34-922c21f5f03a', 2, 'II', '콩트르당스', 'II. Contredanse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f161dc5e-4eed-4edd-ac34-922c21f5f03a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e4b8d2e-e83e-4823-8bb7-43726bd9987e', 3, 'III', '민속 축제', 'III. Folk Feast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e4b8d2e-e83e-4823-8bb7-43726bd9987e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fd1ecbd-0368-4621-94a1-1fbe01308a20', 4, 'IV', '간주곡', 'IV. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fd1ecbd-0368-4621-94a1-1fbe01308a20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ab5e8bd-1c9c-4b46-9c14-94ae46c83866', 5, 'V', '손풍금 왈츠', 'V. Barrel-organ Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ab5e8bd-1c9c-4b46-9c14-94ae46c83866'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea5af57b-7913-451e-9c69-7e526776dcdb', 6, 'VI', '갤럽', 'VI. Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea5af57b-7913-451e-9c69-7e526776dcdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e296c97-3579-47a4-ae57-b0538e908a48', 7, 'VII', '서주', 'VII. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e296c97-3579-47a4-ae57-b0538e908a48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:765c5724-e9c3-3101-bcc0-26b82a6112fa', 8, 'VIII', '로망스', 'VIII. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:765c5724-e9c3-3101-bcc0-26b82a6112fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2f640b5-4f16-4b97-9449-805e94c96d07', 9, 'IX', '인테르메초', 'IX. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2f640b5-4f16-4b97-9449-805e94c96d07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87e4acec-83eb-41b7-9954-4a6edb56dcd6', 10, 'X', '녹턴', 'X. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87e4acec-83eb-41b7-9954-4a6edb56dcd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a72d7040-0a69-4b7a-aaf0-4945a2665fa1', 11, 'XI', '장면', 'XI. Scene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a72d7040-0a69-4b7a-aaf0-4945a2665fa1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eac8be6-b9b1-46ac-a166-810376de8dcd', 12, 'XII', '피날레', 'XII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '영화 모음곡 <등에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eac8be6-b9b1-46ac-a166-810376de8dcd'
);


-- Op. 98 돌마톱스키의 시에 의한 5개의 로망스

UPDATE pieces piece
SET piece.title = '돌마톱스키의 시에 의한 5개의 로망스', piece.title_en = 'Five Romances on Verses by Dolmatovsky',
    piece.type = 'album', piece.opus_number = 'Op. 98',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1954, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13308 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1954
WHERE piece.id = 13308 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '첫 만남의 날', part.name_en = 'The Day of Our First Meeting',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13308 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:092ce4ab-6d02-4739-a53b-59aafad0d1e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:092ce4ab-6d02-4739-a53b-59aafad0d1e2', 1, NULL, '첫 만남의 날', 'The Day of Our First Meeting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13308 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:092ce4ab-6d02-4739-a53b-59aafad0d1e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '사랑 고백의 날', part.name_en = 'The Day of Declaration of Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13308 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4a5ceda8-42db-4407-b708-f20b5b3f2630' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a5ceda8-42db-4407-b708-f20b5b3f2630', 2, NULL, '사랑 고백의 날', 'The Day of Declaration of Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13308 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a5ceda8-42db-4407-b708-f20b5b3f2630'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '다툼의 날', part.name_en = 'The Day of Tiffs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13308 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:34adee10-ffc2-4bfa-bf3d-1242ae7ee1f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34adee10-ffc2-4bfa-bf3d-1242ae7ee1f5', 3, NULL, '다툼의 날', 'The Day of Tiffs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13308 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34adee10-ffc2-4bfa-bf3d-1242ae7ee1f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '행복의 날', part.name_en = 'The Day of Happiness',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13308 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:797c9f84-b991-46bd-9f8e-667c0f709893' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:797c9f84-b991-46bd-9f8e-667c0f709893', 4, NULL, '행복의 날', 'The Day of Happiness', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13308 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:797c9f84-b991-46bd-9f8e-667c0f709893'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '추억의 날', part.name_en = 'The Day of Reminiscences',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13308 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6dade29e-dd9c-40cc-8a97-eeba651fda6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6dade29e-dd9c-40cc-8a97-eeba651fda6e', 5, NULL, '추억의 날', 'The Day of Reminiscences', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13308 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6dade29e-dd9c-40cc-8a97-eeba651fda6e'
);


-- Op. 99 영화음악 <첫 번째 제대>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <첫 번째 제대>', 'The First Echelon', 'song', 'Op. 99', NULL, NULL, 1956, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <첫 번째 제대>'
);


-- Op. 99a 영화 모음곡 <첫 번째 제대>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 모음곡 <첫 번째 제대>', 'Suite from The First Echelon', 'song', 'Op. 99a', NULL, NULL, 1956, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 모음곡 <첫 번째 제대>'
);


-- Op. 101 현악 4중주 6번 G장조

UPDATE pieces piece
SET piece.title = '현악 4중주 6번 G장조', piece.title_en = 'String Quartet No. 6 in G major',
    piece.type = 'album', piece.opus_number = 'Op. 101',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1956, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12297 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1956
WHERE piece.id = 12297 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:89eda310-d89b-32ed-82b6-494be145f95a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89eda310-d89b-32ed-82b6-494be145f95a', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89eda310-d89b-32ed-82b6-494be145f95a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato con moto', part.name_en = 'II. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c38ac137-4ecc-3399-b7e6-c4f33e1cebd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c38ac137-4ecc-3399-b7e6-c4f33e1cebd0', 2, 'II', 'Moderato con moto', 'II. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c38ac137-4ecc-3399-b7e6-c4f33e1cebd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lento', part.name_en = 'III. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b34b6a8b-8af5-36dd-9a27-63b8c4b76945' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b34b6a8b-8af5-36dd-9a27-63b8c4b76945', 3, 'III', 'Lento', 'III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b34b6a8b-8af5-36dd-9a27-63b8c4b76945'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Lento – Allegretto', part.name_en = 'IV. Lento – Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12297 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ca102798-890a-39e8-b820-0aac8139304c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca102798-890a-39e8-b820-0aac8139304c', 4, 'IV', 'Lento – Allegretto', 'IV. Lento – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12297 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca102798-890a-39e8-b820-0aac8139304c'
);


-- Op. 102 피아노 협주곡 2번 F장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 458 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:df63906c-f51a-301d-9220-58425a2100cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante', part.name_en = 'II. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 458 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:37e6e498-6376-3346-bec1-1d0f9eaeb823' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 458 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3ca3c170-c8f2-357a-b8f5-2ecdcfe3aa6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));


-- Op. 103 교향곡 11번 G단조 "1905년"

UPDATE pieces piece
SET piece.title = '교향곡 11번 G단조 "1905년"', piece.title_en = 'Symphony No. 11 in G minor "The Year 1905"',
    piece.type = 'album', piece.opus_number = 'Op. 103',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1957, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12628 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1957
WHERE piece.id = 12628 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '궁전 광장. Adagio', part.name_en = 'I. The Palace Square. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12628 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c8a194bf-30ed-3662-85f1-4c82d0fae008' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8a194bf-30ed-3662-85f1-4c82d0fae008', 1, 'I', '궁전 광장. Adagio', 'I. The Palace Square. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12628 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8a194bf-30ed-3662-85f1-4c82d0fae008'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '1월 9일. Adagio – Allegro – Adagio', part.name_en = 'II. The Ninth of January. Adagio – Allegro – Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12628 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5d506caa-b949-3142-91a1-34940be2a74a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d506caa-b949-3142-91a1-34940be2a74a', 2, 'II', '1월 9일. Adagio – Allegro – Adagio', 'II. The Ninth of January. Adagio – Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12628 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d506caa-b949-3142-91a1-34940be2a74a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '영원한 기억. Adagio', part.name_en = 'III. Eternal Memory. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12628 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3d4d55dc-d159-33b1-bb98-1c778640f971' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d4d55dc-d159-33b1-bb98-1c778640f971', 3, 'III', '영원한 기억. Adagio', 'III. Eternal Memory. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12628 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d4d55dc-d159-33b1-bb98-1c778640f971'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '경종. Allegro non troppo – Allegro – Moderato – Adagio – Allegro', part.name_en = 'IV. The Tocsin. Allegro non troppo – Allegro – Moderato – Adagio – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12628 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7442777d-d48c-38ff-a624-1b69d25f7947' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7442777d-d48c-38ff-a624-1b69d25f7947', 4, 'IV', '경종. Allegro non troppo – Allegro – Moderato – Adagio – Allegro', 'IV. The Tocsin. Allegro non troppo – Allegro – Moderato – Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12628 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7442777d-d48c-38ff-a624-1b69d25f7947'
);


-- Op. 105 오페레타 <모스크바, 체료무시키>

UPDATE pieces piece
SET piece.title = '오페레타 <모스크바, 체료무시키>', piece.title_en = 'Moscow, Cheryomushki',
    piece.type = 'song', piece.opus_number = 'Op. 105',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1958, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12034 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1958
WHERE piece.id = 12034 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 107 첼로 협주곡 1번 E♭장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 321 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d75de2f3-66ca-3018-9deb-341f58129994' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d75de2f3-66ca-3018-9deb-341f58129994', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 321 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d75de2f3-66ca-3018-9deb-341f58129994'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato', part.name_en = 'II. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 321 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7868fff0-2cc2-32d4-a26d-e9b6c20f1a46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7868fff0-2cc2-32d4-a26d-e9b6c20f1a46', 2, 'II', 'Moderato', 'II. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 321 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7868fff0-2cc2-32d4-a26d-e9b6c20f1a46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '카덴차', part.name_en = 'III. Cadenza',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 321 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4d4b8bc6-cd4b-311e-8b48-16c2bc3f520e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d4b8bc6-cd4b-311e-8b48-16c2bc3f520e', 3, 'III', '카덴차', 'III. Cadenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 321 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d4b8bc6-cd4b-311e-8b48-16c2bc3f520e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro con moto', part.name_en = 'IV. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 321 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:35f648bf-ef1b-378e-92c1-20df68c0ef1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35f648bf-ef1b-378e-92c1-20df68c0ef1d', 4, 'IV', 'Allegro con moto', 'IV. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 321 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35f648bf-ef1b-378e-92c1-20df68c0ef1d'
);


-- Op. 108 현악 4중주 7번 F#단조

UPDATE pieces piece
SET piece.title = '현악 4중주 7번 F#단조', piece.title_en = 'String Quartet No. 7 in F# minor',
    piece.type = 'album', piece.opus_number = 'Op. 108',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1960, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12472 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1960
WHERE piece.id = 12472 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12472 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:be631607-dd3b-3b51-9f89-c897a3d9d0b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be631607-dd3b-3b51-9f89-c897a3d9d0b2', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12472 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be631607-dd3b-3b51-9f89-c897a3d9d0b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento', part.name_en = 'II. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12472 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4d6864be-9abb-3701-94ed-31855fd29d78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d6864be-9abb-3701-94ed-31855fd29d78', 2, 'II', 'Lento', 'II. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12472 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d6864be-9abb-3701-94ed-31855fd29d78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro – Allegretto', part.name_en = 'III. Allegro – Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12472 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fb7033a9-bc43-3cbf-8ef1-3d98cf97a6a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb7033a9-bc43-3cbf-8ef1-3d98cf97a6a1', 3, 'III', 'Allegro – Allegretto', 'III. Allegro – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12472 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb7033a9-bc43-3cbf-8ef1-3d98cf97a6a1'
);


-- Op. 109 연가곡집 <풍자 (지난날의 그림)>

UPDATE pieces piece
SET piece.title = '연가곡집 <풍자 (지난날의 그림)>', piece.title_en = 'Satires (Pictures of the Past)',
    piece.type = 'album', piece.opus_number = 'Op. 109',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1960, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13636 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1960
WHERE piece.id = 13636 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '비평가에게', part.name_en = 'To a Critic',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13636 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:260e74b9-f26d-4e85-909e-fd01309b1645' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:260e74b9-f26d-4e85-909e-fd01309b1645', 1, NULL, '비평가에게', 'To a Critic', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13636 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:260e74b9-f26d-4e85-909e-fd01309b1645'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '봄의 깨어남', part.name_en = 'Spring Awakening',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13636 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c33a3967-c694-4846-bcf5-58250c2954fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c33a3967-c694-4846-bcf5-58250c2954fc', 2, NULL, '봄의 깨어남', 'Spring Awakening', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13636 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c33a3967-c694-4846-bcf5-58250c2954fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '후손', part.name_en = 'Descendants',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13636 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:80986f1f-6de3-402a-bdf2-0f90761d257b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80986f1f-6de3-402a-bdf2-0f90761d257b', 3, NULL, '후손', 'Descendants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13636 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80986f1f-6de3-402a-bdf2-0f90761d257b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '오해', part.name_en = 'Misunderstanding',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13636 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6f609599-827b-4740-8615-6873b1feebdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f609599-827b-4740-8615-6873b1feebdf', 4, NULL, '오해', 'Misunderstanding', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13636 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f609599-827b-4740-8615-6873b1feebdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '크로이처 소나타', part.name_en = 'Kreutzer Sonata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13636 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e056d390-690a-4cf1-8e3d-0fc03c01dfb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e056d390-690a-4cf1-8e3d-0fc03c01dfb9', 5, NULL, '크로이처 소나타', 'Kreutzer Sonata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13636 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e056d390-690a-4cf1-8e3d-0fc03c01dfb9'
);


-- Op. 110 현악 4중주 8번 C단조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 320 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6bccf951-4a88-3caa-b320-76bb3d9f2c4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bccf951-4a88-3caa-b320-76bb3d9f2c4d', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 320 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bccf951-4a88-3caa-b320-76bb3d9f2c4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro molto', part.name_en = 'II. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 320 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:de01cb61-395d-3711-8a92-17dbec132452' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de01cb61-395d-3711-8a92-17dbec132452', 2, 'II', 'Allegro molto', 'II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 320 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de01cb61-395d-3711-8a92-17dbec132452'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 320 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c119681c-9ee8-3351-bef1-7fb6326a09fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c119681c-9ee8-3351-bef1-7fb6326a09fa', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 320 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c119681c-9ee8-3351-bef1-7fb6326a09fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Largo', part.name_en = 'IV. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 320 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:60162d2a-1268-363f-b089-c622ee87e970' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60162d2a-1268-363f-b089-c622ee87e970', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 320 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60162d2a-1268-363f-b089-c622ee87e970'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Largo', part.name_en = 'V. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 320 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:dfa67875-9aff-3514-990e-d9a0e9d1195e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfa67875-9aff-3514-990e-d9a0e9d1195e', 5, 'V', 'Largo', 'V. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 320 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfa67875-9aff-3514-990e-d9a0e9d1195e'
);


-- Op. 111 영화음악 <닷새 낮 닷새 밤>

UPDATE pieces piece
SET piece.title = '영화음악 <닷새 낮 닷새 밤>', piece.title_en = 'Five Days, Five Nights',
    piece.type = 'song', piece.opus_number = 'Op. 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1960, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12219 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1960
WHERE piece.id = 12219 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 111a 영화 모음곡 <닷새 낮 닷새 밤>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <닷새 낮 닷새 밤>', piece.title_en = 'Suite from Five Days, Five Nights',
    piece.type = 'album', piece.opus_number = 'Op. 111a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1961, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12935 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1961
WHERE piece.id = 12935 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12935 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0d84fe7c-7daf-4ef4-a824-1941d5026a36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d84fe7c-7daf-4ef4-a824-1941d5026a36', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12935 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d84fe7c-7daf-4ef4-a824-1941d5026a36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '폐허가 된 드레스덴', part.name_en = 'II. Dresden in Ruins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12935 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2fdb7450-9d24-4421-a07d-30e8bbc6ab91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fdb7450-9d24-4421-a07d-30e8bbc6ab91', 2, 'II', '폐허가 된 드레스덴', 'II. Dresden in Ruins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12935 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fdb7450-9d24-4421-a07d-30e8bbc6ab91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '해방된 드레스덴', part.name_en = 'III. Liberated Dresden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12935 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4df23770-4a96-4fe8-8ab6-09cc9c985db9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4df23770-4a96-4fe8-8ab6-09cc9c985db9', 3, 'III', '해방된 드레스덴', 'III. Liberated Dresden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12935 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4df23770-4a96-4fe8-8ab6-09cc9c985db9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '간주곡', part.name_en = 'IV. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12935 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:070458dc-1183-4fdb-879b-f70526663ada' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:070458dc-1183-4fdb-879b-f70526663ada', 4, 'IV', '간주곡', 'IV. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12935 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:070458dc-1183-4fdb-879b-f70526663ada'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '피날레', part.name_en = 'V. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12935 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fe9f0627-0375-4b1e-8de7-6486d9807d3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe9f0627-0375-4b1e-8de7-6486d9807d3e', 5, 'V', '피날레', 'V. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12935 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe9f0627-0375-4b1e-8de7-6486d9807d3e'
);


-- None <노보로시스크의 종> (영원한 영광의 불꽃)

UPDATE pieces piece
SET piece.title = '<노보로시스크의 종> (영원한 영광의 불꽃)', piece.title_en = 'Novorossiysk Chimes (The Flame of Eternal Glory)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1960, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12841 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1960
WHERE piece.id = 12841 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 112 교향곡 12번 D단조 "1917년"

UPDATE pieces piece
SET piece.title = '교향곡 12번 D단조 "1917년"', piece.title_en = 'Symphony No. 12 in D minor "The Year 1917"',
    piece.type = 'album', piece.opus_number = 'Op. 112',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1961, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13311 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1961
WHERE piece.id = 13311 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '혁명의 페트로그라드. Moderato – Allegro', part.name_en = 'I. Revolutionary Petrograd. Moderato – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13311 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:65dbdd51-bb51-3553-b8c5-bc6fbf91cf12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65dbdd51-bb51-3553-b8c5-bc6fbf91cf12', 1, 'I', '혁명의 페트로그라드. Moderato – Allegro', 'I. Revolutionary Petrograd. Moderato – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13311 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65dbdd51-bb51-3553-b8c5-bc6fbf91cf12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '라즐리프. Allegro', part.name_en = 'II. Razliv. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13311 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:01eeabfa-eed5-366b-8392-9539697de775' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01eeabfa-eed5-366b-8392-9539697de775', 2, 'II', '라즐리프. Allegro', 'II. Razliv. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13311 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01eeabfa-eed5-366b-8392-9539697de775'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '오로라. Allegro', part.name_en = 'III. Aurora. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13311 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7efb6841-4fcc-3d7c-867d-15ab5f85445c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7efb6841-4fcc-3d7c-867d-15ab5f85445c', 3, 'III', '오로라. Allegro', 'III. Aurora. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13311 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7efb6841-4fcc-3d7c-867d-15ab5f85445c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '인류의 새벽. Allegro – Allegretto', part.name_en = 'IV. The Dawn of Humanity. Allegro – Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13311 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c41ed098-6357-3618-b76d-6e40d39d210a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c41ed098-6357-3618-b76d-6e40d39d210a', 4, 'IV', '인류의 새벽. Allegro – Allegretto', 'IV. The Dawn of Humanity. Allegro – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13311 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c41ed098-6357-3618-b76d-6e40d39d210a'
);


-- Op. 113 교향곡 13번 B♭단조 "바비 야르"

UPDATE pieces piece
SET piece.title = '교향곡 13번 B♭단조 "바비 야르"', piece.title_en = 'Symphony No. 13 in B♭ minor "Babi Yar"',
    piece.type = 'album', piece.opus_number = 'Op. 113',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1962, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12245 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1962
WHERE piece.id = 12245 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '바비 야르. Adagio', part.name_en = 'I. Babi Yar. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12245 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:50e9fd7b-ace9-4319-adcd-354fb1042eac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50e9fd7b-ace9-4319-adcd-354fb1042eac', 1, 'I', '바비 야르. Adagio', 'I. Babi Yar. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12245 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50e9fd7b-ace9-4319-adcd-354fb1042eac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '유머. Allegretto', part.name_en = 'II. Humour. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12245 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0210095e-8c2d-42ac-a3d0-a6ae8f5be558' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0210095e-8c2d-42ac-a3d0-a6ae8f5be558', 2, 'II', '유머. Allegretto', 'II. Humour. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12245 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0210095e-8c2d-42ac-a3d0-a6ae8f5be558'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '상점에서. Adagio', part.name_en = 'III. In the Store. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12245 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c1d071b1-47fe-461b-88b7-273bdbd5257b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1d071b1-47fe-461b-88b7-273bdbd5257b', 3, 'III', '상점에서. Adagio', 'III. In the Store. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12245 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1d071b1-47fe-461b-88b7-273bdbd5257b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '공포. Largo', part.name_en = 'IV. Fears. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12245 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8f81bc42-58a8-473e-aa71-aff5ecd3c20f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f81bc42-58a8-473e-aa71-aff5ecd3c20f', 4, 'IV', '공포. Largo', 'IV. Fears. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12245 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f81bc42-58a8-473e-aa71-aff5ecd3c20f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '출세. Allegretto', part.name_en = 'V. A Career. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12245 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:71e88528-09cf-430c-8f17-ba5e6d70b998' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71e88528-09cf-430c-8f17-ba5e6d70b998', 5, 'V', '출세. Allegretto', 'V. A Career. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12245 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71e88528-09cf-430c-8f17-ba5e6d70b998'
);


-- Op. 114 오페라 <카테리나 이즈마일로바>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <카테리나 이즈마일로바>', 'Katerina Izmailova', 'song', 'Op. 114', NULL, NULL, 1963, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <카테리나 이즈마일로바>'
);


-- Op. 114a 오페라 모음곡 <카테리나 이즈마일로바>

UPDATE pieces piece
SET piece.title = '오페라 모음곡 <카테리나 이즈마일로바>', piece.title_en = 'Suite from Katerina Izmailova',
    piece.type = 'album', piece.opus_number = 'Op. 114a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1963, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13171 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1963
WHERE piece.id = 13171 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13171 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c2b008a0-95ef-4093-ac45-b50ad7c7aec2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2b008a0-95ef-4093-ac45-b50ad7c7aec2', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13171 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2b008a0-95ef-4093-ac45-b50ad7c7aec2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13171 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b9224b52-66c5-426d-8700-e38f5f85d56f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9224b52-66c5-426d-8700-e38f5f85d56f', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13171 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9224b52-66c5-426d-8700-e38f5f85d56f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo', part.name_en = 'III. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13171 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4bf45a29-1230-4973-8fb4-76bd58365c34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bf45a29-1230-4973-8fb4-76bd58365c34', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13171 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bf45a29-1230-4973-8fb4-76bd58365c34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto', part.name_en = 'IV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13171 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ef363d75-c512-4143-a4f7-3245fd7e5390' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef363d75-c512-4143-a4f7-3245fd7e5390', 4, 'IV', 'Allegretto', 'IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13171 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef363d75-c512-4143-a4f7-3245fd7e5390'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Presto', part.name_en = 'V. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13171 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ed098a3d-3ee1-47a3-80cb-28174b82dac0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed098a3d-3ee1-47a3-80cb-28174b82dac0', 5, 'V', 'Presto', 'V. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13171 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed098a3d-3ee1-47a3-80cb-28174b82dac0'
);


-- Op. 115 러시아와 키르기스 민요 주제에 의한 서곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '러시아와 키르기스 민요 주제에 의한 서곡', 'Overture on Russian and Kirghiz Folk Themes', 'song', 'Op. 115', NULL, NULL, 1963, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '러시아와 키르기스 민요 주제에 의한 서곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb42a6d1-c542-42ce-a3a7-693a7e159a5e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb42a6d1-c542-42ce-a3a7-693a7e159a5e'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '러시아와 키르기스 민요 주제에 의한 서곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb42a6d1-c542-42ce-a3a7-693a7e159a5e'
);


-- Op. 116 영화음악 <햄릿>

UPDATE pieces piece
SET piece.title = '영화음악 <햄릿>', piece.title_en = 'Hamlet (film score)',
    piece.type = 'song', piece.opus_number = 'Op. 116',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1964, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12679 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1964
WHERE piece.id = 12679 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 116a 영화 모음곡 <햄릿>

UPDATE pieces piece
SET piece.title = '영화 모음곡 <햄릿>', piece.title_en = 'Suite from Hamlet (film score)',
    piece.type = 'album', piece.opus_number = 'Op. 116a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1964, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12837 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1964
WHERE piece.id = 12837 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주', part.name_en = 'I. Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12837 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d5f4a299-9bf5-47e9-b68f-28cd928ba90b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5f4a299-9bf5-47e9-b68f-28cd928ba90b', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12837 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5f4a299-9bf5-47e9-b68f-28cd928ba90b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '궁정의 무도회', part.name_en = 'II. Ball at the Palace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12837 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8c6e6007-4a2d-4f6f-98a9-b638230c3926' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c6e6007-4a2d-4f6f-98a9-b638230c3926', 2, 'II', '궁정의 무도회', 'II. Ball at the Palace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12837 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c6e6007-4a2d-4f6f-98a9-b638230c3926'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '유령', part.name_en = 'III. The Ghost',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12837 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:484cf58b-50bb-40ad-a138-0f99f31fe0e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:484cf58b-50bb-40ad-a138-0f99f31fe0e2', 3, 'III', '유령', 'III. The Ghost', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12837 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:484cf58b-50bb-40ad-a138-0f99f31fe0e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '정원에서', part.name_en = 'IV. In the Garden',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12837 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:bfd08dd7-dbe5-4e14-bfcc-faaa686e9634' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd08dd7-dbe5-4e14-bfcc-faaa686e9634', 4, 'IV', '정원에서', 'IV. In the Garden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12837 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd08dd7-dbe5-4e14-bfcc-faaa686e9634'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '독살 장면', part.name_en = 'V. Scene of the Poisoning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12837 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:672fb586-74b6-4833-9290-a9c1c2d46493' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:672fb586-74b6-4833-9290-a9c1c2d46493', 5, 'V', '독살 장면', 'V. Scene of the Poisoning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12837 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:672fb586-74b6-4833-9290-a9c1c2d46493'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '배우들의 도착과 극중극', part.name_en = 'VI. Arrival and Scene of the Players',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12837 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:13f8dfbd-1a99-4b55-8def-09804b7d292a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13f8dfbd-1a99-4b55-8def-09804b7d292a', 6, 'VI', '배우들의 도착과 극중극', 'VI. Arrival and Scene of the Players', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12837 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13f8dfbd-1a99-4b55-8def-09804b7d292a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '오필리아', part.name_en = 'VII. Ophelia',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12837 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7f4a69aa-162e-4a8c-a767-eff623c0360d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f4a69aa-162e-4a8c-a767-eff623c0360d', 7, 'VII', '오필리아', 'VII. Ophelia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12837 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f4a69aa-162e-4a8c-a767-eff623c0360d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '결투와 햄릿의 죽음', part.name_en = 'VIII. Duel and Death of Hamlet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12837 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:40420299-9a9f-410e-a653-620dfa473ac9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40420299-9a9f-410e-a653-620dfa473ac9', 8, 'VIII', '결투와 햄릿의 죽음', 'VIII. Duel and Death of Hamlet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12837 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40420299-9a9f-410e-a653-620dfa473ac9'
);


-- Op. 117 현악 4중주 9번 E♭장조

UPDATE pieces piece
SET piece.title = '현악 4중주 9번 E♭장조', piece.title_en = 'String Quartet No. 9 in E♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 117',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1964, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12255 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1964
WHERE piece.id = 12255 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato con moto', part.name_en = 'I. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12255 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8e2cb8e0-dbc2-3ac9-9404-f015fb293e81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e2cb8e0-dbc2-3ac9-9404-f015fb293e81', 1, 'I', 'Moderato con moto', 'I. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12255 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e2cb8e0-dbc2-3ac9-9404-f015fb293e81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12255 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c864fce2-c0fc-323c-86b2-5a5cac5abb17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c864fce2-c0fc-323c-86b2-5a5cac5abb17', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12255 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c864fce2-c0fc-323c-86b2-5a5cac5abb17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12255 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f832b83f-611e-34ec-a038-cf007de021c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f832b83f-611e-34ec-a038-cf007de021c6', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12255 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f832b83f-611e-34ec-a038-cf007de021c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12255 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:93901a1c-944f-3114-9944-5020ec3a505c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93901a1c-944f-3114-9944-5020ec3a505c', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12255 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93901a1c-944f-3114-9944-5020ec3a505c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro', part.name_en = 'V. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12255 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d9531b4f-4a2e-3680-ac99-1c2051d10ed8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9531b4f-4a2e-3680-ac99-1c2051d10ed8', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12255 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9531b4f-4a2e-3680-ac99-1c2051d10ed8'
);


-- Op. 118 현악 4중주 10번 A♭장조

UPDATE pieces piece
SET piece.title = '현악 4중주 10번 A♭장조', piece.title_en = 'String Quartet No. 10 in A♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 118',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1964, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12528 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1964
WHERE piece.id = 12528 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12528 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e17024e7-f9bd-33e2-9cda-8d946d308a99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e17024e7-f9bd-33e2-9cda-8d946d308a99', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12528 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e17024e7-f9bd-33e2-9cda-8d946d308a99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto furioso', part.name_en = 'II. Allegretto furioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12528 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f372c90a-ea37-35eb-8b83-d853acbdfec5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f372c90a-ea37-35eb-8b83-d853acbdfec5', 2, 'II', 'Allegretto furioso', 'II. Allegretto furioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12528 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f372c90a-ea37-35eb-8b83-d853acbdfec5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio', part.name_en = 'III. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12528 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:cc646ab1-674c-3ad6-a83a-fbafe943d70a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc646ab1-674c-3ad6-a83a-fbafe943d70a', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12528 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc646ab1-674c-3ad6-a83a-fbafe943d70a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegretto – Andante', part.name_en = 'IV. Allegretto – Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12528 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1e7b6f90-e532-35af-8000-49562ec27c53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e7b6f90-e532-35af-8000-49562ec27c53', 4, 'IV', 'Allegretto – Andante', 'IV. Allegretto – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12528 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e7b6f90-e532-35af-8000-49562ec27c53'
);


-- Op. 119 칸타타 <스테판 라진의 처형>

UPDATE pieces piece
SET piece.title = '칸타타 <스테판 라진의 처형>', piece.title_en = 'The Execution of Stepan Razin',
    piece.type = 'song', piece.opus_number = 'Op. 119',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1964, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12083 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1964
WHERE piece.id = 12083 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 120 영화음악 <일생 같은 한 해>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화음악 <일생 같은 한 해>', 'A Year Is Like a Lifetime', 'song', 'Op. 120', NULL, NULL, 1965, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화음악 <일생 같은 한 해>'
);


-- Op. 120a 영화 모음곡 <일생 같은 한 해>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영화 모음곡 <일생 같은 한 해>', 'Suite from A Year Is Like a Lifetime', 'song', 'Op. 120a', NULL, NULL, 1965, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영화 모음곡 <일생 같은 한 해>'
);


-- Op. 121 잡지 <크로코딜>의 글에 의한 5개의 로망스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '잡지 <크로코딜>의 글에 의한 5개의 로망스', 'Five Romances on Texts from the Magazine Krokodil', 'album', 'Op. 121', NULL, NULL, 1965, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '잡지 <크로코딜>의 글에 의한 5개의 로망스'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1bb9adf2-1fc5-44dd-863f-a1f1d0ae6f79'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1bb9adf2-1fc5-44dd-863f-a1f1d0ae6f79'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '잡지 <크로코딜>의 글에 의한 5개의 로망스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1bb9adf2-1fc5-44dd-863f-a1f1d0ae6f79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30be40ec-3ae0-4b0c-85a6-0192b06f13c5', 1, NULL, '직접 증언', 'First-hand Evidence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '잡지 <크로코딜>의 글에 의한 5개의 로망스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30be40ec-3ae0-4b0c-85a6-0192b06f13c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d3402dc-d68b-4d90-aa42-d427435635a7', 2, NULL, '교묘한 부탁', 'A Tricky Request', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '잡지 <크로코딜>의 글에 의한 5개의 로망스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d3402dc-d68b-4d90-aa42-d427435635a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9d38cb4-43d9-4724-98eb-5d62c8b268b0', 3, NULL, '신중함', 'Discretion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '잡지 <크로코딜>의 글에 의한 5개의 로망스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9d38cb4-43d9-4724-98eb-5d62c8b268b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d43059a-cb0a-439f-9b5d-926253b045a2', 4, NULL, '이린카와 목동', 'Irinka and the Shepherd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '잡지 <크로코딜>의 글에 의한 5개의 로망스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d43059a-cb0a-439f-9b5d-926253b045a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc6e3be8-131c-4fe5-8fc6-df3a96adee44', 5, NULL, '지극한 기쁨', 'Extreme Delight', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '잡지 <크로코딜>의 글에 의한 5개의 로망스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc6e3be8-131c-4fe5-8fc6-df3a96adee44'
);


-- Op. 122 현악 4중주 11번 F단조

UPDATE pieces piece
SET piece.title = '현악 4중주 11번 F단조', piece.title_en = 'String Quartet No. 11 in F minor',
    piece.type = 'album', piece.opus_number = 'Op. 122',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1966, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13104 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1966
WHERE piece.id = 13104 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주. Andantino', part.name_en = 'I. Introduction. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13104 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5264c19d-b115-35ef-90ce-9d4158747066' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5264c19d-b115-35ef-90ce-9d4158747066', 1, 'I', '서주. Andantino', 'I. Introduction. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13104 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5264c19d-b115-35ef-90ce-9d4158747066'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Allegretto', part.name_en = 'II. Scherzo. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13104 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:dd5b97fa-2039-35b4-9c7d-5068743153eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd5b97fa-2039-35b4-9c7d-5068743153eb', 2, 'II', '스케르초. Allegretto', 'II. Scherzo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13104 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd5b97fa-2039-35b4-9c7d-5068743153eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '레치타티보. Adagio', part.name_en = 'III. Recitative. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13104 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a7b4c325-542b-3499-96ec-0f5e959a384e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7b4c325-542b-3499-96ec-0f5e959a384e', 3, 'III', '레치타티보. Adagio', 'III. Recitative. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13104 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7b4c325-542b-3499-96ec-0f5e959a384e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '에튀드. Allegro', part.name_en = 'IV. Etude. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13104 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c4603e21-30ac-36fe-9dc7-4d9024b8b692' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4603e21-30ac-36fe-9dc7-4d9024b8b692', 4, 'IV', '에튀드. Allegro', 'IV. Etude. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13104 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4603e21-30ac-36fe-9dc7-4d9024b8b692'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '유머레스크. Allegro', part.name_en = 'V. Humoresque. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13104 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0f47f6b1-0195-3f7c-b846-d6c49bb78fe1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f47f6b1-0195-3f7c-b846-d6c49bb78fe1', 5, 'V', '유머레스크. Allegro', 'V. Humoresque. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13104 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f47f6b1-0195-3f7c-b846-d6c49bb78fe1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '엘레지. Adagio', part.name_en = 'VI. Elegy. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13104 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f190357c-bc42-30d9-a8f3-813e87eaa5ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f190357c-bc42-30d9-a8f3-813e87eaa5ec', 6, 'VI', '엘레지. Adagio', 'VI. Elegy. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13104 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f190357c-bc42-30d9-a8f3-813e87eaa5ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '피날레. Moderato', part.name_en = 'VII. Finale. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13104 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d41e5e22-e055-31d1-a14f-c0e00b6001e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d41e5e22-e055-31d1-a14f-c0e00b6001e9', 7, 'VII', '피날레. Moderato', 'VII. Finale. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13104 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d41e5e22-e055-31d1-a14f-c0e00b6001e9'
);


-- Op. 123 가곡 <내 작품 전집의 서문과 그 서문에 대한 짧은 생각>

UPDATE pieces piece
SET piece.title = '가곡 <내 작품 전집의 서문과 그 서문에 대한 짧은 생각>', piece.title_en = 'Preface to the Complete Edition of My Works and a Brief Reflection on this Preface',
    piece.type = 'song', piece.opus_number = 'Op. 123',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1966, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13214 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1966
WHERE piece.id = 13214 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 126 첼로 협주곡 2번 G단조

UPDATE pieces piece
SET piece.title = '첼로 협주곡 2번 G단조', piece.title_en = 'Cello Concerto No. 2 in G minor',
    piece.type = 'album', piece.opus_number = 'Op. 126',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1966, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12613 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1966
WHERE piece.id = 12613 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Largo', part.name_en = 'I. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12613 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ed639148-6d80-302e-b3f8-5013757ebea3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed639148-6d80-302e-b3f8-5013757ebea3', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12613 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed639148-6d80-302e-b3f8-5013757ebea3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초. Allegretto', part.name_en = 'II. Scherzo. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12613 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2727557d-8dd0-39c0-b3b7-62219ee06606' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2727557d-8dd0-39c0-b3b7-62219ee06606', 2, 'II', '스케르초. Allegretto', 'II. Scherzo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12613 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2727557d-8dd0-39c0-b3b7-62219ee06606'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레. Allegretto', part.name_en = 'III. Finale. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12613 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1e5e1122-91fe-37b5-827f-25ab18dd742a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e5e1122-91fe-37b5-827f-25ab18dd742a', 3, 'III', '피날레. Allegretto', 'III. Finale. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12613 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e5e1122-91fe-37b5-827f-25ab18dd742a'
);


-- Op. 127 알렉산드르 블로크의 시에 의한 7개의 로망스

UPDATE pieces piece
SET piece.title = '알렉산드르 블로크의 시에 의한 7개의 로망스', piece.title_en = 'Seven Romances on Poems by Alexander Blok',
    piece.type = 'album', piece.opus_number = 'Op. 127',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1967, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13368 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1967
WHERE piece.id = 13368 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '오필리아의 노래 (Pesnya Ofelii)', part.name_en = 'Pesnya Ofelii',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13368 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:292939dc-a0fc-3a60-be15-53583c1e7d17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:292939dc-a0fc-3a60-be15-53583c1e7d17', 1, NULL, '오필리아의 노래 (Pesnya Ofelii)', 'Pesnya Ofelii', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13368 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:292939dc-a0fc-3a60-be15-53583c1e7d17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '예언의 새 가마윤 (Gamayun, ptitsa veshchaya)', part.name_en = 'Gamayun, ptitsa veshchaya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13368 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:21dd2b5e-db3e-357f-b67c-76ab0ddbc378' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21dd2b5e-db3e-357f-b67c-76ab0ddbc378', 2, NULL, '예언의 새 가마윤 (Gamayun, ptitsa veshchaya)', 'Gamayun, ptitsa veshchaya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13368 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21dd2b5e-db3e-357f-b67c-76ab0ddbc378'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '우리는 함께였네 (My byli vmeste)', part.name_en = 'My byli vmeste',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13368 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:20b58fa5-f6bd-3806-aa48-2e4413e14ebc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20b58fa5-f6bd-3806-aa48-2e4413e14ebc', 3, NULL, '우리는 함께였네 (My byli vmeste)', 'My byli vmeste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13368 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20b58fa5-f6bd-3806-aa48-2e4413e14ebc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '도시는 잠들고 (Gorod spit)', part.name_en = 'Gorod spit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13368 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:601b63d3-712f-3d24-a3e9-9126a63ac820' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:601b63d3-712f-3d24-a3e9-9126a63ac820', 4, NULL, '도시는 잠들고 (Gorod spit)', 'Gorod spit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13368 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:601b63d3-712f-3d24-a3e9-9126a63ac820'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '폭풍 (Burya)', part.name_en = 'Burya',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13368 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b1a43961-3352-312d-a821-0ddd4c4d6078' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1a43961-3352-312d-a821-0ddd4c4d6078', 5, NULL, '폭풍 (Burya)', 'Burya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13368 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1a43961-3352-312d-a821-0ddd4c4d6078'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '비밀의 표지 (Taynye znaki)', part.name_en = 'Taynye znaki',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13368 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:dd08e4da-4c20-3692-bf81-500364d0781d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd08e4da-4c20-3692-bf81-500364d0781d', 6, NULL, '비밀의 표지 (Taynye znaki)', 'Taynye znaki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13368 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd08e4da-4c20-3692-bf81-500364d0781d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '음악 (Muzyka)', part.name_en = 'Muzyka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13368 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:fa0b9354-6612-35c0-976b-0456a3e91f4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa0b9354-6612-35c0-976b-0456a3e91f4e', 7, NULL, '음악 (Muzyka)', 'Muzyka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13368 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa0b9354-6612-35c0-976b-0456a3e91f4e'
);


-- Op. 128 가곡 <봄이여, 봄이여>

UPDATE pieces piece
SET piece.title = '가곡 <봄이여, 봄이여>', piece.title_en = '"Spring, Spring"',
    piece.type = 'song', piece.opus_number = 'Op. 128',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1967, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13427 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1967
WHERE piece.id = 13427 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 129 바이올린 협주곡 2번 C#단조

UPDATE pieces piece
SET piece.title = '바이올린 협주곡 2번 C#단조', piece.title_en = 'Violin Concerto No. 2 in C# minor',
    piece.type = 'album', piece.opus_number = 'Op. 129',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1967, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13498 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1967
WHERE piece.id = 13498 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato', part.name_en = 'I. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13498 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4bb4d882-df8a-462b-ab02-5852a47dba85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bb4d882-df8a-462b-ab02-5852a47dba85', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13498 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bb4d882-df8a-462b-ab02-5852a47dba85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13498 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:231ebecc-fd8c-4bf9-beb4-ca8c4f5c9079' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:231ebecc-fd8c-4bf9-beb4-ca8c4f5c9079', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13498 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:231ebecc-fd8c-4bf9-beb4-ca8c4f5c9079'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Adagio – Allegro', part.name_en = 'III. Adagio – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13498 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8891acb7-cb16-4be5-8726-9c6ca020638e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8891acb7-cb16-4be5-8726-9c6ca020638e', 3, 'III', 'Adagio – Allegro', 'III. Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13498 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8891acb7-cb16-4be5-8726-9c6ca020638e'
);


-- Op. 130 장송과 승리의 전주곡

UPDATE pieces piece
SET piece.title = '장송과 승리의 전주곡', piece.title_en = 'Funeral-Triumphal Prelude',
    piece.type = 'song', piece.opus_number = 'Op. 130',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1967, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13672 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1967
WHERE piece.id = 13672 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 131 교향시 <10월> C단조

UPDATE pieces piece
SET piece.title = '교향시 <10월> C단조', piece.title_en = 'October',
    piece.type = 'song', piece.opus_number = 'Op. 131',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1967, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12800 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1967
WHERE piece.id = 12800 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 132 영화음악 <소피야 페롭스카야>

UPDATE pieces piece
SET piece.title = '영화음악 <소피야 페롭스카야>', piece.title_en = 'Sofiya Perovskaya',
    piece.type = 'song', piece.opus_number = 'Op. 132',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1967, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12492 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1967
WHERE piece.id = 12492 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 133 현악 4중주 12번 D♭장조

UPDATE pieces piece
SET piece.title = '현악 4중주 12번 D♭장조', piece.title_en = 'String Quartet No. 12 in D♭ major',
    piece.type = 'album', piece.opus_number = 'Op. 133',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1968, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13445 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1968
WHERE piece.id = 13445 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato – Allegretto', part.name_en = 'I. Moderato – Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13445 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:45098b17-4a0c-3ef7-95a1-46846f33df00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45098b17-4a0c-3ef7-95a1-46846f33df00', 1, 'I', 'Moderato – Allegretto', 'I. Moderato – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13445 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45098b17-4a0c-3ef7-95a1-46846f33df00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro – Adagio – Moderato – Adagio moderato – Allegretto', part.name_en = 'II. Allegro – Adagio – Moderato – Adagio moderato – Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13445 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:99bb2888-7b84-3d41-b173-4227e7f007e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99bb2888-7b84-3d41-b173-4227e7f007e5', 2, 'II', 'Allegro – Adagio – Moderato – Adagio moderato – Allegretto', 'II. Allegro – Adagio – Moderato – Adagio moderato – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13445 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99bb2888-7b84-3d41-b173-4227e7f007e5'
);


-- Op. 134 바이올린 소나타

UPDATE pieces piece
SET piece.title = '바이올린 소나타', piece.title_en = 'Violin Sonata',
    piece.type = 'album', piece.opus_number = 'Op. 134',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1968, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13391 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1968
WHERE piece.id = 13391 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13391 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:45796f6b-f1cd-3ae0-96f3-c3833ada00ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45796f6b-f1cd-3ae0-96f3-c3833ada00ea', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13391 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45796f6b-f1cd-3ae0-96f3-c3833ada00ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13391 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:198fffc5-efc5-3243-b950-8a27d6023e81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:198fffc5-efc5-3243-b950-8a27d6023e81', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13391 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:198fffc5-efc5-3243-b950-8a27d6023e81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Largo – Andante – Largo', part.name_en = 'III. Largo – Andante – Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13391 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:29adfc1e-4469-3918-b7f0-7a53a93aaa43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29adfc1e-4469-3918-b7f0-7a53a93aaa43', 3, 'III', 'Largo – Andante – Largo', 'III. Largo – Andante – Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13391 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29adfc1e-4469-3918-b7f0-7a53a93aaa43'
);


-- Op. 135 교향곡 14번

UPDATE pieces piece
SET piece.title = '교향곡 14번', piece.title_en = 'Symphony No. 14',
    piece.type = 'album', piece.opus_number = 'Op. 135',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1969, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2435 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1969
WHERE piece.id = 2435 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio "De profundis"', part.name_en = 'I. Adagio "De profundis"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b8a38aef-c430-4fda-a873-1e447d6b8daf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8a38aef-c430-4fda-a873-1e447d6b8daf', 1, 'I', 'Adagio "De profundis"', 'I. Adagio "De profundis"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8a38aef-c430-4fda-a873-1e447d6b8daf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto "Malagueña"', part.name_en = 'II. Allegretto "Malagueña"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a0b34fc1-6579-49a6-a869-16281ce3ef8e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b34fc1-6579-49a6-a869-16281ce3ef8e', 2, 'II', 'Allegretto "Malagueña"', 'II. Allegretto "Malagueña"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b34fc1-6579-49a6-a869-16281ce3ef8e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto "Loreley"', part.name_en = 'III. Allegro molto "Loreley"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1403b52f-1e92-4bce-afe5-649ccb0dc75b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1403b52f-1e92-4bce-afe5-649ccb0dc75b', 3, 'III', 'Allegro molto "Loreley"', 'III. Allegro molto "Loreley"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1403b52f-1e92-4bce-afe5-649ccb0dc75b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio "Le Suicidé"', part.name_en = 'IV. Adagio "Le Suicidé"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:852d18b4-67f3-41ae-8363-345ccf259cef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:852d18b4-67f3-41ae-8363-345ccf259cef', 4, 'IV', 'Adagio "Le Suicidé"', 'IV. Adagio "Le Suicidé"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:852d18b4-67f3-41ae-8363-345ccf259cef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegretto "Les Attentives I"', part.name_en = 'V. Allegretto "Les Attentives I"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2e8501e7-5509-4077-a735-e51d113224a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e8501e7-5509-4077-a735-e51d113224a6', 5, 'V', 'Allegretto "Les Attentives I"', 'V. Allegretto "Les Attentives I"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e8501e7-5509-4077-a735-e51d113224a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Adagio "Les Attentives II"', part.name_en = 'VI. Adagio "Les Attentives II"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1b7e1578-a371-4bc5-84aa-e2512e5002dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b7e1578-a371-4bc5-84aa-e2512e5002dc', 6, 'VI', 'Adagio "Les Attentives II"', 'VI. Adagio "Les Attentives II"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b7e1578-a371-4bc5-84aa-e2512e5002dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Adagio "À la Santé"', part.name_en = 'VII. Adagio "À la Santé"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:18eee08d-747b-4647-ad7a-c9fbefd753d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18eee08d-747b-4647-ad7a-c9fbefd753d6', 7, 'VII', 'Adagio "À la Santé"', 'VII. Adagio "À la Santé"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18eee08d-747b-4647-ad7a-c9fbefd753d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Allegro "Réponse des Cosaques Zaporogues au Sultan de Constantinople"', part.name_en = 'VIII. Allegro "Réponse des Cosaques Zaporogues au Sultan de Constantinople"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:93575afc-bbf9-4067-9f03-d7745c4b5419' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93575afc-bbf9-4067-9f03-d7745c4b5419', 8, 'VIII', 'Allegro "Réponse des Cosaques Zaporogues au Sultan de Constantinople"', 'VIII. Allegro "Réponse des Cosaques Zaporogues au Sultan de Constantinople"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93575afc-bbf9-4067-9f03-d7745c4b5419'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Andante "O, Del''vig, Del''vig!"', part.name_en = 'IX. Andante "O, Del''vig, Del''vig!"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c2616921-3e12-4623-a05b-ec69c7946987' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2616921-3e12-4623-a05b-ec69c7946987', 9, 'IX', 'Andante "O, Del''vig, Del''vig!"', 'IX. Andante "O, Del''vig, Del''vig!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2616921-3e12-4623-a05b-ec69c7946987'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Largo "Der Tod des Dichters"', part.name_en = 'X. Largo "Der Tod des Dichters"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:79cdf4f7-3adf-49fa-a4b3-7303c7b3e47d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79cdf4f7-3adf-49fa-a4b3-7303c7b3e47d', 10, 'X', 'Largo "Der Tod des Dichters"', 'X. Largo "Der Tod des Dichters"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79cdf4f7-3adf-49fa-a4b3-7303c7b3e47d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Moderato "Schlußstück"', part.name_en = 'XI. Moderato "Schlußstück"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2435 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8a7f9159-e03f-4a6b-b755-515221bdfaee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a7f9159-e03f-4a6b-b755-515221bdfaee', 11, 'XI', 'Moderato "Schlußstück"', 'XI. Moderato "Schlußstück"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2435 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a7f9159-e03f-4a6b-b755-515221bdfaee'
);


-- Op. 136 남성 합창을 위한 <충성>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창을 위한 <충성>', 'Loyalty', 'song', 'Op. 136', NULL, NULL, 1970, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창을 위한 <충성>'
);


-- Op. 137 영화음악 <리어 왕>

UPDATE pieces piece
SET piece.title = '영화음악 <리어 왕>', piece.title_en = 'King Lear (film score)',
    piece.type = 'song', piece.opus_number = 'Op. 137',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1970, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12684 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1970
WHERE piece.id = 12684 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 138 현악 4중주 13번 B♭단조

UPDATE pieces piece
SET piece.title = '현악 4중주 13번 B♭단조', piece.title_en = 'String Quartet No. 13 in B♭ minor',
    piece.type = 'song', piece.opus_number = 'Op. 138',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1970, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12730 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1970
WHERE piece.id = 12730 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 139 소비에트 민경 행진곡

UPDATE pieces piece
SET piece.title = '소비에트 민경 행진곡', piece.title_en = 'March of the Soviet Militia',
    piece.type = 'song', piece.opus_number = 'Op. 139',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1970, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12142 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1970
WHERE piece.id = 12142 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- Op. 140 영국 시인의 시에 의한 6개의 로망스 Op. 140

UPDATE pieces piece
SET piece.title = '영국 시인의 시에 의한 6개의 로망스 Op. 140', piece.title_en = 'Six Romances on Verses by British Poets, Op. 140',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '140',
    piece.composition_year = COALESCE(1971, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12411 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1971
WHERE piece.id = 12411 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sir Walter Raleigh to His Son', part.name_en = 'Sir Walter Raleigh to His Son',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12411 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:95f8d49c-4976-4dbf-a4fb-8485daa06e20' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95f8d49c-4976-4dbf-a4fb-8485daa06e20', 1, NULL, 'Sir Walter Raleigh to His Son', 'Sir Walter Raleigh to His Son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12411 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95f8d49c-4976-4dbf-a4fb-8485daa06e20'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'O Wert Thou in the Cauld Blast', part.name_en = 'O Wert Thou in the Cauld Blast',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12411 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2e38cf52-4bf2-4b68-85a3-e48c015da87d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e38cf52-4bf2-4b68-85a3-e48c015da87d', 2, NULL, 'O Wert Thou in the Cauld Blast', 'O Wert Thou in the Cauld Blast', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12411 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e38cf52-4bf2-4b68-85a3-e48c015da87d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'MacPherson''s Farewell', part.name_en = 'MacPherson''s Farewell',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12411 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4e3392db-6271-433b-926b-ffb66c2411bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e3392db-6271-433b-926b-ffb66c2411bf', 3, NULL, 'MacPherson''s Farewell', 'MacPherson''s Farewell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12411 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e3392db-6271-433b-926b-ffb66c2411bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Jenny', part.name_en = 'Jenny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12411 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:158729fd-ccc6-4a97-8d0f-3e0328aa1c2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:158729fd-ccc6-4a97-8d0f-3e0328aa1c2b', 4, NULL, 'Jenny', 'Jenny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12411 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:158729fd-ccc6-4a97-8d0f-3e0328aa1c2b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Sonnet 66', part.name_en = 'Sonnet 66',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12411 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a14dc58c-cd1e-43b2-9bf1-7218271d4a3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a14dc58c-cd1e-43b2-9bf1-7218271d4a3e', 5, NULL, 'Sonnet 66', 'Sonnet 66', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12411 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a14dc58c-cd1e-43b2-9bf1-7218271d4a3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'The King''s Campaign', part.name_en = 'The King''s Campaign',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12411 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f091724e-a1b5-4572-8a1f-7a359914cdf1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f091724e-a1b5-4572-8a1f-7a359914cdf1', 6, NULL, 'The King''s Campaign', 'The King''s Campaign', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12411 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f091724e-a1b5-4572-8a1f-7a359914cdf1'
);


-- Op. 141 교향곡 15번 A장조

UPDATE pieces piece
SET piece.title = '교향곡 15번 A장조', piece.title_en = 'Symphony No. 15 in A major',
    piece.type = 'album', piece.opus_number = 'Op. 141',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1971, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12466 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1971
WHERE piece.id = 12466 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12466 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:764174a7-2666-3305-a175-715215efa97d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:764174a7-2666-3305-a175-715215efa97d', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12466 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:764174a7-2666-3305-a175-715215efa97d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12466 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c365ecd6-6c44-3d36-8271-a28a3e1f1a12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c365ecd6-6c44-3d36-8271-a28a3e1f1a12', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12466 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c365ecd6-6c44-3d36-8271-a28a3e1f1a12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12466 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6f1fc879-2950-3654-a534-2a2863e21c4e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f1fc879-2950-3654-a534-2a2863e21c4e', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12466 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f1fc879-2950-3654-a534-2a2863e21c4e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Adagio', part.name_en = 'IV. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12466 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:cdf48a50-db44-3dc7-9fef-aa0ad532dce8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf48a50-db44-3dc7-9fef-aa0ad532dce8', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12466 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf48a50-db44-3dc7-9fef-aa0ad532dce8'
);


-- Op. 142 현악 4중주 14번 F#장조

UPDATE pieces piece
SET piece.title = '현악 4중주 14번 F#장조', piece.title_en = 'String Quartet No. 14 in F# major',
    piece.type = 'album', piece.opus_number = 'Op. 142',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1973, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13651 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1973
WHERE piece.id = 13651 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13651 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5965d7ec-b5eb-3b05-898b-a7abde4f5a8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5965d7ec-b5eb-3b05-898b-a7abde4f5a8b', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13651 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5965d7ec-b5eb-3b05-898b-a7abde4f5a8b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13651 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:08411e58-ff28-3b74-94bd-24e32dca650c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08411e58-ff28-3b74-94bd-24e32dca650c', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13651 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08411e58-ff28-3b74-94bd-24e32dca650c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto', part.name_en = 'III. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13651 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f326600e-38c2-3e18-9a9f-7f3cf2e0ffa9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f326600e-38c2-3e18-9a9f-7f3cf2e0ffa9', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13651 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f326600e-38c2-3e18-9a9f-7f3cf2e0ffa9'
);


-- Op. 143 연가곡집 <마리나 츠베타예바의 6개의 시>

UPDATE pieces piece
SET piece.title = '연가곡집 <마리나 츠베타예바의 6개의 시>', piece.title_en = 'Six Poems by Marina Tsvetayeva',
    piece.type = 'album', piece.opus_number = 'Op. 143',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1973, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12631 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1973
WHERE piece.id = 12631 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '나의 시', part.name_en = 'My Poems',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12631 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:49f8ad9b-c815-4372-b312-a105f4507b64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49f8ad9b-c815-4372-b312-a105f4507b64', 1, NULL, '나의 시', 'My Poems', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12631 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49f8ad9b-c815-4372-b312-a105f4507b64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '이 다정함은 어디서 오는가', part.name_en = 'Where Does Such Tenderness Come From?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12631 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:989b04f7-6695-431d-aba2-c24569af0164' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:989b04f7-6695-431d-aba2-c24569af0164', 2, NULL, '이 다정함은 어디서 오는가', 'Where Does Such Tenderness Come From?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12631 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:989b04f7-6695-431d-aba2-c24569af0164'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '햄릿과 양심의 대화', part.name_en = 'Hamlet''s Dialogue with His Conscience',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12631 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5762ce20-55f8-48e9-8afb-20134a7f8d14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5762ce20-55f8-48e9-8afb-20134a7f8d14', 3, NULL, '햄릿과 양심의 대화', 'Hamlet''s Dialogue with His Conscience', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12631 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5762ce20-55f8-48e9-8afb-20134a7f8d14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '시인과 황제', part.name_en = 'The Poet and the Tsar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12631 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7a601d40-366b-4195-8cfb-d5dacad675af' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a601d40-366b-4195-8cfb-d5dacad675af', 4, NULL, '시인과 황제', 'The Poet and the Tsar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12631 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a601d40-366b-4195-8cfb-d5dacad675af'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '아니, 북이 울렸다', part.name_en = 'No, the Drum Beat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12631 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6f74cf7b-f908-42bd-bef4-373098dda444' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f74cf7b-f908-42bd-bef4-373098dda444', 5, NULL, '아니, 북이 울렸다', 'No, the Drum Beat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12631 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f74cf7b-f908-42bd-bef4-373098dda444'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '안나 아흐마토바에게', part.name_en = 'To Anna Akhmatova',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12631 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:605efcff-95e3-4bbc-87bd-19945f3dd174' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:605efcff-95e3-4bbc-87bd-19945f3dd174', 6, NULL, '안나 아흐마토바에게', 'To Anna Akhmatova', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12631 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:605efcff-95e3-4bbc-87bd-19945f3dd174'
);


-- Op. 143a 연가곡집 <마리나 츠베타예바의 6개의 시> (관현악 반주)

UPDATE pieces piece
SET piece.title = '연가곡집 <마리나 츠베타예바의 6개의 시> (관현악 반주)', piece.title_en = 'Six Poems by Marina Tsvetayeva (orchestral version)',
    piece.type = 'album', piece.opus_number = 'Op. 143a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1973, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13330 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1973
WHERE piece.id = 13330 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '나의 시', part.name_en = 'My Poems',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13330 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5cb9e4aa-3cbe-4bb1-8917-26020d9072d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cb9e4aa-3cbe-4bb1-8917-26020d9072d6', 1, NULL, '나의 시', 'My Poems', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13330 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cb9e4aa-3cbe-4bb1-8917-26020d9072d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '이 다정함은 어디서 오는가', part.name_en = 'Where Does Such Tenderness Come From?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13330 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:09418692-4a2c-474c-acf3-b451b9846065' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09418692-4a2c-474c-acf3-b451b9846065', 2, NULL, '이 다정함은 어디서 오는가', 'Where Does Such Tenderness Come From?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13330 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09418692-4a2c-474c-acf3-b451b9846065'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '햄릿과 양심의 대화', part.name_en = 'Hamlet''s Dialogue with His Conscience',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13330 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f0c08190-7ed9-43be-ace0-bda358fc5770' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0c08190-7ed9-43be-ace0-bda358fc5770', 3, NULL, '햄릿과 양심의 대화', 'Hamlet''s Dialogue with His Conscience', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13330 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0c08190-7ed9-43be-ace0-bda358fc5770'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '시인과 황제', part.name_en = 'The Poet and the Tsar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13330 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c0bbde74-4ba0-4aac-b288-fefbf1fa5706' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0bbde74-4ba0-4aac-b288-fefbf1fa5706', 4, NULL, '시인과 황제', 'The Poet and the Tsar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13330 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0bbde74-4ba0-4aac-b288-fefbf1fa5706'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '아니, 북이 울렸다', part.name_en = 'No, the Drum Beat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13330 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4521267c-965a-48bd-b7f8-38dcc57d9547' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4521267c-965a-48bd-b7f8-38dcc57d9547', 5, NULL, '아니, 북이 울렸다', 'No, the Drum Beat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13330 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4521267c-965a-48bd-b7f8-38dcc57d9547'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '안나 아흐마토바에게', part.name_en = 'To Anna Akhmatova',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13330 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1463fa22-a6a9-47bc-bdf4-fedb42809395' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1463fa22-a6a9-47bc-bdf4-fedb42809395', 6, NULL, '안나 아흐마토바에게', 'To Anna Akhmatova', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13330 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1463fa22-a6a9-47bc-bdf4-fedb42809395'
);


-- Op. 144 현악 4중주 15번 E♭단조

UPDATE pieces piece
SET piece.title = '현악 4중주 15번 E♭단조', piece.title_en = 'String Quartet No. 15 in E♭ minor',
    piece.type = 'album', piece.opus_number = 'Op. 144',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1974, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13206 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1974
WHERE piece.id = 13206 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '엘레지. Adagio', part.name_en = 'I. Elegy. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13206 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5545316f-f87e-33cb-adac-5ad93fd9455b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5545316f-f87e-33cb-adac-5ad93fd9455b', 1, 'I', '엘레지. Adagio', 'I. Elegy. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13206 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5545316f-f87e-33cb-adac-5ad93fd9455b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '세레나데. Adagio', part.name_en = 'II. Serenade. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13206 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:398f3a13-ca7d-3ffa-9ee6-a2f550de2f95' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:398f3a13-ca7d-3ffa-9ee6-a2f550de2f95', 2, 'II', '세레나데. Adagio', 'II. Serenade. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13206 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398f3a13-ca7d-3ffa-9ee6-a2f550de2f95'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '간주곡. Adagio', part.name_en = 'III. Intermezzo. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13206 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:eb6e9d71-4a99-3902-92c2-fe5e298191a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb6e9d71-4a99-3902-92c2-fe5e298191a1', 3, 'III', '간주곡. Adagio', 'III. Intermezzo. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13206 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb6e9d71-4a99-3902-92c2-fe5e298191a1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '녹턴. Adagio', part.name_en = 'IV. Nocturne. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13206 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4444de9a-b9a5-36d8-8103-946634d5d5b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4444de9a-b9a5-36d8-8103-946634d5d5b1', 4, 'IV', '녹턴. Adagio', 'IV. Nocturne. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13206 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4444de9a-b9a5-36d8-8103-946634d5d5b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '장송 행진곡. Adagio molto', part.name_en = 'V. Funeral March. Adagio molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13206 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a41ad5c3-907b-3caf-a091-342cffd7c712' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a41ad5c3-907b-3caf-a091-342cffd7c712', 5, 'V', '장송 행진곡. Adagio molto', 'V. Funeral March. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13206 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a41ad5c3-907b-3caf-a091-342cffd7c712'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '에필로그. Adagio', part.name_en = 'VI. Epilogue. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13206 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:822bbdb1-6adf-395d-a4b2-e7aa22994b2b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:822bbdb1-6adf-395d-a4b2-e7aa22994b2b', 6, 'VI', '에필로그. Adagio', 'VI. Epilogue. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13206 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:822bbdb1-6adf-395d-a4b2-e7aa22994b2b'
);


-- Op. 145 미켈란젤로 부오나로티의 시에 의한 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미켈란젤로 부오나로티의 시에 의한 모음곡', 'Suite on Verses of Michelangelo Buonarroti', 'album', 'Op. 145', NULL, NULL, 1974, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미켈란젤로 부오나로티의 시에 의한 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5186b01d-0261-40dc-ae06-8954e0262f13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5186b01d-0261-40dc-ae06-8954e0262f13'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5186b01d-0261-40dc-ae06-8954e0262f13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d3d5e74-dbfc-4118-83e5-50008924061b', 1, NULL, '진실', 'Truth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d3d5e74-dbfc-4118-83e5-50008924061b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14c689c9-113b-4a92-a98f-e7f3b3f79345', 2, NULL, '아침', 'Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14c689c9-113b-4a92-a98f-e7f3b3f79345'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aec66605-17d2-459a-910d-e9a31c459d9b', 3, NULL, '사랑', 'Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aec66605-17d2-459a-910d-e9a31c459d9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa62b42a-dc03-4c88-ab2d-0cc3435231f3', 4, NULL, '이별', 'Separation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa62b42a-dc03-4c88-ab2d-0cc3435231f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20aee481-bbae-4fda-b7a6-e67423dca355', 5, NULL, '분노', 'Anger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20aee481-bbae-4fda-b7a6-e67423dca355'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc6e6ec4-376c-4c81-90ad-167d7e131115', 6, NULL, '단테', 'Dante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc6e6ec4-376c-4c81-90ad-167d7e131115'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7537ce7-ae82-45dc-a363-543d6ff6daa8', 7, NULL, '망명자에게', 'To the Exile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7537ce7-ae82-45dc-a363-543d6ff6daa8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddfcbac6-1066-4740-b4ca-38385a4171ce', 8, NULL, '창조', 'Creativity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddfcbac6-1066-4740-b4ca-38385a4171ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce77e38a-20df-4f84-b340-3c0d0d3333d6', 9, NULL, '밤', 'Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce77e38a-20df-4f84-b340-3c0d0d3333d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50043b59-9f11-43a4-bb7b-c3d1838567b2', 10, NULL, '죽음', 'Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50043b59-9f11-43a4-bb7b-c3d1838567b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:699fd722-6677-4073-a286-8fead2e32c83', 11, NULL, '불멸', 'Immortality', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '미켈란젤로 부오나로티의 시에 의한 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:699fd722-6677-4073-a286-8fead2e32c83'
);


-- Op. 145a 미켈란젤로 부오나로티의 시에 의한 모음곡 (관현악 반주)

UPDATE pieces piece
SET piece.title = '미켈란젤로 부오나로티의 시에 의한 모음곡 (관현악 반주)', piece.title_en = 'Suite on Verses of Michelangelo Buonarroti (orchestral version)',
    piece.type = 'album', piece.opus_number = 'Op. 145a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1975, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13097 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1975
WHERE piece.id = 13097 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '진실', part.name_en = 'Truth',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:304ea366-3802-4e39-8418-e03c44cb048d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:304ea366-3802-4e39-8418-e03c44cb048d', 1, NULL, '진실', 'Truth', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304ea366-3802-4e39-8418-e03c44cb048d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '아침', part.name_en = 'Morning',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4b041e96-da3b-4d2f-a41f-2e1dedc7cf50' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b041e96-da3b-4d2f-a41f-2e1dedc7cf50', 2, NULL, '아침', 'Morning', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b041e96-da3b-4d2f-a41f-2e1dedc7cf50'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '사랑', part.name_en = 'Love',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7ac89a62-9c3e-4d16-b0a4-ffdac9dcf292' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ac89a62-9c3e-4d16-b0a4-ffdac9dcf292', 3, NULL, '사랑', 'Love', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ac89a62-9c3e-4d16-b0a4-ffdac9dcf292'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '이별', part.name_en = 'Separation',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b22eba80-d2dd-4656-b095-a55b593d9256' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b22eba80-d2dd-4656-b095-a55b593d9256', 4, NULL, '이별', 'Separation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b22eba80-d2dd-4656-b095-a55b593d9256'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '분노', part.name_en = 'Anger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:027ad81b-8c3f-4212-bb44-c72cce0759b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:027ad81b-8c3f-4212-bb44-c72cce0759b8', 5, NULL, '분노', 'Anger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:027ad81b-8c3f-4212-bb44-c72cce0759b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '단테', part.name_en = 'Dante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:82f16495-854a-4a9b-a393-ca63cfcfb525' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82f16495-854a-4a9b-a393-ca63cfcfb525', 6, NULL, '단테', 'Dante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82f16495-854a-4a9b-a393-ca63cfcfb525'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '망명자에게', part.name_en = 'To the Exile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:87da9c4f-386b-469d-aad0-ae586d890738' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87da9c4f-386b-469d-aad0-ae586d890738', 7, NULL, '망명자에게', 'To the Exile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87da9c4f-386b-469d-aad0-ae586d890738'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '창조', part.name_en = 'Creativity',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:2301de3a-6b45-450f-96a5-ff888f114282' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2301de3a-6b45-450f-96a5-ff888f114282', 8, NULL, '창조', 'Creativity', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2301de3a-6b45-450f-96a5-ff888f114282'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '밤', part.name_en = 'Night',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4d44ca59-b43c-41f1-ad16-f30ade5cb04b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d44ca59-b43c-41f1-ad16-f30ade5cb04b', 9, NULL, '밤', 'Night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d44ca59-b43c-41f1-ad16-f30ade5cb04b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '죽음', part.name_en = 'Death',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c767bc06-4c90-4611-a165-ad93bd777639' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c767bc06-4c90-4611-a165-ad93bd777639', 10, NULL, '죽음', 'Death', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c767bc06-4c90-4611-a165-ad93bd777639'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '불멸', part.name_en = 'Immortality',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13097 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:764354c6-fef0-4f83-a74d-faf499fe2436' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:764354c6-fef0-4f83-a74d-faf499fe2436', 11, NULL, '불멸', 'Immortality', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13097 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:764354c6-fef0-4f83-a74d-faf499fe2436'
);


-- Op. 146 레뱌드킨 대위의 4개의 시

UPDATE pieces piece
SET piece.title = '레뱌드킨 대위의 4개의 시', piece.title_en = 'Four Verses of Captain Lebyadkin',
    piece.type = 'album', piece.opus_number = 'Op. 146',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1974, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12531 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1974
WHERE piece.id = 12531 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '레뱌드킨 대위의 사랑', part.name_en = 'The Love of Captain Lebyadkin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12531 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:9eaf114e-1c71-4a06-af7b-b6e0baea9699' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9eaf114e-1c71-4a06-af7b-b6e0baea9699', 1, NULL, '레뱌드킨 대위의 사랑', 'The Love of Captain Lebyadkin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12531 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9eaf114e-1c71-4a06-af7b-b6e0baea9699'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '바퀴벌레', part.name_en = 'The Cockroach',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12531 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0d9a0a5a-10d5-4522-a7e6-073d27db2ff2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d9a0a5a-10d5-4522-a7e6-073d27db2ff2', 2, NULL, '바퀴벌레', 'The Cockroach', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12531 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d9a0a5a-10d5-4522-a7e6-073d27db2ff2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '가정교사를 위한 자선 무도회', part.name_en = 'The Ball for the Benefit of Governesses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12531 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:405e597c-20fb-496a-9a34-4809bbadbe92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:405e597c-20fb-496a-9a34-4809bbadbe92', 3, NULL, '가정교사를 위한 자선 무도회', 'The Ball for the Benefit of Governesses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12531 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:405e597c-20fb-496a-9a34-4809bbadbe92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '빛나는 인물', part.name_en = 'A Radiant Personality',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12531 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e7ab0a4a-77e8-4e0a-8148-e0e94059ff62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7ab0a4a-77e8-4e0a-8148-e0e94059ff62', 4, NULL, '빛나는 인물', 'A Radiant Personality', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12531 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7ab0a4a-77e8-4e0a-8148-e0e94059ff62'
);


-- Op. 147 비올라 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라 소나타', 'Viola Sonata', 'album', 'Op. 147', NULL, NULL, 1975, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5336146-6dcc-3612-a168-dbb4cb6b3006'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5336146-6dcc-3612-a168-dbb4cb6b3006'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5336146-6dcc-3612-a168-dbb4cb6b3006'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f6f99b0-bad1-3624-b2d5-197106662562', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f6f99b0-bad1-3624-b2d5-197106662562'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00b69ceb-7af1-3e93-8c53-3710242333df', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b69ceb-7af1-3e93-8c53-3710242333df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c8fc4dd-edd4-3e8b-bb17-3d3aae7bc71d', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c8fc4dd-edd4-3e8b-bb17-3d3aae7bc71d'
);


-- None 혁명 희생자를 기리는 장송 행진곡

UPDATE pieces piece
SET piece.title = '혁명 희생자를 기리는 장송 행진곡', piece.title_en = 'Funeral March in Memory of the Victims of the Revolution',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12148 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 12148 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 피아노 소품 <향수>

UPDATE pieces piece
SET piece.title = '피아노 소품 <향수>', piece.title_en = 'Nostalgia',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13453 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 13453 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 1919년 연습장의 피아노 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '1919년 연습장의 피아노 소품', 'Piano Pieces from the Exercise Book "1919"', 'album', NULL, NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '1919년 연습장의 피아노 소품'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 12695 AND linked.composer_id = 83), 'musicbrainz:5d64894f-d8c3-4aed-9339-dacc531f9350', 1, NULL, 'C장조 소품', 'Piece in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '1919년 연습장의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d64894f-d8c3-4aed-9339-dacc531f9350'
);

UPDATE pieces piece
SET piece.title = '1919년 연습장의 피아노 소품 중 "C장조 소품"', piece.title_en = 'Piano Pieces from the Exercise Book "1919": Piece in C major', piece.editor_locked = 1
WHERE piece.id = 12695 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 12724 AND linked.composer_id = 83), 'musicbrainz:6396a696-c7ff-464d-9a8e-dbc06b0f49f3', 2, NULL, '전주곡-행진곡', 'Prelude-March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '1919년 연습장의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6396a696-c7ff-464d-9a8e-dbc06b0f49f3'
);

UPDATE pieces piece
SET piece.title = '1919년 연습장의 피아노 소품 중 "전주곡-행진곡"', piece.title_en = 'Piano Pieces from the Exercise Book "1919": Prelude-March', piece.editor_locked = 1
WHERE piece.id = 12724 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 13127 AND linked.composer_id = 83), 'musicbrainz:a0ebfc19-97ad-49be-a451-de083a4623f2', 3, NULL, '숲에서', 'In the Forest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '1919년 연습장의 피아노 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0ebfc19-97ad-49be-a451-de083a4623f2'
);

UPDATE pieces piece
SET piece.title = '1919년 연습장의 피아노 소품 중 "숲에서"', piece.title_en = 'Piano Pieces from the Exercise Book "1919": In the Forest', piece.editor_locked = 1
WHERE piece.id = 13127 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None 바가텔 C장조

UPDATE pieces piece
SET piece.title = '바가텔 C장조', piece.title_en = 'Bagatelle in C major',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1919, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12406 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1919
WHERE piece.id = 12406 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 2개의 전주곡 (1919)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 전주곡 (1919)', 'Two Preludes (1919)', 'song', NULL, NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 전주곡 (1919)'
);


-- None 6개의 연습 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 연습 소품', 'Exercise Pieces', 'song', NULL, NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 연습 소품'
);


-- None 피아노 2중주를 위한 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 2중주를 위한 환상곡', 'Fantasy for Piano Duo', 'song', NULL, NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 2중주를 위한 환상곡'
);


-- None 미뉴에트, 전주곡과 간주곡

UPDATE pieces piece
SET piece.title = '미뉴에트, 전주곡과 간주곡', piece.title_en = 'Minuet, Prelude and Intermezzo',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1920, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12269 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1920
WHERE piece.id = 12269 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '미뉴에트', part.name_en = 'Minuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12269 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c2c37d5b-59c4-49cc-b699-1204c3056794' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2c37d5b-59c4-49cc-b699-1204c3056794', 1, NULL, '미뉴에트', 'Minuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12269 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2c37d5b-59c4-49cc-b699-1204c3056794'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prelude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12269 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:24c64eba-f0d0-4a34-afb3-9938b7af52b4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24c64eba-f0d0-4a34-afb3-9938b7af52b4', 2, NULL, '전주곡', 'Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12269 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24c64eba-f0d0-4a34-afb3-9938b7af52b4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '간주곡', part.name_en = 'Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12269 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7e34086f-2ba3-4e96-a78d-5268ded7151d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e34086f-2ba3-4e96-a78d-5268ded7151d', 3, NULL, '간주곡', 'Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12269 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e34086f-2ba3-4e96-a78d-5268ded7151d'
);


-- None 5개의 전주곡

UPDATE pieces piece
SET piece.title = '5개의 전주곡', piece.title_en = 'Five Preludes',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1921, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13508 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1921
WHERE piece.id = 13508 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato e scherzando', part.name_en = 'No. 1. Allegro moderato e scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13508 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b2641663-fe26-33f8-ae98-cb770807c2ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2641663-fe26-33f8-ae98-cb770807c2ad', 1, NULL, 'Allegro moderato e scherzando', 'No. 1. Allegro moderato e scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13508 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2641663-fe26-33f8-ae98-cb770807c2ad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'No. 2. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13508 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:806f20bd-feb4-3744-acf0-781d57cc0047' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:806f20bd-feb4-3744-acf0-781d57cc0047', 2, NULL, 'Andante', 'No. 2. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13508 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:806f20bd-feb4-3744-acf0-781d57cc0047'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'No. 3. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13508 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c8c63fe2-8b8b-3eb5-a457-baedaa0a8ced' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8c63fe2-8b8b-3eb5-a457-baedaa0a8ced', 3, NULL, 'Allegro moderato', 'No. 3. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13508 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8c63fe2-8b8b-3eb5-a457-baedaa0a8ced'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Moderato', part.name_en = 'No. 4. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13508 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ad9a6a0f-cda0-3605-9036-1e42a7e94bc6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad9a6a0f-cda0-3605-9036-1e42a7e94bc6', 4, NULL, 'Moderato', 'No. 4. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13508 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad9a6a0f-cda0-3605-9036-1e42a7e94bc6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'No. 5. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13508 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:828ddcc3-a598-3a1a-bd9f-81ded9dc443d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:828ddcc3-a598-3a1a-bd9f-81ded9dc443d', 5, NULL, 'Andantino', 'No. 5. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13508 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:828ddcc3-a598-3a1a-bd9f-81ded9dc443d'
);


-- None 7개의 푸가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7개의 푸가', 'Seven Fugues', 'song', NULL, NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7개의 푸가'
);


-- None 피아노 춤곡 (1923)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 춤곡 (1923)', 'Dance (1923)', 'song', NULL, NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 춤곡 (1923)'
);


-- None 피아노 5중주 (1923)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주 (1923)', 'Piano Quintet (1923)', 'song', NULL, NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주 (1923)'
);


-- None 피아노 소품 (1922–1924)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소품 (1922–1924)', 'Piano Piece (1922–1924)', 'song', NULL, NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소품 (1922–1924)'
);


-- None 비올라와 피아노를 위한 즉흥곡

UPDATE pieces piece
SET piece.title = '비올라와 피아노를 위한 즉흥곡', piece.title_en = 'Impromptu for Viola and Piano',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12594 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 12594 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 현악 4중주를 위한 2개의 소품

UPDATE pieces piece
SET piece.title = '현악 4중주를 위한 2개의 소품', piece.title_en = 'Two Pieces for String Quartet',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1931, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13504 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1931
WHERE piece.id = 13504 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '엘레지', part.name_en = 'Elegy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13504 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:6884d3da-a55b-3e0e-93bb-cf502dc6e656' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6884d3da-a55b-3e0e-93bb-cf502dc6e656', 1, NULL, '엘레지', 'Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13504 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6884d3da-a55b-3e0e-93bb-cf502dc6e656'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '폴카', part.name_en = 'Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13504 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c532cba4-41a7-3604-b97d-43c2c244db66' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c532cba4-41a7-3604-b97d-43c2c244db66', 2, NULL, '폴카', 'Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13504 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c532cba4-41a7-3604-b97d-43c2c244db66'
);


-- None 오르간을 위한 파사칼리아

UPDATE pieces piece
SET piece.title = '오르간을 위한 파사칼리아', piece.title_en = 'Passacaglia for Organ',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1932, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13344 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1932
WHERE piece.id = 13344 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 가곡 <마드리갈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <마드리갈>', 'Madrigal (Impromptu)', 'song', NULL, NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <마드리갈>'
);


-- None 4개의 푸가 (1934)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 푸가 (1934)', 'Four Fugues (1934)', 'album', NULL, NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 푸가 (1934)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-four-fugues-1934:1', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '4개의 푸가 (1934)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-four-fugues-1934:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-four-fugues-1934:2', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '4개의 푸가 (1934)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-four-fugues-1934:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-four-fugues-1934:3', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '4개의 푸가 (1934)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-four-fugues-1934:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-four-fugues-1934:4', 4, NULL, 'E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '4개의 푸가 (1934)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-four-fugues-1934:4'
);


-- None 근위 연대의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '근위 연대의 노래', 'Song of the Regiments of the Guards', 'song', NULL, NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '근위 연대의 노래'
);


-- None 관악대를 위한 의식 행진곡 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악대를 위한 의식 행진곡 D♭장조', 'Ceremonial March in D♭ major', 'song', NULL, NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악대를 위한 의식 행진곡 D♭장조'
);


-- None 2대의 하프를 위한 폴카 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2대의 하프를 위한 폴카 F#단조', 'Polka in F# minor for Two Harps', 'song', NULL, NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2대의 하프를 위한 폴카 F#단조'
);


-- None 위대한 날이 왔다

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '위대한 날이 왔다', 'A Great Day Has Come', 'song', NULL, NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '위대한 날이 왔다'
);


-- None 인민위원에게 바치는 맹세

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '인민위원에게 바치는 맹세', 'The Oath to the People''s Commissar', 'song', NULL, NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '인민위원에게 바치는 맹세'
);


-- None 소련 국가 응모작 "우리 소비에트 조국에 영광을"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소련 국가 응모작 "우리 소비에트 조국에 영광을"', 'Anthem of the Soviet Union ("Glory to Our Soviet Fatherland")', 'song', NULL, NULL, NULL, 1943, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소련 국가 응모작 "우리 소비에트 조국에 영광을"'
);


-- None 소련 국가 응모작 "자유로운 공화국들의 굳건한 연맹"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소련 국가 응모작 "자유로운 공화국들의 굳건한 연맹"', 'Anthem of the Soviet Union ("Unbreakable Union of Freeborn Republics")', 'song', NULL, NULL, NULL, 1943, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소련 국가 응모작 "자유로운 공화국들의 굳건한 연맹"'
);


-- None 조국을 위한 건배

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '조국을 위한 건배', 'A Toast to Our Motherland', 'song', NULL, NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '조국을 위한 건배'
);


-- None 흑해

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '흑해', 'The Black Sea', 'song', NULL, NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '흑해'
);


-- None 피아노 소품 <무르질카>

UPDATE pieces piece
SET piece.title = '피아노 소품 <무르질카>', piece.title_en = 'Murzilka',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1945, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12312 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1945
WHERE piece.id = 12312 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 우리 조국 러시아는 폭풍 속에서 강해졌다

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '우리 조국 러시아는 폭풍 속에서 강해졌다', 'Our Native Russia Has Gained Strength from Storms', 'song', NULL, NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '우리 조국 러시아는 폭풍 속에서 강해졌다'
);


-- None 관현악을 위한 3개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 3개의 소품', 'Three Pieces for Orchestra', 'song', NULL, NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 3개의 소품'
);


-- None <반형식주의 라요크>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<반형식주의 라요크>', 'Antiformalistic Rayok', 'song', NULL, NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<반형식주의 라요크>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0f1b524-4614-4f59-a7bc-6e5146a395e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0f1b524-4614-4f59-a7bc-6e5146a395e4'
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '<반형식주의 라요크>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0f1b524-4614-4f59-a7bc-6e5146a395e4'
);


-- None 모스크바 찬가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모스크바 찬가', 'Hymn to Moscow', 'song', NULL, NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모스크바 찬가'
);


-- None 2대의 피아노를 위한 즐거운 행진곡

UPDATE pieces piece
SET piece.title = '2대의 피아노를 위한 즐거운 행진곡', piece.title_en = 'Merry March for Two Pianos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1949, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12782 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1949
WHERE piece.id = 12782 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 우리의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '우리의 노래', 'Our Song', 'song', NULL, NULL, NULL, 1950, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '우리의 노래'
);


-- None 평화 수호자의 행진

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '평화 수호자의 행진', 'March of Peace Champions', 'song', NULL, NULL, NULL, 1950, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '평화 수호자의 행진'
);


-- None 독일 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '독일 행진곡', 'German March', 'song', NULL, NULL, NULL, 1950, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '독일 행진곡'
);


-- None 피아노 모음곡 <인형의 춤>

UPDATE pieces piece
SET piece.title = '피아노 모음곡 <인형의 춤>', piece.title_en = 'Dances of the Dolls',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1952, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12077 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1952
WHERE piece.id = 12077 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서정적 왈츠', part.name_en = 'Lyric Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12077 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b18ec2aa-87ff-48a2-bbbe-b4f8d4960a54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b18ec2aa-87ff-48a2-bbbe-b4f8d4960a54', 1, NULL, '서정적 왈츠', 'Lyric Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12077 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b18ec2aa-87ff-48a2-bbbe-b4f8d4960a54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '가보트', part.name_en = 'Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12077 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4ea2c51c-ef6c-40b3-a1d6-7973871d4d4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ea2c51c-ef6c-40b3-a1d6-7973871d4d4b', 2, NULL, '가보트', 'Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12077 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ea2c51c-ef6c-40b3-a1d6-7973871d4d4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '로망스', part.name_en = 'Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12077 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:41d0d0bf-9226-40b2-8d27-69b0ca442af9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41d0d0bf-9226-40b2-8d27-69b0ca442af9', 3, NULL, '로망스', 'Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12077 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41d0d0bf-9226-40b2-8d27-69b0ca442af9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '폴카', part.name_en = 'Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12077 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:76c32c71-7b49-4b53-a557-5fb2c1031bcb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76c32c71-7b49-4b53-a557-5fb2c1031bcb', 4, NULL, '폴카', 'Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12077 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76c32c71-7b49-4b53-a557-5fb2c1031bcb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '익살스러운 왈츠', part.name_en = 'Waltz-Joke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12077 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f04d3ea3-271d-4cdd-b317-47d7a2ac2195' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f04d3ea3-271d-4cdd-b317-47d7a2ac2195', 5, NULL, '익살스러운 왈츠', 'Waltz-Joke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12077 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f04d3ea3-271d-4cdd-b317-47d7a2ac2195'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '손풍금', part.name_en = 'Hurdy-Gurdy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12077 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:dd041198-e4e1-43a6-bd26-55b7e9d9d79b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd041198-e4e1-43a6-bd26-55b7e9d9d79b', 6, NULL, '손풍금', 'Hurdy-Gurdy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12077 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd041198-e4e1-43a6-bd26-55b7e9d9d79b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '춤', part.name_en = 'Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12077 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f4d9cd76-8f8e-4be4-9ba5-bc3ba90e13f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4d9cd76-8f8e-4be4-9ba5-bc3ba90e13f8', 7, NULL, '춤', 'Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12077 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4d9cd76-8f8e-4be4-9ba5-bc3ba90e13f8'
);


-- None 발레 모음곡 1번

UPDATE pieces piece
SET piece.title = '발레 모음곡 1번', piece.title_en = 'Ballet Suite No. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1949, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13020 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1949
WHERE piece.id = 13020 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서정적 왈츠', part.name_en = 'I. Lyric Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13020 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:a428dca2-290f-4a47-9e29-061ab4e7486e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a428dca2-290f-4a47-9e29-061ab4e7486e', 1, 'I', '서정적 왈츠', 'I. Lyric Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13020 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a428dca2-290f-4a47-9e29-061ab4e7486e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '춤', part.name_en = 'II. Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13020 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3aa3b68b-fcc6-4aa6-8a5b-0949af98c3fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aa3b68b-fcc6-4aa6-8a5b-0949af98c3fc', 2, 'II', '춤', 'II. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13020 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aa3b68b-fcc6-4aa6-8a5b-0949af98c3fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '로망스', part.name_en = 'III. Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13020 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1aead37b-63f5-48fa-a101-7dca101bec63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aead37b-63f5-48fa-a101-7dca101bec63', 3, 'III', '로망스', 'III. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13020 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aead37b-63f5-48fa-a101-7dca101bec63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '폴카', part.name_en = 'IV. Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13020 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3cc89d45-0a8c-4127-ac93-2aaf1ce187b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cc89d45-0a8c-4127-ac93-2aaf1ce187b9', 4, 'IV', '폴카', 'IV. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13020 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cc89d45-0a8c-4127-ac93-2aaf1ce187b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '익살스러운 왈츠', part.name_en = 'V. Waltz-Joke',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13020 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b6a94904-de76-4b55-b230-bbeef3efaead' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6a94904-de76-4b55-b230-bbeef3efaead', 5, 'V', '익살스러운 왈츠', 'V. Waltz-Joke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13020 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6a94904-de76-4b55-b230-bbeef3efaead'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '갤럽', part.name_en = 'VI. Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13020 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:f0c14924-6065-44a5-921a-d91c06d74cf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0c14924-6065-44a5-921a-d91c06d74cf4', 6, 'VI', '갤럽', 'VI. Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13020 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0c14924-6065-44a5-921a-d91c06d74cf4'
);


-- None 발레 모음곡 2번

UPDATE pieces piece
SET piece.title = '발레 모음곡 2번', piece.title_en = 'Ballet Suite No. 2',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1951, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12992 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1951
WHERE piece.id = 12992 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '왈츠', part.name_en = 'I. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12992 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7adaec1c-4501-49a2-914f-1863671f5bc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7adaec1c-4501-49a2-914f-1863671f5bc8', 1, 'I', '왈츠', 'I. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12992 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7adaec1c-4501-49a2-914f-1863671f5bc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12992 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:43ef4565-c00f-484f-9ddb-f85ae8871d18' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43ef4565-c00f-484f-9ddb-f85ae8871d18', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12992 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43ef4565-c00f-484f-9ddb-f85ae8871d18'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '폴카', part.name_en = 'III. Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12992 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1ed4fd03-2f96-4e18-9a04-cf65188ef504' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ed4fd03-2f96-4e18-9a04-cf65188ef504', 3, 'III', '폴카', 'III. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12992 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ed4fd03-2f96-4e18-9a04-cf65188ef504'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '감상적인 로망스', part.name_en = 'IV. Sentimental Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12992 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:212b39d6-a255-4751-8162-91b068a8aac3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:212b39d6-a255-4751-8162-91b068a8aac3', 4, 'IV', '감상적인 로망스', 'IV. Sentimental Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12992 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:212b39d6-a255-4751-8162-91b068a8aac3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '봄의 왈츠', part.name_en = 'V. Spring Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12992 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1898fb7a-4e9d-423c-af92-087e256697b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1898fb7a-4e9d-423c-af92-087e256697b1', 5, 'V', '봄의 왈츠', 'V. Spring Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12992 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1898fb7a-4e9d-423c-af92-087e256697b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '피날레', part.name_en = 'VI. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12992 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:e145e575-46ca-4d8e-86d1-7a6b881e3169' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e145e575-46ca-4d8e-86d1-7a6b881e3169', 6, 'VI', '피날레', 'VI. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12992 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e145e575-46ca-4d8e-86d1-7a6b881e3169'
);


-- None 발레 모음곡 3번

UPDATE pieces piece
SET piece.title = '발레 모음곡 3번', piece.title_en = 'Ballet Suite No. 3',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1953, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13310 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1953
WHERE piece.id = 13310 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '왈츠', part.name_en = 'I. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13310 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:c0bd16ac-8eb9-42e6-9adb-7ea184e804b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0bd16ac-8eb9-42e6-9adb-7ea184e804b2', 1, 'I', '왈츠', 'I. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13310 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0bd16ac-8eb9-42e6-9adb-7ea184e804b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '가보트', part.name_en = 'II. Gavotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13310 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:3bb34f1e-dda8-43b0-9eea-6213b58cacdc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bb34f1e-dda8-43b0-9eea-6213b58cacdc', 2, 'II', '가보트', 'II. Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13310 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bb34f1e-dda8-43b0-9eea-6213b58cacdc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '춤', part.name_en = 'III. Dance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13310 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d513cc43-85c3-4daf-a83b-b643b1adf654' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d513cc43-85c3-4daf-a83b-b643b1adf654', 3, 'III', '춤', 'III. Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13310 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d513cc43-85c3-4daf-a83b-b643b1adf654'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '엘레지', part.name_en = 'IV. Elegy',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13310 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:4503b693-e497-49f7-ba23-5c95e900a853' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4503b693-e497-49f7-ba23-5c95e900a853', 4, 'IV', '엘레지', 'IV. Elegy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13310 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4503b693-e497-49f7-ba23-5c95e900a853'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '왈츠', part.name_en = 'V. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13310 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d3d91763-a59a-4f06-835d-0daed803ca9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3d91763-a59a-4f06-835d-0daed803ca9d', 5, 'V', '왈츠', 'V. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13310 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3d91763-a59a-4f06-835d-0daed803ca9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '갤럽', part.name_en = 'VI. Galop',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13310 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:1ea03ee6-a5cc-439b-a398-f331d2528594' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea03ee6-a5cc-439b-a398-f331d2528594', 6, 'VI', '갤럽', 'VI. Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13310 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea03ee6-a5cc-439b-a398-f331d2528594'
);


-- None 발레 모음곡 4번

UPDATE pieces piece
SET piece.title = '발레 모음곡 4번', piece.title_en = 'Ballet Suite No. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1953, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12103 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1953
WHERE piece.id = 12103 AND piece.composer_id = 83 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '서주 (변주)', part.name_en = 'I. Introduction (Variation)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12103 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:d101ee35-7485-352a-9dc3-4b87eff909d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d101ee35-7485-352a-9dc3-4b87eff909d0', 1, 'I', '서주 (변주)', 'I. Introduction (Variation)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12103 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d101ee35-7485-352a-9dc3-4b87eff909d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '왈츠', part.name_en = 'II. Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12103 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5ec692c9-4107-3f97-b3d2-e21c94fa021f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ec692c9-4107-3f97-b3d2-e21c94fa021f', 2, 'II', '왈츠', 'II. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12103 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ec692c9-4107-3f97-b3d2-e21c94fa021f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스케르초', part.name_en = 'III. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 12103 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0628038f-0b25-3d2a-bba7-4bc64967bd63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0628038f-0b25-3d2a-bba7-4bc64967bd63', 3, 'III', '스케르초', 'III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 12103 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0628038f-0b25-3d2a-bba7-4bc64967bd63'
);


-- None 2대의 피아노를 위한 타란텔라

UPDATE pieces piece
SET piece.title = '2대의 피아노를 위한 타란텔라', piece.title_en = 'Tarantella for Two Pianos',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1954, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13130 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1954
WHERE piece.id = 13130 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 가곡 <입맞춤이 있었네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <입맞춤이 있었네>', '"There Were Kisses..."', 'song', NULL, NULL, NULL, 1954, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <입맞춤이 있었네>'
);


-- None 10월의 새벽

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '10월의 새벽', 'October Dawn', 'song', NULL, NULL, NULL, 1954, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '10월의 새벽'
);


-- None 버라이어티 오케스트라 모음곡 1번

UPDATE pieces piece
SET piece.title = '버라이어티 오케스트라 모음곡 1번', piece.title_en = 'Suite for Variety Orchestra No. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 13454 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '행진곡', part.name_en = 'I. March',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13454 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:027b3aa9-c85f-3376-8f3c-ac3b950e8c15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:027b3aa9-c85f-3376-8f3c-ac3b950e8c15', 1, 'I', '행진곡', 'I. March', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13454 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:027b3aa9-c85f-3376-8f3c-ac3b950e8c15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '춤 1번', part.name_en = 'II. Dance No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13454 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0d4312bc-b34d-3859-97c2-952b8cf1797a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d4312bc-b34d-3859-97c2-952b8cf1797a', 2, 'II', '춤 1번', 'II. Dance No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13454 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d4312bc-b34d-3859-97c2-952b8cf1797a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '춤 2번', part.name_en = 'III. Dance No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13454 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:b848aeb3-90d2-33d2-98c7-14a8c7d2735c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b848aeb3-90d2-33d2-98c7-14a8c7d2735c', 3, 'III', '춤 2번', 'III. Dance No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13454 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b848aeb3-90d2-33d2-98c7-14a8c7d2735c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '작은 폴카', part.name_en = 'IV. Little Polka',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13454 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:7ccaccd1-0ebc-39c3-aeae-0136d21c2ac0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ccaccd1-0ebc-39c3-aeae-0136d21c2ac0', 4, 'IV', '작은 폴카', 'IV. Little Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13454 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ccaccd1-0ebc-39c3-aeae-0136d21c2ac0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '서정적 왈츠', part.name_en = 'V. Lyric Waltz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13454 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:5fd4f95f-5a04-32d5-a48b-cc0f373be0de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fd4f95f-5a04-32d5-a48b-cc0f373be0de', 5, 'V', '서정적 왈츠', 'V. Lyric Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13454 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fd4f95f-5a04-32d5-a48b-cc0f373be0de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = '왈츠 1번', part.name_en = 'VI. Waltz No. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13454 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:0982ff87-590c-30f3-b256-b4c7b03f281d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0982ff87-590c-30f3-b256-b4c7b03f281d', 6, 'VI', '왈츠 1번', 'VI. Waltz No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13454 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0982ff87-590c-30f3-b256-b4c7b03f281d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 319 AND linked.composer_id = 83),
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = '왈츠 2번', part.name_en = 'VII. Waltz No. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13454 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:8fcac0d0-d728-32e1-b7a5-8e5560ed36ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 319 AND linked.composer_id = 83), 'musicbrainz:8fcac0d0-d728-32e1-b7a5-8e5560ed36ab', 7, 'VII', '왈츠 2번', 'VII. Waltz No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13454 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fcac0d0-d728-32e1-b7a5-8e5560ed36ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = '피날레', part.name_en = 'VIII. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 13454 AND p.composer_id = 83 AND part.part_key = 'musicbrainz:ca9508a1-fbb5-312e-8365-d1f25ba29e78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca9508a1-fbb5-312e-8365-d1f25ba29e78', 8, 'VIII', '피날레', 'VIII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 13454 AND p.composer_id = 83
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca9508a1-fbb5-312e-8365-d1f25ba29e78'
);


-- None 발레 <아가씨와 불량배>

UPDATE pieces piece
SET piece.title = '발레 <아가씨와 불량배>', piece.title_en = 'The Lady and the Hooligan',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1962, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12862 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1962
WHERE piece.id = 12862 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None 부수음악 <예브게니 오네긴>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <예브게니 오네긴>', 'Yevgeny Onegin (incidental music)', 'song', NULL, NULL, NULL, 1964, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <예브게니 오네긴>'
);


-- None 버라이어티 오케스트라 모음곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '버라이어티 오케스트라 모음곡 2번', 'Suite for Variety Orchestra No. 2', 'album', NULL, NULL, NULL, 1967, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '버라이어티 오케스트라 모음곡 2번'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-variety-suite-2:1', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '버라이어티 오케스트라 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-variety-suite-2:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-variety-suite-2:2', 2, 'II', '왈츠', 'II. Waltz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '버라이어티 오케스트라 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-variety-suite-2:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-variety-suite-2:3', 3, 'III', '간주곡', 'III. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '버라이어티 오케스트라 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-variety-suite-2:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:shostakovich:shostakovich-wo-variety-suite-2:4', 4, 'IV', '피날레', 'IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 83 AND p.title = '버라이어티 오케스트라 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:shostakovich:shostakovich-wo-variety-suite-2:4'
);


-- None 가곡 <옐라부가의 못>

UPDATE pieces piece
SET piece.title = '가곡 <옐라부가의 못>', piece.title_en = 'Yelabuga Nail',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1971, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 12719 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1971
WHERE piece.id = 12719 AND piece.composer_id = 83 AND piece.composition_year IS NULL;


-- None <인터비전>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<인터비전>', 'Intervision', 'song', NULL, NULL, NULL, 1971, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<인터비전>'
);


-- None 발레 <몽상가들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <몽상가들>', 'The Dreamers', 'song', NULL, NULL, NULL, 1975, 'manual', 1
FROM composers c
WHERE c.id = 83
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <몽상가들>'
);


-- 단독으로 연주되는 대목은 남기고 제목만 우리말로
UPDATE pieces piece
SET piece.title = '영화음악 <카운터플랜> 중 "카운터플랜의 노래"', piece.title_en = '"Song of the Counterplan" from Counterplan', piece.editor_locked = 1
WHERE piece.id = 13553 AND piece.composer_id = 83
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 111개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 83 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    1643, 2346, 2479, 12013, 12030, 12042, 12045, 12048, 12100, 12113, 12124, 12140, 12146, 12193, 12201, 12223, 12257, 12261, 12279, 12281,
    12341, 12355, 12359, 12375, 12378, 12392, 12396, 12399, 12403, 12437, 12438, 12446, 12459, 12467, 12507, 12512, 12514, 12515, 12526, 12536,
    12550, 12564, 12571, 12574, 12601, 12614, 12655, 12666, 12674, 12676, 12681, 12708, 12735, 12738, 12777, 12815, 12833, 12845, 12865, 12879,
    12891, 12904, 12909, 12918, 12947, 12950, 12987, 13014, 13016, 13017, 13019, 13046, 13049, 13050, 13054, 13092, 13106, 13120, 13173, 13188,
    13218, 13248, 13260, 13266, 13296, 13325, 13327, 13328, 13343, 13378, 13411, 13417, 13419, 13420, 13432, 13435, 13450, 13452, 13459, 13463,
    13464, 13487, 13561, 13563, 13603, 13609, 13644, 13652, 13682, 13687, 13701
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
