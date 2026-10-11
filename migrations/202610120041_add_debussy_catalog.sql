-- 드뷔시 작품을 출판 단위로 다시 짠다(카탈로그: L.(르쥐르 1977)·CD). 작품 139개(묶음 25, 다악장 15, 낱곡 99),
-- 새 작품 28개, 기존 작품 111개(seed 제목 고침 127개), part 155개, 그 아래 3개,
-- 기존 part 고쳐 씀 4개, 기존 작품 연결 22개. 카탈로그에 대응이 없는 seed 135개는 목록에서 숨긴다.
--
-- 정한 것
--   catalogue 는 운영·음반 표기와 같은 L¹(L. 75), catalogueAlt 는 L²(CD 82). L¹ 이 없는 곡은 CD 번호만.
--   같은 곡의 여러 판은 한 작품(드뷔시가 쓴 완전한 판의 번호·MBID). 남이 완성한 5곡은 넣고 오렐지 복원 2곡은 뺀다.
--   220 「달빛」은 <베르가마스크 모음곡> 3번, 224 「아라베스크 1번」은 <2개의 아라베스크> 1번 part 로 잇는다.
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

-- L. 2 가곡 <Madrid>

UPDATE pieces piece
SET piece.title = '가곡 <Madrid>', piece.title_en = 'Madrid',
    piece.type = 'song', piece.opus_number = 'L. 2',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1879, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10660 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1879
WHERE piece.id = 10660 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 4 가곡 <Nuit d'étoiles>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Nuit d''étoiles>', 'Nuit d''étoiles', 'song', 'L. 4', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Nuit d''étoiles>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f3a5ef3-5346-46d3-a4d9-9c1711588d87'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f3a5ef3-5346-46d3-a4d9-9c1711588d87'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡 <Nuit d''étoiles>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f3a5ef3-5346-46d3-a4d9-9c1711588d87'
);


-- L. 8 가곡 <Rêverie>

UPDATE pieces piece
SET piece.title = '가곡 <Rêverie>', piece.title_en = 'Rêverie (Le zéphir à la douce haleine)',
    piece.type = 'song', piece.opus_number = 'L. 8',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10477 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 10477 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 9 <보헤미안 춤>

UPDATE pieces piece
SET piece.title = '<보헤미안 춤>', piece.title_en = 'Danse bohémienne',
    piece.type = 'song', piece.opus_number = 'L. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7588 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 7588 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 3 피아노 3중주 G장조

UPDATE pieces piece
SET piece.title = '피아노 3중주 G장조', piece.title_en = 'Piano Trio in G major',
    piece.type = 'album', piece.opus_number = 'L. 3',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7431 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 7431 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino con moto allegro', part.name_en = 'I. Andantino con moto allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7431 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:3df69b2b-0d4e-4ba5-a993-ea83e948c01c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3df69b2b-0d4e-4ba5-a993-ea83e948c01c', 1, 'I', 'Andantino con moto allegro', 'I. Andantino con moto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7431 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3df69b2b-0d4e-4ba5-a993-ea83e948c01c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '스케르초 – 인테르메초. Moderato con allegro', part.name_en = 'II. Scherzo – Intermezzo. Moderato con allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7431 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:42f01635-f9fb-47d5-a284-ac29ef6cde8c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42f01635-f9fb-47d5-a284-ac29ef6cde8c', 2, 'II', '스케르초 – 인테르메초. Moderato con allegro', 'II. Scherzo – Intermezzo. Moderato con allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7431 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42f01635-f9fb-47d5-a284-ac29ef6cde8c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante espressivo', part.name_en = 'III. Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7431 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:71b0e0ab-ea95-4214-b7cd-b0e7634fdb9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71b0e0ab-ea95-4214-b7cd-b0e7634fdb9c', 3, 'III', 'Andante espressivo', 'III. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7431 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71b0e0ab-ea95-4214-b7cd-b0e7634fdb9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Appassionato', part.name_en = 'IV. Finale. Appassionato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7431 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:7443a753-af1c-4276-bacd-f062b24fda74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7443a753-af1c-4276-bacd-f062b24fda74', 4, 'IV', '피날레. Appassionato', 'IV. Finale. Appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7431 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7443a753-af1c-4276-bacd-f062b24fda74'
);


-- L. 5 가곡 <Caprice>

UPDATE pieces piece
SET piece.title = '가곡 <Caprice>', piece.title_en = 'Caprice',
    piece.type = 'song', piece.opus_number = 'L. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7652 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 7652 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 16 가곡 <Aimons-nous et dormons>

UPDATE pieces piece
SET piece.title = '가곡 <Aimons-nous et dormons>', piece.title_en = 'Aimons-nous et dormons',
    piece.type = 'song', piece.opus_number = 'L. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1880, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7583 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1880
WHERE piece.id = 7583 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 10 교향곡 B단조 (피아노 연탄)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 B단조 (피아노 연탄)', 'Symphony in B minor (piano four-hands)', 'song', 'L. 10', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 B단조 (피아노 연탄)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbb113ce-6806-42b7-afbd-963254f8ebda'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbb113ce-6806-42b7-afbd-963254f8ebda'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '교향곡 B단조 (피아노 연탄)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbb113ce-6806-42b7-afbd-963254f8ebda'
);


-- None 가곡 <Les baisers>

UPDATE pieces piece
SET piece.title = '가곡 <Les baisers>', piece.title_en = 'Les baisers',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8578 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 8578 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 17 가곡 <Rondel chinois>

UPDATE pieces piece
SET piece.title = '가곡 <Rondel chinois>', piece.title_en = 'Rondel chinois',
    piece.type = 'song', piece.opus_number = 'L. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7650 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 7650 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 18 가곡 <Tragédie>

UPDATE pieces piece
SET piece.title = '가곡 <Tragédie>', piece.title_en = 'Tragédie',
    piece.type = 'song', piece.opus_number = 'L. 18',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9183 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 9183 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 19 가곡 <Jane>

UPDATE pieces piece
SET piece.title = '가곡 <Jane>', piece.title_en = 'Jane',
    piece.type = 'song', piece.opus_number = 'L. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7651 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 7651 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 33 가곡 <La fille aux cheveux de lin>

UPDATE pieces piece
SET piece.title = '가곡 <La fille aux cheveux de lin>', piece.title_en = 'La fille aux cheveux de lin (song)',
    piece.type = 'song', piece.opus_number = 'L. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10608 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 10608 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 7 가곡 <Fleur des blés>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Fleur des blés>', 'Fleur des blés', 'song', 'L. 7', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Fleur des blés>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70161866-1bb6-4b9b-8032-3970788d97a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70161866-1bb6-4b9b-8032-3970788d97a7'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡 <Fleur des blés>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70161866-1bb6-4b9b-8032-3970788d97a7'
);


-- L. 30 가곡 <Rondeau>

UPDATE pieces piece
SET piece.title = '가곡 <Rondeau>', piece.title_en = 'Rondeau',
    piece.type = 'song', piece.opus_number = 'L. 30',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7868 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 7868 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 11 가곡 <Souhait>

UPDATE pieces piece
SET piece.title = '가곡 <Souhait>', piece.title_en = 'Souhait',
    piece.type = 'song', piece.opus_number = 'L. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10784 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 10784 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 12 가곡 <Triolet à Philis>

UPDATE pieces piece
SET piece.title = '가곡 <Triolet à Philis>', piece.title_en = 'Triolet à Philis (Zéphyr)',
    piece.type = 'song', piece.opus_number = 'L. 12',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7537 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 7537 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- None <디안> 서곡 (피아노 연탄)

UPDATE pieces piece
SET piece.title = '<디안> 서곡 (피아노 연탄)', piece.title_en = 'Diane, Overture (piano four-hands)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8961 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 8961 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- None 가곡 <Les papillons>

UPDATE pieces piece
SET piece.title = '가곡 <Les papillons>', piece.title_en = 'Les papillons',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9314 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 9314 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 46 가곡 <L'archet>

UPDATE pieces piece
SET piece.title = '가곡 <L''archet>', piece.title_en = 'L''archet',
    piece.type = 'song', piece.opus_number = 'L. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7613 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 7613 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 48 가곡 <Fleur des eaux>

UPDATE pieces piece
SET piece.title = '가곡 <Fleur des eaux>', piece.title_en = 'Fleur des eaux (Les baisers d''amour)',
    piece.type = 'song', piece.opus_number = 'L. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7520 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 7520 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 47 가곡 <Chanson triste>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson triste>', piece.title_en = 'Chanson triste',
    piece.type = 'song', piece.opus_number = 'L. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7591 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 7591 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- None 가곡 <Les elfes>

UPDATE pieces piece
SET piece.title = '가곡 <Les elfes>', piece.title_en = 'Les elfes',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1881, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7949 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1881
WHERE piece.id = 7949 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 21 가곡 <Fantoches> (첫 판)

UPDATE pieces piece
SET piece.title = '가곡 <Fantoches> (첫 판)', piece.title_en = 'Fantoches (first version)',
    piece.type = 'song', piece.opus_number = 'L. 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7654 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 7654 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 49 2중창 <Églogue>

UPDATE pieces piece
SET piece.title = '2중창 <Églogue>', piece.title_en = 'Églogue',
    piece.type = 'song', piece.opus_number = 'L. 49',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9689 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 9689 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 13 가곡 <Les roses>

UPDATE pieces piece
SET piece.title = '가곡 <Les roses>', piece.title_en = 'Les roses',
    piece.type = 'song', piece.opus_number = 'L. 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10663 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10663 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 34 가곡 <Sérénade>

UPDATE pieces piece
SET piece.title = '가곡 <Sérénade>', piece.title_en = 'Sérénade',
    piece.type = 'song', piece.opus_number = 'L. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10581 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10581 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 15 가곡 <Pierrot>

UPDATE pieces piece
SET piece.title = '가곡 <Pierrot>', piece.title_en = 'Pierrot',
    piece.type = 'song', piece.opus_number = 'L. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7544 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 7544 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 23 가곡 <Fête galante>

UPDATE pieces piece
SET piece.title = '가곡 <Fête galante>', piece.title_en = 'Fête galante',
    piece.type = 'song', piece.opus_number = 'L. 23',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9627 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 9627 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 35 합창곡 <Choeur des brises>

UPDATE pieces piece
SET piece.title = '합창곡 <Choeur des brises>', piece.title_en = 'Choeur des brises',
    piece.type = 'song', piece.opus_number = 'L. 35',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10642 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10642 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- None 가곡 <Il dort encore>

UPDATE pieces piece
SET piece.title = '가곡 <Il dort encore>', piece.title_en = 'Il dort encore',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10630 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10630 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 20 칸타타 <다니엘>

UPDATE pieces piece
SET piece.title = '칸타타 <다니엘>', piece.title_en = 'Daniel, cantata',
    piece.type = 'song', piece.opus_number = 'L. 20',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9997 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 9997 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 22 가곡 <Le lilas>

UPDATE pieces piece
SET piece.title = '가곡 <Le lilas>', piece.title_en = 'Le lilas',
    piece.type = 'song', piece.opus_number = 'L. 22',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7790 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 7790 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 24 칸타타 <봄> (1882)

UPDATE pieces piece
SET piece.title = '칸타타 <봄> (1882)', piece.title_en = 'Printemps (Salut printemps), cantata',
    piece.type = 'song', piece.opus_number = 'L. 24',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10084 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10084 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 25 가곡 <Flots, palmes et sables>

UPDATE pieces piece
SET piece.title = '가곡 <Flots, palmes et sables>', piece.title_en = 'Flots, palmes et sables',
    piece.type = 'song', piece.opus_number = 'L. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9646 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 9646 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 27 첼로와 관현악을 위한 인테르메초

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 관현악을 위한 인테르메초', 'Intermezzo for cello and orchestra', 'song', 'L. 27', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 관현악을 위한 인테르메초'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3dca1a1b-bae9-46c3-b749-6c3a14a94abe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3dca1a1b-bae9-46c3-b749-6c3a14a94abe'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '첼로와 관현악을 위한 인테르메초' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3dca1a1b-bae9-46c3-b749-6c3a14a94abe'
);


-- None 2중창 <Ode bachique>

UPDATE pieces piece
SET piece.title = '2중창 <Ode bachique>', piece.title_en = 'Ode bachique',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10806 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10806 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 28 가곡 <En sourdine> (첫 판)

UPDATE pieces piece
SET piece.title = '가곡 <En sourdine> (첫 판)', piece.title_en = 'En sourdine (first version)',
    piece.type = 'song', piece.opus_number = 'L. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10810 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10810 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 29 가곡 <Mandoline>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mandoline>', 'Mandoline', 'song', 'L. 29', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mandoline>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d603dec-8fd3-467b-8cb6-799dfc20688c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d603dec-8fd3-467b-8cb6-799dfc20688c'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡 <Mandoline>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d603dec-8fd3-467b-8cb6-799dfc20688c'
);


-- L. 14 가곡 <Séguidille>

UPDATE pieces piece
SET piece.title = '가곡 <Séguidille>', piece.title_en = 'Séguidille',
    piece.type = 'song', piece.opus_number = 'L. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10484 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10484 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 32 가곡 <Clair de lune> (첫 판)

UPDATE pieces piece
SET piece.title = '가곡 <Clair de lune> (첫 판)', piece.title_en = 'Clair de lune (song, first version)',
    piece.type = 'song', piece.opus_number = 'L. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1882, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10566 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1882
WHERE piece.id = 10566 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 50 관현악 모음곡 1번 (피아노 연탄)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 모음곡 1번 (피아노 연탄)', 'Première Suite d''orchestre (piano four-hands)', 'album', 'L. 50', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 모음곡 1번 (피아노 연탄)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82c0eba4-279c-400e-bc32-99f1553261a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82c0eba4-279c-400e-bc32-99f1553261a5'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '관현악 모음곡 1번 (피아노 연탄)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82c0eba4-279c-400e-bc32-99f1553261a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58f02f7f-cb7f-45ce-bb1e-fdabfcea022a', 1, 'I', 'Fête', 'I. Fête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '관현악 모음곡 1번 (피아노 연탄)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58f02f7f-cb7f-45ce-bb1e-fdabfcea022a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78db1f6b-00bb-49b0-b02e-9fade61d7557', 2, 'II', '발레', 'II. Ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '관현악 모음곡 1번 (피아노 연탄)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78db1f6b-00bb-49b0-b02e-9fade61d7557'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6053f7d6-fdb9-4ac3-8763-e8507402cc48', 3, 'III', 'Rêve', 'III. Rêve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '관현악 모음곡 1번 (피아노 연탄)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6053f7d6-fdb9-4ac3-8763-e8507402cc48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a84a5735-562f-4819-b66b-e1b883bd9733', 4, 'IV', 'Cortège et Bacchanale', 'IV. Cortège et Bacchanale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '관현악 모음곡 1번 (피아노 연탄)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a84a5735-562f-4819-b66b-e1b883bd9733'
);


-- L. 31 가곡 <Pantomime>

UPDATE pieces piece
SET piece.title = '가곡 <Pantomime>', piece.title_en = 'Pantomime',
    piece.type = 'song', piece.opus_number = 'L. 31',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10448 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 10448 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 42 2중창 <Chanson espagnole>

UPDATE pieces piece
SET piece.title = '2중창 <Chanson espagnole>', piece.title_en = 'Chanson espagnole',
    piece.type = 'song', piece.opus_number = 'L. 42',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9121 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 9121 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 39 가곡 <Coquetterie posthume>

UPDATE pieces piece
SET piece.title = '가곡 <Coquetterie posthume>', piece.title_en = 'Coquetterie posthume',
    piece.type = 'song', piece.opus_number = 'L. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8924 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 8924 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 40 남성 합창과 관현악을 위한 <Invocation>

UPDATE pieces piece
SET piece.title = '남성 합창과 관현악을 위한 <Invocation>', piece.title_en = 'Invocation',
    piece.type = 'song', piece.opus_number = 'L. 40',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9187 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 9187 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 41 칸타타 <검투사>

UPDATE pieces piece
SET piece.title = '칸타타 <검투사>', piece.title_en = 'Le gladiateur, cantata',
    piece.type = 'song', piece.opus_number = 'L. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11159 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 11159 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 43 가곡 <Romance> (Silence ineffable de l'heure)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Romance> (Silence ineffable de l''heure)', 'Romance (Silence ineffable de l''heure)', 'song', 'L. 43', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Romance> (Silence ineffable de l''heure)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de4e3a06-86c7-4141-a67f-d79f4c5d7a7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de4e3a06-86c7-4141-a67f-d79f4c5d7a7d'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡 <Romance> (Silence ineffable de l''heure)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de4e3a06-86c7-4141-a67f-d79f4c5d7a7d'
);


-- L. 44 가곡 <Musique>

UPDATE pieces piece
SET piece.title = '가곡 <Musique>', piece.title_en = 'Musique',
    piece.type = 'song', piece.opus_number = 'L. 44',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11089 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 11089 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 45 가곡 <Paysage sentimental>

UPDATE pieces piece
SET piece.title = '가곡 <Paysage sentimental>', piece.title_en = 'Paysage sentimental',
    piece.type = 'song', piece.opus_number = 'L. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1883, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8123 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1883
WHERE piece.id = 8123 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 52 가곡 <Romance> (Voici que le printemps)

UPDATE pieces piece
SET piece.title = '가곡 <Romance> (Voici que le printemps)', piece.title_en = 'Romance (Voici que le printemps)',
    piece.type = 'song', piece.opus_number = 'L. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8107 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 8107 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 53 가곡 <Apparition>

UPDATE pieces piece
SET piece.title = '가곡 <Apparition>', piece.title_en = 'Apparition',
    piece.type = 'song', piece.opus_number = 'L. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7624 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 7624 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 54 가곡 <La romance d'Ariel>

UPDATE pieces piece
SET piece.title = '가곡 <La romance d''Ariel>', piece.title_en = 'La romance d''Ariel',
    piece.type = 'song', piece.opus_number = 'L. 54',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10541 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 10541 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 55 가곡 <Regret>

UPDATE pieces piece
SET piece.title = '가곡 <Regret>', piece.title_en = 'Regret',
    piece.type = 'song', piece.opus_number = 'L. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10759 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 10759 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 56 칸타타 <봄> (1884)

UPDATE pieces piece
SET piece.title = '칸타타 <봄> (1884)', piece.title_en = 'Le printemps (L''aimable printemps), cantata',
    piece.type = 'song', piece.opus_number = 'L. 56',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10976 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 10976 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 57 칸타타 <탕아>

UPDATE pieces piece
SET piece.title = '칸타타 <탕아>', piece.title_en = 'L''enfant prodigue, scène lyrique',
    piece.type = 'song', piece.opus_number = 'L. 57',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8502 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 8502 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 36 디베르티스망 (피아노 연탄)

UPDATE pieces piece
SET piece.title = '디베르티스망 (피아노 연탄)', piece.title_en = 'Divertissement (piano four-hands)',
    piece.type = 'song', piece.opus_number = 'L. 36',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1884, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9486 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1884
WHERE piece.id = 9486 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 60 가곡집 <Ariettes oubliées>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <Ariettes oubliées>', 'Ariettes oubliées', 'album', 'L. 60', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <Ariettes oubliées>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d0e2100-95f9-46b4-b81f-6270c470efbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1d0e2100-95f9-46b4-b81f-6270c470efbd'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <Ariettes oubliées>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d0e2100-95f9-46b4-b81f-6270c470efbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d146b8b-6a0a-4136-a8d9-1f70da6c04a9', 1, NULL, 'C''est l''extase langoureuse', 'No. 1 C''est l''extase langoureuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <Ariettes oubliées>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d146b8b-6a0a-4136-a8d9-1f70da6c04a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f115fe4-1c0b-46fa-980a-cfbee0b4c07e', 2, NULL, 'Il pleure dans mon cœur', 'No. 2 Il pleure dans mon cœur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <Ariettes oubliées>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f115fe4-1c0b-46fa-980a-cfbee0b4c07e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab9e4584-a1ee-4ace-9356-f7b8171590b1', 3, NULL, 'L''ombre des arbres', 'No. 3 L''ombre des arbres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <Ariettes oubliées>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab9e4584-a1ee-4ace-9356-f7b8171590b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0b7d108-45f2-4854-8559-22df1eb994a7', 4, NULL, 'Chevaux de bois', 'No. 4 Paysages belges: Chevaux de bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <Ariettes oubliées>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0b7d108-45f2-4854-8559-22df1eb994a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6df305d-63b1-406e-ab5d-d21dd9c91593', 5, NULL, 'Green', 'No. 5 Aquarelles: Green', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <Ariettes oubliées>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6df305d-63b1-406e-ab5d-d21dd9c91593'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a46f53af-943b-4f54-aae8-3763c3f22545', 6, NULL, 'Spleen', 'No. 6 Aquarelles: Spleen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <Ariettes oubliées>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a46f53af-943b-4f54-aae8-3763c3f22545'
);


-- L. 79 <두 개의 로망스>

UPDATE pieces piece
SET piece.title = '<두 개의 로망스>', piece.title_en = 'Deux romances',
    piece.type = 'album', piece.opus_number = 'L. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1885, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10803 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1885
WHERE piece.id = 10803 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Romance', part.name_en = 'No. 1 Romance (L''âme évaporée et souffrante)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10803 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:f1e697e8-a8bc-4c43-9fe7-2cbda3c9f17e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1e697e8-a8bc-4c43-9fe7-2cbda3c9f17e', 1, NULL, 'Romance', 'No. 1 Romance (L''âme évaporée et souffrante)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10803 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1e697e8-a8bc-4c43-9fe7-2cbda3c9f17e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Les cloches', part.name_en = 'No. 2 Les cloches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10803 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:55da3385-677d-4348-af21-2552bd92307f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55da3385-677d-4348-af21-2552bd92307f', 2, NULL, 'Les cloches', 'No. 2 Les cloches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10803 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55da3385-677d-4348-af21-2552bd92307f'
);


-- L. 61 교향적 모음곡 <봄>

UPDATE pieces piece
SET piece.title = '교향적 모음곡 <봄>', piece.title_en = 'Printemps, suite symphonique',
    piece.type = 'album', piece.opus_number = 'L. 61',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1887, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9122 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1887
WHERE piece.id = 9122 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Très modéré', part.name_en = 'I. Très modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9122 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:1a73618e-b9e5-4244-8c37-63fd98d438b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a73618e-b9e5-4244-8c37-63fd98d438b6', 1, 'I', 'Très modéré', 'I. Très modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9122 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a73618e-b9e5-4244-8c37-63fd98d438b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Modéré', part.name_en = 'II. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9122 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:81e93345-bfe3-422f-b2e4-ae5556756adc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81e93345-bfe3-422f-b2e4-ae5556756adc', 2, 'II', 'Modéré', 'II. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9122 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81e93345-bfe3-422f-b2e4-ae5556756adc'
);


-- L. 62 칸타타 <선택받은 처녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <선택받은 처녀>', 'La Damoiselle élue', 'song', 'L. 62', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <선택받은 처녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40ce7425-f0f1-42e6-92e6-9d7af59acd74'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40ce7425-f0f1-42e6-92e6-9d7af59acd74'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '칸타타 <선택받은 처녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40ce7425-f0f1-42e6-92e6-9d7af59acd74'
);


-- L. 64 <보들레르의 시 5편>

UPDATE pieces piece
SET piece.title = '<보들레르의 시 5편>', piece.title_en = 'Cinq poèmes de Baudelaire',
    piece.type = 'album', piece.opus_number = 'L. 64',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1889, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10042 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1889
WHERE piece.id = 10042 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le balcon', part.name_en = 'No. 1 Le balcon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10042 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:00a2ea08-11f1-307f-8821-e736895c4856' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00a2ea08-11f1-307f-8821-e736895c4856', 1, NULL, 'Le balcon', 'No. 1 Le balcon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10042 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00a2ea08-11f1-307f-8821-e736895c4856'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Harmonie du soir', part.name_en = 'No. 2 Harmonie du soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10042 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:b55208d2-4ac2-3f71-8ab8-ccdfd9cc3685' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b55208d2-4ac2-3f71-8ab8-ccdfd9cc3685', 2, NULL, 'Harmonie du soir', 'No. 2 Harmonie du soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10042 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b55208d2-4ac2-3f71-8ab8-ccdfd9cc3685'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le jet d''eau', part.name_en = 'No. 3 Le jet d''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10042 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:1bd32848-1366-345d-8a33-5caa362528ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bd32848-1366-345d-8a33-5caa362528ff', 3, NULL, 'Le jet d''eau', 'No. 3 Le jet d''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10042 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd32848-1366-345d-8a33-5caa362528ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Recueillement', part.name_en = 'No. 4 Recueillement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10042 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:78e6ece7-478c-38f3-8e09-e20847edd201' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78e6ece7-478c-38f3-8e09-e20847edd201', 4, NULL, 'Recueillement', 'No. 4 Recueillement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10042 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e6ece7-478c-38f3-8e09-e20847edd201'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La mort des amants', part.name_en = 'No. 5 La mort des amants',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10042 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:00b75def-651f-345f-9738-a916e370f7a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00b75def-651f-345f-9738-a916e370f7a3', 5, NULL, 'La mort des amants', 'No. 5 La mort des amants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10042 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b75def-651f-345f-9738-a916e370f7a3'
);


-- L. 65 <작은 모음곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<작은 모음곡>', 'Petite Suite', 'album', 'L. 65', NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<작은 모음곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db6b904f-b5ee-4e3c-a172-5aab4aa526e0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db6b904f-b5ee-4e3c-a172-5aab4aa526e0'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<작은 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db6b904f-b5ee-4e3c-a172-5aab4aa526e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6477fe28-fa4e-3b68-a4a7-567c748739f6', 1, 'I', 'En bateau', 'I. En bateau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<작은 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6477fe28-fa4e-3b68-a4a7-567c748739f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:525cd5c9-059b-3ea1-bb8a-1e4f70a65b1d', 2, 'II', 'Cortège', 'II. Cortège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<작은 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:525cd5c9-059b-3ea1-bb8a-1e4f70a65b1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ac43c33-5c8e-3cfe-bf98-48469f5ef79a', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<작은 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ac43c33-5c8e-3cfe-bf98-48469f5ef79a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e00abe0b-f5f0-364e-a9d9-11fc322b4ac7', 4, 'IV', '발레', 'IV. Ballet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<작은 모음곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e00abe0b-f5f0-364e-a9d9-11fc322b4ac7'
);


-- L. 73 피아노와 관현악을 위한 환상곡

UPDATE pieces piece
SET piece.title = '피아노와 관현악을 위한 환상곡', piece.title_en = 'Fantaisie for piano and orchestra',
    piece.type = 'album', piece.opus_number = 'L. 73',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10373 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 10373 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante – Allegro', part.name_en = 'I. Andante – Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10373 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:6d7c429f-32ec-46a3-9f4e-2c574a9b9e97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d7c429f-32ec-46a3-9f4e-2c574a9b9e97', 1, 'I', 'Andante – Allegro', 'I. Andante – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10373 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d7c429f-32ec-46a3-9f4e-2c574a9b9e97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lento e molto espressivo', part.name_en = 'II. Lento e molto espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10373 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:cc295add-f5e9-4c74-a7bf-0529a017b56d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc295add-f5e9-4c74-a7bf-0529a017b56d', 2, 'II', 'Lento e molto espressivo', 'II. Lento e molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10373 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc295add-f5e9-4c74-a7bf-0529a017b56d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro molto', part.name_en = 'III. Allegro molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10373 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:097c011e-147a-427a-9f20-11b785a23c96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:097c011e-147a-427a-9f20-11b785a23c96', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10373 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:097c011e-147a-427a-9f20-11b785a23c96'
);


-- L. 63 가곡 <Axel>

UPDATE pieces piece
SET piece.title = '가곡 <Axel>', piece.title_en = 'Axel',
    piece.type = 'song', piece.opus_number = 'L. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10664 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 10664 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 66 2개의 아라베스크

UPDATE pieces piece
SET piece.title = '2개의 아라베스크', piece.title_en = 'Deux arabesques',
    piece.type = 'album', piece.opus_number = 'L. 66',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11034 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 11034 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 224 AND linked.composer_id = 50),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'E장조', part.name_en = 'No. 1 in E major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11034 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:e92cdd58-c0b1-315a-8193-5f2bfccda28c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 224 AND linked.composer_id = 50), 'musicbrainz:e92cdd58-c0b1-315a-8193-5f2bfccda28c', 1, NULL, 'E장조', 'No. 1 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11034 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e92cdd58-c0b1-315a-8193-5f2bfccda28c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'G장조', part.name_en = 'No. 2 in G major',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 11034 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:3dea5e9e-7904-3627-a135-e1e4c8a8cc5a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dea5e9e-7904-3627-a135-e1e4c8a8cc5a', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 11034 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dea5e9e-7904-3627-a135-e1e4c8a8cc5a'
);


-- L. 67 마주르카

UPDATE pieces piece
SET piece.title = '마주르카', piece.title_en = 'Mazurka',
    piece.type = 'song', piece.opus_number = 'L. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7446 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 7446 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 69 <스티리아풍 타란텔라>

UPDATE pieces piece
SET piece.title = '<스티리아풍 타란텔라>', piece.title_en = 'Tarantelle styrienne (Danse)',
    piece.type = 'song', piece.opus_number = 'L. 69',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7439 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 7439 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 70 <슬라브 발라드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<슬라브 발라드>', 'Ballade slave (Ballade)', 'song', 'L. 70', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<슬라브 발라드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f924696e-0f37-3557-bb40-7fe10448b0a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f924696e-0f37-3557-bb40-7fe10448b0a2'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<슬라브 발라드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f924696e-0f37-3557-bb40-7fe10448b0a2'
);


-- L. 71 <낭만적 왈츠>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<낭만적 왈츠>', 'Valse romantique', 'song', 'L. 71', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<낭만적 왈츠>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f166206e-c5d2-3a21-b593-72ecf560fa04'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f166206e-c5d2-3a21-b593-72ecf560fa04'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<낭만적 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f166206e-c5d2-3a21-b593-72ecf560fa04'
);


-- L. 72 오페라 <로드리그와 시멘>

UPDATE pieces piece
SET piece.title = '오페라 <로드리그와 시멘>', piece.title_en = 'Rodrigue et Chimène',
    piece.type = 'song', piece.opus_number = 'L. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9787 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 9787 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 74 가곡 <La belle au bois dormant>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La belle au bois dormant>', 'La belle au bois dormant', 'song', 'L. 74', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La belle au bois dormant>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af56a436-835b-4edf-a97f-de922709a254'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af56a436-835b-4edf-a97f-de922709a254'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡 <La belle au bois dormant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af56a436-835b-4edf-a97f-de922709a254'
);


-- L. 75 <베르가마스크 모음곡>

UPDATE pieces piece
SET piece.title = '<베르가마스크 모음곡>', piece.title_en = 'Suite bergamasque',
    piece.type = 'album', piece.opus_number = 'L. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8876 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 8876 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8876 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:fe4cfa64-156a-3d74-bf2e-7c12f01908bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe4cfa64-156a-3d74-bf2e-7c12f01908bb', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8876 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe4cfa64-156a-3d74-bf2e-7c12f01908bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '미뉴에트', part.name_en = 'II. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8876 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:82ea1cd4-1692-3b55-99a8-9b387cfa2ba3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82ea1cd4-1692-3b55-99a8-9b387cfa2ba3', 2, 'II', '미뉴에트', 'II. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8876 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82ea1cd4-1692-3b55-99a8-9b387cfa2ba3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 220 AND linked.composer_id = 50),
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '달빛 (Clair de lune)', part.name_en = 'III. Clair de lune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8876 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:8d331505-4d88-39ae-81c7-bec5da77af96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 220 AND linked.composer_id = 50), 'musicbrainz:8d331505-4d88-39ae-81c7-bec5da77af96', 3, 'III', '달빛 (Clair de lune)', 'III. Clair de lune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8876 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d331505-4d88-39ae-81c7-bec5da77af96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '파스피에', part.name_en = 'IV. Passepied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8876 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:59cce5c6-5483-32c4-8823-5841ae4e8a69' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59cce5c6-5483-32c4-8823-5841ae4e8a69', 4, 'IV', '파스피에', 'IV. Passepied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8876 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59cce5c6-5483-32c4-8823-5841ae4e8a69'
);


-- L. 77 <스코틀랜드 행진곡>

UPDATE pieces piece
SET piece.title = '<스코틀랜드 행진곡>', piece.title_en = 'Marche écossaise sur un thème populaire',
    piece.type = 'song', piece.opus_number = 'L. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1890, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10965 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1890
WHERE piece.id = 10965 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 6 가곡 <아름다운 저녁>

UPDATE pieces piece
SET piece.title = '가곡 <아름다운 저녁>', piece.title_en = 'Beau soir',
    piece.type = 'song', piece.opus_number = 'L. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10236 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 10236 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 81 베를렌의 시에 의한 3개의 가곡

UPDATE pieces piece
SET piece.title = '베를렌의 시에 의한 3개의 가곡', piece.title_en = 'Trois mélodies de Verlaine',
    piece.type = 'album', piece.opus_number = 'L. 81',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1891, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9644 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1891
WHERE piece.id = 9644 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La mer est plus belle', part.name_en = 'No. 1 La mer est plus belle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9644 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:ae918302-0112-4ee1-833c-d56ebb464501' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae918302-0112-4ee1-833c-d56ebb464501', 1, NULL, 'La mer est plus belle', 'No. 1 La mer est plus belle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9644 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae918302-0112-4ee1-833c-d56ebb464501'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le son du cor s''afflige', part.name_en = 'No. 2 Le son du cor s''afflige',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9644 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:35781729-f653-45e8-8792-58caef66e9a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35781729-f653-45e8-8792-58caef66e9a4', 2, NULL, 'Le son du cor s''afflige', 'No. 2 Le son du cor s''afflige', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9644 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35781729-f653-45e8-8792-58caef66e9a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'L''échelonnement des haies', part.name_en = 'No. 3 L''échelonnement des haies',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9644 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:8d875d3e-e04a-44b9-ab76-7b76e6061206' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d875d3e-e04a-44b9-ab76-7b76e6061206', 3, NULL, 'L''échelonnement des haies', 'No. 3 L''échelonnement des haies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9644 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d875d3e-e04a-44b9-ab76-7b76e6061206'
);


-- L. 80 가곡집 <Fêtes galantes> 1집

UPDATE pieces piece
SET piece.title = '가곡집 <Fêtes galantes> 1집', piece.title_en = 'Fêtes galantes, Set 1',
    piece.type = 'album', piece.opus_number = 'L. 80',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8219 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 8219 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'En sourdine', part.name_en = 'No. 1 En sourdine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8219 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:23de7097-d71b-4815-bbdc-6032ab55333e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23de7097-d71b-4815-bbdc-6032ab55333e', 1, NULL, 'En sourdine', 'No. 1 En sourdine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8219 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23de7097-d71b-4815-bbdc-6032ab55333e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fantoches', part.name_en = 'No. 2 Fantoches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8219 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:1fd65297-c845-4154-99f5-a181c11da20f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1fd65297-c845-4154-99f5-a181c11da20f', 2, NULL, 'Fantoches', 'No. 2 Fantoches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8219 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fd65297-c845-4154-99f5-a181c11da20f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Clair de lune', part.name_en = 'No. 3 Clair de lune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8219 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:32d61023-74f7-4fc7-9387-b9708ee70f48' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32d61023-74f7-4fc7-9387-b9708ee70f48', 3, NULL, 'Clair de lune', 'No. 3 Clair de lune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8219 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32d61023-74f7-4fc7-9387-b9708ee70f48'
);


-- L. 76 가곡 <Les angélus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Les angélus>', 'Les angélus', 'song', 'L. 76', NULL, NULL, 1892, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Les angélus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '209b5602-3399-45ca-b2fd-f5783334023d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '209b5602-3399-45ca-b2fd-f5783334023d'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡 <Les angélus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '209b5602-3399-45ca-b2fd-f5783334023d'
);


-- L. 82 피아노를 위한 녹턴

UPDATE pieces piece
SET piece.title = '피아노를 위한 녹턴', piece.title_en = 'Nocturne for piano',
    piece.type = 'song', piece.opus_number = 'L. 82',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1892, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7510 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1892
WHERE piece.id = 7510 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 84 가곡집 <서정적 산문>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <서정적 산문>', 'Proses lyriques', 'album', 'L. 84', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <서정적 산문>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '187fd282-ae06-4888-9926-79f3abba5e29'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '187fd282-ae06-4888-9926-79f3abba5e29'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <서정적 산문>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '187fd282-ae06-4888-9926-79f3abba5e29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c343655-2a93-49db-bf72-66712df9320f', 1, NULL, 'De rêve', 'No. 1 De rêve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <서정적 산문>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c343655-2a93-49db-bf72-66712df9320f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcb9a55e-1017-4a74-af2e-58492846ee54', 2, NULL, 'De grève', 'No. 2 De grève', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <서정적 산문>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcb9a55e-1017-4a74-af2e-58492846ee54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf7455c-3624-4cf5-9237-f7bdfe9e4689', 3, NULL, 'De fleurs', 'No. 3 De fleurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <서정적 산문>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf7455c-3624-4cf5-9237-f7bdfe9e4689'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40d01bec-0166-4ea9-a3db-6a2ab7e455cd', 4, NULL, 'De soir', 'No. 4 De soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <서정적 산문>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40d01bec-0166-4ea9-a3db-6a2ab7e455cd'
);


-- L. 85 현악 4중주 G단조

UPDATE pieces piece
SET piece.title = '현악 4중주 G단조', piece.title_en = 'String Quartet in G minor',
    piece.type = 'album', piece.opus_number = 'L. 85',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7484 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 7484 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Animé et très décidé', part.name_en = 'I. Animé et très décidé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7484 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:85ffec33-85ea-45c5-bb12-0ce5d0647c44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85ffec33-85ea-45c5-bb12-0ce5d0647c44', 1, 'I', 'Animé et très décidé', 'I. Animé et très décidé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7484 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85ffec33-85ea-45c5-bb12-0ce5d0647c44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Assez vif et bien rythmé', part.name_en = 'II. Assez vif et bien rythmé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7484 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:c72b4a96-48f8-4f2c-9059-736c62bc4566' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c72b4a96-48f8-4f2c-9059-736c62bc4566', 2, 'II', 'Assez vif et bien rythmé', 'II. Assez vif et bien rythmé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7484 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c72b4a96-48f8-4f2c-9059-736c62bc4566'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino, doucement expressif', part.name_en = 'III. Andantino, doucement expressif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7484 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:f8bbb541-295b-452c-98be-6282343fc4b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8bbb541-295b-452c-98be-6282343fc4b7', 3, 'III', 'Andantino, doucement expressif', 'III. Andantino, doucement expressif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7484 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8bbb541-295b-452c-98be-6282343fc4b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Très modéré', part.name_en = 'IV. Très modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7484 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:31a96826-fbc2-4db0-aae2-3a7d30fc4736' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31a96826-fbc2-4db0-aae2-3a7d30fc4736', 4, 'IV', 'Très modéré', 'IV. Très modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7484 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31a96826-fbc2-4db0-aae2-3a7d30fc4736'
);


-- L. 88 오페라 <펠레아스와 멜리장드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <펠레아스와 멜리장드>', 'Pelléas et Mélisande', 'song', 'L. 88', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <펠레아스와 멜리장드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d7bec68-2514-4852-b9b5-c02104a98dbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3d7bec68-2514-4852-b9b5-c02104a98dbd'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '오페라 <펠레아스와 멜리장드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d7bec68-2514-4852-b9b5-c02104a98dbd'
);


-- L. 87 <잊혀진 영상>

UPDATE pieces piece
SET piece.title = '<잊혀진 영상>', piece.title_en = 'Images oubliées',
    piece.type = 'album', piece.opus_number = 'L. 87',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1894, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8226 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1894
WHERE piece.id = 8226 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lent (mélancolique et doux)', part.name_en = 'No. 1 Lent (mélancolique et doux)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8226 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:a80de783-4c65-3a77-ab3a-cd237acf3e5f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a80de783-4c65-3a77-ab3a-cd237acf3e5f', 1, NULL, 'Lent (mélancolique et doux)', 'No. 1 Lent (mélancolique et doux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8226 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a80de783-4c65-3a77-ab3a-cd237acf3e5f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Souvenir du Louvre', part.name_en = 'No. 2 Souvenir du Louvre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8226 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:dee1781b-957f-30bc-8fcb-48640f5a8caa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dee1781b-957f-30bc-8fcb-48640f5a8caa', 2, NULL, 'Souvenir du Louvre', 'No. 2 Souvenir du Louvre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8226 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dee1781b-957f-30bc-8fcb-48640f5a8caa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Quelques aspects de « Nous n''irons plus au bois »', part.name_en = 'No. 3 Quelques aspects de « Nous n''irons plus au bois »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8226 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:c8da6f5a-3021-3152-86ff-24e71dd2b605' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8da6f5a-3021-3152-86ff-24e71dd2b605', 3, NULL, 'Quelques aspects de « Nous n''irons plus au bois »', 'No. 3 Quelques aspects de « Nous n''irons plus au bois »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8226 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8da6f5a-3021-3152-86ff-24e71dd2b605'
);


-- L. 95 <피아노를 위하여>

UPDATE pieces piece
SET piece.title = '<피아노를 위하여>', piece.title_en = 'Pour le piano',
    piece.type = 'album', piece.opus_number = 'L. 95',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7482 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 7482 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '전주곡', part.name_en = 'I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7482 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:5b7f6c25-cec3-30df-814c-81831266d6db' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b7f6c25-cec3-30df-814c-81831266d6db', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7482 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b7f6c25-cec3-30df-814c-81831266d6db'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '사라반드', part.name_en = 'II. Sarabande',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7482 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:75c3effb-37fb-3bcc-844d-a763b3b4e84e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75c3effb-37fb-3bcc-844d-a763b3b4e84e', 2, 'II', '사라반드', 'II. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7482 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75c3effb-37fb-3bcc-844d-a763b3b4e84e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '토카타', part.name_en = 'III. Toccata',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7482 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:1bd3225c-0380-317f-aedb-d49df0249c53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bd3225c-0380-317f-aedb-d49df0249c53', 3, 'III', '토카타', 'III. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7482 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd3225c-0380-317f-aedb-d49df0249c53'
);


-- L. 89 바리톤과 관현악을 위한 <La Saulaie>

UPDATE pieces piece
SET piece.title = '바리톤과 관현악을 위한 <La Saulaie>', piece.title_en = 'La Saulaie',
    piece.type = 'song', piece.opus_number = 'L. 89',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8536 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 8536 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 90 가곡집 <빌리티스의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <빌리티스의 노래>', 'Chansons de Bilitis', 'album', 'L. 90', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <빌리티스의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3c7c847-31ae-477f-8409-72f4c3a99a96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3c7c847-31ae-477f-8409-72f4c3a99a96'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <빌리티스의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3c7c847-31ae-477f-8409-72f4c3a99a96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92a245cb-8bc5-499a-b102-00871a9fced6', 1, NULL, 'La flûte de Pan', 'No. 1 La flûte de Pan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <빌리티스의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a245cb-8bc5-499a-b102-00871a9fced6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3af49256-b632-4927-9654-c0dde2362ca7', 2, NULL, 'La chevelure', 'No. 2 La chevelure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <빌리티스의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af49256-b632-4927-9654-c0dde2362ca7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e25154e3-04e1-41bc-a0f5-f3947f9ce013', 3, NULL, 'Le tombeau des Naïades', 'No. 3 Le tombeau des Naïades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡집 <빌리티스의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e25154e3-04e1-41bc-a0f5-f3947f9ce013'
);


-- L. 91 관현악을 위한 3개의 녹턴

UPDATE pieces piece
SET piece.title = '관현악을 위한 3개의 녹턴', piece.title_en = 'Nocturnes',
    piece.type = 'album', piece.opus_number = 'L. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8526 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 8526 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '구름 (Nuages)', part.name_en = 'I. Nuages',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8526 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:dee3eaf8-08b4-3f47-b5db-bc6154497492' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dee3eaf8-08b4-3f47-b5db-bc6154497492', 1, 'I', '구름 (Nuages)', 'I. Nuages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8526 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dee3eaf8-08b4-3f47-b5db-bc6154497492'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '축제 (Fêtes)', part.name_en = 'II. Fêtes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8526 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:506d22e4-ba5c-344d-9c55-4204664a0508' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:506d22e4-ba5c-344d-9c55-4204664a0508', 2, 'II', '축제 (Fêtes)', 'II. Fêtes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8526 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:506d22e4-ba5c-344d-9c55-4204664a0508'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '사이렌 (Sirènes)', part.name_en = 'III. Sirènes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8526 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:62222ae3-2a30-341d-bc13-47a2eea87b6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62222ae3-2a30-341d-bc13-47a2eea87b6f', 3, 'III', '사이렌 (Sirènes)', 'III. Sirènes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8526 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62222ae3-2a30-341d-bc13-47a2eea87b6f'
);


-- L. 92 샤를 도를레앙의 시에 의한 3개의 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '샤를 도를레앙의 시에 의한 3개의 노래', 'Trois chansons de Charles d''Orléans', 'album', 'L. 92', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '샤를 도를레앙의 시에 의한 3개의 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efbad127-4df6-475b-a880-23aaaa9c1496'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efbad127-4df6-475b-a880-23aaaa9c1496'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '샤를 도를레앙의 시에 의한 3개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efbad127-4df6-475b-a880-23aaaa9c1496'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c444c1c-9203-4f3f-9d50-89482dc343b7', 1, NULL, 'Dieu ! qu''il la fait bon regarder !', 'No. 1 Dieu ! qu''il la fait bon regarder !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '샤를 도를레앙의 시에 의한 3개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c444c1c-9203-4f3f-9d50-89482dc343b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:280f69ff-d462-4fa0-8688-ec63566c5960', 2, NULL, 'Quand j''ai ouy le tabourin sonner', 'No. 2 Quand j''ai ouy le tabourin sonner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '샤를 도를레앙의 시에 의한 3개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:280f69ff-d462-4fa0-8688-ec63566c5960'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02c4c241-2143-45ea-bcd1-e55c39bf2a68', 3, NULL, 'Yver, vous n''estes qu''un villain', 'No. 3 Yver, vous n''estes qu''un villain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '샤를 도를레앙의 시에 의한 3개의 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02c4c241-2143-45ea-bcd1-e55c39bf2a68'
);


-- L. 93 <죽음의 비극>을 위한 자장가

UPDATE pieces piece
SET piece.title = '<죽음의 비극>을 위한 자장가', piece.title_en = 'Berceuse for La tragédie de la mort',
    piece.type = 'song', piece.opus_number = 'L. 93',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7499 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 7499 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 94 가곡집 <Nuits blanches>

UPDATE pieces piece
SET piece.title = '가곡집 <Nuits blanches>', piece.title_en = 'Nuits blanches',
    piece.type = 'album', piece.opus_number = 'L. 94',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7928 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 7928 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nuit sans fin', part.name_en = 'No. 1 Nuit sans fin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7928 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:c39ff925-620e-488d-affc-aea0fe327cd9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c39ff925-620e-488d-affc-aea0fe327cd9', 1, NULL, 'Nuit sans fin', 'No. 1 Nuit sans fin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7928 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c39ff925-620e-488d-affc-aea0fe327cd9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Lorsqu''elle est entrée', part.name_en = 'No. 2 Lorsqu''elle est entrée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7928 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:eb36c516-5fac-43b3-8efd-f978607c326c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb36c516-5fac-43b3-8efd-f978607c326c', 2, NULL, 'Lorsqu''elle est entrée', 'No. 2 Lorsqu''elle est entrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7928 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb36c516-5fac-43b3-8efd-f978607c326c'
);


-- L. 96 부수음악 <빌리티스의 노래>

UPDATE pieces piece
SET piece.title = '부수음악 <빌리티스의 노래>', piece.title_en = 'Les chansons de Bilitis, incidental music',
    piece.type = 'song', piece.opus_number = 'L. 96',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10061 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 10061 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 97 <린다라하> (두 대의 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<린다라하> (두 대의 피아노)', 'Lindaraja (two pianos)', 'song', 'L. 97', NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<린다라하> (두 대의 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd695a425-86ab-4b57-a881-1915652b0a76'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd695a425-86ab-4b57-a881-1915652b0a76'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<린다라하> (두 대의 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd695a425-86ab-4b57-a881-1915652b0a76'
);


-- L. 98 알토 색소폰과 관현악을 위한 랩소디

UPDATE pieces piece
SET piece.catalogue_system = 'L.', piece.catalogue_number = '98'
WHERE piece.id = 492 AND piece.composer_id = 50
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1911
WHERE piece.id = 492 AND piece.composer_id = 50 AND piece.composition_year IS NULL;
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0bbd82ee-9cbb-40a5-82ff-da8d31e276ea'
FROM pieces p
WHERE p.id = 492 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0bbd82ee-9cbb-40a5-82ff-da8d31e276ea'
);


-- L. 110 <영상> 1집

UPDATE pieces piece
SET piece.title = '<영상> 1집', piece.title_en = 'Images, Set 1',
    piece.type = 'album', piece.opus_number = 'L. 110',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7904 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 7904 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '물의 반영 (Reflets dans l''eau)', part.name_en = 'No. 1 Reflets dans l''eau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7904 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:eb7155d9-3bba-34da-bbf6-6ff2584e2d4b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb7155d9-3bba-34da-bbf6-6ff2584e2d4b', 1, NULL, '물의 반영 (Reflets dans l''eau)', 'No. 1 Reflets dans l''eau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7904 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb7155d9-3bba-34da-bbf6-6ff2584e2d4b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '라모 찬가 (Hommage à Rameau)', part.name_en = 'No. 2 Hommage à Rameau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7904 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:d650beb5-3a7f-3c61-847d-85b6a418dece' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d650beb5-3a7f-3c61-847d-85b6a418dece', 2, NULL, '라모 찬가 (Hommage à Rameau)', 'No. 2 Hommage à Rameau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7904 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d650beb5-3a7f-3c61-847d-85b6a418dece'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '움직임 (Mouvement)', part.name_en = 'No. 3 Mouvement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7904 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:7aef4b74-ea40-3636-a2df-4ebd0c6522ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7aef4b74-ea40-3636-a2df-4ebd0c6522ad', 3, NULL, '움직임 (Mouvement)', 'No. 3 Mouvement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7904 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aef4b74-ea40-3636-a2df-4ebd0c6522ad'
);


-- L. 78 가곡 <Dans le jardin>

UPDATE pieces piece
SET piece.title = '가곡 <Dans le jardin>', piece.title_en = 'Dans le jardin',
    piece.type = 'song', piece.opus_number = 'L. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8640 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 8640 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 100 <판화>

UPDATE pieces piece
SET piece.title = '<판화>', piece.title_en = 'Estampes',
    piece.type = 'album', piece.opus_number = 'L. 100',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10040 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 10040 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '탑 (Pagodes)', part.name_en = 'No. 1 Pagodes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10040 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:71d55229-3dd9-3f62-b82e-d5c1444b8e04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71d55229-3dd9-3f62-b82e-d5c1444b8e04', 1, NULL, '탑 (Pagodes)', 'No. 1 Pagodes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10040 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71d55229-3dd9-3f62-b82e-d5c1444b8e04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '그라나다의 저녁 (La soirée dans Grenade)', part.name_en = 'No. 2 La soirée dans Grenade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10040 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:caec7e76-b080-344b-9f49-22be2fe584ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caec7e76-b080-344b-9f49-22be2fe584ea', 2, NULL, '그라나다의 저녁 (La soirée dans Grenade)', 'No. 2 La soirée dans Grenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10040 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caec7e76-b080-344b-9f49-22be2fe584ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '비 오는 정원 (Jardins sous la pluie)', part.name_en = 'No. 3 Jardins sous la pluie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10040 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:bc7d0107-3bc8-3433-b6f1-f9d2ecfeb01c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc7d0107-3bc8-3433-b6f1-f9d2ecfeb01c', 3, NULL, '비 오는 정원 (Jardins sous la pluie)', 'No. 3 Jardins sous la pluie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10040 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc7d0107-3bc8-3433-b6f1-f9d2ecfeb01c'
);


-- L. 106 <기쁨의 섬>

UPDATE pieces piece
SET piece.title = '<기쁨의 섬>', piece.title_en = 'L''isle joyeuse',
    piece.type = 'song', piece.opus_number = 'L. 106',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7542 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 7542 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 105 <가면>

UPDATE pieces piece
SET piece.title = '<가면>', piece.title_en = 'Masques',
    piece.type = 'song', piece.opus_number = 'L. 105',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7541 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 7541 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 109 <바다>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '바다 위의 새벽부터 정오까지 (De l''aube à midi sur la mer)', part.name_en = 'I. De l''aube à midi sur la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 222 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:79701d0b-2e23-364b-ac7b-56a67f9b4425' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79701d0b-2e23-364b-ac7b-56a67f9b4425', 1, 'I', '바다 위의 새벽부터 정오까지 (De l''aube à midi sur la mer)', 'I. De l''aube à midi sur la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 222 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79701d0b-2e23-364b-ac7b-56a67f9b4425'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '파도의 희롱 (Jeux de vagues)', part.name_en = 'II. Jeux de vagues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 222 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:2841c050-ac4c-3b7f-b361-b37ebf727917' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2841c050-ac4c-3b7f-b361-b37ebf727917', 2, 'II', '파도의 희롱 (Jeux de vagues)', 'II. Jeux de vagues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 222 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2841c050-ac4c-3b7f-b361-b37ebf727917'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '바람과 바다의 대화 (Dialogue du vent et de la mer)', part.name_en = 'III. Dialogue du vent et de la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 222 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:9b9acf70-f80e-377b-8448-38f8b3158be0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b9acf70-f80e-377b-8448-38f8b3158be0', 3, 'III', '바람과 바다의 대화 (Dialogue du vent et de la mer)', 'III. Dialogue du vent et de la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 222 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b9acf70-f80e-377b-8448-38f8b3158be0'
);


-- L. 99 <스케치북에서>

UPDATE pieces piece
SET piece.title = '<스케치북에서>', piece.title_en = 'D''un cahier d''esquisses',
    piece.type = 'song', piece.opus_number = 'L. 99',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10259 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 10259 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 103 <신성한 춤과 세속적인 춤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<신성한 춤과 세속적인 춤>', 'Danse sacrée et danse profane', 'album', 'L. 103', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<신성한 춤과 세속적인 춤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '727783b1-3b74-4c8f-bce8-15b2dbcc3c3d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '727783b1-3b74-4c8f-bce8-15b2dbcc3c3d'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<신성한 춤과 세속적인 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '727783b1-3b74-4c8f-bce8-15b2dbcc3c3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:abfb4c0d-9edd-433d-8915-cfb6ce117273', 1, 'I', '신성한 춤 (Danse sacrée)', 'I. Danse sacrée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<신성한 춤과 세속적인 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abfb4c0d-9edd-433d-8915-cfb6ce117273'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cc25b4b-25f9-48ee-85c2-9c2519c271e6', 2, 'II', '세속적인 춤 (Danse profane)', 'II. Danse profane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<신성한 춤과 세속적인 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cc25b4b-25f9-48ee-85c2-9c2519c271e6'
);


-- L. 104 가곡집 <Fêtes galantes> 2집

UPDATE pieces piece
SET piece.title = '가곡집 <Fêtes galantes> 2집', piece.title_en = 'Fêtes galantes, Set 2',
    piece.type = 'album', piece.opus_number = 'L. 104',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10051 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 10051 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Les ingénus', part.name_en = 'No. 1 Les ingénus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10051 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:4f788f60-e1be-4196-8fa0-d0925ddaaa2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f788f60-e1be-4196-8fa0-d0925ddaaa2a', 1, NULL, 'Les ingénus', 'No. 1 Les ingénus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10051 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f788f60-e1be-4196-8fa0-d0925ddaaa2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le faune', part.name_en = 'No. 2 Le faune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10051 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:c8040a00-69b3-4a6f-b11d-82281a9fc49b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8040a00-69b3-4a6f-b11d-82281a9fc49b', 2, NULL, 'Le faune', 'No. 2 Le faune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10051 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8040a00-69b3-4a6f-b11d-82281a9fc49b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Colloque sentimental', part.name_en = 'No. 3 Colloque sentimental',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10051 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:53e7d397-cd7e-44d0-83d2-6403927e3ad1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53e7d397-cd7e-44d0-83d2-6403927e3ad1', 3, NULL, 'Colloque sentimental', 'No. 3 Colloque sentimental', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10051 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53e7d397-cd7e-44d0-83d2-6403927e3ad1'
);


-- L. 102 <프랑스의 노래 3곡>

UPDATE pieces piece
SET piece.title = '<프랑스의 노래 3곡>', piece.title_en = 'Trois chansons de France',
    piece.type = 'album', piece.opus_number = 'L. 102',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7929 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 7929 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Rondel: Le temps a laissé son manteau', part.name_en = 'No. 1 Rondel: Le temps a laissé son manteau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7929 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:10985f9a-fe28-42c9-985f-845272117fef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10985f9a-fe28-42c9-985f-845272117fef', 1, NULL, 'Rondel: Le temps a laissé son manteau', 'No. 1 Rondel: Le temps a laissé son manteau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7929 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10985f9a-fe28-42c9-985f-845272117fef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La grotte', part.name_en = 'No. 2 La grotte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7929 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:4505bfa1-c83b-4d74-a3f8-fac05fc6deb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4505bfa1-c83b-4d74-a3f8-fac05fc6deb6', 2, NULL, 'La grotte', 'No. 2 La grotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7929 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4505bfa1-c83b-4d74-a3f8-fac05fc6deb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Rondel: Pour ce que Plaisance est morte', part.name_en = 'No. 3 Rondel: Pour ce que Plaisance est morte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7929 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:1a69505f-1e9c-421a-a3b9-a47645ce2cc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a69505f-1e9c-421a-a3b9-a47645ce2cc9', 3, NULL, 'Rondel: Pour ce que Plaisance est morte', 'No. 3 Rondel: Pour ce que Plaisance est morte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7929 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a69505f-1e9c-421a-a3b9-a47645ce2cc9'
);


-- L. 107 부수음악 <리어 왕>

UPDATE pieces piece
SET piece.title = '부수음악 <리어 왕>', piece.title_en = 'Le roi Lear, incidental music',
    piece.type = 'song', piece.opus_number = 'L. 107',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10452 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 10452 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 108 피아노 소품 <Morceau de concours>

UPDATE pieces piece
SET piece.title = '피아노 소품 <Morceau de concours>', piece.title_en = 'Morceau de concours (Pièce pour piano)',
    piece.type = 'song', piece.opus_number = 'L. 108',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1904, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8284 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 8284 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 122 관현악을 위한 <영상>

UPDATE pieces piece
SET piece.title = '관현악을 위한 <영상>', piece.title_en = 'Images for orchestra',
    piece.type = 'album', piece.opus_number = 'L. 122',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9965 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 9965 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '지그 (Gigues)', part.name_en = 'No. 1 Gigues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9965 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:6cc5435a-06b0-3790-9a86-769774bce1dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cc5435a-06b0-3790-9a86-769774bce1dd', 1, NULL, '지그 (Gigues)', 'No. 1 Gigues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9965 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cc5435a-06b0-3790-9a86-769774bce1dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '이베리아 (Ibéria)', part.name_en = 'No. 2 Ibéria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9965 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d', 2, NULL, '이베리아 (Ibéria)', 'No. 2 Ibéria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9965 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '거리와 길에서 (Par les rues et par les chemins)', part.name_en = 'I. Par les rues et par les chemins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9965 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:ac2c5ab0-8693-3053-aa2f-b5d7fe1f18d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac2c5ab0-8693-3053-aa2f-b5d7fe1f18d0', 1, 'I', '거리와 길에서 (Par les rues et par les chemins)', 'I. Par les rues et par les chemins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d'
WHERE p.id = 9965 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac2c5ab0-8693-3053-aa2f-b5d7fe1f18d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '밤의 향기 (Les parfums de la nuit)', part.name_en = 'II. Les parfums de la nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9965 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:8e902770-5b34-33ef-8784-79db1a248b3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e902770-5b34-33ef-8784-79db1a248b3b', 2, 'II', '밤의 향기 (Les parfums de la nuit)', 'II. Les parfums de la nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d'
WHERE p.id = 9965 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e902770-5b34-33ef-8784-79db1a248b3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '축제일 아침 (Le matin d''un jour de fête)', part.name_en = 'III. Le matin d''un jour de fête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9965 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:ffb21e25-83c7-3469-8971-954a3f459d98' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ffb21e25-83c7-3469-8971-954a3f459d98', 3, 'III', '축제일 아침 (Le matin d''un jour de fête)', 'III. Le matin d''un jour de fête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d18bb4d8-7f25-4740-956e-12b9eb57b68d'
WHERE p.id = 9965 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffb21e25-83c7-3469-8971-954a3f459d98'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '봄의 론도 (Rondes de printemps)', part.name_en = 'No. 3 Rondes de printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9965 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:030c111d-e53f-338d-b129-c0ae88d74916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:030c111d-e53f-338d-b129-c0ae88d74916', 3, NULL, '봄의 론도 (Rondes de printemps)', 'No. 3 Rondes de printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9965 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:030c111d-e53f-338d-b129-c0ae88d74916'
);


-- L. 113 <어린이 차지>

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10979 AND linked.composer_id = 50),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '그라두스 아드 파르나숨 박사 (Doctor Gradus ad Parnassum)', part.name_en = 'No. 1 Doctor Gradus ad Parnassum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 223 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:d2930d02-da88-3706-b0d9-d1157a5e90a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE pieces piece
SET piece.title = '<어린이 차지> 중 "그라두스 아드 파르나숨 박사 (Doctor Gradus ad Parnassum)"', piece.title_en = 'Children''s Corner: No. 1 Doctor Gradus ad Parnassum', piece.editor_locked = 1
WHERE piece.id = 10979 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 11098 AND linked.composer_id = 50),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '코끼리의 자장가 (Jimbo''s Lullaby)', part.name_en = 'No. 2 Jimbo''s Lullaby',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 223 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:620bdff9-49b6-3d3b-8d9f-5199a0fa451d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE pieces piece
SET piece.title = '<어린이 차지> 중 "코끼리의 자장가 (Jimbo''s Lullaby)"', piece.title_en = 'Children''s Corner: No. 2 Jimbo''s Lullaby', piece.editor_locked = 1
WHERE piece.id = 11098 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 7825 AND linked.composer_id = 50),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '인형의 세레나데 (Serenade for the Doll)', part.name_en = 'No. 3 Serenade for the Doll',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 223 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:b4f45d55-e97a-3428-86d6-16289be69b54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE pieces piece
SET piece.title = '<어린이 차지> 중 "인형의 세레나데 (Serenade for the Doll)"', piece.title_en = 'Children''s Corner: No. 3 Serenade for the Doll', piece.editor_locked = 1
WHERE piece.id = 7825 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8233 AND linked.composer_id = 50),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '눈이 춤춘다 (The Snow Is Dancing)', part.name_en = 'No. 4 The Snow Is Dancing',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 223 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:933fb12e-012e-3af9-b28b-8dfaa5387593' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE pieces piece
SET piece.title = '<어린이 차지> 중 "눈이 춤춘다 (The Snow Is Dancing)"', piece.title_en = 'Children''s Corner: No. 4 The Snow Is Dancing', piece.editor_locked = 1
WHERE piece.id = 8233 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8399 AND linked.composer_id = 50),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '작은 목동 (The Little Shepherd)', part.name_en = 'No. 5 The Little Shepherd',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 223 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:88ccf215-6387-36cb-8f66-97f4a31aaec8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8399 AND linked.composer_id = 50), 'musicbrainz:88ccf215-6387-36cb-8f66-97f4a31aaec8', 5, NULL, '작은 목동 (The Little Shepherd)', 'No. 5 The Little Shepherd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 223 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88ccf215-6387-36cb-8f66-97f4a31aaec8'
);

UPDATE pieces piece
SET piece.title = '<어린이 차지> 중 "작은 목동 (The Little Shepherd)"', piece.title_en = 'Children''s Corner: No. 5 The Little Shepherd', piece.editor_locked = 1
WHERE piece.id = 8399 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9090 AND linked.composer_id = 50),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '골리워그의 케이크워크 (Golliwogg''s Cakewalk)', part.name_en = 'No. 6 Golliwogg''s Cakewalk',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 223 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:11c9cd37-42ab-3cba-97d1-7c331cd05a41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9090 AND linked.composer_id = 50), 'musicbrainz:11c9cd37-42ab-3cba-97d1-7c331cd05a41', 6, NULL, '골리워그의 케이크워크 (Golliwogg''s Cakewalk)', 'No. 6 Golliwogg''s Cakewalk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 223 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11c9cd37-42ab-3cba-97d1-7c331cd05a41'
);

UPDATE pieces piece
SET piece.title = '<어린이 차지> 중 "골리워그의 케이크워크 (Golliwogg''s Cakewalk)"', piece.title_en = 'Children''s Corner: No. 6 Golliwogg''s Cakewalk', piece.editor_locked = 1
WHERE piece.id = 9090 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- L. 111 <영상> 2집

UPDATE pieces piece
SET piece.title = '<영상> 2집', piece.title_en = 'Images, Set 2',
    piece.type = 'album', piece.opus_number = 'L. 111',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1907, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9350 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1907
WHERE piece.id = 9350 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '잎새를 스치는 종소리 (Cloches à travers les feuilles)', part.name_en = 'No. 1 Cloches à travers les feuilles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9350 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:4ecb3381-bc65-3892-860e-ba240239f18e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ecb3381-bc65-3892-860e-ba240239f18e', 1, NULL, '잎새를 스치는 종소리 (Cloches à travers les feuilles)', 'No. 1 Cloches à travers les feuilles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9350 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ecb3381-bc65-3892-860e-ba240239f18e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '황폐한 사원에 걸린 달 (Et la lune descend sur le temple qui fut)', part.name_en = 'No. 2 Et la lune descend sur le temple qui fut',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9350 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:125fdf95-8019-31d8-9885-81eb93701e5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:125fdf95-8019-31d8-9885-81eb93701e5c', 2, NULL, '황폐한 사원에 걸린 달 (Et la lune descend sur le temple qui fut)', 'No. 2 Et la lune descend sur le temple qui fut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9350 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:125fdf95-8019-31d8-9885-81eb93701e5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '금빛 물고기 (Poissons d''or)', part.name_en = 'No. 3 Poissons d''or',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9350 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:f2997b31-b1ec-382b-8b9b-679db8be353d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2997b31-b1ec-382b-8b9b-679db8be353d', 3, NULL, '금빛 물고기 (Poissons d''or)', 'No. 3 Poissons d''or', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9350 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2997b31-b1ec-382b-8b9b-679db8be353d'
);


-- L. 112 오페라 <어셔가의 몰락>

UPDATE pieces piece
SET piece.title = '오페라 <어셔가의 몰락>', piece.title_en = 'La chute de la maison Usher',
    piece.type = 'song', piece.opus_number = 'L. 112',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10905 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 10905 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 114 <Le petit nègre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Le petit nègre>', 'Le petit nègre (Cake-Walk)', 'song', 'L. 114', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Le petit nègre>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a78a1b5-2d3f-363d-9d91-b5659b918eba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a78a1b5-2d3f-363d-9d91-b5659b918eba'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<Le petit nègre>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a78a1b5-2d3f-363d-9d91-b5659b918eba'
);


-- L. 115 <하이든 찬가>

UPDATE pieces piece
SET piece.title = '<하이든 찬가>', piece.title_en = 'Hommage à Haydn',
    piece.type = 'song', piece.opus_number = 'L. 115',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1909, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7727 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1909
WHERE piece.id = 7727 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 116 클라리넷을 위한 랩소디 1번

UPDATE pieces piece
SET piece.title = '클라리넷을 위한 랩소디 1번', piece.title_en = 'Première rhapsodie for clarinet',
    piece.type = 'song', piece.opus_number = 'L. 116',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7512 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 7512 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 117 <전주곡집> 1권

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권', piece.title_en = 'Préludes, Book 1',
    piece.type = 'album', piece.opus_number = 'L. 117',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8018 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 8018 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8933 AND linked.composer_id = 50),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '델포이의 무희들 (Danseuses de Delphes)', part.name_en = 'No. 1 Danseuses de Delphes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:906fa17d-0eed-30d6-b35b-ac33ca08b0d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8933 AND linked.composer_id = 50), 'musicbrainz:906fa17d-0eed-30d6-b35b-ac33ca08b0d7', 1, NULL, '델포이의 무희들 (Danseuses de Delphes)', 'No. 1 Danseuses de Delphes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:906fa17d-0eed-30d6-b35b-ac33ca08b0d7'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "델포이의 무희들 (Danseuses de Delphes)"', piece.title_en = 'Préludes, Book 1: No. 1 Danseuses de Delphes', piece.editor_locked = 1
WHERE piece.id = 8933 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9917 AND linked.composer_id = 50),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '돛 (Voiles)', part.name_en = 'No. 2 Voiles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:50b37d10-66d0-35d5-ae33-7fc94705f153' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9917 AND linked.composer_id = 50), 'musicbrainz:50b37d10-66d0-35d5-ae33-7fc94705f153', 2, NULL, '돛 (Voiles)', 'No. 2 Voiles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b37d10-66d0-35d5-ae33-7fc94705f153'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "돛 (Voiles)"', piece.title_en = 'Préludes, Book 1: No. 2 Voiles', piece.editor_locked = 1
WHERE piece.id = 9917 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 7771 AND linked.composer_id = 50),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '들을 지나는 바람 (Le vent dans la plaine)', part.name_en = 'No. 3 Le vent dans la plaine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:63b78a8c-46a1-37bc-b545-9db2e761788a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7771 AND linked.composer_id = 50), 'musicbrainz:63b78a8c-46a1-37bc-b545-9db2e761788a', 3, NULL, '들을 지나는 바람 (Le vent dans la plaine)', 'No. 3 Le vent dans la plaine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63b78a8c-46a1-37bc-b545-9db2e761788a'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "들을 지나는 바람 (Le vent dans la plaine)"', piece.title_en = 'Préludes, Book 1: No. 3 Le vent dans la plaine', piece.editor_locked = 1
WHERE piece.id = 7771 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10187 AND linked.composer_id = 50),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Les sons et les parfums tournent dans l''air du soir', part.name_en = 'No. 4 « Les sons et les parfums tournent dans l''air du soir »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:02504605-947c-3491-b945-93198878cf2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10187 AND linked.composer_id = 50), 'musicbrainz:02504605-947c-3491-b945-93198878cf2d', 4, NULL, 'Les sons et les parfums tournent dans l''air du soir', 'No. 4 « Les sons et les parfums tournent dans l''air du soir »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02504605-947c-3491-b945-93198878cf2d'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "Les sons et les parfums tournent dans l''air du soir"', piece.title_en = 'Préludes, Book 1: No. 4 « Les sons et les parfums tournent dans l''air du soir »', piece.editor_locked = 1
WHERE piece.id = 10187 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 7989 AND linked.composer_id = 50),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '아나카프리 언덕 (Les collines d''Anacapri)', part.name_en = 'No. 5 Les collines d''Anacapri',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:17617878-5058-3448-a804-64b0111bea1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7989 AND linked.composer_id = 50), 'musicbrainz:17617878-5058-3448-a804-64b0111bea1d', 5, NULL, '아나카프리 언덕 (Les collines d''Anacapri)', 'No. 5 Les collines d''Anacapri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17617878-5058-3448-a804-64b0111bea1d'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "아나카프리 언덕 (Les collines d''Anacapri)"', piece.title_en = 'Préludes, Book 1: No. 5 Les collines d''Anacapri', piece.editor_locked = 1
WHERE piece.id = 7989 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8089 AND linked.composer_id = 50),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '눈 위의 발자국 (Des pas sur la neige)', part.name_en = 'No. 6 Des pas sur la neige',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:8f77875b-5329-3d85-b4f0-621d2c9d610f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8089 AND linked.composer_id = 50), 'musicbrainz:8f77875b-5329-3d85-b4f0-621d2c9d610f', 6, NULL, '눈 위의 발자국 (Des pas sur la neige)', 'No. 6 Des pas sur la neige', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f77875b-5329-3d85-b4f0-621d2c9d610f'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "눈 위의 발자국 (Des pas sur la neige)"', piece.title_en = 'Préludes, Book 1: No. 6 Des pas sur la neige', piece.editor_locked = 1
WHERE piece.id = 8089 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 9306 AND linked.composer_id = 50),
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '서풍이 본 것 (Ce qu''a vu le vent d''ouest)', part.name_en = 'No. 7 Ce qu''a vu le vent d''ouest',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:e747b5b9-11fd-3aea-a733-a23660330d19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 9306 AND linked.composer_id = 50), 'musicbrainz:e747b5b9-11fd-3aea-a733-a23660330d19', 7, NULL, '서풍이 본 것 (Ce qu''a vu le vent d''ouest)', 'No. 7 Ce qu''a vu le vent d''ouest', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e747b5b9-11fd-3aea-a733-a23660330d19'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "서풍이 본 것 (Ce qu''a vu le vent d''ouest)"', piece.title_en = 'Préludes, Book 1: No. 7 Ce qu''a vu le vent d''ouest', piece.editor_locked = 1
WHERE piece.id = 9306 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10756 AND linked.composer_id = 50),
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '아마빛 머리의 소녀 (La fille aux cheveux de lin)', part.name_en = 'No. 8 La fille aux cheveux de lin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:1fb7717b-431a-363f-a617-047645e3a525' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10756 AND linked.composer_id = 50), 'musicbrainz:1fb7717b-431a-363f-a617-047645e3a525', 8, NULL, '아마빛 머리의 소녀 (La fille aux cheveux de lin)', 'No. 8 La fille aux cheveux de lin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb7717b-431a-363f-a617-047645e3a525'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "아마빛 머리의 소녀 (La fille aux cheveux de lin)"', piece.title_en = 'Préludes, Book 1: No. 8 La fille aux cheveux de lin', piece.editor_locked = 1
WHERE piece.id = 10756 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10970 AND linked.composer_id = 50),
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '끊어진 세레나데 (La sérénade interrompue)', part.name_en = 'No. 9 La sérénade interrompue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:07c99a12-2f8b-37cc-860c-9dd0ce386b92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10970 AND linked.composer_id = 50), 'musicbrainz:07c99a12-2f8b-37cc-860c-9dd0ce386b92', 9, NULL, '끊어진 세레나데 (La sérénade interrompue)', 'No. 9 La sérénade interrompue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07c99a12-2f8b-37cc-860c-9dd0ce386b92'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "끊어진 세레나데 (La sérénade interrompue)"', piece.title_en = 'Préludes, Book 1: No. 9 La sérénade interrompue', piece.editor_locked = 1
WHERE piece.id = 10970 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8353 AND linked.composer_id = 50),
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '가라앉은 성당 (La cathédrale engloutie)', part.name_en = 'No. 10 La cathédrale engloutie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:5d67897e-ddf7-3b05-ad26-2a611a143137' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8353 AND linked.composer_id = 50), 'musicbrainz:5d67897e-ddf7-3b05-ad26-2a611a143137', 10, NULL, '가라앉은 성당 (La cathédrale engloutie)', 'No. 10 La cathédrale engloutie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d67897e-ddf7-3b05-ad26-2a611a143137'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "가라앉은 성당 (La cathédrale engloutie)"', piece.title_en = 'Préludes, Book 1: No. 10 La cathédrale engloutie', piece.editor_locked = 1
WHERE piece.id = 8353 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8679 AND linked.composer_id = 50),
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '퍽의 춤 (La danse de Puck)', part.name_en = 'No. 11 La danse de Puck',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:70fd061f-0bd2-3f96-8bd3-05ad011e6532' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8679 AND linked.composer_id = 50), 'musicbrainz:70fd061f-0bd2-3f96-8bd3-05ad011e6532', 11, NULL, '퍽의 춤 (La danse de Puck)', 'No. 11 La danse de Puck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70fd061f-0bd2-3f96-8bd3-05ad011e6532'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "퍽의 춤 (La danse de Puck)"', piece.title_en = 'Préludes, Book 1: No. 11 La danse de Puck', piece.editor_locked = 1
WHERE piece.id = 8679 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8306 AND linked.composer_id = 50),
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '민스트럴 (Minstrels)', part.name_en = 'No. 12 Minstrels',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8018 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:70495469-c5b2-3141-8578-3c5c4b5bb44b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 8306 AND linked.composer_id = 50), 'musicbrainz:70495469-c5b2-3141-8578-3c5c4b5bb44b', 12, NULL, '민스트럴 (Minstrels)', 'No. 12 Minstrels', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8018 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70495469-c5b2-3141-8578-3c5c4b5bb44b'
);

UPDATE pieces piece
SET piece.title = '<전주곡집> 1권 중 "민스트럴 (Minstrels)"', piece.title_en = 'Préludes, Book 1: No. 12 Minstrels', piece.editor_locked = 1
WHERE piece.id = 8306 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- L. 119 프랑수아 비용의 발라드 3곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '프랑수아 비용의 발라드 3곡', 'Trois ballades de François Villon', 'album', 'L. 119', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '프랑수아 비용의 발라드 3곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4126ba17-719f-431b-a67c-5e4ac6e9c362'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4126ba17-719f-431b-a67c-5e4ac6e9c362'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '프랑수아 비용의 발라드 3곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4126ba17-719f-431b-a67c-5e4ac6e9c362'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:935f4dbc-3620-48be-8ac6-6054c7a5ccb1', 1, NULL, 'Ballade de Villon à s''amye', 'No. 1 Ballade de Villon à s''amye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '프랑수아 비용의 발라드 3곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:935f4dbc-3620-48be-8ac6-6054c7a5ccb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:396a7169-a6e6-4194-aa9c-1b0c47225271', 2, NULL, 'Ballade que Villon feit à la requeste de sa mère pour prier Nostre-Dame', 'No. 2 Ballade que Villon feit à la requeste de sa mère pour prier Nostre-Dame', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '프랑수아 비용의 발라드 3곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:396a7169-a6e6-4194-aa9c-1b0c47225271'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83bd150e-0450-4b2b-ad41-72468e2bce85', 3, NULL, 'Ballade des femmes de Paris', 'No. 3 Ballade des femmes de Paris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '프랑수아 비용의 발라드 3곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83bd150e-0450-4b2b-ad41-72468e2bce85'
);


-- L. 120 클라리넷과 피아노를 위한 소품

UPDATE pieces piece
SET piece.title = '클라리넷과 피아노를 위한 소품', piece.title_en = 'Petite pièce for clarinet and piano',
    piece.type = 'song', piece.opus_number = 'L. 120',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7436 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 7436 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 121 <렌토보다 느리게>

UPDATE pieces piece
SET piece.title = '<렌토보다 느리게>', piece.title_en = 'La plus que lente',
    piece.type = 'song', piece.opus_number = 'L. 121',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7443 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 7443 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 118 가곡집 <두 연인의 산책길>

UPDATE pieces piece
SET piece.title = '가곡집 <두 연인의 산책길>', piece.title_en = 'Le promenoir des deux amants',
    piece.type = 'album', piece.opus_number = 'L. 118',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10304 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 10304 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Auprès de cette grotte sombre', part.name_en = 'No. 1 Auprès de cette grotte sombre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10304 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:dcacf21a-f205-4322-9516-e0a93935c2e9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcacf21a-f205-4322-9516-e0a93935c2e9', 1, NULL, 'Auprès de cette grotte sombre', 'No. 1 Auprès de cette grotte sombre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10304 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcacf21a-f205-4322-9516-e0a93935c2e9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Crois mon conseil, chère Climène', part.name_en = 'No. 2 Crois mon conseil, chère Climène',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10304 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:2afdd202-bf8e-4f8c-a222-3906f74440a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2afdd202-bf8e-4f8c-a222-3906f74440a9', 2, NULL, 'Crois mon conseil, chère Climène', 'No. 2 Crois mon conseil, chère Climène', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10304 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2afdd202-bf8e-4f8c-a222-3906f74440a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Je tremble en voyant ton visage', part.name_en = 'No. 3 Je tremble en voyant ton visage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10304 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:f3617d7d-458b-471a-b25c-718635efd716' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3617d7d-458b-471a-b25c-718635efd716', 3, NULL, 'Je tremble en voyant ton visage', 'No. 3 Je tremble en voyant ton visage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10304 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3617d7d-458b-471a-b25c-718635efd716'
);


-- L. 124 신비극 <성 세바스티안의 순교>

UPDATE pieces piece
SET piece.title = '신비극 <성 세바스티안의 순교>', piece.title_en = 'Le martyre de saint Sébastien',
    piece.type = 'song', piece.opus_number = 'L. 124',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1911, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 11031 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1911
WHERE piece.id = 11031 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 123 <전주곡집> 2권

UPDATE pieces piece
SET piece.title = '<전주곡집> 2권', piece.title_en = 'Préludes, Book 2',
    piece.type = 'album', piece.opus_number = 'L. 123',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10842 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 10842 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '안개 (Brouillards)', part.name_en = 'No. 1 Brouillards',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:3b550cba-8ea8-38f2-b263-a9e4178f97c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b550cba-8ea8-38f2-b263-a9e4178f97c5', 1, NULL, '안개 (Brouillards)', 'No. 1 Brouillards', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b550cba-8ea8-38f2-b263-a9e4178f97c5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '낙엽 (Feuilles mortes)', part.name_en = 'No. 2 Feuilles mortes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:a2c31c0f-6cf3-32a2-98a0-9049b7334303' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2c31c0f-6cf3-32a2-98a0-9049b7334303', 2, NULL, '낙엽 (Feuilles mortes)', 'No. 2 Feuilles mortes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2c31c0f-6cf3-32a2-98a0-9049b7334303'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La puerta del Vino', part.name_en = 'No. 3 La puerta del Vino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:8c02a94f-74cb-3c9d-93f7-ee3157f5386e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c02a94f-74cb-3c9d-93f7-ee3157f5386e', 3, NULL, 'La puerta del Vino', 'No. 3 La puerta del Vino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c02a94f-74cb-3c9d-93f7-ee3157f5386e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Les fées sont d''exquises danseuses', part.name_en = 'No. 4 « Les fées sont d''exquises danseuses »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:5c484cba-9be2-3eab-b5f3-a70544e34cc9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c484cba-9be2-3eab-b5f3-a70544e34cc9', 4, NULL, 'Les fées sont d''exquises danseuses', 'No. 4 « Les fées sont d''exquises danseuses »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c484cba-9be2-3eab-b5f3-a70544e34cc9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '히스 (Bruyères)', part.name_en = 'No. 5 Bruyères',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:8752aad4-8c92-37fb-8929-7ec388a34934' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8752aad4-8c92-37fb-8929-7ec388a34934', 5, NULL, '히스 (Bruyères)', 'No. 5 Bruyères', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8752aad4-8c92-37fb-8929-7ec388a34934'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '괴짜 라빈 장군 (Général Lavine – eccentric)', part.name_en = 'No. 6 Général Lavine – eccentric',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:4d102caf-e11d-3ea9-a0aa-d111187ed97f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d102caf-e11d-3ea9-a0aa-d111187ed97f', 6, NULL, '괴짜 라빈 장군 (Général Lavine – eccentric)', 'No. 6 Général Lavine – eccentric', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d102caf-e11d-3ea9-a0aa-d111187ed97f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La terrasse des audiences du clair de lune', part.name_en = 'No. 7 La terrasse des audiences du clair de lune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:979ca39d-7ec3-34e8-a283-34e224693bdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:979ca39d-7ec3-34e8-a283-34e224693bdb', 7, NULL, 'La terrasse des audiences du clair de lune', 'No. 7 La terrasse des audiences du clair de lune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:979ca39d-7ec3-34e8-a283-34e224693bdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '물의 요정 (Ondine)', part.name_en = 'No. 8 Ondine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:8ad0da5d-eabd-3e55-943d-d83882cb9af0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad0da5d-eabd-3e55-943d-d83882cb9af0', 8, NULL, '물의 요정 (Ondine)', 'No. 8 Ondine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad0da5d-eabd-3e55-943d-d83882cb9af0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '피크위크 경을 기리며 (Hommage à S. Pickwick Esq. P.P.M.P.C.)', part.name_en = 'No. 9 Hommage à S. Pickwick Esq. P.P.M.P.C.',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:16e81e0c-04c7-383a-8f7c-c172b36737bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16e81e0c-04c7-383a-8f7c-c172b36737bd', 9, NULL, '피크위크 경을 기리며 (Hommage à S. Pickwick Esq. P.P.M.P.C.)', 'No. 9 Hommage à S. Pickwick Esq. P.P.M.P.C.', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16e81e0c-04c7-383a-8f7c-c172b36737bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '카노프 (Canope)', part.name_en = 'No. 10 Canope',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:21720b04-d07b-30b8-8145-64bc144762b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21720b04-d07b-30b8-8145-64bc144762b7', 10, NULL, '카노프 (Canope)', 'No. 10 Canope', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21720b04-d07b-30b8-8145-64bc144762b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '교대하는 3도 (Les tierces alternées)', part.name_en = 'No. 11 Les tierces alternées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:a4e211bb-3df7-3d19-bb53-24ba9c139e93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4e211bb-3df7-3d19-bb53-24ba9c139e93', 11, NULL, '교대하는 3도 (Les tierces alternées)', 'No. 11 Les tierces alternées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4e211bb-3df7-3d19-bb53-24ba9c139e93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '불꽃놀이 (Feux d''artifice)', part.name_en = 'No. 12 Feux d''artifice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 10842 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:e5523e04-7b75-380f-b5d9-f08ff2bbf9bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5523e04-7b75-380f-b5d9-f08ff2bbf9bd', 12, NULL, '불꽃놀이 (Feux d''artifice)', 'No. 12 Feux d''artifice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 10842 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5523e04-7b75-380f-b5d9-f08ff2bbf9bd'
);


-- L. 125 발레 <캄마>

UPDATE pieces piece
SET piece.title = '발레 <캄마>', piece.title_en = 'Khamma, légende dansée',
    piece.type = 'song', piece.opus_number = 'L. 125',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1912, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7500 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1912
WHERE piece.id = 7500 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 126 발레 <유희>

UPDATE pieces piece
SET piece.title = '발레 <유희>', piece.title_en = 'Jeux, poème dansé',
    piece.type = 'song', piece.opus_number = 'L. 126',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 504 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 504 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 127 <말라르메의 시 3편>

UPDATE pieces piece
SET piece.title = '<말라르메의 시 3편>', piece.title_en = 'Trois poèmes de Stéphane Mallarmé',
    piece.type = 'album', piece.opus_number = 'L. 127',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9422 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 9422 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Soupir', part.name_en = 'No. 1 Soupir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9422 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:d7a67bb8-e75b-428f-8876-f4ce2a24785d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7a67bb8-e75b-428f-8876-f4ce2a24785d', 1, NULL, 'Soupir', 'No. 1 Soupir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9422 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a67bb8-e75b-428f-8876-f4ce2a24785d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Placet futile', part.name_en = 'No. 2 Placet futile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9422 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:c4679dc2-a94b-4490-b17d-7719f958c2b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4679dc2-a94b-4490-b17d-7719f958c2b1', 2, NULL, 'Placet futile', 'No. 2 Placet futile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9422 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4679dc2-a94b-4490-b17d-7719f958c2b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Éventail', part.name_en = 'No. 3 Éventail',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9422 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:a4b896c2-7543-413a-9ff9-7d6f3d313af4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4b896c2-7543-413a-9ff9-7d6f3d313af4', 3, NULL, 'Éventail', 'No. 3 Éventail', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9422 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4b896c2-7543-413a-9ff9-7d6f3d313af4'
);


-- L. 128 발레 <장난감 상자>

UPDATE pieces piece
SET piece.title = '발레 <장난감 상자>', piece.title_en = 'La boîte à joujoux',
    piece.type = 'song', piece.opus_number = 'L. 128',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9937 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 9937 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 129 <시링크스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<시링크스>', 'Syrinx', 'song', 'L. 129', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<시링크스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '937f3282-a272-3021-8261-f1f31bbe83ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '937f3282-a272-3021-8261-f1f31bbe83ab'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<시링크스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '937f3282-a272-3021-8261-f1f31bbe83ab'
);


-- L. 131 <6개의 고대 비명>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<6개의 고대 비명>', 'Six épigraphes antiques', 'album', 'L. 131', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<6개의 고대 비명>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6fe453c-1b73-45ce-92b1-e51fcf1e39b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6fe453c-1b73-45ce-92b1-e51fcf1e39b7'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<6개의 고대 비명>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6fe453c-1b73-45ce-92b1-e51fcf1e39b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bc280f1-19db-3b19-a881-0190948e58fa', 1, NULL, 'Pour invoquer Pan, dieu du vent d''été', 'No. 1 Pour invoquer Pan, dieu du vent d''été', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<6개의 고대 비명>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bc280f1-19db-3b19-a881-0190948e58fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:819fb78a-743e-3edf-ab93-a4f504f24817', 2, NULL, 'Pour un tombeau sans nom', 'No. 2 Pour un tombeau sans nom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<6개의 고대 비명>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:819fb78a-743e-3edf-ab93-a4f504f24817'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc5763a3-fe93-3770-bc57-d551b3b521ef', 3, NULL, 'Pour que la nuit soit propice', 'No. 3 Pour que la nuit soit propice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<6개의 고대 비명>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc5763a3-fe93-3770-bc57-d551b3b521ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74530eba-ff53-395c-9476-9361ec492971', 4, NULL, 'Pour la danseuse aux crotales', 'No. 4 Pour la danseuse aux crotales', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<6개의 고대 비명>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74530eba-ff53-395c-9476-9361ec492971'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa7b635d-aabd-345c-aa51-d9821227a764', 5, NULL, 'Pour l''Égyptienne', 'No. 5 Pour l''Égyptienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<6개의 고대 비명>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa7b635d-aabd-345c-aa51-d9821227a764'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1ea309b-e1a8-3269-ae0b-ed0e866115d9', 6, NULL, 'Pour remercier la pluie au matin', 'No. 6 Pour remercier la pluie au matin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<6개의 고대 비명>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1ea309b-e1a8-3269-ae0b-ed0e866115d9'
);


-- L. 132 <영웅적 자장가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<영웅적 자장가>', 'Berceuse héroïque', 'song', 'L. 132', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<영웅적 자장가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0be4fe27-8809-4063-85b9-84c33bd17ade'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0be4fe27-8809-4063-85b9-84c33bd17ade'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<영웅적 자장가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0be4fe27-8809-4063-85b9-84c33bd17ade'
);


-- L. 133 피아노 소품 <Page d'album>

UPDATE pieces piece
SET piece.title = '피아노 소품 <Page d''album>', piece.title_en = 'Pièce pour l''œuvre du Vêtement du blessé (Page d''album)',
    piece.type = 'song', piece.opus_number = 'L. 133',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10579 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 10579 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 134 <흰색과 검은색으로>

UPDATE pieces piece
SET piece.title = '<흰색과 검은색으로>', piece.title_en = 'En blanc et noir',
    piece.type = 'album', piece.opus_number = 'L. 134',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8776 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 8776 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Avec emportement', part.name_en = 'I. Avec emportement',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8776 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:b5261129-8bb8-4670-98f1-9a96ecbb5150' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5261129-8bb8-4670-98f1-9a96ecbb5150', 1, 'I', 'Avec emportement', 'I. Avec emportement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8776 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5261129-8bb8-4670-98f1-9a96ecbb5150'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lent. Sombre', part.name_en = 'II. Lent. Sombre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8776 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:41af5339-117d-4d9e-9b43-5c6eb36d01a0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41af5339-117d-4d9e-9b43-5c6eb36d01a0', 2, 'II', 'Lent. Sombre', 'II. Lent. Sombre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8776 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41af5339-117d-4d9e-9b43-5c6eb36d01a0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Scherzando', part.name_en = 'III. Scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 8776 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:a48d91fd-8786-4800-acf0-8a2e43822e7f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a48d91fd-8786-4800-acf0-8a2e43822e7f', 3, 'III', 'Scherzando', 'III. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 8776 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a48d91fd-8786-4800-acf0-8a2e43822e7f'
);


-- L. 136 12개의 연습곡

UPDATE pieces piece
SET piece.title = '12개의 연습곡', piece.title_en = 'Douze Études',
    piece.type = 'album', piece.opus_number = 'L. 136',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7860 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 7860 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '다섯 손가락을 위하여 (Pour les « cinq doigts »)', part.name_en = 'No. 1 Pour les « cinq doigts » d''après Monsieur Czerny',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:a6aa3ec6-04c4-3646-ad17-9a749232a6b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6aa3ec6-04c4-3646-ad17-9a749232a6b6', 1, NULL, '다섯 손가락을 위하여 (Pour les « cinq doigts »)', 'No. 1 Pour les « cinq doigts » d''après Monsieur Czerny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6aa3ec6-04c4-3646-ad17-9a749232a6b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '3도를 위하여 (Pour les tierces)', part.name_en = 'No. 2 Pour les tierces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:88db36ee-8b29-394b-81e2-56cf3e0a69e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88db36ee-8b29-394b-81e2-56cf3e0a69e2', 2, NULL, '3도를 위하여 (Pour les tierces)', 'No. 2 Pour les tierces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88db36ee-8b29-394b-81e2-56cf3e0a69e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '4도를 위하여 (Pour les quartes)', part.name_en = 'No. 3 Pour les quartes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:ef88c079-6a68-3ba4-8d40-8237015c3294' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef88c079-6a68-3ba4-8d40-8237015c3294', 3, NULL, '4도를 위하여 (Pour les quartes)', 'No. 3 Pour les quartes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef88c079-6a68-3ba4-8d40-8237015c3294'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '6도를 위하여 (Pour les sixtes)', part.name_en = 'No. 4 Pour les sixtes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:139405fa-60a3-3493-8d04-b97543646f5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:139405fa-60a3-3493-8d04-b97543646f5e', 4, NULL, '6도를 위하여 (Pour les sixtes)', 'No. 4 Pour les sixtes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:139405fa-60a3-3493-8d04-b97543646f5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '옥타브를 위하여 (Pour les octaves)', part.name_en = 'No. 5 Pour les octaves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:432418e5-105b-35af-8252-045ec5868ff5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:432418e5-105b-35af-8252-045ec5868ff5', 5, NULL, '옥타브를 위하여 (Pour les octaves)', 'No. 5 Pour les octaves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:432418e5-105b-35af-8252-045ec5868ff5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '여덟 손가락을 위하여 (Pour les huit doigts)', part.name_en = 'No. 6 Pour les huit doigts',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:544e6b62-3e96-3ec2-9cb5-5c57bf0019b7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:544e6b62-3e96-3ec2-9cb5-5c57bf0019b7', 6, NULL, '여덟 손가락을 위하여 (Pour les huit doigts)', 'No. 6 Pour les huit doigts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:544e6b62-3e96-3ec2-9cb5-5c57bf0019b7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '반음계를 위하여 (Pour les degrés chromatiques)', part.name_en = 'No. 7 Pour les degrés chromatiques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:fc16882e-e1b0-396a-aaec-0d04a5ea742d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc16882e-e1b0-396a-aaec-0d04a5ea742d', 7, NULL, '반음계를 위하여 (Pour les degrés chromatiques)', 'No. 7 Pour les degrés chromatiques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc16882e-e1b0-396a-aaec-0d04a5ea742d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '꾸밈음을 위하여 (Pour les agréments)', part.name_en = 'No. 8 Pour les agréments',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:47e5b457-0ba2-36f0-8481-bf8ab8eee2c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47e5b457-0ba2-36f0-8481-bf8ab8eee2c2', 8, NULL, '꾸밈음을 위하여 (Pour les agréments)', 'No. 8 Pour les agréments', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47e5b457-0ba2-36f0-8481-bf8ab8eee2c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '반복음을 위하여 (Pour les notes répétées)', part.name_en = 'No. 9 Pour les notes répétées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:a966171b-210e-3c4c-bc20-dfda9916c323' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a966171b-210e-3c4c-bc20-dfda9916c323', 9, NULL, '반복음을 위하여 (Pour les notes répétées)', 'No. 9 Pour les notes répétées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a966171b-210e-3c4c-bc20-dfda9916c323'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '대비되는 음향을 위하여 (Pour les sonorités opposées)', part.name_en = 'No. 10 Pour les sonorités opposées',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:61ed17f4-8f33-3377-b80f-42389a6906de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61ed17f4-8f33-3377-b80f-42389a6906de', 10, NULL, '대비되는 음향을 위하여 (Pour les sonorités opposées)', 'No. 10 Pour les sonorités opposées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61ed17f4-8f33-3377-b80f-42389a6906de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '복합 아르페지오를 위하여 (Pour les arpèges composés)', part.name_en = 'No. 11 Pour les arpèges composés',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:e0cc6236-8900-37d1-a7c8-23098a0cc54b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0cc6236-8900-37d1-a7c8-23098a0cc54b', 11, NULL, '복합 아르페지오를 위하여 (Pour les arpèges composés)', 'No. 11 Pour les arpèges composés', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0cc6236-8900-37d1-a7c8-23098a0cc54b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '화음을 위하여 (Pour les accords)', part.name_en = 'No. 12 Pour les accords',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7860 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:eb82bd5d-067d-33a6-ba7a-c23455a93ec6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb82bd5d-067d-33a6-ba7a-c23455a93ec6', 12, NULL, '화음을 위하여 (Pour les accords)', 'No. 12 Pour les accords', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7860 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb82bd5d-067d-33a6-ba7a-c23455a93ec6'
);


-- None <되찾은 연습곡>

UPDATE pieces piece
SET piece.title = '<되찾은 연습곡>', piece.title_en = 'Étude retrouvée (Pour les arpèges composés)',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 8773 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 8773 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- L. 135 첼로 소나타 D단조

UPDATE pieces piece
SET piece.title = '첼로 소나타 D단조', piece.title_en = 'Cello Sonata in D minor',
    piece.type = 'album', piece.opus_number = 'L. 135',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7475 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 7475 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '프롤로그', part.name_en = 'I. Prologue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7475 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:31134df0-9f66-4372-955d-667f124bbb93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31134df0-9f66-4372-955d-667f124bbb93', 1, 'I', '프롤로그', 'I. Prologue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7475 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31134df0-9f66-4372-955d-667f124bbb93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '세레나데', part.name_en = 'II. Sérénade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7475 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:d3f91699-10ad-4ddb-8ecd-218690e49dbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3f91699-10ad-4ddb-8ecd-218690e49dbf', 2, 'II', '세레나데', 'II. Sérénade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7475 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3f91699-10ad-4ddb-8ecd-218690e49dbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레', part.name_en = 'III. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7475 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:1e9c2102-2340-4ae7-960c-ed97a7e24fb0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e9c2102-2340-4ae7-960c-ed97a7e24fb0', 3, 'III', '피날레', 'III. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7475 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e9c2102-2340-4ae7-960c-ed97a7e24fb0'
);


-- L. 137 플루트, 비올라, 하프를 위한 소나타

UPDATE pieces piece
SET piece.title = '플루트, 비올라, 하프를 위한 소나타', piece.title_en = 'Sonata for flute, viola and harp',
    piece.type = 'album', piece.opus_number = 'L. 137',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1915, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 7628 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1915
WHERE piece.id = 7628 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '파스토랄', part.name_en = 'I. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7628 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:e7489dbf-bf52-4115-b65c-fd523f40f7bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7489dbf-bf52-4115-b65c-fd523f40f7bf', 1, 'I', '파스토랄', 'I. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7628 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7489dbf-bf52-4115-b65c-fd523f40f7bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '간주곡', part.name_en = 'II. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7628 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:c1ab7911-c595-49ce-928c-a8be1aae05c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1ab7911-c595-49ce-928c-a8be1aae05c6', 2, 'II', '간주곡', 'II. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7628 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1ab7911-c595-49ce-928c-a8be1aae05c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레', part.name_en = 'III. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 7628 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:389fce18-dde2-4539-90e7-9e2520f258ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389fce18-dde2-4539-90e7-9e2520f258ce', 3, 'III', '피날레', 'III. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 7628 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389fce18-dde2-4539-90e7-9e2520f258ce'
);


-- L. 138 피아노를 위한 엘레지

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노를 위한 엘레지', 'Élégie for piano', 'song', 'L. 138', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노를 위한 엘레지'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b2e35cd-0041-4af0-9481-cd0d809df71f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b2e35cd-0041-4af0-9481-cd0d809df71f'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '피아노를 위한 엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b2e35cd-0041-4af0-9481-cd0d809df71f'
);


-- L. 139 가곡 <집 없는 아이들의 크리스마스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <집 없는 아이들의 크리스마스>', 'Noël des enfants qui n''ont plus de maison', 'song', 'L. 139', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <집 없는 아이들의 크리스마스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76a1e06a-bd63-4855-b86f-f0534c7f8929'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76a1e06a-bd63-4855-b86f-f0534c7f8929'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '가곡 <집 없는 아이들의 크리스마스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76a1e06a-bd63-4855-b86f-f0534c7f8929'
);


-- L. 140 바이올린 소나타 G단조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 G단조', piece.title_en = 'Violin Sonata in G minor',
    piece.type = 'album', piece.opus_number = 'L. 140',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9414 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 9414 AND piece.composer_id = 50 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 10832 AND linked.composer_id = 50),
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro vivo', part.name_en = 'I. Allegro vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9414 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:c75f9180-dd10-4fc8-9cf8-59eab247aee5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 10832 AND linked.composer_id = 50), 'musicbrainz:c75f9180-dd10-4fc8-9cf8-59eab247aee5', 1, 'I', 'Allegro vivo', 'I. Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9414 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c75f9180-dd10-4fc8-9cf8-59eab247aee5'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 G단조 중 "Allegro vivo"', piece.title_en = 'Violin Sonata in G minor: I. Allegro vivo', piece.editor_locked = 1
WHERE piece.id = 10832 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 7553 AND linked.composer_id = 50),
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '간주곡. Fantasque et léger', part.name_en = 'II. Intermède. Fantasque et léger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9414 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:e409d8df-76cb-46a9-988a-9304cdd4eec3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 7553 AND linked.composer_id = 50), 'musicbrainz:e409d8df-76cb-46a9-988a-9304cdd4eec3', 2, 'II', '간주곡. Fantasque et léger', 'II. Intermède. Fantasque et léger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9414 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e409d8df-76cb-46a9-988a-9304cdd4eec3'
);

UPDATE pieces piece
SET piece.title = '바이올린 소나타 G단조 중 "간주곡. Fantasque et léger"', piece.title_en = 'Violin Sonata in G minor: II. Intermède. Fantasque et léger', piece.editor_locked = 1
WHERE piece.id = 7553 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '피날레. Très animé', part.name_en = 'III. Finale. Très animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 9414 AND p.composer_id = 50 AND part.part_key = 'musicbrainz:7bcb31db-ff18-4030-b6b1-c9822c46a46c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bcb31db-ff18-4030-b6b1-c9822c46a46c', 3, 'III', '피날레. Très animé', 'III. Finale. Très animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 9414 AND p.composer_id = 50
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bcb31db-ff18-4030-b6b1-c9822c46a46c'
);


-- L. 141 칸타타 <프랑스에 바치는 송가>

UPDATE pieces piece
SET piece.title = '칸타타 <프랑스에 바치는 송가>', piece.title_en = 'Ode à la France',
    piece.type = 'song', piece.opus_number = 'L. 141',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1917, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 9393 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1917
WHERE piece.id = 9393 AND piece.composer_id = 50 AND piece.composition_year IS NULL;


-- None <Les soirs illuminés par l'ardeur du charbon>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Les soirs illuminés par l''ardeur du charbon>', 'Les soirs illuminés par l''ardeur du charbon', 'song', NULL, NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 50
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Les soirs illuminés par l''ardeur du charbon>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e97321ae-ec1c-4d39-b370-e1b6e4ee6b57'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e97321ae-ec1c-4d39-b370-e1b6e4ee6b57'
FROM pieces p
WHERE p.composer_id = 50 AND p.title = '<Les soirs illuminés par l''ardeur du charbon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e97321ae-ec1c-4d39-b370-e1b6e4ee6b57'
);


-- 단독으로 연주되는 대목은 남기고 제목만 우리말로
UPDATE pieces piece
SET piece.title = '<성 세바스티안의 순교> 교향적 단장', piece.title_en = 'Le martyre de saint Sébastien, fragments symphoniques', piece.editor_locked = 1
WHERE piece.id = 9631 AND piece.composer_id = 50
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

-- 카탈로그에 대응이 없는 seed 작품 135개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 50 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    572, 601, 1047, 1110, 1528, 2387, 2390, 2683, 7445, 7508, 7519, 7547, 7575, 7653, 7720, 7725, 7739, 7828, 7834, 7848,
    7852, 7877, 7879, 7919, 7921, 7926, 7948, 7993, 8055, 8065, 8077, 8095, 8108, 8115, 8148, 8155, 8279, 8290, 8359, 8371,
    8441, 8453, 8528, 8537, 8540, 8552, 8570, 8572, 8643, 8657, 8707, 8724, 8744, 8784, 8832, 8875, 8886, 8897, 8935, 8946,
    9006, 9030, 9035, 9068, 9172, 9224, 9278, 9304, 9373, 9381, 9397, 9442, 9513, 9529, 9537, 9553, 9563, 9582, 9595, 9604,
    9610, 9662, 9663, 9687, 9720, 9740, 9753, 9759, 9792, 9813, 9847, 9873, 9878, 9952, 9981, 10070, 10072, 10183, 10201, 10231,
    10254, 10263, 10276, 10306, 10354, 10378, 10381, 10386, 10397, 10403, 10431, 10465, 10478, 10515, 10530, 10542, 10547, 10577, 10584, 10640,
    10698, 10709, 10768, 10801, 10830, 10906, 10911, 10926, 11010, 11013, 11048, 11069, 11080, 11180, 11280
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
