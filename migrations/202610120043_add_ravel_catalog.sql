-- 라벨 작품을 출판 단위로 다시 짠다(카탈로그: M.(마르나)·MA). 작품 102개(묶음 17, 다악장 23, 낱곡 62),
-- 새 작품 46개, 기존 작품 56개(seed 제목 고침 80개), part 172개, 그 아래 26개,
-- 기존 part 고쳐 씀 3개, 기존 작품 연결 35개. 카탈로그에 대응이 없는 seed 51개는 목록에서 숨긴다.
--
-- 정한 것
--   라벨 자신의 다른 편성판은 M. 번호가 따로면 따로 작품. 대표 가곡인 민요 편곡 5건(MA 4–22)은 넣는다.
--   <스페인의 시간>·<어린이와 마법>은 seed 가 장면을 가리켜 part 를 둔다.
--   231·26037·457 은 MBID 가 관현악·편성판이라 작품번호를 M. 19a·60a·76a 로 고치고 457 제목 오타(치건 → 치간느)를 고친다.
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

-- M. 2 그리그 주제에 의한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그리그 주제에 의한 변주곡', 'Variations on a Theme of Grieg (Death of Åse)', 'song', 'M. 2', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그리그 주제에 의한 변주곡'
);


-- M. 3 슈만 주제에 의한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '슈만 주제에 의한 변주곡', 'Variations on a Theme of Schumann (Freu dich sehr, o meine Seele)', 'song', 'M. 3', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '슈만 주제에 의한 변주곡'
);


-- M. 4 가곡 <Ballade de la reine morte d'aimer>

UPDATE pieces piece
SET piece.title = '가곡 <Ballade de la reine morte d''aimer>', piece.title_en = 'Ballade de la reine morte d''aimer',
    piece.type = 'song', piece.opus_number = 'M. 4',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1402 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 1402 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 5 그로테스크 세레나데

UPDATE pieces piece
SET piece.title = '그로테스크 세레나데', piece.title_en = 'Sérénade grotesque',
    piece.type = 'song', piece.opus_number = 'M. 5',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1893, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2430 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1893
WHERE piece.id = 2430 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 6 가곡 <Un grand sommeil noir>

UPDATE pieces piece
SET piece.title = '가곡 <Un grand sommeil noir>', piece.title_en = 'Un grand sommeil noir',
    piece.type = 'song', piece.opus_number = 'M. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1895, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1248 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1895
WHERE piece.id = 1248 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 7 고풍스러운 미뉴에트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '고풍스러운 미뉴에트', 'Menuet antique', 'song', 'M. 7', NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '고풍스러운 미뉴에트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9aacef3-d2d5-32de-9890-f1edc781772a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9aacef3-d2d5-32de-9890-f1edc781772a'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '고풍스러운 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9aacef3-d2d5-32de-9890-f1edc781772a'
);


-- M. 7a 고풍스러운 미뉴에트 (관현악)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '고풍스러운 미뉴에트 (관현악)', 'Menuet antique (orchestral version)', 'song', 'M. 7a', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '고풍스러운 미뉴에트 (관현악)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48bfa53d-3fae-3512-882b-5057606f1d89'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48bfa53d-3fae-3512-882b-5057606f1d89'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '고풍스러운 미뉴에트 (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48bfa53d-3fae-3512-882b-5057606f1d89'
);


-- M. 8, 13 두 대의 피아노를 위한 <Sites auriculaires>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 <Sites auriculaires>', 'Sites auriculaires, for two pianos', 'album', 'M. 8, 13', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 <Sites auriculaires>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m008-013:1', 1, NULL, '하바네라', 'Habanera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '두 대의 피아노를 위한 <Sites auriculaires>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m008-013:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m008-013:2', 2, NULL, 'Entre cloches', 'Entre cloches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '두 대의 피아노를 위한 <Sites auriculaires>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m008-013:2'
);


-- M. 9 가곡 <Sainte>

UPDATE pieces piece
SET piece.title = '가곡 <Sainte>', piece.title_en = 'Sainte',
    piece.type = 'song', piece.opus_number = 'M. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 10820 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 10820 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 10, 21 가곡집 <클레망 마로의 에피그램 2편>

UPDATE pieces piece
SET piece.title = '가곡집 <클레망 마로의 에피그램 2편>', piece.title_en = 'Deux épigrammes de Clément Marot',
    piece.type = 'album', piece.opus_number = 'M. 10, 21',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1899, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2158 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1899
WHERE piece.id = 2158 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'D''Anne qui me jecta de la neige', part.name_en = 'D''Anne qui me jecta de la neige',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2158 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:75339392-8dba-4b16-b23b-5f2ca07eabf8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75339392-8dba-4b16-b23b-5f2ca07eabf8', 1, NULL, 'D''Anne qui me jecta de la neige', 'D''Anne qui me jecta de la neige', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2158 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75339392-8dba-4b16-b23b-5f2ca07eabf8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'D''Anne jouant de l''espinette', part.name_en = 'D''Anne jouant de l''espinette',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2158 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:ef659543-84ea-4cd3-ada3-d199b7135003' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef659543-84ea-4cd3-ada3-d199b7135003', 2, NULL, 'D''Anne jouant de l''espinette', 'D''Anne jouant de l''espinette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2158 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef659543-84ea-4cd3-ada3-d199b7135003'
);


-- M. 11 발레 음악 <La Parade> (피아노)

UPDATE pieces piece
SET piece.title = '발레 음악 <La Parade> (피아노)', piece.title_en = 'La Parade, ballet music for piano',
    piece.type = 'song', piece.opus_number = 'M. 11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1896, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1258 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1896
WHERE piece.id = 1258 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 12 바이올린 소나타 1번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 1번 A단조', 'Violin Sonata No. 1 in A minor ("Sonate posthume")', 'song', 'M. 12', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 1번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e69653c2-46d1-4baf-b864-e5c628d5c07a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e69653c2-46d1-4baf-b864-e5c628d5c07a'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '바이올린 소나타 1번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e69653c2-46d1-4baf-b864-e5c628d5c07a'
);


-- M. 14 왈츠 D장조

UPDATE pieces piece
SET piece.title = '왈츠 D장조', piece.title_en = 'Valse in D major',
    piece.type = 'song', piece.opus_number = 'M. 14',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2553 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 2553 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 15 가곡 <Chanson du rouet>

UPDATE pieces piece
SET piece.title = '가곡 <Chanson du rouet>', piece.title_en = 'Chanson du rouet',
    piece.type = 'song', piece.opus_number = 'M. 15',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2939 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 2939 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 16 가곡 <Si morne !>

UPDATE pieces piece
SET piece.title = '가곡 <Si morne !>', piece.title_en = 'Si morne !',
    piece.type = 'song', piece.opus_number = 'M. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1556 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 1556 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 17 서곡 <셰에라자드>

UPDATE pieces piece
SET piece.title = '서곡 <셰에라자드>', piece.title_en = 'Shéhérazade, ouverture de féerie',
    piece.type = 'song', piece.opus_number = 'M. 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1898, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1109 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1898
WHERE piece.id = 1109 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 17a 서곡 <셰에라자드> (네 손 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <셰에라자드> (네 손 피아노)', 'Shéhérazade, ouverture de féerie (piano four hands)', 'song', 'M. 17a', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <셰에라자드> (네 손 피아노)'
);


-- M. 19 죽은 왕녀를 위한 파반느 (피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '죽은 왕녀를 위한 파반느 (피아노)', 'Pavane pour une infante défunte (piano)', 'song', 'M. 19', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '죽은 왕녀를 위한 파반느 (피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '859d1566-7332-3fe9-b46b-78f6de837258'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '859d1566-7332-3fe9-b46b-78f6de837258'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '죽은 왕녀를 위한 파반느 (피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '859d1566-7332-3fe9-b46b-78f6de837258'
);


-- M. 23 푸가 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 D장조', 'Fugue in D major', 'song', 'M. 23', NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 D장조'
);


-- M. 25 합창곡 <Les bayadères>

UPDATE pieces piece
SET piece.title = '합창곡 <Les bayadères>', piece.title_en = 'Les bayadères',
    piece.type = 'song', piece.opus_number = 'M. 25',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1900, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1558 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1900
WHERE piece.id = 1558 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 27 푸가 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 F장조', 'Fugue in F major', 'song', 'M. 27', NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 F장조'
);


-- M. 28 합창곡 <Tout est lumière>

UPDATE pieces piece
SET piece.title = '합창곡 <Tout est lumière>', piece.title_en = 'Tout est lumière',
    piece.type = 'song', piece.opus_number = 'M. 28',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2041 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 2041 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 29 칸타타 <Myrrha>

UPDATE pieces piece
SET piece.title = '칸타타 <Myrrha>', piece.title_en = 'Myrrha, cantata',
    piece.type = 'album', piece.opus_number = 'M. 29',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1901, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1081 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1901
WHERE piece.id = 1081 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1081 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:8475c79b-dbf8-43e9-a6e0-affb8d89ba82' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8475c79b-dbf8-43e9-a6e0-affb8d89ba82', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1081 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8475c79b-dbf8-43e9-a6e0-affb8d89ba82'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Me voici seul enfin', part.name_en = 'Me voici seul enfin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1081 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:083c83cc-4302-41a3-bf56-6b76d57764c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:083c83cc-4302-41a3-bf56-6b76d57764c6', 2, NULL, 'Me voici seul enfin', 'Me voici seul enfin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1081 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:083c83cc-4302-41a3-bf56-6b76d57764c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ainsi qu''un signal dans le ciel passe', part.name_en = 'Ainsi qu''un signal dans le ciel passe',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1081 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:4feb4ecf-5f88-4e49-9a07-b2b9b1ce580d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4feb4ecf-5f88-4e49-9a07-b2b9b1ce580d', 3, NULL, 'Ainsi qu''un signal dans le ciel passe', 'Ainsi qu''un signal dans le ciel passe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1081 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4feb4ecf-5f88-4e49-9a07-b2b9b1ce580d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Que tu peux retrouver de nouveaux soldats', part.name_en = 'Que tu peux retrouver de nouveaux soldats',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1081 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:3c67ab40-5cde-4dc4-bf82-a6396227096c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c67ab40-5cde-4dc4-bf82-a6396227096c', 4, NULL, 'Que tu peux retrouver de nouveaux soldats', 'Que tu peux retrouver de nouveaux soldats', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1081 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c67ab40-5cde-4dc4-bf82-a6396227096c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tu ne passeras pas, ô roi', part.name_en = 'Tu ne passeras pas, ô roi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1081 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:e79d96b8-5eeb-48ec-aa94-a99729da47ff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e79d96b8-5eeb-48ec-aa94-a99729da47ff', 5, NULL, 'Tu ne passeras pas, ô roi', 'Tu ne passeras pas, ô roi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1081 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e79d96b8-5eeb-48ec-aa94-a99729da47ff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Arrière donc !', part.name_en = 'Arrière donc !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1081 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:47bac1bb-b549-48b4-9630-a9f03bf59ae1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47bac1bb-b549-48b4-9630-a9f03bf59ae1', 6, NULL, 'Arrière donc !', 'Arrière donc !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1081 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47bac1bb-b549-48b4-9630-a9f03bf59ae1'
);


-- M. 32 푸가 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 E♭장조', 'Fugue in E♭ major', 'song', 'M. 32', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 E♭장조'
);


-- M. 33 합창곡 <La Nuit>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <La Nuit>', 'La Nuit', 'song', 'M. 33', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <La Nuit>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18db025a-b00e-4d1e-a779-b573d3ea9699'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '18db025a-b00e-4d1e-a779-b573d3ea9699'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '합창곡 <La Nuit>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18db025a-b00e-4d1e-a779-b573d3ea9699'
);


-- M. 34 칸타타 <Alcyone>

UPDATE pieces piece
SET piece.title = '칸타타 <Alcyone>', piece.title_en = 'Alcyone, cantata',
    piece.type = 'album', piece.opus_number = 'M. 34',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1902, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1374 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1902
WHERE piece.id = 1374 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1374 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:e6800649-2c38-4d35-9ae4-23dffb20b177' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6800649-2c38-4d35-9ae4-23dffb20b177', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1374 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6800649-2c38-4d35-9ae4-23dffb20b177'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'À l''horizon les voiles blanches ont disparu', part.name_en = 'À l''horizon les voiles blanches ont disparu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1374 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:7a79bb26-2767-4b99-a270-ed779db3ffdb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a79bb26-2767-4b99-a270-ed779db3ffdb', 2, NULL, 'À l''horizon les voiles blanches ont disparu', 'À l''horizon les voiles blanches ont disparu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1374 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a79bb26-2767-4b99-a270-ed779db3ffdb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Description symphonique', part.name_en = 'Description symphonique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1374 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:9ea24b46-f9fd-4651-9f3e-6ae47dfb76aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ea24b46-f9fd-4651-9f3e-6ae47dfb76aa', 3, NULL, 'Description symphonique', 'Description symphonique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1374 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ea24b46-f9fd-4651-9f3e-6ae47dfb76aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ah ! Dieux puissants', part.name_en = 'Ah ! Dieux puissants',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1374 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:01ef9035-1c00-47be-b5e2-f186e86e8a43' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01ef9035-1c00-47be-b5e2-f186e86e8a43', 4, NULL, 'Ah ! Dieux puissants', 'Ah ! Dieux puissants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1374 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01ef9035-1c00-47be-b5e2-f186e86e8a43'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Mon aimé ! Mon aimé !', part.name_en = 'Mon aimé ! Mon aimé !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1374 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:a607c09b-55ed-4f48-a85f-114dbf05f6c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a607c09b-55ed-4f48-a85f-114dbf05f6c7', 5, NULL, 'Mon aimé ! Mon aimé !', 'Mon aimé ! Mon aimé !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1374 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a607c09b-55ed-4f48-a85f-114dbf05f6c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Ma fille, mon enfant ! Qu''as-tu ?', part.name_en = 'Ma fille, mon enfant ! Qu''as-tu ?',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1374 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1a75a1e9-5342-438c-8dc8-a1b14f762a35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a75a1e9-5342-438c-8dc8-a1b14f762a35', 6, NULL, 'Ma fille, mon enfant ! Qu''as-tu ?', 'Ma fille, mon enfant ! Qu''as-tu ?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1374 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a75a1e9-5342-438c-8dc8-a1b14f762a35'
);


-- M. 35 현악 4중주 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 F장조', 'String Quartet in F major', 'album', 'M. 35', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8beb49f1-314e-44c0-855f-a93fea527e06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8beb49f1-314e-44c0-855f-a93fea527e06'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8beb49f1-314e-44c0-855f-a93fea527e06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8343a616-e822-3bbe-9199-7b995a490e03', 1, 'I', 'Allegro moderato. Très doux', 'I. Allegro moderato. Très doux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8343a616-e822-3bbe-9199-7b995a490e03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fb58b0e-d4a1-3639-a23c-e97829689661', 2, 'II', 'Assez vif. Très rythmé', 'II. Assez vif. Très rythmé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fb58b0e-d4a1-3639-a23c-e97829689661'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94efe173-3c0a-30c8-8e86-f90c08f878bc', 3, 'III', 'Très lent', 'III. Très lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94efe173-3c0a-30c8-8e86-f90c08f878bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2497 AND linked.composer_id = 52), 'musicbrainz:35a5546b-93e2-321b-9585-32877981e658', 4, 'IV', 'Vif et agité', 'IV. Vif et agité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35a5546b-93e2-321b-9585-32877981e658'
);

UPDATE pieces piece
SET piece.title = '현악 4중주 F장조 중 "Vif et agité"', piece.title_en = 'String Quartet in F major: IV. Vif et agité', piece.editor_locked = 1
WHERE piece.id = 2497 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- M. 36 푸가 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 E단조', 'Fugue in E minor', 'song', 'M. 36', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 E단조'
);


-- M. 37 합창곡 <Matinée de Provence>

UPDATE pieces piece
SET piece.title = '합창곡 <Matinée de Provence>', piece.title_en = 'Matinée de Provence',
    piece.type = 'song', piece.opus_number = 'M. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1251 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 1251 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 38 칸타타 <Alyssa>

UPDATE pieces piece
SET piece.title = '칸타타 <Alyssa>', piece.title_en = 'Alyssa, cantata',
    piece.type = 'album', piece.opus_number = 'M. 38',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 955 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 955 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '전주곡', part.name_en = 'Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 955 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:57087848-bd99-4fc7-a876-1037edc20252' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57087848-bd99-4fc7-a876-1037edc20252', 1, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 955 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57087848-bd99-4fc7-a876-1037edc20252'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Elfes légers, elfes errants', part.name_en = 'Elfes légers, elfes errants',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 955 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:6c030102-af20-440e-b0e2-23aeb0d3628f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c030102-af20-440e-b0e2-23aeb0d3628f', 2, NULL, 'Elfes légers, elfes errants', 'Elfes légers, elfes errants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 955 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c030102-af20-440e-b0e2-23aeb0d3628f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Là-bas, tout là-bas', part.name_en = 'Là-bas, tout là-bas',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 955 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:ff92bb36-7f26-432e-919e-65d7a4fca7be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff92bb36-7f26-432e-919e-65d7a4fca7be', 3, NULL, 'Là-bas, tout là-bas', 'Là-bas, tout là-bas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 955 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff92bb36-7f26-432e-919e-65d7a4fca7be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'On dirait un bruit lointain d''armures', part.name_en = 'On dirait un bruit lointain d''armures',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 955 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:635efbce-f7ef-492f-bd6a-0664d2c43673' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:635efbce-f7ef-492f-bd6a-0664d2c43673', 4, NULL, 'On dirait un bruit lointain d''armures', 'On dirait un bruit lointain d''armures', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 955 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:635efbce-f7ef-492f-bd6a-0664d2c43673'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le Barde, porte-glaive !', part.name_en = 'Le Barde, porte-glaive !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 955 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:c6dda26f-85a1-4045-b0e1-4b737bbb5cfc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6dda26f-85a1-4045-b0e1-4b737bbb5cfc', 5, NULL, 'Le Barde, porte-glaive !', 'Le Barde, porte-glaive !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 955 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6dda26f-85a1-4045-b0e1-4b737bbb5cfc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Puisqu''en vain pour eux je supplie', part.name_en = 'Puisqu''en vain pour eux je supplie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 955 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:507a8653-6ce2-4793-a3f8-7483dd220c45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:507a8653-6ce2-4793-a3f8-7483dd220c45', 6, NULL, 'Puisqu''en vain pour eux je supplie', 'Puisqu''en vain pour eux je supplie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 955 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:507a8653-6ce2-4793-a3f8-7483dd220c45'
);


-- M. 39 가곡 <Manteau de fleurs>

UPDATE pieces piece
SET piece.title = '가곡 <Manteau de fleurs>', piece.title_en = 'Manteau de fleurs',
    piece.type = 'song', piece.opus_number = 'M. 39',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1980 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 1980 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 39a 가곡 <Manteau de fleurs> (관현악 반주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Manteau de fleurs> (관현악 반주)', 'Manteau de fleurs (orchestral version)', 'song', 'M. 39a', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Manteau de fleurs> (관현악 반주)'
);


-- M. 40 소나티네

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나티네', 'Sonatine', 'album', 'M. 40', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나티네'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b581055-38b8-444d-806a-d9d357b4bdaf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b581055-38b8-444d-806a-d9d357b4bdaf'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '소나티네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b581055-38b8-444d-806a-d9d357b4bdaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a14be5f-8c33-3c4e-bb43-6c148e0bee2d', 1, 'I', 'Modéré', 'I. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '소나티네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a14be5f-8c33-3c4e-bb43-6c148e0bee2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae99b5ef-ec85-321e-a4bd-9ce2279f6fe3', 2, 'II', 'Mouvement de menuet', 'II. Mouvement de menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '소나티네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae99b5ef-ec85-321e-a4bd-9ce2279f6fe3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f528941-6bf2-3d03-aa96-48b698328c29', 3, 'III', 'Animé', 'III. Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '소나티네' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f528941-6bf2-3d03-aa96-48b698328c29'
);


-- M. 41 가곡집 <셰에라자드>

UPDATE pieces piece
SET piece.title = '가곡집 <셰에라자드>', piece.title_en = 'Shéhérazade, three poems for voice and orchestra',
    piece.type = 'album', piece.opus_number = 'M. 41',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1903, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1046 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1903
WHERE piece.id = 1046 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '아시아 (Asie)', part.name_en = 'Asie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1046 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:20d11900-1302-4e6a-9c86-417b0d7e9c16' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20d11900-1302-4e6a-9c86-417b0d7e9c16', 1, NULL, '아시아 (Asie)', 'Asie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1046 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20d11900-1302-4e6a-9c86-417b0d7e9c16'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '마법의 피리 (La Flûte enchantée)', part.name_en = 'La Flûte enchantée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1046 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:296ff249-b314-37ac-b559-c4a8d7eba409' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:296ff249-b314-37ac-b559-c4a8d7eba409', 2, NULL, '마법의 피리 (La Flûte enchantée)', 'La Flûte enchantée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1046 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:296ff249-b314-37ac-b559-c4a8d7eba409'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '무심한 사람 (L''Indifférent)', part.name_en = 'L''Indifférent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1046 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:e4950cf5-7fd0-4626-8ed9-1151b877552e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4950cf5-7fd0-4626-8ed9-1151b877552e', 3, NULL, '무심한 사람 (L''Indifférent)', 'L''Indifférent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1046 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4950cf5-7fd0-4626-8ed9-1151b877552e'
);


-- M. 42 미뉴에트 C#단조

UPDATE pieces piece
SET piece.catalogue_system = 'M.', piece.catalogue_number = '42'
WHERE piece.id = 479 AND piece.composer_id = 52
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1904
WHERE piece.id = 479 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 43 피아노 모음곡 <거울>

UPDATE pieces piece
SET piece.title = '피아노 모음곡 <거울>', piece.title_en = 'Miroirs',
    piece.type = 'album', piece.opus_number = 'M. 43',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1900 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 1900 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '나방 (Noctuelles)', part.name_en = 'Noctuelles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1900 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:e7d9f6bc-20b5-35e8-81da-0f92a2f6f967' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7d9f6bc-20b5-35e8-81da-0f92a2f6f967', 1, NULL, '나방 (Noctuelles)', 'Noctuelles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1900 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7d9f6bc-20b5-35e8-81da-0f92a2f6f967'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '슬픈 새들 (Oiseaux tristes)', part.name_en = 'Oiseaux tristes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1900 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1542bc44-fead-354a-b6a1-0f41e169d1a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1542bc44-fead-354a-b6a1-0f41e169d1a2', 2, NULL, '슬픈 새들 (Oiseaux tristes)', 'Oiseaux tristes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1900 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1542bc44-fead-354a-b6a1-0f41e169d1a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '바다 위의 작은 배 (Une barque sur l''océan)', part.name_en = 'Une barque sur l''océan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1900 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:88888e07-c508-3e41-b401-62f0408c5173' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88888e07-c508-3e41-b401-62f0408c5173', 3, NULL, '바다 위의 작은 배 (Une barque sur l''océan)', 'Une barque sur l''océan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1900 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88888e07-c508-3e41-b401-62f0408c5173'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '어릿광대의 아침 노래 (Alborada del gracioso)', part.name_en = 'Alborada del gracioso',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1900 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:6e2f3c13-0ae9-340f-b5c2-e3bfe0efc91f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e2f3c13-0ae9-340f-b5c2-e3bfe0efc91f', 4, NULL, '어릿광대의 아침 노래 (Alborada del gracioso)', 'Alborada del gracioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1900 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e2f3c13-0ae9-340f-b5c2-e3bfe0efc91f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '종의 골짜기 (La Vallée des cloches)', part.name_en = 'La Vallée des cloches',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1900 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:cdf51b7a-f670-351a-9cfc-5b238832bedf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdf51b7a-f670-351a-9cfc-5b238832bedf', 5, NULL, '종의 골짜기 (La Vallée des cloches)', 'La Vallée des cloches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1900 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdf51b7a-f670-351a-9cfc-5b238832bedf'
);


-- M. 43a <바다 위의 작은 배> (관현악)

UPDATE pieces piece
SET piece.title = '<바다 위의 작은 배> (관현악)', piece.title_en = 'Une barque sur l''océan (orchestral version)',
    piece.type = 'song', piece.opus_number = 'M. 43a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1141 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 1141 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 43c <어릿광대의 아침 노래> (관현악)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<어릿광대의 아침 노래> (관현악)', 'Alborada del gracioso (orchestral version)', 'song', 'M. 43c', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<어릿광대의 아침 노래> (관현악)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18e8ba3c-7bc7-306a-9faa-f4230aefe1e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '18e8ba3c-7bc7-306a-9faa-f4230aefe1e8'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<어릿광대의 아침 노래> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '18e8ba3c-7bc7-306a-9faa-f4230aefe1e8'
);


-- M. 44 푸가 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 C장조', 'Fugue in C major', 'song', 'M. 44', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 C장조'
);


-- M. 45 합창곡 <L'Aurore>

UPDATE pieces piece
SET piece.title = '합창곡 <L''Aurore>', piece.title_en = 'L''Aurore',
    piece.type = 'song', piece.opus_number = 'M. 45',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1711 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 1711 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 46 서주와 알레그로

UPDATE pieces piece
SET piece.title = '서주와 알레그로', piece.title_en = 'Introduction et Allegro, for harp, flute, clarinet and string quartet',
    piece.type = 'song', piece.opus_number = 'M. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 642 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 642 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 47 가곡 <Noël des jouets>

UPDATE pieces piece
SET piece.title = '가곡 <Noël des jouets>', piece.title_en = 'Noël des jouets',
    piece.type = 'song', piece.opus_number = 'M. 47',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1905, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2325 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1905
WHERE piece.id = 2325 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 47b 가곡 <Noël des jouets> (관현악 반주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Noël des jouets> (관현악 반주)', 'Noël des jouets (orchestral version, revised)', 'song', 'M. 47b', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Noël des jouets> (관현악 반주)'
);


-- M. 48 가곡 <Les grands vents venus d'outre-mer>

UPDATE pieces piece
SET piece.title = '가곡 <Les grands vents venus d''outre-mer>', piece.title_en = 'Les grands vents venus d''outre-mer',
    piece.type = 'song', piece.opus_number = 'M. 48',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2213 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 2213 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 50 연가곡집 <박물지>

UPDATE pieces piece
SET piece.title = '연가곡집 <박물지>', piece.title_en = 'Histoires naturelles',
    piece.type = 'album', piece.opus_number = 'M. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1503 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 1503 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '공작 (Le Paon)', part.name_en = 'Le Paon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1503 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:7a182086-632d-42b8-baf3-d64ddc7f7a06' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a182086-632d-42b8-baf3-d64ddc7f7a06', 1, NULL, '공작 (Le Paon)', 'Le Paon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1503 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a182086-632d-42b8-baf3-d64ddc7f7a06'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '귀뚜라미 (Le Grillon)', part.name_en = 'Le Grillon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1503 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:c69ea6e6-7e2c-4e45-b261-43b43e45844d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c69ea6e6-7e2c-4e45-b261-43b43e45844d', 2, NULL, '귀뚜라미 (Le Grillon)', 'Le Grillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1503 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c69ea6e6-7e2c-4e45-b261-43b43e45844d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '백조 (Le Cygne)', part.name_en = 'Le Cygne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1503 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:5534701f-6387-432e-ba36-2e674eb263f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5534701f-6387-432e-ba36-2e674eb263f2', 3, NULL, '백조 (Le Cygne)', 'Le Cygne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1503 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5534701f-6387-432e-ba36-2e674eb263f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '물총새 (Le Martin-pêcheur)', part.name_en = 'Le Martin-pêcheur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1503 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:87291ebb-a7dd-459d-b40b-f67b9517e389' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87291ebb-a7dd-459d-b40b-f67b9517e389', 4, NULL, '물총새 (Le Martin-pêcheur)', 'Le Martin-pêcheur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1503 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87291ebb-a7dd-459d-b40b-f67b9517e389'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '뿔닭 (La Pintade)', part.name_en = 'La Pintade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1503 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:16862fa2-5716-4bac-a151-a9d54d804424' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16862fa2-5716-4bac-a151-a9d54d804424', 5, NULL, '뿔닭 (La Pintade)', 'La Pintade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1503 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16862fa2-5716-4bac-a151-a9d54d804424'
);


-- M. 51 하바네라 형식의 보칼리즈 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하바네라 형식의 보칼리즈 연습곡', 'Vocalise-étude en forme de habanera', 'song', 'M. 51', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하바네라 형식의 보칼리즈 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a92a1431-c38e-357a-b644-dc228a150b75'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a92a1431-c38e-357a-b644-dc228a150b75'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '하바네라 형식의 보칼리즈 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a92a1431-c38e-357a-b644-dc228a150b75'
);


-- M. 52 오페라 <스페인의 시간>

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간>', piece.title_en = 'L''Heure espagnole',
    piece.type = 'album', piece.opus_number = 'M. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1911, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1029 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1911
WHERE piece.id = 1029 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2113 AND linked.composer_id = 52),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '서주', part.name_en = 'Introduction',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:f3dd1901-6f51-4464-80f2-aee3458ab101' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2113 AND linked.composer_id = 52), 'musicbrainz:f3dd1901-6f51-4464-80f2-aee3458ab101', 1, NULL, '서주', 'Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3dd1901-6f51-4464-80f2-aee3458ab101'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "서주"', piece.title_en = 'L''Heure espagnole: Introduction', piece.editor_locked = 1
WHERE piece.id = 2113 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2347 AND linked.composer_id = 52),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '제1장 « Señor Torquemada, horloger de Tolède ? »', part.name_en = 'Scène I. « Señor Torquemada, horloger de Tolède ? »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:fd73dd6c-95dd-4d08-b3cd-b24d1251b7c5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2347 AND linked.composer_id = 52), 'musicbrainz:fd73dd6c-95dd-4d08-b3cd-b24d1251b7c5', 2, NULL, '제1장 « Señor Torquemada, horloger de Tolède ? »', 'Scène I. « Señor Torquemada, horloger de Tolède ? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd73dd6c-95dd-4d08-b3cd-b24d1251b7c5'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제1장 « Señor Torquemada, horloger de Tolède ? »"', piece.title_en = 'L''Heure espagnole: Scène I. « Señor Torquemada, horloger de Tolède ? »', piece.editor_locked = 1
WHERE piece.id = 2347 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1367 AND linked.composer_id = 52),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '제2장 « Totor ! »', part.name_en = 'Scène II. « Totor ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1fb28fec-09e2-46f9-bd5c-570fb86bc4e4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1367 AND linked.composer_id = 52), 'musicbrainz:1fb28fec-09e2-46f9-bd5c-570fb86bc4e4', 3, NULL, '제2장 « Totor ! »', 'Scène II. « Totor ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb28fec-09e2-46f9-bd5c-570fb86bc4e4'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제2장 « Totor ! »"', piece.title_en = 'L''Heure espagnole: Scène II. « Totor ! »', piece.editor_locked = 1
WHERE piece.id = 1367 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 3012 AND linked.composer_id = 52),
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '제3장 « Il reste, voilà bien ma chance ! »', part.name_en = 'Scène III. « Il reste, voilà bien ma chance ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:03b05ff1-57b4-46eb-8c9d-c37aab644daa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 3012 AND linked.composer_id = 52), 'musicbrainz:03b05ff1-57b4-46eb-8c9d-c37aab644daa', 4, NULL, '제3장 « Il reste, voilà bien ma chance ! »', 'Scène III. « Il reste, voilà bien ma chance ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03b05ff1-57b4-46eb-8c9d-c37aab644daa'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제3장 « Il reste, voilà bien ma chance ! »"', piece.title_en = 'L''Heure espagnole: Scène III. « Il reste, voilà bien ma chance ! »', piece.editor_locked = 1
WHERE piece.id = 3012 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2230 AND linked.composer_id = 52),
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '제4장 « Il était temps, voici Gonzalve ! »', part.name_en = 'Scène IV. « Il était temps, voici Gonzalve ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:94502758-74ce-4947-ad8f-d6caeab235b5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2230 AND linked.composer_id = 52), 'musicbrainz:94502758-74ce-4947-ad8f-d6caeab235b5', 5, NULL, '제4장 « Il était temps, voici Gonzalve ! »', 'Scène IV. « Il était temps, voici Gonzalve ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94502758-74ce-4947-ad8f-d6caeab235b5'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제4장 « Il était temps, voici Gonzalve ! »"', piece.title_en = 'L''Heure espagnole: Scène IV. « Il était temps, voici Gonzalve ! »', piece.editor_locked = 1
WHERE piece.id = 2230 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1766 AND linked.composer_id = 52),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '제5장 « C''est fait, l''horloge est à sa place »', part.name_en = 'Scène V. « C''est fait, l''horloge est à sa place »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1b59cd12-1fc5-402a-9a05-863c56ee278a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1766 AND linked.composer_id = 52), 'musicbrainz:1b59cd12-1fc5-402a-9a05-863c56ee278a', 6, NULL, '제5장 « C''est fait, l''horloge est à sa place »', 'Scène V. « C''est fait, l''horloge est à sa place »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b59cd12-1fc5-402a-9a05-863c56ee278a'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제5장 « C''est fait, l''horloge est à sa place »"', piece.title_en = 'L''Heure espagnole: Scène V. « C''est fait, l''horloge est à sa place »', piece.editor_locked = 1
WHERE piece.id = 1766 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1351 AND linked.composer_id = 52),
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '제6장 « Maintenant pas de temps à perdre ! »', part.name_en = 'Scène VI. « Maintenant pas de temps à perdre ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:18148ea1-6cfe-45c9-93d8-7def73d44ac5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1351 AND linked.composer_id = 52), 'musicbrainz:18148ea1-6cfe-45c9-93d8-7def73d44ac5', 7, NULL, '제6장 « Maintenant pas de temps à perdre ! »', 'Scène VI. « Maintenant pas de temps à perdre ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18148ea1-6cfe-45c9-93d8-7def73d44ac5'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제6장 « Maintenant pas de temps à perdre ! »"', piece.title_en = 'L''Heure espagnole: Scène VI. « Maintenant pas de temps à perdre ! »', piece.editor_locked = 1
WHERE piece.id = 1351 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1295 AND linked.composer_id = 52),
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '제7장 « Salut à la belle horlogère ! »', part.name_en = 'Scène VII. « Salut à la belle horlogère ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:25efae33-b6d4-4d59-adc2-4ff1290ec0bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1295 AND linked.composer_id = 52), 'musicbrainz:25efae33-b6d4-4d59-adc2-4ff1290ec0bc', 8, NULL, '제7장 « Salut à la belle horlogère ! »', 'Scène VII. « Salut à la belle horlogère ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25efae33-b6d4-4d59-adc2-4ff1290ec0bc'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제7장 « Salut à la belle horlogère ! »"', piece.title_en = 'L''Heure espagnole: Scène VII. « Salut à la belle horlogère ! »', piece.editor_locked = 1
WHERE piece.id = 1295 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2867 AND linked.composer_id = 52),
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '제8장 « Voilà !... Et maintenant à l''autre ! »', part.name_en = 'Scène VIII. « Voilà !... Et maintenant à l''autre ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:682b3e03-f4f9-4fd4-9730-125ebd4c0dd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2867 AND linked.composer_id = 52), 'musicbrainz:682b3e03-f4f9-4fd4-9730-125ebd4c0dd0', 9, NULL, '제8장 « Voilà !... Et maintenant à l''autre ! »', 'Scène VIII. « Voilà !... Et maintenant à l''autre ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:682b3e03-f4f9-4fd4-9730-125ebd4c0dd0'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제8장 « Voilà !... Et maintenant à l''autre ! »"', piece.title_en = 'L''Heure espagnole: Scène VIII. « Voilà !... Et maintenant à l''autre ! »', piece.editor_locked = 1
WHERE piece.id = 2867 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2417 AND linked.composer_id = 52),
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '제9장 « Évidemment, elle me congédie »', part.name_en = 'Scène IX. « Évidemment, elle me congédie »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:c0f4b60c-a761-4d5e-9da5-98629694a5fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2417 AND linked.composer_id = 52), 'musicbrainz:c0f4b60c-a761-4d5e-9da5-98629694a5fd', 10, NULL, '제9장 « Évidemment, elle me congédie »', 'Scène IX. « Évidemment, elle me congédie »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0f4b60c-a761-4d5e-9da5-98629694a5fd'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제9장 « Évidemment, elle me congédie »"', piece.title_en = 'L''Heure espagnole: Scène IX. « Évidemment, elle me congédie »', piece.editor_locked = 1
WHERE piece.id = 2417 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2044 AND linked.composer_id = 52),
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '제10장 « Voilà ce que j''appelle une femme charmante »', part.name_en = 'Scène X. « Voilà ce que j''appelle une femme charmante »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:d324aa49-1760-45b3-9b12-f8d35e03bcfb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2044 AND linked.composer_id = 52), 'musicbrainz:d324aa49-1760-45b3-9b12-f8d35e03bcfb', 11, NULL, '제10장 « Voilà ce que j''appelle une femme charmante »', 'Scène X. « Voilà ce que j''appelle une femme charmante »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d324aa49-1760-45b3-9b12-f8d35e03bcfb'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제10장 « Voilà ce que j''appelle une femme charmante »"', piece.title_en = 'L''Heure espagnole: Scène X. « Voilà ce que j''appelle une femme charmante »', piece.editor_locked = 1
WHERE piece.id = 2044 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1901 AND linked.composer_id = 52),
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '제11장 « Monsieur, ah ! Monsieur ! »', part.name_en = 'Scène XI. « Monsieur, ah ! Monsieur ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:a13f0a1f-42c5-4583-b474-4a6a297b6c6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1901 AND linked.composer_id = 52), 'musicbrainz:a13f0a1f-42c5-4583-b474-4a6a297b6c6e', 12, NULL, '제11장 « Monsieur, ah ! Monsieur ! »', 'Scène XI. « Monsieur, ah ! Monsieur ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a13f0a1f-42c5-4583-b474-4a6a297b6c6e'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제11장 « Monsieur, ah ! Monsieur ! »"', piece.title_en = 'L''Heure espagnole: Scène XI. « Monsieur, ah ! Monsieur ! »', piece.editor_locked = 1
WHERE piece.id = 1901 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2463 AND linked.composer_id = 52),
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '제12장 « Enfin, il part ! »', part.name_en = 'Scène XII. « Enfin, il part ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:647bb631-cd20-41f6-b299-810a1dd5e41f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2463 AND linked.composer_id = 52), 'musicbrainz:647bb631-cd20-41f6-b299-810a1dd5e41f', 13, NULL, '제12장 « Enfin, il part ! »', 'Scène XII. « Enfin, il part ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:647bb631-cd20-41f6-b299-810a1dd5e41f'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제12장 « Enfin, il part ! »"', piece.title_en = 'L''Heure espagnole: Scène XII. « Enfin, il part ! »', piece.editor_locked = 1
WHERE piece.id = 2463 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1214 AND linked.composer_id = 52),
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '제13장 « Voilà l''objet ! »', part.name_en = 'Scène XIII. « Voilà l''objet ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1d6db118-5ac2-42df-acda-3315e842ff26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1214 AND linked.composer_id = 52), 'musicbrainz:1d6db118-5ac2-42df-acda-3315e842ff26', 14, NULL, '제13장 « Voilà l''objet ! »', 'Scène XIII. « Voilà l''objet ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d6db118-5ac2-42df-acda-3315e842ff26'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제13장 « Voilà l''objet ! »"', piece.title_en = 'L''Heure espagnole: Scène XIII. « Voilà l''objet ! »', piece.editor_locked = 1
WHERE piece.id = 1214 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2642 AND linked.composer_id = 52),
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '제14장 « Ah ! vous, n''est-ce pas, preste ! leste ! »', part.name_en = 'Scène XIV. « Ah ! vous, n''est-ce pas, preste ! leste ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:65d72f63-6d22-4415-b20f-96bd9f38dea3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2642 AND linked.composer_id = 52), 'musicbrainz:65d72f63-6d22-4415-b20f-96bd9f38dea3', 15, NULL, '제14장 « Ah ! vous, n''est-ce pas, preste ! leste ! »', 'Scène XIV. « Ah ! vous, n''est-ce pas, preste ! leste ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65d72f63-6d22-4415-b20f-96bd9f38dea3'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제14장 « Ah ! vous, n''est-ce pas, preste ! leste ! »"', piece.title_en = 'L''Heure espagnole: Scène XIV. « Ah ! vous, n''est-ce pas, preste ! leste ! »', piece.editor_locked = 1
WHERE piece.id = 2642 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2556 AND linked.composer_id = 52),
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = '제15장 « En dépit de cette inhumaine »', part.name_en = 'Scène XV. « En dépit de cette inhumaine »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:104bb26f-68b3-4c28-86e5-1880ab736033' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2556 AND linked.composer_id = 52), 'musicbrainz:104bb26f-68b3-4c28-86e5-1880ab736033', 16, NULL, '제15장 « En dépit de cette inhumaine »', 'Scène XV. « En dépit de cette inhumaine »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:104bb26f-68b3-4c28-86e5-1880ab736033'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제15장 « En dépit de cette inhumaine »"', piece.title_en = 'L''Heure espagnole: Scène XV. « En dépit de cette inhumaine »', piece.editor_locked = 1
WHERE piece.id = 2556 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2526 AND linked.composer_id = 52),
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = '제16장 « Voilà ce que j''appelle une femme charmante ! »', part.name_en = 'Scène XVI. « Voilà ce que j''appelle une femme charmante ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:370d46af-ce57-48f9-9e21-bc01262f2ee8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2526 AND linked.composer_id = 52), 'musicbrainz:370d46af-ce57-48f9-9e21-bc01262f2ee8', 17, NULL, '제16장 « Voilà ce que j''appelle une femme charmante ! »', 'Scène XVI. « Voilà ce que j''appelle une femme charmante ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:370d46af-ce57-48f9-9e21-bc01262f2ee8'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제16장 « Voilà ce que j''appelle une femme charmante ! »"', piece.title_en = 'L''Heure espagnole: Scène XVI. « Voilà ce que j''appelle une femme charmante ! »', piece.editor_locked = 1
WHERE piece.id = 2526 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2972 AND linked.composer_id = 52),
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = '제17장 « Oh ! la pitoyable aventure ! » (Concepción, Gonzalve)', part.name_en = 'Scène XVII. « Oh ! la pitoyable aventure ! » (Concepción, Gonzalve)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:f7a12cfc-b5e2-403e-a9f6-4bb9a716f8e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2972 AND linked.composer_id = 52), 'musicbrainz:f7a12cfc-b5e2-403e-a9f6-4bb9a716f8e1', 18, NULL, '제17장 « Oh ! la pitoyable aventure ! » (Concepción, Gonzalve)', 'Scène XVII. « Oh ! la pitoyable aventure ! » (Concepción, Gonzalve)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a12cfc-b5e2-403e-a9f6-4bb9a716f8e1'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제17장 « Oh ! la pitoyable aventure ! » (Concepción, Gonzalve)"', piece.title_en = 'L''Heure espagnole: Scène XVII. « Oh ! la pitoyable aventure ! » (Concepción, Gonzalve)', piece.editor_locked = 1
WHERE piece.id = 2972 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1072 AND linked.composer_id = 52),
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = '제18장 « Voilà !... Et maintenant, Señora »', part.name_en = 'Scène XVIII. « Voilà !... Et maintenant, Señora »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:bc8cae8c-7e48-4064-8d2e-835fa05df9cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1072 AND linked.composer_id = 52), 'musicbrainz:bc8cae8c-7e48-4064-8d2e-835fa05df9cb', 19, NULL, '제18장 « Voilà !... Et maintenant, Señora »', 'Scène XVIII. « Voilà !... Et maintenant, Señora »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc8cae8c-7e48-4064-8d2e-835fa05df9cb'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제18장 « Voilà !... Et maintenant, Señora »"', piece.title_en = 'L''Heure espagnole: Scène XVIII. « Voilà !... Et maintenant, Señora »', piece.editor_locked = 1
WHERE piece.id = 1072 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1762 AND linked.composer_id = 52),
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '제19장 « Adieu, cellule, adieu, donjon ! »', part.name_en = 'Scène XIX. « Adieu, cellule, adieu, donjon ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:cc1ec1e4-2b66-4b33-9e05-c4b9d8d38ccf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1762 AND linked.composer_id = 52), 'musicbrainz:cc1ec1e4-2b66-4b33-9e05-c4b9d8d38ccf', 20, NULL, '제19장 « Adieu, cellule, adieu, donjon ! »', 'Scène XIX. « Adieu, cellule, adieu, donjon ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc1ec1e4-2b66-4b33-9e05-c4b9d8d38ccf'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제19장 « Adieu, cellule, adieu, donjon ! »"', piece.title_en = 'L''Heure espagnole: Scène XIX. « Adieu, cellule, adieu, donjon ! »', piece.editor_locked = 1
WHERE piece.id = 1762 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = '제19장 « Mon œil anxieux interroge »', part.name_en = 'Scène XIX. « Mon œil anxieux interroge »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:9abf3371-ebe2-432a-ba98-c9cf62b9db26' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9abf3371-ebe2-432a-ba98-c9cf62b9db26', 21, NULL, '제19장 « Mon œil anxieux interroge »', 'Scène XIX. « Mon œil anxieux interroge »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9abf3371-ebe2-432a-ba98-c9cf62b9db26'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1714 AND linked.composer_id = 52),
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = '제20장 « Il n''est, pour l''horloger »', part.name_en = 'Scène XX. « Il n''est, pour l''horloger »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:18f6a99c-6336-40ab-a98f-f03327c6b1f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1714 AND linked.composer_id = 52), 'musicbrainz:18f6a99c-6336-40ab-a98f-f03327c6b1f8', 22, NULL, '제20장 « Il n''est, pour l''horloger »', 'Scène XX. « Il n''est, pour l''horloger »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18f6a99c-6336-40ab-a98f-f03327c6b1f8'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제20장 « Il n''est, pour l''horloger »"', piece.title_en = 'L''Heure espagnole: Scène XX. « Il n''est, pour l''horloger »', piece.editor_locked = 1
WHERE piece.id = 1714 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1313 AND linked.composer_id = 52),
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = '제21장 « Pardieu, déménageur, vous venez à propos ! »', part.name_en = 'Scène XXI. « Pardieu, déménageur, vous venez à propos ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:79db7226-efe1-4d0e-9bbe-3f0ce3ba209d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1313 AND linked.composer_id = 52), 'musicbrainz:79db7226-efe1-4d0e-9bbe-3f0ce3ba209d', 23, NULL, '제21장 « Pardieu, déménageur, vous venez à propos ! »', 'Scène XXI. « Pardieu, déménageur, vous venez à propos ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79db7226-efe1-4d0e-9bbe-3f0ce3ba209d'
);

UPDATE pieces piece
SET piece.title = '오페라 <스페인의 시간> 중 "제21장 « Pardieu, déménageur, vous venez à propos ! »"', piece.title_en = 'L''Heure espagnole: Scène XXI. « Pardieu, déménageur, vous venez à propos ! »', piece.editor_locked = 1
WHERE piece.id = 1313 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = '제21장 « Un financier... Et un poète »', part.name_en = 'Scène XXI. « Un financier... Et un poète »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1029 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:416a9413-1497-4473-a6b9-db9c20e24c6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:416a9413-1497-4473-a6b9-db9c20e24c6e', 24, NULL, '제21장 « Un financier... Et un poète »', 'Scène XXI. « Un financier... Et un poète »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1029 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:416a9413-1497-4473-a6b9-db9c20e24c6e'
);


-- M. 53 가곡 <Sur l'herbe>

UPDATE pieces piece
SET piece.title = '가곡 <Sur l''herbe>', piece.title_en = 'Sur l''herbe',
    piece.type = 'song', piece.opus_number = 'M. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1907, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1717 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1907
WHERE piece.id = 1717 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 54 스페인 광시곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스페인 광시곡', 'Rapsodie espagnole', 'album', 'M. 54', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스페인 광시곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47889055-6fb8-4534-ae93-0047976de763'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47889055-6fb8-4534-ae93-0047976de763'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47889055-6fb8-4534-ae93-0047976de763'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2889 AND linked.composer_id = 52), 'musicbrainz:115ca3b9-e2dc-37f8-ad4b-13546e5c02e7', 1, 'I', '밤의 전주곡 (Prélude à la nuit)', 'I. Prélude à la nuit. Très modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:115ca3b9-e2dc-37f8-ad4b-13546e5c02e7'
);

UPDATE pieces piece
SET piece.title = '스페인 광시곡 중 "밤의 전주곡 (Prélude à la nuit)"', piece.title_en = 'Rapsodie espagnole: I. Prélude à la nuit. Très modéré', piece.editor_locked = 1
WHERE piece.id = 2889 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1447 AND linked.composer_id = 52), 'musicbrainz:d38881fd-f115-3fbb-bb89-c8d5f142be22', 2, 'II', '말라게냐 (Malagueña)', 'II. Malagueña. Assez vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d38881fd-f115-3fbb-bb89-c8d5f142be22'
);

UPDATE pieces piece
SET piece.title = '스페인 광시곡 중 "말라게냐 (Malagueña)"', piece.title_en = 'Rapsodie espagnole: II. Malagueña. Assez vif', piece.editor_locked = 1
WHERE piece.id = 1447 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1993 AND linked.composer_id = 52), 'musicbrainz:29dcb25b-eed0-381d-ba5b-1fdadb30b65b', 3, 'III', '하바네라 (Habanera)', 'III. Habanera. Assez lent et d''un rythme las', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29dcb25b-eed0-381d-ba5b-1fdadb30b65b'
);

UPDATE pieces piece
SET piece.title = '스페인 광시곡 중 "하바네라 (Habanera)"', piece.title_en = 'Rapsodie espagnole: III. Habanera. Assez lent et d''un rythme las', piece.editor_locked = 1
WHERE piece.id = 1993 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1252 AND linked.composer_id = 52), 'musicbrainz:e1d22d8c-91be-3a78-b918-ae2987178c0f', 4, 'IV', '축제 (Feria)', 'IV. Feria. Assez animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d22d8c-91be-3a78-b918-ae2987178c0f'
);

UPDATE pieces piece
SET piece.title = '스페인 광시곡 중 "축제 (Feria)"', piece.title_en = 'Rapsodie espagnole: IV. Feria. Assez animé', piece.editor_locked = 1
WHERE piece.id = 1252 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- M. 54a 스페인 광시곡 (두 대의 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스페인 광시곡 (두 대의 피아노)', 'Rapsodie espagnole (two pianos)', 'album', 'M. 54a', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스페인 광시곡 (두 대의 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b6d1d00-d966-45cc-ae63-07c530394dc1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b6d1d00-d966-45cc-ae63-07c530394dc1'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡 (두 대의 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b6d1d00-d966-45cc-ae63-07c530394dc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:526b35b1-88fe-485a-aacd-29c98f1f6398', 1, 'I', '밤의 전주곡 (Prélude à la nuit)', 'I. Prélude à la nuit. Très modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡 (두 대의 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:526b35b1-88fe-485a-aacd-29c98f1f6398'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d8e9639-771e-4e2f-bd3f-335fb3e4b0b4', 2, 'II', '말라게냐 (Malagueña)', 'II. Malagueña. Assez vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡 (두 대의 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d8e9639-771e-4e2f-bd3f-335fb3e4b0b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16b86c21-f95d-48b5-b188-9fdfff980610', 3, 'III', '하바네라 (Habanera)', 'III. Habanera. Assez lent et d''un rythme las', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡 (두 대의 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16b86c21-f95d-48b5-b188-9fdfff980610'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e99f4576-f846-4db9-858e-17c95d6dbce8', 4, 'IV', '축제 (Feria)', 'IV. Feria. Assez animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '스페인 광시곡 (두 대의 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e99f4576-f846-4db9-858e-17c95d6dbce8'
);


-- M. 55 <밤의 가스파르>

UPDATE pieces piece
SET piece.title = '<밤의 가스파르>', piece.title_en = 'Gaspard de la nuit',
    piece.type = 'album', piece.opus_number = 'M. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1908, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2849 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1908
WHERE piece.id = 2849 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '물의 요정 (Ondine)', part.name_en = 'I. Ondine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2849 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:e0b05037-708c-3a2f-83e5-25561e9e168d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0b05037-708c-3a2f-83e5-25561e9e168d', 1, 'I', '물의 요정 (Ondine)', 'I. Ondine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2849 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0b05037-708c-3a2f-83e5-25561e9e168d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '교수대 (Le Gibet)', part.name_en = 'II. Le Gibet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2849 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:56151945-72df-39a3-b9e1-e2c8c7fb6ce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56151945-72df-39a3-b9e1-e2c8c7fb6ce9', 2, 'II', '교수대 (Le Gibet)', 'II. Le Gibet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2849 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56151945-72df-39a3-b9e1-e2c8c7fb6ce9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '스카르보 (Scarbo)', part.name_en = 'III. Scarbo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2849 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:0733823f-530a-3da0-98a0-6d697b07474d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0733823f-530a-3da0-98a0-6d697b07474d', 3, 'III', '스카르보 (Scarbo)', 'III. Scarbo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2849 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0733823f-530a-3da0-98a0-6d697b07474d'
);


-- M. 57 발레 <다프니스와 클로에>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <다프니스와 클로에>', 'Daphnis et Chloé', 'song', 'M. 57', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <다프니스와 클로에>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a55d2dfe-fb81-42e8-9e0f-3e6fd9654ca1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a55d2dfe-fb81-42e8-9e0f-3e6fd9654ca1'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '발레 <다프니스와 클로에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a55d2dfe-fb81-42e8-9e0f-3e6fd9654ca1'
);


-- M. 57a 발레 <다프니스와 클로에> 모음곡 1번

UPDATE pieces piece
SET piece.title = '발레 <다프니스와 클로에> 모음곡 1번', piece.title_en = 'Daphnis et Chloé, Suite No. 1',
    piece.type = 'album', piece.opus_number = 'M. 57a',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1911, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 679 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1911
WHERE piece.id = 679 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '녹턴 (Nocturne)', part.name_en = 'I. Nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 679 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:0f926d9d-1467-49fd-b5f9-d654b2a89ba2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f926d9d-1467-49fd-b5f9-d654b2a89ba2', 1, 'I', '녹턴 (Nocturne)', 'I. Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 679 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f926d9d-1467-49fd-b5f9-d654b2a89ba2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '간주곡 (Interlude)', part.name_en = 'II. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 679 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:944b2e4f-ece4-4955-91db-85bc57ae6e00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:944b2e4f-ece4-4955-91db-85bc57ae6e00', 2, 'II', '간주곡 (Interlude)', 'II. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 679 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:944b2e4f-ece4-4955-91db-85bc57ae6e00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '전쟁의 춤 (Danse guerrière)', part.name_en = 'III. Danse guerrière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 679 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:b3634a9d-9b37-4196-97c1-829fedfceff6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3634a9d-9b37-4196-97c1-829fedfceff6', 3, 'III', '전쟁의 춤 (Danse guerrière)', 'III. Danse guerrière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 679 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3634a9d-9b37-4196-97c1-829fedfceff6'
);


-- M. 57b 발레 <다프니스와 클로에> 모음곡 2번

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '해돋이 (Lever du jour)', part.name_en = 'I. Lever du jour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 234 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:541b51e5-62e0-3f71-9a71-8810df700253' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:541b51e5-62e0-3f71-9a71-8810df700253', 1, 'I', '해돋이 (Lever du jour)', 'I. Lever du jour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 234 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:541b51e5-62e0-3f71-9a71-8810df700253'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '판토마임 (Pantomime)', part.name_en = 'II. Pantomime',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 234 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:e4744f8f-1ae5-3af2-a86a-7d0a321dba78' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4744f8f-1ae5-3af2-a86a-7d0a321dba78', 2, 'II', '판토마임 (Pantomime)', 'II. Pantomime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 234 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4744f8f-1ae5-3af2-a86a-7d0a321dba78'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '군무 (Danse générale)', part.name_en = 'III. Danse générale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 234 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:f789cb42-b7e3-30c5-8fac-a454b02b656f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f789cb42-b7e3-30c5-8fac-a454b02b656f', 3, 'III', '군무 (Danse générale)', 'III. Danse générale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 234 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f789cb42-b7e3-30c5-8fac-a454b02b656f'
);


-- M. 57c <다프니스와 클로에> 피아노 발췌곡

UPDATE pieces piece
SET piece.title = '<다프니스와 클로에> 피아노 발췌곡', piece.title_en = 'Danse gracieuse de Daphnis, suite (piano excerpts from Daphnis et Chloé)',
    piece.type = 'album', piece.opus_number = 'M. 57c',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2050 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 2050 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2494 AND linked.composer_id = 52),
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '다프니스의 우아하고 가벼운 춤 (Danse gracieuse et légère de Daphnis)', part.name_en = 'Danse gracieuse et légère de Daphnis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2050 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:95e60fb3-a364-4744-abcc-4a2370b5ecf4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2494 AND linked.composer_id = 52), 'musicbrainz:95e60fb3-a364-4744-abcc-4a2370b5ecf4', 1, NULL, '다프니스의 우아하고 가벼운 춤 (Danse gracieuse et légère de Daphnis)', 'Danse gracieuse et légère de Daphnis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2050 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95e60fb3-a364-4744-abcc-4a2370b5ecf4'
);

UPDATE pieces piece
SET piece.title = '<다프니스와 클로에> 피아노 발췌곡 중 "다프니스의 우아하고 가벼운 춤 (Danse gracieuse et légère de Daphnis)"', piece.title_en = 'Danse gracieuse de Daphnis, suite (piano excerpts from Daphnis et Chloé): Danse gracieuse et légère de Daphnis', piece.editor_locked = 1
WHERE piece.id = 2494 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2383 AND linked.composer_id = 52),
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '녹턴, 간주곡과 전쟁의 춤 (Nocturne, Interlude et Danse guerrière)', part.name_en = 'Nocturne – Interlude – Danse guerrière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2050 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:ee3ae507-1d24-4c48-9754-9091de434913' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2383 AND linked.composer_id = 52), 'musicbrainz:ee3ae507-1d24-4c48-9754-9091de434913', 2, NULL, '녹턴, 간주곡과 전쟁의 춤 (Nocturne, Interlude et Danse guerrière)', 'Nocturne – Interlude – Danse guerrière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2050 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee3ae507-1d24-4c48-9754-9091de434913'
);

UPDATE pieces piece
SET piece.title = '<다프니스와 클로에> 피아노 발췌곡 중 "녹턴, 간주곡과 전쟁의 춤 (Nocturne, Interlude et Danse guerrière)"', piece.title_en = 'Danse gracieuse de Daphnis, suite (piano excerpts from Daphnis et Chloé): Nocturne – Interlude – Danse guerrière', piece.editor_locked = 1
WHERE piece.id = 2383 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2832 AND linked.composer_id = 52),
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '다프니스와 클로에의 장면 (Scène de Daphnis et Chloé)', part.name_en = 'Scène de Daphnis et Chloé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2050 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:51e993bc-a3ab-4196-9915-e3555bccdaa7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 2832 AND linked.composer_id = 52), 'musicbrainz:51e993bc-a3ab-4196-9915-e3555bccdaa7', 3, NULL, '다프니스와 클로에의 장면 (Scène de Daphnis et Chloé)', 'Scène de Daphnis et Chloé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2050 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51e993bc-a3ab-4196-9915-e3555bccdaa7'
);

UPDATE pieces piece
SET piece.title = '<다프니스와 클로에> 피아노 발췌곡 중 "다프니스와 클로에의 장면 (Scène de Daphnis et Chloé)"', piece.title_en = 'Danse gracieuse de Daphnis, suite (piano excerpts from Daphnis et Chloé): Scène de Daphnis et Chloé', piece.editor_locked = 1
WHERE piece.id = 2832 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- M. 57d 발레 <다프니스와 클로에> (피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <다프니스와 클로에> (피아노)', 'Daphnis et Chloé (piano version of the ballet)', 'song', 'M. 57d', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <다프니스와 클로에> (피아노)'
);


-- M. 58 하이든 이름에 의한 미뉴에트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하이든 이름에 의한 미뉴에트', 'Menuet sur le nom d''Haydn', 'song', 'M. 58', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하이든 이름에 의한 미뉴에트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dc0574e-a8c3-3206-b1c0-2015c1430eb2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1dc0574e-a8c3-3206-b1c0-2015c1430eb2'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '하이든 이름에 의한 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dc0574e-a8c3-3206-b1c0-2015c1430eb2'
);


-- M. 60 <어미 거위> (네 손 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<어미 거위> (네 손 피아노)', 'Ma mère l''Oye, five children''s pieces for piano four hands', 'album', 'M. 60', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<어미 거위> (네 손 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '698a7f3c-7472-487b-a9de-e6f3affc7a30'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '698a7f3c-7472-487b-a9de-e6f3affc7a30'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<어미 거위> (네 손 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '698a7f3c-7472-487b-a9de-e6f3affc7a30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c1ad613-cba2-35e7-a7c6-def224319521', 1, 'I', '잠자는 숲속 미녀의 파반느 (Pavane de la Belle au bois dormant)', 'I. Pavane de la Belle au bois dormant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<어미 거위> (네 손 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c1ad613-cba2-35e7-a7c6-def224319521'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:587770a3-f455-3817-90e5-10c3da2a1352', 2, 'II', '엄지 동자 (Petit Poucet)', 'II. Petit Poucet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<어미 거위> (네 손 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:587770a3-f455-3817-90e5-10c3da2a1352'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d75bd010-1d33-331c-b8f4-b082fb87689f', 3, 'III', '파고다의 여왕 레드로네트 (Laideronnette, impératrice des pagodes)', 'III. Laideronnette, impératrice des pagodes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<어미 거위> (네 손 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d75bd010-1d33-331c-b8f4-b082fb87689f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71ffc02d-c3e7-36cf-a4fd-63418da9407e', 4, 'IV', '미녀와 야수의 대화 (Les Entretiens de la Belle et de la Bête)', 'IV. Les Entretiens de la Belle et de la Bête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<어미 거위> (네 손 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71ffc02d-c3e7-36cf-a4fd-63418da9407e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb8950e0-6e01-311c-8cb8-b19ccad4a8f4', 5, 'V', '요정의 정원 (Le Jardin féerique)', 'V. Le Jardin féerique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<어미 거위> (네 손 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb8950e0-6e01-311c-8cb8-b19ccad4a8f4'
);


-- M. 60a <어미 거위> 모음곡

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '잠자는 숲속 미녀의 파반느 (Pavane de la Belle au bois dormant)', part.name_en = 'I. Pavane de la Belle au bois dormant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26037 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:c5777e2c-b592-48e5-b8cc-1a8b3defd7da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5777e2c-b592-48e5-b8cc-1a8b3defd7da', 1, 'I', '잠자는 숲속 미녀의 파반느 (Pavane de la Belle au bois dormant)', 'I. Pavane de la Belle au bois dormant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26037 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5777e2c-b592-48e5-b8cc-1a8b3defd7da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '엄지 동자 (Petit Poucet)', part.name_en = 'II. Petit Poucet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26037 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:0e6acb22-8251-48a8-9032-68e76a047edf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e6acb22-8251-48a8-9032-68e76a047edf', 2, 'II', '엄지 동자 (Petit Poucet)', 'II. Petit Poucet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26037 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e6acb22-8251-48a8-9032-68e76a047edf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '파고다의 여왕 레드로네트 (Laideronnette, impératrice des pagodes)', part.name_en = 'III. Laideronnette, impératrice des pagodes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26037 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:a155e1f1-fc7e-4c7c-8cf3-19c3c20671b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a155e1f1-fc7e-4c7c-8cf3-19c3c20671b3', 3, 'III', '파고다의 여왕 레드로네트 (Laideronnette, impératrice des pagodes)', 'III. Laideronnette, impératrice des pagodes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26037 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a155e1f1-fc7e-4c7c-8cf3-19c3c20671b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '미녀와 야수의 대화 (Les Entretiens de la Belle et de la Bête)', part.name_en = 'IV. Les Entretiens de la Belle et de la Bête',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26037 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:b7ee1bb6-a288-4f8c-97eb-3114bf25bcfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7ee1bb6-a288-4f8c-97eb-3114bf25bcfa', 4, 'IV', '미녀와 야수의 대화 (Les Entretiens de la Belle et de la Bête)', 'IV. Les Entretiens de la Belle et de la Bête', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26037 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7ee1bb6-a288-4f8c-97eb-3114bf25bcfa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1062 AND linked.composer_id = 52),
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = '요정의 정원 (Le Jardin féerique)', part.name_en = 'V. Le Jardin féerique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26037 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:3d287fde-4b60-44ac-ac49-14f22fc2f02b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1062 AND linked.composer_id = 52), 'musicbrainz:3d287fde-4b60-44ac-ac49-14f22fc2f02b', 5, 'V', '요정의 정원 (Le Jardin féerique)', 'V. Le Jardin féerique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26037 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d287fde-4b60-44ac-ac49-14f22fc2f02b'
);

UPDATE pieces piece
SET piece.title = '<어미 거위> 모음곡 중 "요정의 정원 (Le Jardin féerique)"', piece.title_en = 'Ma mère l''Oye, suite for orchestra: V. Le Jardin féerique', piece.editor_locked = 1
WHERE piece.id = 1062 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- M. 61 <고귀하고 감상적인 왈츠>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<고귀하고 감상적인 왈츠>', 'Valses nobles et sentimentales', 'album', 'M. 61', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<고귀하고 감상적인 왈츠>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '96b050d7-9778-4c98-821e-3f0a3eaac34e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '96b050d7-9778-4c98-821e-3f0a3eaac34e'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '96b050d7-9778-4c98-821e-3f0a3eaac34e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21964781-d592-337b-8939-22c9ec275a46', 1, 'I', 'Modéré – Très franc', 'I. Modéré – Très franc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21964781-d592-337b-8939-22c9ec275a46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:800e0b1b-eee1-3a23-a6b9-95fb5732a79b', 2, 'II', 'Assez lent', 'II. Assez lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:800e0b1b-eee1-3a23-a6b9-95fb5732a79b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc963095-b275-3e8d-9de7-e3e9f41d2690', 3, 'III', 'Modéré', 'III. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc963095-b275-3e8d-9de7-e3e9f41d2690'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8d64307-a077-3aa7-b70c-f22d938e5c80', 4, 'IV', 'Assez animé', 'IV. Assez animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8d64307-a077-3aa7-b70c-f22d938e5c80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:100615fa-e95c-39cb-8943-885aad11dd5a', 5, 'V', 'Presque lent', 'V. Presque lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:100615fa-e95c-39cb-8943-885aad11dd5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:444a0408-0af9-3701-80b7-0ecaffe1f2ee', 6, 'VI', 'Vif', 'VI. Vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:444a0408-0af9-3701-80b7-0ecaffe1f2ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0def1d08-d323-3ec0-9411-ff475191f6a1', 7, 'VII', 'Moins vif', 'VII. Moins vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0def1d08-d323-3ec0-9411-ff475191f6a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:955dc200-f05d-3501-bf56-823c36fd1092', 8, 'VIII', '에필로그. Lent', 'VIII. Épilogue. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:955dc200-f05d-3501-bf56-823c36fd1092'
);


-- M. 61a <고귀하고 감상적인 왈츠> (관현악)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<고귀하고 감상적인 왈츠> (관현악)', 'Valses nobles et sentimentales, orchestral version (ballet Adélaïde ou le langage des fleurs)', 'album', 'M. 61a', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<고귀하고 감상적인 왈츠> (관현악)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b504fc06-60c3-4ba1-b315-bcf90c1b1d90'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b504fc06-60c3-4ba1-b315-bcf90c1b1d90'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b504fc06-60c3-4ba1-b315-bcf90c1b1d90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15bc3c8d-9727-39b0-9a48-f03781d71301', 1, 'I', 'Modéré', 'I. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15bc3c8d-9727-39b0-9a48-f03781d71301'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28025e69-0574-3f23-8adc-5158c0eb37b0', 2, 'II', 'Assez lent', 'II. Assez lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28025e69-0574-3f23-8adc-5158c0eb37b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:579e0a79-6f80-32a9-897c-df6e2a650667', 3, 'III', 'Modéré', 'III. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:579e0a79-6f80-32a9-897c-df6e2a650667'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ed17ceb-377d-33c7-a566-79e85e755b17', 4, 'IV', 'Animé', 'IV. Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ed17ceb-377d-33c7-a566-79e85e755b17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03d72d72-a91d-399f-8528-18d27a6ceff4', 5, 'V', 'Presque lent', 'V. Presque lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d72d72-a91d-399f-8528-18d27a6ceff4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d92f598-e940-36ca-869d-9c1804cab5cd', 6, 'VI', 'Assez vif', 'VI. Assez vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d92f598-e940-36ca-869d-9c1804cab5cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d0b17ae-32e5-3229-9983-5aa9dff76e06', 7, 'VII', 'Moins vif', 'VII. Moins vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d0b17ae-32e5-3229-9983-5aa9dff76e06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b78d33ae-35e6-33a7-b444-eca5f20380fd', 8, 'VIII', '에필로그. Lent', 'VIII. Épilogue. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<고귀하고 감상적인 왈츠> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b78d33ae-35e6-33a7-b444-eca5f20380fd'
);


-- M. 62 발레 <어미 거위>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <어미 거위>', 'Ma mère l''Oye, ballet', 'song', 'M. 62', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <어미 거위>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a638901c-f094-4d20-967e-5e0ad8ab52a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a638901c-f094-4d20-967e-5e0ad8ab52a3'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '발레 <어미 거위>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a638901c-f094-4d20-967e-5e0ad8ab52a3'
);


-- M. 63 피아노곡 <À la manière de…>

UPDATE pieces piece
SET piece.title = '피아노곡 <À la manière de…>', piece.title_en = 'À la manière de…',
    piece.type = 'album', piece.opus_number = 'M. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2631 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 2631 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'À la manière de Borodine (왈츠)', part.name_en = 'À la manière de Borodine (Valse)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2631 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:0df7e921-d63f-3e76-a08a-48310f3f7e79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0df7e921-d63f-3e76-a08a-48310f3f7e79', 1, NULL, 'À la manière de Borodine (왈츠)', 'À la manière de Borodine (Valse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2631 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0df7e921-d63f-3e76-a08a-48310f3f7e79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'À la manière de Chabrier', part.name_en = 'À la manière de Chabrier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2631 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:916ca26f-bff6-3f7f-8f30-00e53c5c108e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:916ca26f-bff6-3f7f-8f30-00e53c5c108e', 2, NULL, 'À la manière de Chabrier', 'À la manière de Chabrier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2631 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:916ca26f-bff6-3f7f-8f30-00e53c5c108e'
);


-- M. 64 가곡집 <스테판 말라르메의 시 3편>

UPDATE pieces piece
SET piece.title = '가곡집 <스테판 말라르메의 시 3편>', piece.title_en = 'Trois poèmes de Stéphane Mallarmé',
    piece.type = 'album', piece.opus_number = 'M. 64',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 724 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 724 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Soupir', part.name_en = 'Soupir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 724 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:180dd3a6-6611-4996-8189-af0516264c49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:180dd3a6-6611-4996-8189-af0516264c49', 1, NULL, 'Soupir', 'Soupir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 724 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:180dd3a6-6611-4996-8189-af0516264c49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Placet futile', part.name_en = 'Placet futile',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 724 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:3dac4c43-2fb9-4dbd-972b-1ef24408f153' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dac4c43-2fb9-4dbd-972b-1ef24408f153', 2, NULL, 'Placet futile', 'Placet futile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 724 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dac4c43-2fb9-4dbd-972b-1ef24408f153'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Surgi de la croupe et du bond', part.name_en = 'Surgi de la croupe et du bond',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 724 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:f001830e-b1ad-4fb9-b482-818dda0e61b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f001830e-b1ad-4fb9-b482-818dda0e61b1', 3, NULL, 'Surgi de la croupe et du bond', 'Surgi de la croupe et du bond', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 724 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f001830e-b1ad-4fb9-b482-818dda0e61b1'
);


-- M. 64a 가곡집 <스테판 말라르메의 시 3편> (목소리와 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <스테판 말라르메의 시 3편> (목소리와 피아노)', 'Trois poèmes de Stéphane Mallarmé (voice and piano)', 'album', 'M. 64a', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <스테판 말라르메의 시 3편> (목소리와 피아노)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m064a:1', 1, NULL, 'Soupir', 'Soupir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <스테판 말라르메의 시 3편> (목소리와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m064a:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m064a:2', 2, NULL, 'Placet futile', 'Placet futile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <스테판 말라르메의 시 3편> (목소리와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m064a:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m064a:3', 3, NULL, 'Surgi de la croupe et du bond', 'Surgi de la croupe et du bond', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <스테판 말라르메의 시 3편> (목소리와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m064a:3'
);


-- M. 65 전주곡 A단조

UPDATE pieces piece
SET piece.title = '전주곡 A단조', piece.title_en = 'Prélude in A minor',
    piece.type = 'song', piece.opus_number = 'M. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1913, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2400 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1913
WHERE piece.id = 2400 AND piece.composer_id = 52 AND piece.composition_year IS NULL;
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8753434f-e6b8-374e-8e77-8b2ec278164d'
FROM pieces p
WHERE p.id = 2400 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8753434f-e6b8-374e-8e77-8b2ec278164d'
);


-- M. 67 피아노 3중주 A단조

UPDATE pieces piece
SET piece.title = '피아노 3중주 A단조', piece.title_en = 'Piano Trio in A minor',
    piece.type = 'album', piece.opus_number = 'M. 67',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1914, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 611 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1914
WHERE piece.id = 611 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Modéré', part.name_en = 'I. Modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 611 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:2f479288-4f5f-3526-b2ba-c3d116eb4b9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f479288-4f5f-3526-b2ba-c3d116eb4b9c', 1, 'I', 'Modéré', 'I. Modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 611 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f479288-4f5f-3526-b2ba-c3d116eb4b9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '판툼. Assez vif', part.name_en = 'II. Pantoum. Assez vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 611 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:0fda678d-5901-3892-bcf4-3123c8a4a513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fda678d-5901-3892-bcf4-3123c8a4a513', 2, 'II', '판툼. Assez vif', 'II. Pantoum. Assez vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 611 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fda678d-5901-3892-bcf4-3123c8a4a513'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '파사칼리아. Très large', part.name_en = 'III. Passacaille. Très large',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 611 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:b25def56-dbb1-3ad0-bfc3-8d0c683c6159' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b25def56-dbb1-3ad0-bfc3-8d0c683c6159', 3, 'III', '파사칼리아. Très large', 'III. Passacaille. Très large', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 611 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b25def56-dbb1-3ad0-bfc3-8d0c683c6159'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '피날레. Animé', part.name_en = 'IV. Final. Animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 611 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:67f8fcf2-287f-3486-b490-11918e156e5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f8fcf2-287f-3486-b490-11918e156e5c', 4, 'IV', '피날레. Animé', 'IV. Final. Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 611 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f8fcf2-287f-3486-b490-11918e156e5c'
);


-- M. 68 <쿠프랭의 무덤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<쿠프랭의 무덤>', 'Le Tombeau de Couperin', 'album', 'M. 68', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<쿠프랭의 무덤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2443b5bb-ed33-3acd-b8a1-3700eefa5efd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2443b5bb-ed33-3acd-b8a1-3700eefa5efd'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2443b5bb-ed33-3acd-b8a1-3700eefa5efd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8a2445b-755a-3d7d-a301-1707c10f6fa4', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8a2445b-755a-3d7d-a301-1707c10f6fa4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f7ba7a4-8d86-3eea-9b7c-80d8ad7e50c2', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f7ba7a4-8d86-3eea-9b7c-80d8ad7e50c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a97a182-a337-3e50-ac59-501022874846', 3, 'III', '포를란', 'III. Forlane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a97a182-a337-3e50-ac59-501022874846'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c90b1726-da00-31fb-9c8f-6c7e510169e7', 4, 'IV', '리고동', 'IV. Rigaudon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c90b1726-da00-31fb-9c8f-6c7e510169e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da19835a-9905-3ca8-8f1f-0dc0b1670e51', 5, 'V', '미뉴에트', 'V. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da19835a-9905-3ca8-8f1f-0dc0b1670e51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51843b0d-21c1-3960-9cc5-6b7892975135', 6, 'VI', '토카타', 'VI. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51843b0d-21c1-3960-9cc5-6b7892975135'
);


-- M. 68a <쿠프랭의 무덤> (관현악)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<쿠프랭의 무덤> (관현악)', 'Le Tombeau de Couperin (orchestral version)', 'album', 'M. 68a', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<쿠프랭의 무덤> (관현악)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db3d1dec-edc6-496f-8dfe-63d1036da7a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db3d1dec-edc6-496f-8dfe-63d1036da7a2'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db3d1dec-edc6-496f-8dfe-63d1036da7a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7813419d-5009-3603-b3e4-528d2d0f281d', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7813419d-5009-3603-b3e4-528d2d0f281d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d2adc7c-4aaa-3e8f-8272-6fe4d6890934', 2, 'II', '포를란', 'II. Forlane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d2adc7c-4aaa-3e8f-8272-6fe4d6890934'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bddbd47-7e36-35e0-a3dd-579a939737e9', 3, 'III', '미뉴에트', 'III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bddbd47-7e36-35e0-a3dd-579a939737e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5484f1d4-e67a-3122-9a7c-dc833fef3958', 4, 'IV', '리고동', 'IV. Rigaudon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<쿠프랭의 무덤> (관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5484f1d4-e67a-3122-9a7c-dc833fef3958'
);


-- M. 69 무반주 합창을 위한 <세 개의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 합창을 위한 <세 개의 노래>', 'Trois chansons, for unaccompanied mixed choir', 'album', 'M. 69', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 합창을 위한 <세 개의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ec740c3-070c-4aa8-a959-8b592bc9a253'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ec740c3-070c-4aa8-a959-8b592bc9a253'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '무반주 합창을 위한 <세 개의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ec740c3-070c-4aa8-a959-8b592bc9a253'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d69ea73a-7caa-44bf-827d-96c8cf34050f', 1, NULL, 'Nicolette', 'Nicolette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '무반주 합창을 위한 <세 개의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d69ea73a-7caa-44bf-827d-96c8cf34050f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adeb1773-c4bd-49be-bacd-b0fc775d721e', 2, NULL, 'Trois beaux oiseaux du paradis', 'Trois beaux oiseaux du paradis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '무반주 합창을 위한 <세 개의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adeb1773-c4bd-49be-bacd-b0fc775d721e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ee3bbcd-fc8e-439f-bcbd-9597acc2b25f', 3, NULL, 'Ronde', 'Ronde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '무반주 합창을 위한 <세 개의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ee3bbcd-fc8e-439f-bcbd-9597acc2b25f'
);


-- M. 69a <세 개의 노래> (목소리와 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<세 개의 노래> (목소리와 피아노)', 'Trois chansons (voice and piano)', 'album', 'M. 69a', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<세 개의 노래> (목소리와 피아노)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m069a:1', 1, NULL, 'Nicolette', 'Nicolette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<세 개의 노래> (목소리와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m069a:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m069a:2', 2, NULL, 'Trois beaux oiseaux du paradis', 'Trois beaux oiseaux du paradis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<세 개의 노래> (목소리와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m069a:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m069a:3', 3, NULL, 'Ronde', 'Ronde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<세 개의 노래> (목소리와 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m069a:3'
);


-- M. 70 두 대의 피아노 다섯 손을 위한 <Frontispice>

UPDATE pieces piece
SET piece.title = '두 대의 피아노 다섯 손을 위한 <Frontispice>', piece.title_en = 'Frontispice, for two pianos five hands',
    piece.type = 'song', piece.opus_number = 'M. 70',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1918, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 534 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1918
WHERE piece.id = 534 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 71 오페라 <어린이와 마법>

UPDATE pieces piece
SET piece.opus_number = 'M. 71'
WHERE piece.id = 484 AND piece.composer_id = 52
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1925
WHERE piece.id = 484 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '제1부', part.name_en = 'Première partie (Tableau I)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715', 1, NULL, '제1부', 'Première partie (Tableau I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '« J''ai pas envie de faire ma page ! »', part.name_en = '« J''ai pas envie de faire ma page ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:66ca8819-14b2-4590-889e-054a4a791f07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:66ca8819-14b2-4590-889e-054a4a791f07', 1, NULL, '« J''ai pas envie de faire ma page ! »', '« J''ai pas envie de faire ma page ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ca8819-14b2-4590-889e-054a4a791f07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '« Bébé a été sage ? »', part.name_en = '« Bébé a été sage ? »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:926b9b48-8806-4183-9616-a4fcb24d8cc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:926b9b48-8806-4183-9616-a4fcb24d8cc7', 2, NULL, '« Bébé a été sage ? »', '« Bébé a été sage ? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:926b9b48-8806-4183-9616-a4fcb24d8cc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '« Ça m''est égal ! »', part.name_en = '« Ça m''est égal ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:28fe8e9f-a422-4702-86fd-2e684132eb15' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28fe8e9f-a422-4702-86fd-2e684132eb15', 3, NULL, '« Ça m''est égal ! »', '« Ça m''est égal ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28fe8e9f-a422-4702-86fd-2e684132eb15'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '« Votre serviteur humble, Bergère »', part.name_en = '« Votre serviteur humble, Bergère »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:e4fc73ac-cb2a-4f1b-9f76-97a126f64897' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4fc73ac-cb2a-4f1b-9f76-97a126f64897', 4, NULL, '« Votre serviteur humble, Bergère »', '« Votre serviteur humble, Bergère »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4fc73ac-cb2a-4f1b-9f76-97a126f64897'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '« Ding, ding, ding, ding »', part.name_en = '« Ding, ding, ding, ding »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:83cca0d4-ed23-47c4-b181-1500d91c969c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:83cca0d4-ed23-47c4-b181-1500d91c969c', 5, NULL, '« Ding, ding, ding, ding »', '« Ding, ding, ding, ding »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83cca0d4-ed23-47c4-b181-1500d91c969c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 8174 AND linked.composer_id = 52),
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '« How''s your mug? »', part.name_en = '« How''s your mug? »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:fb43abd7-b117-4462-899b-703d4c08764b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 8174 AND linked.composer_id = 52), 'musicbrainz:fb43abd7-b117-4462-899b-703d4c08764b', 6, NULL, '« How''s your mug? »', '« How''s your mug? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb43abd7-b117-4462-899b-703d4c08764b'
);

UPDATE pieces piece
SET piece.title = '오페라 <어린이와 마법> 제1부 중 "« How''s your mug? »"', piece.title_en = 'L''Enfant et les sortilèges, fantaisie lyrique, Première partie (Tableau I): « How''s your mug? »', piece.editor_locked = 1
WHERE piece.id = 8174 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '« Keng-ça-fou, mah-jong »', part.name_en = '« Keng-ça-fou, mah-jong »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:06b666a8-7bc9-4347-b946-b137b8960c9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06b666a8-7bc9-4347-b946-b137b8960c9d', 7, NULL, '« Keng-ça-fou, mah-jong »', '« Keng-ça-fou, mah-jong »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b666a8-7bc9-4347-b946-b137b8960c9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '« Oh ! Ma belle tasse chinoise ! »', part.name_en = '« Oh ! Ma belle tasse chinoise ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:eeb2dc1c-9939-44a8-acc0-19992aa7635c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eeb2dc1c-9939-44a8-acc0-19992aa7635c', 8, NULL, '« Oh ! Ma belle tasse chinoise ! »', '« Oh ! Ma belle tasse chinoise ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeb2dc1c-9939-44a8-acc0-19992aa7635c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '« Arrière ! Je réchauffe les bons »', part.name_en = '« Arrière ! Je réchauffe les bons »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:0226a868-7e4a-4f42-9b26-5ad8baf4ea97' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0226a868-7e4a-4f42-9b26-5ad8baf4ea97', 9, NULL, '« Arrière ! Je réchauffe les bons »', '« Arrière ! Je réchauffe les bons »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0226a868-7e4a-4f42-9b26-5ad8baf4ea97'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '« Adieu, pastourelles ! »', part.name_en = '« Adieu, pastourelles ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:ce7dc38d-d71c-441d-88d1-fe8994d02e52' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce7dc38d-d71c-441d-88d1-fe8994d02e52', 10, NULL, '« Adieu, pastourelles ! »', '« Adieu, pastourelles ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce7dc38d-d71c-441d-88d1-fe8994d02e52'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '« Ah ! C''est elle ! C''est elle ! »', part.name_en = '« Ah ! C''est elle ! C''est elle ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:8c66cfc0-3253-4b2e-bf20-6720c3b7844c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c66cfc0-3253-4b2e-bf20-6720c3b7844c', 11, NULL, '« Ah ! C''est elle ! C''est elle ! »', '« Ah ! C''est elle ! C''est elle ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c66cfc0-3253-4b2e-bf20-6720c3b7844c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 1897 AND linked.composer_id = 52),
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '« Toi, le cœur de la rose »', part.name_en = '« Toi, le cœur de la rose »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:f86c9502-1d4f-4d71-862f-a48ab1795064' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 1897 AND linked.composer_id = 52), 'musicbrainz:f86c9502-1d4f-4d71-862f-a48ab1795064', 12, NULL, '« Toi, le cœur de la rose »', '« Toi, le cœur de la rose »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f86c9502-1d4f-4d71-862f-a48ab1795064'
);

UPDATE pieces piece
SET piece.title = '오페라 <어린이와 마법> 제1부 중 "« Toi, le cœur de la rose »"', piece.title_en = 'L''Enfant et les sortilèges, fantaisie lyrique, Première partie (Tableau I): « Toi, le cœur de la rose »', piece.editor_locked = 1
WHERE piece.id = 1897 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = '« Deux robinets coulent dans un réservoir ! »', part.name_en = '« Deux robinets coulent dans un réservoir ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:760895ef-30ed-44aa-b73b-08d1ad4d32e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:760895ef-30ed-44aa-b73b-08d1ad4d32e2', 13, NULL, '« Deux robinets coulent dans un réservoir ! »', '« Deux robinets coulent dans un réservoir ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:760895ef-30ed-44aa-b73b-08d1ad4d32e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '« Oh ! Ma tête ! »', part.name_en = '« Oh ! Ma tête ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:6e90e74c-9f70-4a79-9759-5ebe18d1958c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e90e74c-9f70-4a79-9759-5ebe18d1958c', 14, NULL, '« Oh ! Ma tête ! »', '« Oh ! Ma tête ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e90e74c-9f70-4a79-9759-5ebe18d1958c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '« Duo miaulé »', part.name_en = '« Duo miaulé »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:fc62bef4-edb4-4831-aabd-250c4d7ed1cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc62bef4-edb4-4831-aabd-250c4d7ed1cb', 15, NULL, '« Duo miaulé »', '« Duo miaulé »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:93ae1b2f-cef9-4584-8f9f-680e1dfac715'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc62bef4-edb4-4831-aabd-250c4d7ed1cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '제2부', part.name_en = 'Seconde partie (Tableau II)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf', 2, NULL, '제2부', 'Seconde partie (Tableau II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '« Musique d''insectes, de rainettes, etc. »', part.name_en = '« Musique d''insectes, de rainettes, etc. »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:de900cff-18fa-48c5-b05b-5fbf6d9b87bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de900cff-18fa-48c5-b05b-5fbf6d9b87bf', 1, NULL, '« Musique d''insectes, de rainettes, etc. »', '« Musique d''insectes, de rainettes, etc. »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de900cff-18fa-48c5-b05b-5fbf6d9b87bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '« Ah ! Quelle joie de te retrouver, Jardin ! »', part.name_en = '« Ah ! Quelle joie de te retrouver, Jardin ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:d41b046d-8f1d-42e8-885d-d5afa4b3bc74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d41b046d-8f1d-42e8-885d-d5afa4b3bc74', 2, NULL, '« Ah ! Quelle joie de te retrouver, Jardin ! »', '« Ah ! Quelle joie de te retrouver, Jardin ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d41b046d-8f1d-42e8-885d-d5afa4b3bc74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '« Où es-tu ? Je te cherche... »', part.name_en = '« Où es-tu ? Je te cherche... »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:8603a2a3-7250-4e6d-81f1-188877a21f84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8603a2a3-7250-4e6d-81f1-188877a21f84', 3, NULL, '« Où es-tu ? Je te cherche... »', '« Où es-tu ? Je te cherche... »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8603a2a3-7250-4e6d-81f1-188877a21f84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Ronde des chauves-souris : « Rends-la moi... Tsk, Tsk... »', part.name_en = 'Ronde des chauves-souris : « Rends-la moi... Tsk, Tsk... »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:e805b57a-748d-490e-bc1f-1f5ada059829' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e805b57a-748d-490e-bc1f-1f5ada059829', 4, NULL, 'Ronde des chauves-souris : « Rends-la moi... Tsk, Tsk... »', 'Ronde des chauves-souris : « Rends-la moi... Tsk, Tsk... »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e805b57a-748d-490e-bc1f-1f5ada059829'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '« Danse des rainettes »', part.name_en = '« Danse des rainettes »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:88216478-78a1-4a49-93e7-490301000ce9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88216478-78a1-4a49-93e7-490301000ce9', 5, NULL, '« Danse des rainettes »', '« Danse des rainettes »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88216478-78a1-4a49-93e7-490301000ce9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '« Ké ké ké ké ké Côâc »', part.name_en = '« Ké ké ké ké ké Côâc »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:3ba945d4-fe07-4c3d-b6e4-490920de04f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3ba945d4-fe07-4c3d-b6e4-490920de04f3', 6, NULL, '« Ké ké ké ké ké Côâc »', '« Ké ké ké ké ké Côâc »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ba945d4-fe07-4c3d-b6e4-490920de04f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '« Sauve-toi, sotte ! Et la cage ? La cage ? »', part.name_en = '« Sauve-toi, sotte ! Et la cage ? La cage ? »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:69175699-18f6-442c-83e8-765f0d6b7b65' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69175699-18f6-442c-83e8-765f0d6b7b65', 7, NULL, '« Sauve-toi, sotte ! Et la cage ? La cage ? »', '« Sauve-toi, sotte ! Et la cage ? La cage ? »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69175699-18f6-442c-83e8-765f0d6b7b65'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '« La cage, c''était pour mieux voir ta prestesse »', part.name_en = '« La cage, c''était pour mieux voir ta prestesse »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:de12fcb2-fdca-45c3-9bfc-937226645fdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de12fcb2-fdca-45c3-9bfc-937226645fdd', 8, NULL, '« La cage, c''était pour mieux voir ta prestesse »', '« La cage, c''était pour mieux voir ta prestesse »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de12fcb2-fdca-45c3-9bfc-937226645fdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '« Ah ! C''est l''enfant au couteau ! »', part.name_en = '« Ah ! C''est l''enfant au couteau ! »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:7f9b51af-9d7d-41f6-b14f-5805cb6c2a17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f9b51af-9d7d-41f6-b14f-5805cb6c2a17', 9, NULL, '« Ah ! C''est l''enfant au couteau ! »', '« Ah ! C''est l''enfant au couteau ! »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f9b51af-9d7d-41f6-b14f-5805cb6c2a17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '« Il a pansé la plaie... »', part.name_en = '« Il a pansé la plaie... »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1e4e7be5-ac3f-43e7-959f-b85a8b633e05' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e4e7be5-ac3f-43e7-959f-b85a8b633e05', 10, NULL, '« Il a pansé la plaie... »', '« Il a pansé la plaie... »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e4e7be5-ac3f-43e7-959f-b85a8b633e05'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '« Il est bon, l''enfant, il est sage »', part.name_en = '« Il est bon, l''enfant, il est sage »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 484 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1f440415-668a-4a86-ab33-6fce023aad8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1f440415-668a-4a86-ab33-6fce023aad8a', 11, NULL, '« Il est bon, l''enfant, il est sage »', '« Il est bon, l''enfant, il est sage »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:61893b44-d156-42ab-881a-04420f330eaf'
WHERE p.id = 484 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f440415-668a-4a86-ab33-6fce023aad8a'
);


-- M. 72 <라 발스>

UPDATE pieces piece
SET piece.title = '<라 발스>', piece.title_en = 'La Valse, poème chorégraphique',
    piece.type = 'song', piece.opus_number = 'M. 72',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1920, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1538 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1920
WHERE piece.id = 1538 AND piece.composer_id = 52 AND piece.composition_year IS NULL;
INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '698cf12e-ea7f-3271-91f4-41a7edc4bbed'
FROM pieces p
WHERE p.id = 1538 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '698cf12e-ea7f-3271-91f4-41a7edc4bbed'
);


-- M. 72a <라 발스> (두 대의 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<라 발스> (두 대의 피아노)', 'La Valse (two pianos)', 'song', 'M. 72a', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<라 발스> (두 대의 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '074284a9-9251-4e83-9673-cd8a3fed1792'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '074284a9-9251-4e83-9673-cd8a3fed1792'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<라 발스> (두 대의 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '074284a9-9251-4e83-9673-cd8a3fed1792'
);


-- M. 72b <라 발스> (피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<라 발스> (피아노)', 'La Valse (piano)', 'song', 'M. 72b', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<라 발스> (피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9dd33df8-3293-4b4a-a74b-13ed64c28cdd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9dd33df8-3293-4b4a-a74b-13ed64c28cdd'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<라 발스> (피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9dd33df8-3293-4b4a-a74b-13ed64c28cdd'
);


-- M. 73 바이올린과 첼로를 위한 소나타 A단조

UPDATE pieces piece
SET piece.catalogue_system = 'M.', piece.catalogue_number = '73'
WHERE piece.id = 470 AND piece.composer_id = 52
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1922
WHERE piece.id = 470 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 470 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:a407b326-753f-466c-ac59-050fd0609c76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a407b326-753f-466c-ac59-050fd0609c76', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 470 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a407b326-753f-466c-ac59-050fd0609c76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Très vif', part.name_en = 'II. Très vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 470 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:2f79c193-186b-4029-b1f8-0d39060462bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f79c193-186b-4029-b1f8-0d39060462bc', 2, 'II', 'Très vif', 'II. Très vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 470 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f79c193-186b-4029-b1f8-0d39060462bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Lent', part.name_en = 'III. Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 470 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:28bc018b-01a9-4962-ba3f-1d992b40c351' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28bc018b-01a9-4962-ba3f-1d992b40c351', 3, 'III', 'Lent', 'III. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 470 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28bc018b-01a9-4962-ba3f-1d992b40c351'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Vif, avec entrain', part.name_en = 'IV. Vif, avec entrain',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 470 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:ec633963-f236-4af6-8bac-71471d884437' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec633963-f236-4af6-8bac-71471d884437', 4, 'IV', 'Vif, avec entrain', 'IV. Vif, avec entrain', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 470 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec633963-f236-4af6-8bac-71471d884437'
);


-- M. 74 가브리엘 포레 이름에 의한 자장가

UPDATE pieces piece
SET piece.title = '가브리엘 포레 이름에 의한 자장가', piece.title_en = 'Berceuse sur le nom de Gabriel Fauré',
    piece.type = 'song', piece.opus_number = 'M. 74',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1922, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 862 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1922
WHERE piece.id = 862 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 75 가곡 <Ronsard à son âme>

UPDATE pieces piece
SET piece.title = '가곡 <Ronsard à son âme>', piece.title_en = 'Ronsard à son âme',
    piece.type = 'song', piece.opus_number = 'M. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1924, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2682 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1924
WHERE piece.id = 2682 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 75a 가곡 <Ronsard à son âme> (관현악 반주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ronsard à son âme> (관현악 반주)', 'Ronsard à son âme (orchestral version)', 'song', 'M. 75a', NULL, NULL, 1935, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ronsard à son âme> (관현악 반주)'
);


-- M. 76 치간느 (바이올린과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '치간느 (바이올린과 피아노)', 'Tzigane, rapsodie de concert (violin and piano)', 'song', 'M. 76', NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '치간느 (바이올린과 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6e59d93-e2ec-352d-a007-c36557e56dfa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6e59d93-e2ec-352d-a007-c36557e56dfa'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '치간느 (바이올린과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6e59d93-e2ec-352d-a007-c36557e56dfa'
);


-- M. 77 바이올린 소나타 2번 G장조

UPDATE pieces piece
SET piece.title = '바이올린 소나타 2번 G장조', piece.title_en = 'Violin Sonata No. 2 in G major',
    piece.type = 'album', piece.opus_number = 'M. 77',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1927, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 620 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1927
WHERE piece.id = 620 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto', part.name_en = 'I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 620 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:029a68dd-7e71-4234-a066-8c8c49a56a85' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:029a68dd-7e71-4234-a066-8c8c49a56a85', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 620 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:029a68dd-7e71-4234-a066-8c8c49a56a85'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '블루스. Moderato', part.name_en = 'II. Blues. Moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 620 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:3adbf0de-36c5-4ec1-904c-f89deb03472e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3adbf0de-36c5-4ec1-904c-f89deb03472e', 2, 'II', '블루스. Moderato', 'II. Blues. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 620 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3adbf0de-36c5-4ec1-904c-f89deb03472e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '무궁동. Allegro', part.name_en = 'III. Perpetuum mobile. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 620 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:42c8e54d-1ebe-4047-ac88-e2dd2cf38513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42c8e54d-1ebe-4047-ac88-e2dd2cf38513', 3, 'III', '무궁동. Allegro', 'III. Perpetuum mobile. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 620 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42c8e54d-1ebe-4047-ac88-e2dd2cf38513'
);


-- M. 78 가곡집 <마다가스카르 원주민의 노래>

UPDATE pieces piece
SET piece.title = '가곡집 <마다가스카르 원주민의 노래>', piece.title_en = 'Chansons madécasses',
    piece.type = 'album', piece.opus_number = 'M. 78',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1926, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1478 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1926
WHERE piece.id = 1478 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Nahandove', part.name_en = 'Nahandove',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1478 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:8fc8993a-cf86-4804-90b8-0da4e62219fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fc8993a-cf86-4804-90b8-0da4e62219fb', 1, NULL, 'Nahandove', 'Nahandove', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1478 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fc8993a-cf86-4804-90b8-0da4e62219fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Aoua !', part.name_en = 'Aoua !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1478 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:7c8b8f15-ac0f-4a0a-92a1-f122f7666454' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c8b8f15-ac0f-4a0a-92a1-f122f7666454', 2, NULL, 'Aoua !', 'Aoua !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1478 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c8b8f15-ac0f-4a0a-92a1-f122f7666454'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Il est doux', part.name_en = 'Il est doux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1478 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:b449e269-c7aa-4fb7-9672-c453b964c1d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b449e269-c7aa-4fb7-9672-c453b964c1d0', 3, NULL, 'Il est doux', 'Il est doux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1478 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b449e269-c7aa-4fb7-9672-c453b964c1d0'
);


-- M. 79 가곡 <Rêves>

UPDATE pieces piece
SET piece.title = '가곡 <Rêves>', piece.title_en = 'Rêves',
    piece.type = 'song', piece.opus_number = 'M. 79',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1927, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1477 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1927
WHERE piece.id = 1477 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- M. 80 <잔의 부채>를 위한 팡파르

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<잔의 부채>를 위한 팡파르', 'Fanfare for L''éventail de Jeanne', 'song', 'M. 80', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<잔의 부채>를 위한 팡파르'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '124fa564-7a3f-3b30-ba01-203446d99a67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '124fa564-7a3f-3b30-ba01-203446d99a67'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<잔의 부채>를 위한 팡파르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '124fa564-7a3f-3b30-ba01-203446d99a67'
);


-- M. 80a <잔의 부채>를 위한 팡파르 (네 손 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<잔의 부채>를 위한 팡파르 (네 손 피아노)', 'Fanfare for L''éventail de Jeanne (piano four hands)', 'song', 'M. 80a', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<잔의 부채>를 위한 팡파르 (네 손 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '035439b5-4489-454e-97e8-35fec43263b0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '035439b5-4489-454e-97e8-35fec43263b0'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '<잔의 부채>를 위한 팡파르 (네 손 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '035439b5-4489-454e-97e8-35fec43263b0'
);


-- M. 80b <잔의 부채>를 위한 팡파르 (피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<잔의 부채>를 위한 팡파르 (피아노)', 'Fanfare for L''éventail de Jeanne (piano)', 'song', 'M. 80b', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<잔의 부채>를 위한 팡파르 (피아노)'
);


-- M. 81a 볼레로 (피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '볼레로 (피아노)', 'Boléro (piano)', 'song', 'M. 81a', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '볼레로 (피아노)'
);


-- M. 81b 볼레로 (네 손 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '볼레로 (네 손 피아노)', 'Boléro (piano four hands)', 'song', 'M. 81b', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '볼레로 (네 손 피아노)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fe6c807-4538-4284-acc2-478e993cd1f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2fe6c807-4538-4284-acc2-478e993cd1f5'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '볼레로 (네 손 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2fe6c807-4538-4284-acc2-478e993cd1f5'
);


-- M. 82 왼손을 위한 피아노 협주곡 D장조

UPDATE pieces piece
SET piece.opus_number = 'M. 82'
WHERE piece.id = 488 AND piece.composer_id = 52
  AND piece.catalogue_number IS NULL AND piece.opus_number IS NULL;
UPDATE pieces piece
SET piece.composition_year = 1930
WHERE piece.id = 488 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lento', part.name_en = 'I. Lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 488 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:9fdcb8bd-fc37-43ee-b965-90fc9db375de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fdcb8bd-fc37-43ee-b965-90fc9db375de', 1, 'I', 'Lento', 'I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 488 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fdcb8bd-fc37-43ee-b965-90fc9db375de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 488 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:7da66f93-f805-4fd2-a8f6-7d42667c091c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7da66f93-f805-4fd2-a8f6-7d42667c091c', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 488 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7da66f93-f805-4fd2-a8f6-7d42667c091c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tempo I', part.name_en = 'III. Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 488 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:8397e6c4-cfa8-474b-b696-e5c9bf4a5ec9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8397e6c4-cfa8-474b-b696-e5c9bf4a5ec9', 3, 'III', 'Tempo I', 'III. Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 488 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8397e6c4-cfa8-474b-b696-e5c9bf4a5ec9'
);


-- M. 83 피아노 협주곡 G장조

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegramente', part.name_en = 'I. Allegramente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 233 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:4b81c3ce-7c5e-3dbd-a0a5-d3744b867d2d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = (SELECT linked.id FROM pieces linked WHERE linked.id = 2078 AND linked.composer_id = 52),
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio assai', part.name_en = 'II. Adagio assai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 233 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:9cd60669-5784-3eba-b475-871f7bbaa4cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

UPDATE pieces piece
SET piece.title = '피아노 협주곡 G장조 중 "Adagio assai"', piece.title_en = 'Piano Concerto in G major: II. Adagio assai', piece.editor_locked = 1
WHERE piece.id = 2078 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Presto', part.name_en = 'III. Presto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 233 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:95399729-16ca-349c-93f5-c92666a299c1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));


-- M. 84 가곡집 <돈키호테가 둘시네아에게>

UPDATE pieces piece
SET piece.title = '가곡집 <돈키호테가 둘시네아에게>', piece.title_en = 'Don Quichotte à Dulcinée, for baritone and orchestra',
    piece.type = 'album', piece.opus_number = 'M. 84',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1933, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 2558 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1933
WHERE piece.id = 2558 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson romanesque', part.name_en = 'Chanson romanesque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2558 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:33fec9d1-5c7f-40bf-b64f-54d8bdc8a6f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33fec9d1-5c7f-40bf-b64f-54d8bdc8a6f5', 1, NULL, 'Chanson romanesque', 'Chanson romanesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2558 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33fec9d1-5c7f-40bf-b64f-54d8bdc8a6f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chanson épique', part.name_en = 'Chanson épique',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2558 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:f65f78b2-baaf-40c0-872e-99976c1394bb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f65f78b2-baaf-40c0-872e-99976c1394bb', 2, NULL, 'Chanson épique', 'Chanson épique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2558 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f65f78b2-baaf-40c0-872e-99976c1394bb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chanson à boire', part.name_en = 'Chanson à boire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 2558 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:9d326bed-2f83-44c1-b270-c528eed1ff8b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d326bed-2f83-44c1-b270-c528eed1ff8b', 3, NULL, 'Chanson à boire', 'Chanson à boire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 2558 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d326bed-2f83-44c1-b270-c528eed1ff8b'
);


-- M. 84a 가곡집 <돈키호테가 둘시네아에게> (바리톤과 피아노)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <돈키호테가 둘시네아에게> (바리톤과 피아노)', 'Don Quichotte à Dulcinée, for baritone and piano', 'album', 'M. 84a', NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <돈키호테가 둘시네아에게> (바리톤과 피아노)'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m084a:1', 1, NULL, 'Chanson romanesque', 'Chanson romanesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <돈키호테가 둘시네아에게> (바리톤과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m084a:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m084a:2', 2, NULL, 'Chanson épique', 'Chanson épique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <돈키호테가 둘시네아에게> (바리톤과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m084a:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:ravel:ravel-m084a:3', 3, NULL, 'Chanson à boire', 'Chanson à boire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <돈키호테가 둘시네아에게> (바리톤과 피아노)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:ravel:ravel-m084a:3'
);


-- MA 4, 5, 9–11 가곡집 <그리스 민요 5곡>

UPDATE pieces piece
SET piece.title = '가곡집 <그리스 민요 5곡>', piece.title_en = 'Cinq mélodies populaires grecques',
    piece.type = 'album', piece.opus_number = 'MA 4, 5, 9–11',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1906, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 991 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1906
WHERE piece.id = 991 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson de la mariée', part.name_en = 'Chanson de la mariée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 991 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:405def34-fb35-4de7-bc98-8eac91ccf58f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:405def34-fb35-4de7-bc98-8eac91ccf58f', 1, NULL, 'Chanson de la mariée', 'Chanson de la mariée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 991 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:405def34-fb35-4de7-bc98-8eac91ccf58f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Là-bas, vers l''église', part.name_en = 'Là-bas, vers l''église',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 991 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:181a89f4-1769-4f30-8df4-a3ff9b1740c6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:181a89f4-1769-4f30-8df4-a3ff9b1740c6', 2, NULL, 'Là-bas, vers l''église', 'Là-bas, vers l''église', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 991 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:181a89f4-1769-4f30-8df4-a3ff9b1740c6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Quel galant m''est comparable', part.name_en = 'Quel galant m''est comparable',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 991 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:21941641-4fe0-4f34-8372-a8fe3ae7b0c7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21941641-4fe0-4f34-8372-a8fe3ae7b0c7', 3, NULL, 'Quel galant m''est comparable', 'Quel galant m''est comparable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 991 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21941641-4fe0-4f34-8372-a8fe3ae7b0c7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Chanson des cueilleuses de lentisques', part.name_en = 'Chanson des cueilleuses de lentisques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 991 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:9c49c8bb-cd1d-44e5-93ef-7d44aabe0023' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c49c8bb-cd1d-44e5-93ef-7d44aabe0023', 4, NULL, 'Chanson des cueilleuses de lentisques', 'Chanson des cueilleuses de lentisques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 991 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c49c8bb-cd1d-44e5-93ef-7d44aabe0023'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Tout gai !', part.name_en = 'Tout gai !',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 991 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1ebc4cf2-43db-4457-90fc-e05c003a4af5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ebc4cf2-43db-4457-90fc-e05c003a4af5', 5, NULL, 'Tout gai !', 'Tout gai !', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 991 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ebc4cf2-43db-4457-90fc-e05c003a4af5'
);


-- MA 12 가곡 <Chanson écossaise>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Chanson écossaise>', 'Chanson écossaise (Ye banks and braes o'' bonnie Doon)', 'song', 'MA 12', NULL, NULL, 1909, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Chanson écossaise>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8305813-7ec7-4231-a199-b2bf7b328660'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8305813-7ec7-4231-a199-b2bf7b328660'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡 <Chanson écossaise>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8305813-7ec7-4231-a199-b2bf7b328660'
);


-- MA 13 가곡 <Tripatos>

UPDATE pieces piece
SET piece.title = '가곡 <Tripatos>', piece.title_en = 'Tripatos (Kherya pou dhen idhen ilyos)',
    piece.type = 'song', piece.opus_number = 'MA 13',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1909, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1922 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1909
WHERE piece.id = 1922 AND piece.composer_id = 52 AND piece.composition_year IS NULL;


-- MA 17 가곡집 <민요 4곡>

UPDATE pieces piece
SET piece.title = '가곡집 <민요 4곡>', piece.title_en = 'Chants populaires',
    piece.type = 'album', piece.opus_number = 'MA 17',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(1910, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 1437 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;
UPDATE pieces piece
SET piece.composition_year = 1910
WHERE piece.id = 1437 AND piece.composer_id = 52 AND piece.composition_year IS NULL;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '스페인 노래 (Chanson espagnole)', part.name_en = 'Chanson espagnole: Adios men homino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1437 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:da606534-26bf-39c0-8786-7e6dd07bfc40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da606534-26bf-39c0-8786-7e6dd07bfc40', 1, NULL, '스페인 노래 (Chanson espagnole)', 'Chanson espagnole: Adios men homino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1437 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da606534-26bf-39c0-8786-7e6dd07bfc40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '프랑스 노래 (Chanson française)', part.name_en = 'Chanson française: Janeta ount anirem gardar',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1437 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:4bc9b7ff-21ca-3bd4-8a58-479a1ff68e44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4bc9b7ff-21ca-3bd4-8a58-479a1ff68e44', 2, NULL, '프랑스 노래 (Chanson française)', 'Chanson française: Janeta ount anirem gardar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1437 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bc9b7ff-21ca-3bd4-8a58-479a1ff68e44'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '이탈리아 노래 (Chanson italienne)', part.name_en = 'Chanson italienne: M''affaccio la finestra',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1437 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:1e6da64d-f2b7-3bfc-aab0-fe3014a88752' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e6da64d-f2b7-3bfc-aab0-fe3014a88752', 3, NULL, '이탈리아 노래 (Chanson italienne)', 'Chanson italienne: M''affaccio la finestra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1437 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e6da64d-f2b7-3bfc-aab0-fe3014a88752'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '히브리 노래 (Chanson hébraïque)', part.name_en = 'Chanson hébraïque: Mejerke, main Suhn',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 1437 AND p.composer_id = 52 AND part.part_key = 'musicbrainz:c5673a9d-92c7-44ec-9429-285a750dc916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5673a9d-92c7-44ec-9429-285a750dc916', 4, NULL, '히브리 노래 (Chanson hébraïque)', 'Chanson hébraïque: Mejerke, main Suhn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 1437 AND p.composer_id = 52
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5673a9d-92c7-44ec-9429-285a750dc916'
);


-- MA 22 가곡집 <두 개의 히브리 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <두 개의 히브리 노래>', 'Deux mélodies hébraïques', 'album', 'MA 22', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 52
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <두 개의 히브리 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbf19f74-f957-424e-b668-bcec118cf368'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cbf19f74-f957-424e-b668-bcec118cf368'
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <두 개의 히브리 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbf19f74-f957-424e-b668-bcec118cf368'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 1439 AND linked.composer_id = 52), 'musicbrainz:5c5f051e-61cf-3274-ac65-b15b58607c0c', 1, NULL, 'Kaddisch', 'Kaddisch: Yithgaddal weyithkaddash', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <두 개의 히브리 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c5f051e-61cf-3274-ac65-b15b58607c0c'
);

UPDATE pieces piece
SET piece.title = '가곡집 <두 개의 히브리 노래> 중 "Kaddisch"', piece.title_en = 'Deux mélodies hébraïques: Kaddisch: Yithgaddal weyithkaddash', piece.editor_locked = 1
WHERE piece.id = 1439 AND piece.composer_id = 52
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b65f9dc-1430-499c-9c23-21f34ba3e609', 2, NULL, 'L''Énigme éternelle', 'L''Énigme éternelle: Fragt die Velt die alte Casche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 52 AND p.title = '가곡집 <두 개의 히브리 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b65f9dc-1430-499c-9c23-21f34ba3e609'
);

-- 카탈로그에 대응이 없는 seed 작품 51개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 52 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    514, 545, 666, 770, 771, 774, 854, 861, 884, 898, 930, 954, 1009, 1060, 1156, 1190, 1243, 1254, 1341, 1348,
    1525, 1529, 1585, 1673, 1734, 1774, 1815, 1835, 1843, 1914, 2180, 2222, 2225, 2381, 2404, 2429, 2527, 2610, 2637, 2649,
    2692, 2802, 2811, 2859, 2860, 2865, 2872, 2913, 7491, 7571, 7717
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);

-- 운영 manual 작품 셋은 MBID 가 관현악·편성판인데 opus 가 원곡 번호로 적혀 있어, 새로 넣는 원곡과 번호가 겹친다.
-- 판 번호로 고치고, 「치건」 오타를 바로잡는다.
UPDATE pieces piece SET piece.opus_number = 'M. 19a'
WHERE piece.id = 231 AND piece.composer_id = 52 AND piece.opus_number = 'M. 19';
UPDATE pieces piece SET piece.opus_number = 'M. 60a'
WHERE piece.id = 26037 AND piece.composer_id = 52 AND piece.opus_number = 'M. 60';
UPDATE pieces piece SET piece.opus_number = 'M. 76a', piece.title = '치간느'
WHERE piece.id = 457 AND piece.composer_id = 52 AND piece.opus_number = 'M. 76' AND piece.title = '치건';
