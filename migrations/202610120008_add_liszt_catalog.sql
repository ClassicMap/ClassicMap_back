-- 리스트의 원작을 설 번호 단위로 채운다. 작품 365개(묶음 42, 다악장 11, 낱곡 312), part 257, 그 아래 42.
-- 새 작품 363개, 기존 2개(MBID). 사랑의 꿈 3번 139·라 캄파넬라 140·헝가리 광시곡 2번 141·마제파 143 은
-- 각 묶음(S. 541·141·244·139)의 part 로 잇는다.
--
-- 정한 것
--   위키백과 원작 구역(S. 1–350)만 넣는다. 남의 곡 판타지·패러프레이즈·편곡과 민요·국가 편곡은 뺀다.
--   같은 곡의 여러 판은 마지막 판만(초절기교 S. 139, 파가니니 S. 141). <나그네의 앨범> S. 156 은 넣는다.
--   메피스토 왈츠 1번은 관현악판(S. 110 의 2번)과 피아노판 S. 514 둘 다 있다. 2번은 피아노판 S. 515 만.
--   <사랑의 꿈> 은 피아노판 S. 541 묶음과 가곡판(S. 307·308·298/2)을 따로 둔다.
--   가곡·합창곡 제목은 원제다. 앨범의 한 페이지 가운데 조성이 겹치는 셋은 제목 끝에 S. 번호를 붙인다.
--
-- 공통: 자료는 seed_pipeline/curation/catalog-wave1-2026-10-11/<작곡가>/catalog.json 이고, 본문은 그 폴더의
-- gen_catalog.py 가 만든다. 위키백과 영어판 작품 목록을 기준으로 MusicBrainz work 와 맞췄다.
--   단위: 한 작품번호 아래 함께 출판된 곡은 묶음(작품 하나 + part), 악장으로 나뉜 작품은 악장을 part 로,
--     묶음 안 곡이 다시 악장으로 나뉘면 그 아래 part(parent_part_id)로 둔다. 오페라·발레·오라토리오 같은
--     무대·대형 성악 작품은 이번에는 part 없이 둔다.
--   이름: 묶음 제목은 갈래만으로 구별이 안 되면 끝에 카탈로그를 넣고("현악 4중주 Op. 18") opus_number 를
--     비운 채 catalogue_system·catalogue_number 를 채운다. 낱곡·다악장은 opus_number 에 카탈로그를 둔다.
--     part 이름에는 "1번"·"1악장" 을 넣지 않는다(번호는 sequence_number). 악장만 movement_number 를 채운다.
--     가곡 제목은 널리 쓰는 우리말이 확실할 때만 "우리말 (원제)", 아니면 원제다.
--   빼는 것: 위작(의심만 붙은 곡은 작곡가별로 아래에 적었다), 소실, 단편·스케치, 남의 작품 편곡, 민요 편곡, 같은 곡의 옛 판.
--   기존 작품: MBID 로 먼저, 없으면 카탈로그 번호로 맞춘다. 기존 작품의 제목·설명·링크는 바꾸지 않고, 비어 있는
--     작품번호·연도만 채운다. 기존 작품에 없는 다른 판 MBID(원곡 work 등)는 식별자로 더하고 기존 식별자는 그대로 둔다.
--     따로 있던 낱곡이 새 묶음 안 곡이면 part.linked_piece_id 로 잇는다.
--   part 는 EDITOR_REVIEWED 로 넣는다. 같은 MBID 가 이미 다른 작품에 있으면 작품도 식별자도 넣지 않는다.
--   방금 넣은 작품은 (작곡가, 제목, origin='manual') 로 찾는다. 두 번 돌려도 같다.

-- S. 1 오페라 <돈 산슈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <돈 산슈>', 'Opera <Don Sanche, ou Le château de l''amour>', 'song', 'S. 1', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <돈 산슈>'
);


-- S. 2 오라토리오 <성 엘리자베트의 전설>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <성 엘리자베트의 전설>', 'Oratorio <Die Legende von der heiligen Elisabeth>', 'song', 'S. 2', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <성 엘리자베트의 전설>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '801accef-4fa2-41eb-a8a8-bb8226764bb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '801accef-4fa2-41eb-a8a8-bb8226764bb7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오라토리오 <성 엘리자베트의 전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '801accef-4fa2-41eb-a8a8-bb8226764bb7'
);


-- S. 3 오라토리오 <그리스도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <그리스도>', 'Oratorio <Christus>', 'song', 'S. 3', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <그리스도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ca8583c-946b-4cdd-ad38-0d80218ca387'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ca8583c-946b-4cdd-ad38-0d80218ca387'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오라토리오 <그리스도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ca8583c-946b-4cdd-ad38-0d80218ca387'
);


-- S. 4/2 <아시시의 성 프란치스코의 태양의 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아시시의 성 프란치스코의 태양의 찬가>', 'Cantico del sol di Francesco d''Assisi', 'song', 'S. 4/2', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아시시의 성 프란치스코의 태양의 찬가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb70379a-be33-494a-b500-4ddf08a3c548'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb70379a-be33-494a-b500-4ddf08a3c548'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<아시시의 성 프란치스코의 태양의 찬가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb70379a-be33-494a-b500-4ddf08a3c548'
);


-- S. 5/2 <성 체칠리아의 전설>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<성 체칠리아의 전설>', 'Sainte Cécile (Die heilige Cäcilia)', 'song', 'S. 5/2', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<성 체칠리아의 전설>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef106dd3-3d3e-49fc-be04-0d520e69f040'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef106dd3-3d3e-49fc-be04-0d520e69f040'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<성 체칠리아의 전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef106dd3-3d3e-49fc-be04-0d520e69f040'
);


-- S. 6 칸타타 <슈트라스부르크 대성당의 종>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <슈트라스부르크 대성당의 종>', 'Cantata <Die Glocken des Strassburger Münsters>', 'song', 'S. 6', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <슈트라스부르크 대성당의 종>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '777d3a62-ba09-4afa-ae03-2ebf6192d23b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '777d3a62-ba09-4afa-ae03-2ebf6192d23b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '칸타타 <슈트라스부르크 대성당의 종>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '777d3a62-ba09-4afa-ae03-2ebf6192d23b'
);


-- S. 7 합창곡 <Cantantibus organis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Cantantibus organis>', 'Cantantibus organis', 'song', 'S. 7', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Cantantibus organis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb398281-e901-4145-8cda-f9fe993b3b90'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb398281-e901-4145-8cda-f9fe993b3b90'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Cantantibus organis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb398281-e901-4145-8cda-f9fe993b3b90'
);


-- S. 8/2 남성 합창 미사 "세크사르드"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 미사 "세크사르드"', 'Missa quattuor vocum ad aequales "Szekszárd Mass"', 'album', 'S. 8/2', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 미사 "세크사르드"'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s8-2:1', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창 미사 "세크사르드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s8-2:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s8-2:2', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창 미사 "세크사르드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s8-2:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s8-2:3', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창 미사 "세크사르드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s8-2:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s8-2:4', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창 미사 "세크사르드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s8-2:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s8-2:5', 5, 'V', '베네딕투스', 'V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창 미사 "세크사르드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s8-2:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s8-2:6', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창 미사 "세크사르드"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s8-2:6'
);


-- S. 9 그란 미사

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그란 미사', 'Missa solennis "Graner Messe"', 'album', 'S. 9', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그란 미사'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '449c1d9b-718a-494b-93e4-a526f64bbccf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '449c1d9b-718a-494b-93e4-a526f64bbccf'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '그란 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '449c1d9b-718a-494b-93e4-a526f64bbccf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0b32c39-9c0f-40f0-a064-54d011a91fc0', 1, 'I', '키리에. Andante solenne', 'I. Kyrie. Andante solenne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '그란 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0b32c39-9c0f-40f0-a064-54d011a91fc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb6f7056-37bf-4edc-b791-bf81900be6d3', 2, 'II', '글로리아. Allegro, ma non troppo', 'II. Gloria. Allegro, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '그란 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb6f7056-37bf-4edc-b791-bf81900be6d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:328bd666-9165-4594-aa6e-c16867827515', 3, 'III', '크레도. Andante maestoso, risoluto', 'III. Credo. Andante maestoso, risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '그란 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:328bd666-9165-4594-aa6e-c16867827515'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fbaae80-3307-4d93-a4ee-1471c9a7681d', 4, 'IV', '상투스. Andante solenne', 'IV. Sanctus. Andante solenne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '그란 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fbaae80-3307-4d93-a4ee-1471c9a7681d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80730aa9-ab11-4c3a-90a2-4507fcce3115', 5, 'V', '베네딕투스. Andante con pietà', 'V. Benedictus. Andante con pietà', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '그란 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80730aa9-ab11-4c3a-90a2-4507fcce3115'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca79e048-9977-4233-b3f8-0cb095397d4f', 6, 'VI', '아뉴스 데이. Adagio non troppo', 'VI. Agnus Dei. Adagio non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '그란 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca79e048-9977-4233-b3f8-0cb095397d4f'
);


-- S. 10 미사 코랄리스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 코랄리스', 'Missa choralis', 'album', 'S. 10', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 코랄리스'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e1c7291-4a59-4e09-974b-3846822106aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e1c7291-4a59-4e09-974b-3846822106aa'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '미사 코랄리스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e1c7291-4a59-4e09-974b-3846822106aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37023e63-1be2-41ed-a720-4bdb01a42dcd', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '미사 코랄리스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37023e63-1be2-41ed-a720-4bdb01a42dcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02bd623a-3793-47b0-a1a3-4c43208bf181', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '미사 코랄리스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02bd623a-3793-47b0-a1a3-4c43208bf181'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dee9731-ba55-46a6-a1f1-9ecc8b50941f', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '미사 코랄리스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dee9731-ba55-46a6-a1f1-9ecc8b50941f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23c51470-0ff8-4e39-be5c-f1f5b1ea9058', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '미사 코랄리스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23c51470-0ff8-4e39-be5c-f1f5b1ea9058'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25229f40-1373-414f-8487-f1fa3a6e9b25', 5, 'V', '베네딕투스', 'V. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '미사 코랄리스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25229f40-1373-414f-8487-f1fa3a6e9b25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62e8e435-e0ea-4b1e-9d40-d50577b8764f', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '미사 코랄리스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62e8e435-e0ea-4b1e-9d40-d50577b8764f'
);


-- S. 11 헝가리 대관식 미사

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리 대관식 미사', 'Hungarian Coronation Mass', 'album', 'S. 11', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리 대관식 미사'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fe6fc2e-79a8-45b1-a813-ea21125d1d3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4fe6fc2e-79a8-45b1-a813-ea21125d1d3e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4fe6fc2e-79a8-45b1-a813-ea21125d1d3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de8c127a-81ca-4adc-9483-e042fc4b2928', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de8c127a-81ca-4adc-9483-e042fc4b2928'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc14ba0d-20c0-4cc2-b449-64c8a4473973', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc14ba0d-20c0-4cc2-b449-64c8a4473973'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c7e4769-5e6d-47c1-8c76-c3addbd00c61', 3, 'III', '그라두알레 (시편 116편)', 'III. Graduale (Psalm 116)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c7e4769-5e6d-47c1-8c76-c3addbd00c61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5ad4fc1-722f-4464-8103-009fd49d214c', 4, 'IV', '크레도', 'IV. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5ad4fc1-722f-4464-8103-009fd49d214c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6523c7e3-7461-47f8-9414-1fcab5eee3cf', 5, 'V', '오페르토리움', 'V. Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6523c7e3-7461-47f8-9414-1fcab5eee3cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d7649c6-eea9-4e9a-8cf2-3720ad7d60af', 6, 'VI', '상투스', 'VI. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d7649c6-eea9-4e9a-8cf2-3720ad7d60af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1a2652a-cffa-44d6-9f7c-2cf7fffbdc80', 7, 'VII', '베네딕투스', 'VII. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1a2652a-cffa-44d6-9f7c-2cf7fffbdc80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df6daf11-a2e6-40f9-a4a8-3ab96337db5c', 8, 'VIII', '아뉴스 데이', 'VIII. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 대관식 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df6daf11-a2e6-40f9-a4a8-3ab96337db5c'
);


-- S. 12 레퀴엠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레퀴엠', 'Requiem (Missa pro defunctis)', 'album', 'S. 12', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레퀴엠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3e77bef-e4bc-4513-9279-e7dd335639f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3e77bef-e4bc-4513-9279-e7dd335639f0'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3e77bef-e4bc-4513-9279-e7dd335639f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:143e5fed-bd13-4557-84b7-b5a595b44a9e', 1, 'I', '레퀴엠 에테르남', 'I. Requiem aeternam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:143e5fed-bd13-4557-84b7-b5a595b44a9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec262fdd-4516-4e48-9bdd-a79786605755', 2, 'II', '디에스 이레', 'II. Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec262fdd-4516-4e48-9bdd-a79786605755'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca5c7c04-8da4-409f-a974-8755e15c1ed7', 3, 'III', '오페르토리움', 'III. Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca5c7c04-8da4-409f-a974-8755e15c1ed7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2320f953-7177-45ce-a4a0-a1616e7bca17', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2320f953-7177-45ce-a4a0-a1616e7bca17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b05ab2cb-ef23-45ae-bdfb-c0fd35201245', 5, 'V', '아뉴스 데이', 'V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b05ab2cb-ef23-45ae-bdfb-c0fd35201245'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97bd72de-9e12-4b39-9575-38ab7e8e67f6', 6, 'VI', '리베라 메', 'VI. Libera me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97bd72de-9e12-4b39-9575-38ab7e8e67f6'
);


-- S. 13/2 시편 13편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 13편', 'Psalm 13 "Herr, wie lange willst du meiner so gar vergessen"', 'song', 'S. 13/2', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 13편'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05b223e5-8a20-44ca-8e23-af698f23b292'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05b223e5-8a20-44ca-8e23-af698f23b292'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '시편 13편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05b223e5-8a20-44ca-8e23-af698f23b292'
);


-- S. 14/2 시편 18편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 18편', 'Psalm 18 "Coeli enarrant gloriam Dei"', 'song', 'S. 14/2', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 18편'
);


-- S. 15/2b 시편 23편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 23편', 'Psalm 23 "Mein Gott, der ist mein Hirt"', 'song', 'S. 15/2b', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 23편'
);


-- S. 16/2 시편 129편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 129편', 'Psalm 129 "De profundis"', 'song', 'S. 16/2', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 129편'
);


-- S. 17/2 시편 137편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 137편', 'Psalm 137 "An den Wassern zu Babylon"', 'song', 'S. 17/2', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 137편'
);


-- S. 18 프랑스어 가사 합창곡 S. 18

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '프랑스어 가사 합창곡 S. 18', 'Choruses with French Texts, S. 18', 'album', NULL, 'S.', '18', 1846, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '프랑스어 가사 합창곡 S. 18'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bff5de5a-3492-49e5-ab03-f4266a3d9233'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bff5de5a-3492-49e5-ab03-f4266a3d9233'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '프랑스어 가사 합창곡 S. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bff5de5a-3492-49e5-ab03-f4266a3d9233'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s18:1', 1, NULL, 'L''Eternel est son nom', 'L''Eternel est son nom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '프랑스어 가사 합창곡 S. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s18:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s18:2', 2, NULL, 'Chantons, chantons l''auteur de la lumière', 'Chantons, chantons l''auteur de la lumière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '프랑스어 가사 합창곡 S. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s18:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s18:3', 3, NULL, 'A장조', 'Allegretto, moderato con grazia in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '프랑스어 가사 합창곡 S. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s18:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s18:4', 4, NULL, 'Combien j''ai douce souvenance', 'Combien j''ai douce souvenance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '프랑스어 가사 합창곡 S. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s18:4'
);


-- S. 19/4 합창곡 <Hymne de l'enfant à son réveil>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Hymne de l''enfant à son réveil>', 'Hymne de l''enfant à son réveil', 'song', 'S. 19/4', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Hymne de l''enfant à son réveil>'
);


-- S. 20/2 합창곡 <Ave Maria I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ave Maria I>', 'Ave Maria I in A major', 'song', 'S. 20/2', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ave Maria I>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '359b47ee-33b5-4c79-9808-3f93322823a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '359b47ee-33b5-4c79-9808-3f93322823a3'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Ave Maria I>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '359b47ee-33b5-4c79-9808-3f93322823a3'
);


-- S. 21/2 합창곡 <Pater noster I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Pater noster I>', 'Pater noster I', 'song', 'S. 21/2', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Pater noster I>'
);


-- S. 22 합창곡 <Pater noster IV>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Pater noster IV>', 'Pater noster IV in C major', 'song', 'S. 22', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Pater noster IV>'
);


-- S. 23 합창곡 <Domine salvum fac regem>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Domine salvum fac regem>', 'Domine salvum fac regem (Psalm 20)', 'song', 'S. 23', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Domine salvum fac regem>'
);


-- S. 24 합창곡 <Te Deum I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Te Deum I>', 'Te Deum I', 'song', 'S. 24', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Te Deum I>'
);


-- S. 26 합창곡 <Festgesang zur Eröffnung der zehnten allgemeinen deutschen Lehrerversammlung>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Festgesang zur Eröffnung der zehnten allgemeinen deutschen Lehrerversammlung>', 'Festgesang zur Eröffnung der zehnten allgemeinen deutschen Lehrerversammlung', 'song', 'S. 26', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Festgesang zur Eröffnung der zehnten allgemeinen deutschen Lehrerversammlung>'
);


-- S. 27 합창곡 <Te Deum II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Te Deum II>', 'Te Deum II', 'song', 'S. 27', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Te Deum II>'
);


-- S. 28 합창곡 <An den heiligen Franziskus von Paula>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <An den heiligen Franziskus von Paula>', 'An den heiligen Franziskus von Paula (Gebet)', 'song', 'S. 28', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <An den heiligen Franziskus von Paula>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f128391c-4b01-4153-87fe-3aae0a8bcb82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f128391c-4b01-4153-87fe-3aae0a8bcb82'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <An den heiligen Franziskus von Paula>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f128391c-4b01-4153-87fe-3aae0a8bcb82'
);


-- S. 30 <Responsorien und Antiphonen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Responsorien und Antiphonen>', 'Responsorien und Antiphonen', 'song', 'S. 30', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Responsorien und Antiphonen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6243407e-fa60-44dd-a018-33ea6eabfcda'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6243407e-fa60-44dd-a018-33ea6eabfcda'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<Responsorien und Antiphonen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6243407e-fa60-44dd-a018-33ea6eabfcda'
);


-- S. 31/2 합창곡 <Christus ist geboren I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Christus ist geboren I>', 'Christus ist geboren I', 'song', 'S. 31/2', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Christus ist geboren I>'
);


-- S. 32/3 합창곡 <Christus ist geboren II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Christus ist geboren II>', 'Christus ist geboren II', 'song', 'S. 32/3', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Christus ist geboren II>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6775a15e-2d95-4b93-86b8-cf88cd136510'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6775a15e-2d95-4b93-86b8-cf88cd136510'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Christus ist geboren II>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6775a15e-2d95-4b93-86b8-cf88cd136510'
);


-- S. 33 합창곡 <Slavimo slavno, Slaveni!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Slavimo slavno, Slaveni!>', 'Slavimo slavno, Slaveni!', 'song', 'S. 33', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Slavimo slavno, Slaveni!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be42c02e-006e-4921-a243-b484b5be33c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be42c02e-006e-4921-a243-b484b5be33c7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Slavimo slavno, Slaveni!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be42c02e-006e-4921-a243-b484b5be33c7'
);


-- S. 34/2 합창곡 <Ave maris stella>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ave maris stella>', 'Ave maris stella', 'song', 'S. 34/2', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ave maris stella>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44de1e45-9ee2-42a6-a465-7483d10e1464'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44de1e45-9ee2-42a6-a465-7483d10e1464'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Ave maris stella>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44de1e45-9ee2-42a6-a465-7483d10e1464'
);


-- S. 35/2 합창곡 <Crux!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Crux!>', 'Crux! (Hymne des marins)', 'song', 'S. 35/2', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Crux!>'
);


-- S. 36 합창곡 <Dall' alma Roma>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Dall'' alma Roma>', 'Dall'' alma Roma', 'song', 'S. 36', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Dall'' alma Roma>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4504dc42-0ac3-4838-b85a-ceeb6502f5f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4504dc42-0ac3-4838-b85a-ceeb6502f5f7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Dall'' alma Roma>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4504dc42-0ac3-4838-b85a-ceeb6502f5f7'
);


-- S. 37 합창곡 <Mihi autem adhaerere>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Mihi autem adhaerere>', 'Mihi autem adhaerere', 'song', 'S. 37', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Mihi autem adhaerere>'
);


-- S. 38 합창곡 <Ave Maria II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ave Maria II>', 'Ave Maria II in D major', 'song', 'S. 38', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ave Maria II>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb23cf46-b80c-4f0f-b217-75d7bad75ae2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb23cf46-b80c-4f0f-b217-75d7bad75ae2'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Ave Maria II>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb23cf46-b80c-4f0f-b217-75d7bad75ae2'
);


-- S. 39/2 합창곡 <Inno a Maria Vergine>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Inno a Maria Vergine>', 'Inno a Maria Vergine', 'song', 'S. 39/2', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Inno a Maria Vergine>'
);


-- S. 40 합창곡 <O salutaris hostia I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <O salutaris hostia I>', 'O salutaris hostia I', 'song', 'S. 40', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <O salutaris hostia I>'
);


-- S. 41/2 합창곡 <Pater noster III>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Pater noster III>', 'Pater noster III', 'song', 'S. 41/2', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Pater noster III>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c680ba8-9593-4970-bd87-4fe6cc0a6d72'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c680ba8-9593-4970-bd87-4fe6cc0a6d72'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Pater noster III>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c680ba8-9593-4970-bd87-4fe6cc0a6d72'
);


-- S. 42/2 합창곡 <Tantum ergo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Tantum ergo>', 'Tantum ergo', 'song', 'S. 42/2', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Tantum ergo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '616993a2-6ce3-4fcc-bb1a-27d4008be98c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '616993a2-6ce3-4fcc-bb1a-27d4008be98c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Tantum ergo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '616993a2-6ce3-4fcc-bb1a-27d4008be98c'
);


-- S. 43 합창곡 <O salutaris hostia II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <O salutaris hostia II>', 'O salutaris hostia II in E major', 'song', 'S. 43', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <O salutaris hostia II>'
);


-- S. 44 합창곡 <Ave verum corpus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ave verum corpus>', 'Ave verum corpus', 'song', 'S. 44', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ave verum corpus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdfc3854-7bf2-436e-8a34-84185bc34420'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fdfc3854-7bf2-436e-8a34-84185bc34420'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Ave verum corpus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdfc3854-7bf2-436e-8a34-84185bc34420'
);


-- S. 46/2 합창곡 <Anima Christi sanctifica me>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Anima Christi sanctifica me>', 'Anima Christi sanctifica me', 'song', 'S. 46/2', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Anima Christi sanctifica me>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0c12946-619c-4e80-a528-2f51f0642f15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0c12946-619c-4e80-a528-2f51f0642f15'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Anima Christi sanctifica me>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0c12946-619c-4e80-a528-2f51f0642f15'
);


-- S. 47 합창곡 <Sankt Christoph>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Sankt Christoph>', 'Sankt Christoph (Legende)', 'song', 'S. 47', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Sankt Christoph>'
);


-- S. 48 합창곡 <Der Herr bewahret die Seelen seiner Heiligen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Der Herr bewahret die Seelen seiner Heiligen>', 'Der Herr bewahret die Seelen seiner Heiligen', 'song', 'S. 48', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Der Herr bewahret die Seelen seiner Heiligen>'
);


-- S. 49 합창곡 <O heilige Nacht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <O heilige Nacht>', 'O heilige Nacht (Weihnachtslied)', 'song', 'S. 49', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <O heilige Nacht>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17ed5a85-3f02-416a-b903-3249a5edda17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17ed5a85-3f02-416a-b903-3249a5edda17'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <O heilige Nacht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17ed5a85-3f02-416a-b903-3249a5edda17'
);


-- S. 52 <Septem sacramenta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Septem sacramenta>', 'Septem sacramenta', 'song', 'S. 52', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Septem sacramenta>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '634ee073-09b4-4afc-844d-7db87a9a8c54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '634ee073-09b4-4afc-844d-7db87a9a8c54'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<Septem sacramenta>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '634ee073-09b4-4afc-844d-7db87a9a8c54'
);


-- S. 53 <십자가의 길>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<십자가의 길>', 'Via crucis', 'song', 'S. 53', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<십자가의 길>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56133ca0-e2cd-4266-aa1f-92947a532e05'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56133ca0-e2cd-4266-aa1f-92947a532e05'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<십자가의 길>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56133ca0-e2cd-4266-aa1f-92947a532e05'
);


-- S. 55 합창곡 <Ossa arida>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ossa arida>', 'Ossa arida', 'song', 'S. 55', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ossa arida>'
);


-- S. 56 합창곡집 <로사리오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡집 <로사리오>', 'Rosario', 'album', 'S. 56', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡집 <로사리오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd95bf692-ff31-4738-8681-7a76a3f62d55'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd95bf692-ff31-4738-8681-7a76a3f62d55'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡집 <로사리오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd95bf692-ff31-4738-8681-7a76a3f62d55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24c7ef31-3d26-4e4d-a736-586eaa2bc9aa', 1, NULL, '환희의 신비 (Mysteria gaudiosa)', 'Mysteria gaudiosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡집 <로사리오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24c7ef31-3d26-4e4d-a736-586eaa2bc9aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1a7e2fa-1fa6-4d5a-a828-ba96b82da20b', 2, NULL, '고통의 신비 (Mysteria dolorosa)', 'Mysteria dolorosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡집 <로사리오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1a7e2fa-1fa6-4d5a-a828-ba96b82da20b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3becb0f2-e332-44b0-b0e9-d3a4336f91f1', 3, NULL, '영광의 신비 (Mysteria gloriosa)', 'Mysteria gloriosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡집 <로사리오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3becb0f2-e332-44b0-b0e9-d3a4336f91f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2df4745e-0a1e-47f7-860d-1f63bc46dbe4', 4, NULL, 'Pater noster', 'Pater noster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡집 <로사리오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2df4745e-0a1e-47f7-860d-1f63bc46dbe4'
);


-- S. 57 합창곡 <In domum Domini ibimus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <In domum Domini ibimus>', 'In domum Domini ibimus', 'song', 'S. 57', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <In domum Domini ibimus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84cdd9c7-2fd9-447f-aca0-84fad5ddf962'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84cdd9c7-2fd9-447f-aca0-84fad5ddf962'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <In domum Domini ibimus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84cdd9c7-2fd9-447f-aca0-84fad5ddf962'
);


-- S. 58 합창곡 <O sacrum convivium>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <O sacrum convivium>', 'O sacrum convivium', 'song', 'S. 58', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <O sacrum convivium>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a96d320-6384-49c8-8527-807a8deb4ec0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a96d320-6384-49c8-8527-807a8deb4ec0'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <O sacrum convivium>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a96d320-6384-49c8-8527-807a8deb4ec0'
);


-- S. 59 합창곡집 <Pro Papa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡집 <Pro Papa>', 'Pro Papa', 'album', 'S. 59', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡집 <Pro Papa>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s59:1', 1, NULL, 'Tu es Petrus', 'Tu es Petrus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡집 <Pro Papa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s59:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s59:2', 2, NULL, 'Dominus conservet eum', 'Dominus conservet eum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡집 <Pro Papa>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s59:2'
);


-- S. 60 합창곡 <Ave Maria III>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Ave Maria III>', 'Ave Maria III "Sposalizio"', 'song', 'S. 60', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Ave Maria III>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2b8a008-614a-4a68-8f36-088b93d8d072'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b2b8a008-614a-4a68-8f36-088b93d8d072'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Ave Maria III>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2b8a008-614a-4a68-8f36-088b93d8d072'
);


-- S. 61 합창곡 <Nun danket alle Gott>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Nun danket alle Gott>', 'Nun danket alle Gott', 'song', 'S. 61', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Nun danket alle Gott>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0293a625-cb7a-4c1e-9595-36dd7e807d5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0293a625-cb7a-4c1e-9595-36dd7e807d5a'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Nun danket alle Gott>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0293a625-cb7a-4c1e-9595-36dd7e807d5a'
);


-- S. 62 합창곡 <Mariengarten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Mariengarten>', 'Mariengarten', 'song', 'S. 62', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Mariengarten>'
);


-- S. 63 합창곡 <Qui seminant in lacrimis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Qui seminant in lacrimis>', 'Qui seminant in lacrimis (Psalm 125)', 'song', 'S. 63', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Qui seminant in lacrimis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ce1914b-b7c7-4c2a-b8f9-196e36a5045e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ce1914b-b7c7-4c2a-b8f9-196e36a5045e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Qui seminant in lacrimis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ce1914b-b7c7-4c2a-b8f9-196e36a5045e'
);


-- S. 64 합창곡 <Pax vobiscum!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Pax vobiscum!>', 'Pax vobiscum!', 'song', 'S. 64', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Pax vobiscum!>'
);


-- S. 65 합창곡 <Qui Mariam absolvisti>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Qui Mariam absolvisti>', 'Qui Mariam absolvisti', 'song', 'S. 65', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Qui Mariam absolvisti>'
);


-- S. 66 합창곡 <Salve Regina>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Salve Regina>', 'Salve Regina', 'song', 'S. 66', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Salve Regina>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f1607e3-2cc2-4fe1-bdaf-cbda1b8aca17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f1607e3-2cc2-4fe1-bdaf-cbda1b8aca17'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '합창곡 <Salve Regina>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f1607e3-2cc2-4fe1-bdaf-cbda1b8aca17'
);


-- S. 67 칸타타 <본 베토벤 기념비 제막 축전 칸타타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <본 베토벤 기념비 제막 축전 칸타타>', 'Festkantate zur Enthüllung des Beethoven-Denkmals in Bonn (Beethoven Cantata No. 1)', 'song', 'S. 67', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <본 베토벤 기념비 제막 축전 칸타타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '626c2fa8-cef4-44ee-8982-eb098b85783f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '626c2fa8-cef4-44ee-8982-eb098b85783f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '칸타타 <본 베토벤 기념비 제막 축전 칸타타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '626c2fa8-cef4-44ee-8982-eb098b85783f'
);


-- S. 68 칸타타 <베토벤 탄생 100주년 축전 칸타타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <베토벤 탄생 100주년 축전 칸타타>', 'Zur Säcularfeier Beethovens (Beethoven Cantata No. 2)', 'song', 'S. 68', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <베토벤 탄생 100주년 축전 칸타타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa02b64c-2465-4f36-8f4b-04d22c003cb0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa02b64c-2465-4f36-8f4b-04d22c003cb0'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '칸타타 <베토벤 탄생 100주년 축전 칸타타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa02b64c-2465-4f36-8f4b-04d22c003cb0'
);


-- S. 69iii <헤르더의 '해방된 프로메테우스'를 위한 합창곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헤르더의 ''해방된 프로메테우스''를 위한 합창곡>', 'Chöre zu Herders Entfesseltem Prometheus', 'song', 'S. 69iii', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<헤르더의 ''해방된 프로메테우스''를 위한 합창곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '412b233f-194b-4624-a405-3947cf2b3f0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '412b233f-194b-4624-a405-3947cf2b3f0b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<헤르더의 ''해방된 프로메테우스''를 위한 합창곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '412b233f-194b-4624-a405-3947cf2b3f0b'
);


-- S. 70iv 합창곡 <An die Künstler>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <An die Künstler>', 'An die Künstler', 'song', 'S. 70iv', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <An die Künstler>'
);


-- S. 72 4성부 남성 합창곡 S. 72

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4성부 남성 합창곡 S. 72', 'Vierstimmige Männergesänge, S. 72', 'album', NULL, 'S.', '72', 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4성부 남성 합창곡 S. 72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s72:1', 1, NULL, 'Rheinweinlied', 'Rheinweinlied (Wo solch ein Feuer)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '4성부 남성 합창곡 S. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s72:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s72:2', 2, NULL, 'Studentenlied aus Goethes Faust', 'Studentenlied aus Goethes Faust (Es lebt'' eine Ratt im Kellernest)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '4성부 남성 합창곡 S. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s72:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s72:3', 3, NULL, 'Reiterlied I', 'Reiterlied I (Die bange Nacht ist nun herum)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '4성부 남성 합창곡 S. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s72:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s72:4', 4, NULL, 'Reiterlied II', 'Reiterlied II (Die bange Nacht ist nun herum)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '4성부 남성 합창곡 S. 72' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s72:4'
);


-- S. 73 합창곡 <Es war einmal ein König>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Es war einmal ein König>', 'Es war einmal ein König (Flohlied)', 'song', 'S. 73', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Es war einmal ein König>'
);


-- S. 74/2 합창곡 <Das deutsche Vaterland>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Das deutsche Vaterland>', 'Das deutsche Vaterland', 'song', 'S. 74/2', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Das deutsche Vaterland>'
);


-- S. 75/3 합창곡 <Über allen Gipfeln ist Ruh'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Über allen Gipfeln ist Ruh''>', 'Über allen Gipfeln ist Ruh'' (Wanderers Nachtlied)', 'song', 'S. 75/3', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Über allen Gipfeln ist Ruh''>'
);


-- S. 76 합창곡 <Das düstre Meer umrauscht mich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Das düstre Meer umrauscht mich>', 'Das düstre Meer umrauscht mich', 'song', 'S. 76', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Das düstre Meer umrauscht mich>'
);


-- S. 76a 합창곡 <Heil! Unsrer Glocke heil>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Heil! Unsrer Glocke heil>', 'Heil! Unsrer Glocke heil', 'song', 'S. 76a', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Heil! Unsrer Glocke heil>'
);


-- S. 77 합창곡 <Die lustige Legion>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Die lustige Legion>', 'Die lustige Legion', 'song', 'S. 77', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Die lustige Legion>'
);


-- S. 78 합창곡 <Trinkspruch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Trinkspruch>', 'Trinkspruch', 'song', 'S. 78', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Trinkspruch>'
);


-- S. 79/1 합창곡 <Titan>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Titan>', 'Titan', 'song', 'S. 79/1', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Titan>'
);


-- S. 80 남성 합창곡집 <4원소>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡집 <4원소>', 'Les quatre élémens', 'album', 'S. 80', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡집 <4원소>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s80:1', 1, NULL, '땅 (La terre)', 'La terre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <4원소>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s80:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s80:2', 2, NULL, '북풍 (Les aquilons)', 'Les aquilons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <4원소>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s80:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s80:3', 3, NULL, '물결 (Les flots)', 'Les flots', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <4원소>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s80:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s80:4', 4, NULL, '별 (Les astres)', 'Les astres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <4원소>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s80:4'
);


-- S. 81/1 합창곡 <Le forgeron>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Le forgeron>', 'Le forgeron', 'song', 'S. 81/1', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Le forgeron>'
);


-- S. 81a 합창곡 <A patakhoz>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <A patakhoz>', 'A patakhoz', 'song', 'S. 81a', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <A patakhoz>'
);


-- S. 82 합창곡 <Arbeiterchor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Arbeiterchor>', 'Arbeiterchor', 'song', 'S. 82', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Arbeiterchor>'
);


-- S. 83a <헝가리아 칸타타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헝가리아 칸타타>', 'Ungaria-Kantate', 'song', 'S. 83a', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<헝가리아 칸타타>'
);


-- S. 84/2 합창곡 <Licht, mehr Licht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Licht, mehr Licht>', 'Licht, mehr Licht', 'song', 'S. 84/2', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Licht, mehr Licht>'
);


-- S. 85/3 합창곡 <Chor der Engel aus Goethes Faust II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Chor der Engel aus Goethes Faust II>', 'Chor der Engel aus Goethes Faust II', 'song', 'S. 85/3', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Chor der Engel aus Goethes Faust II>'
);


-- S. 86a 합창곡 <Festchor zur Enthüllung des Herder-Denkmals in Weimar>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Festchor zur Enthüllung des Herder-Denkmals in Weimar>', 'Festchor zur Enthüllung des Herder-Denkmals in Weimar', 'song', 'S. 86a', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Festchor zur Enthüllung des Herder-Denkmals in Weimar>'
);


-- S. 88 합창곡 <Mit klingendem Spiel I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Mit klingendem Spiel I>', 'Mit klingendem Spiel I (Morgenlied)', 'song', 'S. 88', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Mit klingendem Spiel I>'
);


-- S. 89 합창곡 <Mit klingendem Spiel II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Mit klingendem Spiel II>', 'Mit klingendem Spiel II (Morgenlied)', 'song', 'S. 89', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Mit klingendem Spiel II>'
);


-- S. 90 남성 합창곡집 <Für Männergesang>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡집 <Für Männergesang>', 'Für Männergesang, S. 90', 'album', 'S. 90', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡집 <Für Männergesang>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:1', 1, NULL, 'Vereins-Lied', 'Vereins-Lied (Frisch auf, zu neuem Leben)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:2', 2, NULL, 'Ständchen', 'Ständchen (Hüttelein, still und klein)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:3', 3, NULL, 'Wir sind nicht Mumien', 'Wir sind nicht Mumien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:4', 4, NULL, 'Vor der Schlacht', 'Vor der Schlacht (Es rufet Gott uns mahnend)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:5', 5, NULL, 'Nicht gezagt', 'Nicht gezagt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:6', 6, NULL, 'Es rufet Gott', 'Es rufet Gott', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:7', 7, NULL, 'Soldatenlied aus Faust', 'Soldatenlied aus Faust (Burgen mit hohen Mauern und Zinnen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:8', 8, NULL, 'Die alten Sagen kunden', 'Die alten Sagen kunden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:9', 9, NULL, 'Saatengrün', 'Saatengrün', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:10', 10, NULL, 'Der Gang um Mitternacht', 'Der Gang um Mitternacht (Ich schreite mit dem Geist)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:11', 11, NULL, 'Festlied zu Schillers Jubelfeier', 'Festlied zu Schillers Jubelfeier 10 November 1859', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s90:12', 12, NULL, 'Gottes ist der Orient', 'Gottes ist der Orient', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '남성 합창곡집 <Für Männergesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s90:12'
);


-- S. 91/2 합창곡 <Das Lied der Begeisterung>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Das Lied der Begeisterung>', 'Das Lied der Begeisterung', 'song', 'S. 91/2', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Das Lied der Begeisterung>'
);


-- S. 92 합창곡 <Carl August weilt mit uns>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Carl August weilt mit uns>', 'Carl August weilt mit uns', 'song', 'S. 92', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Carl August weilt mit uns>'
);


-- S. 94 합창곡 <Gruss>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Gruss>', 'Gruss', 'song', 'S. 94', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Gruss>'
);


-- S. 95 교향시 <산 위에서 들은 것>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <산 위에서 들은 것>', 'Symphonic Poem <Ce qu''on entend sur la montagne>', 'song', 'S. 95', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <산 위에서 들은 것>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64ff79db-fb6a-3760-991a-43e48a60c6ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64ff79db-fb6a-3760-991a-43e48a60c6ae'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <산 위에서 들은 것>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64ff79db-fb6a-3760-991a-43e48a60c6ae'
);


-- S. 96 교향시 <타소, 비탄과 승리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <타소, 비탄과 승리>', 'Symphonic Poem <Tasso, lamento e trionfo>', 'song', 'S. 96', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <타소, 비탄과 승리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcf56829-d97c-3b4e-89a9-f2309ef4c872'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bcf56829-d97c-3b4e-89a9-f2309ef4c872'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <타소, 비탄과 승리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcf56829-d97c-3b4e-89a9-f2309ef4c872'
);


-- S. 98 교향시 <오르페우스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <오르페우스>', 'Symphonic Poem <Orpheus>', 'song', 'S. 98', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <오르페우스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73ead8fa-0664-3225-b3d9-da7b92b0e3e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '73ead8fa-0664-3225-b3d9-da7b92b0e3e4'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <오르페우스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73ead8fa-0664-3225-b3d9-da7b92b0e3e4'
);


-- S. 99 교향시 <프로메테우스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <프로메테우스>', 'Symphonic Poem <Prometheus>', 'song', 'S. 99', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <프로메테우스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa90c063-aaa1-31ea-95ee-eb56637858a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa90c063-aaa1-31ea-95ee-eb56637858a5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <프로메테우스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa90c063-aaa1-31ea-95ee-eb56637858a5'
);


-- S. 100 교향시 <마제파>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <마제파>', 'Symphonic Poem <Mazeppa>', 'song', 'S. 100', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <마제파>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '158e25fe-8aef-3e89-bc5e-1768c5b3aff3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '158e25fe-8aef-3e89-bc5e-1768c5b3aff3'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <마제파>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '158e25fe-8aef-3e89-bc5e-1768c5b3aff3'
);


-- S. 101 교향시 <축제의 울림>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <축제의 울림>', 'Symphonic Poem <Festklänge>', 'song', 'S. 101', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <축제의 울림>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8705ea75-26d4-3882-add6-339d9dadd102'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8705ea75-26d4-3882-add6-339d9dadd102'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <축제의 울림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8705ea75-26d4-3882-add6-339d9dadd102'
);


-- S. 102 교향시 <영웅의 장송곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <영웅의 장송곡>', 'Symphonic Poem <Héroïde funèbre>', 'song', 'S. 102', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <영웅의 장송곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17ffec80-780c-3075-8cea-2ca3e2c49cc4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17ffec80-780c-3075-8cea-2ca3e2c49cc4'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <영웅의 장송곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17ffec80-780c-3075-8cea-2ca3e2c49cc4'
);


-- S. 103 교향시 <헝가리아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <헝가리아>', 'Symphonic Poem <Hungaria>', 'song', 'S. 103', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <헝가리아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfe3db67-cec2-3dc0-9d78-c2ca4e4d0a82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dfe3db67-cec2-3dc0-9d78-c2ca4e4d0a82'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <헝가리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfe3db67-cec2-3dc0-9d78-c2ca4e4d0a82'
);


-- S. 104 교향시 <햄릿>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <햄릿>', 'Symphonic Poem <Hamlet>', 'song', 'S. 104', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <햄릿>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec212796-1704-3418-874a-469223555dcf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec212796-1704-3418-874a-469223555dcf'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <햄릿>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec212796-1704-3418-874a-469223555dcf'
);


-- S. 105 교향시 <훈족의 싸움>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <훈족의 싸움>', 'Symphonic Poem <Hunnenschlacht>', 'song', 'S. 105', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <훈족의 싸움>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0696b62e-a784-31be-bf22-31ffcec596d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0696b62e-a784-31be-bf22-31ffcec596d7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <훈족의 싸움>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0696b62e-a784-31be-bf22-31ffcec596d7'
);


-- S. 106 교향시 <이상>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <이상>', 'Symphonic Poem <Die Ideale>', 'song', 'S. 106', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <이상>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19bce121-ef5e-3bd0-a071-3f147e3c9abf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19bce121-ef5e-3bd0-a071-3f147e3c9abf'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <이상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19bce121-ef5e-3bd0-a071-3f147e3c9abf'
);


-- S. 107 교향시 <요람에서 무덤까지>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <요람에서 무덤까지>', 'Symphonic Poem <Von der Wiege bis zum Grabe>', 'album', 'S. 107', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <요람에서 무덤까지>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f89185a7-bc70-4656-9400-ba4bd55ca543'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f89185a7-bc70-4656-9400-ba4bd55ca543'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <요람에서 무덤까지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f89185a7-bc70-4656-9400-ba4bd55ca543'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6c95134-c88e-34cd-8ab6-16ab5244c0f6', 1, 'I', '요람 (Die Wiege)', 'I. Die Wiege', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <요람에서 무덤까지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6c95134-c88e-34cd-8ab6-16ab5244c0f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:def5b5cf-7665-3ef4-8d01-29c5c5aa1942', 2, 'II', '생존을 위한 투쟁 (Der Kampf ums Dasein)', 'II. Der Kampf ums Dasein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <요람에서 무덤까지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:def5b5cf-7665-3ef4-8d01-29c5c5aa1942'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:242412fa-7401-314f-8957-1d73e30cf4f2', 3, 'III', '무덤으로, 미래 생명의 요람 (Zum Grabe: die Wiege des zukünftigen Lebens)', 'III. Zum Grabe: die Wiege des zukünftigen Lebens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '교향시 <요람에서 무덤까지>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:242412fa-7401-314f-8957-1d73e30cf4f2'
);


-- S. 108 파우스트 교향곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파우스트 교향곡', 'A Faust Symphony', 'album', 'S. 108', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파우스트 교향곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b714a8b4-1e1d-4dd7-b2b4-b0275131be57'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b714a8b4-1e1d-4dd7-b2b4-b0275131be57'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파우스트 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b714a8b4-1e1d-4dd7-b2b4-b0275131be57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38cc83cf-de1c-3f3f-b45c-c04173290436', 1, 'I', '파우스트. Lento assai – Allegro impetuoso', 'I. Faust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파우스트 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38cc83cf-de1c-3f3f-b45c-c04173290436'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:623d67fa-9133-3ecb-8e80-c584011ff3d7', 2, 'II', '그레트헨. Andante soave', 'II. Gretchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파우스트 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:623d67fa-9133-3ecb-8e80-c584011ff3d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b449cc93-2366-3e53-9158-1c1021cfe7c4', 3, 'III', '메피스토펠레스. Allegro vivace, ironico', 'III. Mephistopheles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파우스트 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b449cc93-2366-3e53-9158-1c1021cfe7c4'
);


-- S. 109 단테 교향곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '단테 교향곡', 'A Symphony to Dante''s Divina Commedia', 'album', 'S. 109', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '단테 교향곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a541d25f-ac65-455d-9a83-919f140f5853'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a541d25f-ac65-455d-9a83-919f140f5853'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '단테 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a541d25f-ac65-455d-9a83-919f140f5853'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7c3c090-0b2b-4293-a770-e684b08f90a8', 1, 'I', '지옥 (Inferno)', 'I. Inferno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '단테 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7c3c090-0b2b-4293-a770-e684b08f90a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:104686e3-6cd1-4580-806a-12b078e79296', 2, 'II', '연옥 – 마니피캇 (Purgatorio – Magnificat)', 'II. Purgatorio – Magnificat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '단테 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:104686e3-6cd1-4580-806a-12b078e79296'
);


-- S. 110 레나우의 <파우스트>에 의한 2개의 에피소드

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레나우의 <파우스트>에 의한 2개의 에피소드', 'Two Episodes from Lenau''s Faust', 'album', 'S. 110', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레나우의 <파우스트>에 의한 2개의 에피소드'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eff720d2-d600-4216-a16b-74c623d9ec5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eff720d2-d600-4216-a16b-74c623d9ec5f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레나우의 <파우스트>에 의한 2개의 에피소드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eff720d2-d600-4216-a16b-74c623d9ec5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76b551a7-c564-3ee5-8468-5174b4ee5b29', 1, NULL, '밤의 행렬 (Der nächtliche Zug)', 'Der nächtliche Zug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레나우의 <파우스트>에 의한 2개의 에피소드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76b551a7-c564-3ee5-8468-5174b4ee5b29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97462861-2dd1-35b2-bf67-403d506c33db', 2, NULL, '마을 주막의 춤 "메피스토 왈츠 1번" (Der Tanz in der Dorfschenke)', 'Der Tanz in der Dorfschenke (Mephisto Waltz No. 1)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '레나우의 <파우스트>에 의한 2개의 에피소드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97462861-2dd1-35b2-bf67-403d506c33db'
);


-- S. 112 3개의 장송 송가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 장송 송가', 'Three Odes funèbres', 'album', 'S. 112', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 장송 송가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '349d9bc4-8bc4-47e5-80f7-921bd07fdb26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '349d9bc4-8bc4-47e5-80f7-921bd07fdb26'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 장송 송가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '349d9bc4-8bc4-47e5-80f7-921bd07fdb26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25e5e535-98a3-4c20-860c-858a53491b44', 1, NULL, '죽은 이들 (Les morts)', 'Les morts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 장송 송가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25e5e535-98a3-4c20-860c-858a53491b44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d1b1e89-4518-4f1d-a9ca-6b7f0bb697a1', 2, NULL, '밤 (La notte)', 'La notte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 장송 송가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d1b1e89-4518-4f1d-a9ca-6b7f0bb697a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8616356-ec63-4e63-95b8-821be4bc207d', 3, NULL, '타소의 장례 개선 (Le triomphe funèbre du Tasse)', 'Le triomphe funèbre du Tasse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 장송 송가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8616356-ec63-4e63-95b8-821be4bc207d'
);


-- S. 113/2 관현악곡 <살베 폴로니아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악곡 <살베 폴로니아>', 'Salve Polonia', 'song', 'S. 113/2', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악곡 <살베 폴로니아>'
);


-- S. 114 <예술가 축제 행렬>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<예술가 축제 행렬>', 'Künstlerfestzug zur Schillerfeier 1859', 'song', 'S. 114', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<예술가 축제 행렬>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a4db02b-fafa-46cc-8ee2-7befcf32c919'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a4db02b-fafa-46cc-8ee2-7befcf32c919'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<예술가 축제 행렬>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a4db02b-fafa-46cc-8ee2-7befcf32c919'
);


-- S. 115 <괴테 기념 축제 행진곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<괴테 기념 축제 행진곡>', 'Festmarsch zur Goethe-Jubiläumsfeier', 'song', 'S. 115', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<괴테 기념 축제 행진곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d17fbe3-15ae-4d41-8977-b2b382d648b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d17fbe3-15ae-4d41-8977-b2b382d648b1'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<괴테 기념 축제 행진곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d17fbe3-15ae-4d41-8977-b2b382d648b1'
);


-- S. 118 <헝가리 대관식 행진곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헝가리 대관식 행진곡>', 'Ungarischer Marsch zur Krönungsfeier in Ofen-Pest', 'song', 'S. 118', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<헝가리 대관식 행진곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45a7e0dd-fa68-4a45-a4db-63e27bc380fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '45a7e0dd-fa68-4a45-a4db-63e27bc380fe'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<헝가리 대관식 행진곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45a7e0dd-fa68-4a45-a4db-63e27bc380fe'
);


-- S. 119 <헝가리 돌격 행진곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헝가리 돌격 행진곡>', 'Ungarischer Sturmmarsch', 'song', 'S. 119', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<헝가리 돌격 행진곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca330065-9551-3419-91ee-776df662d2d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca330065-9551-3419-91ee-776df662d2d2'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<헝가리 돌격 행진곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca330065-9551-3419-91ee-776df662d2d2'
);


-- S. 121 <저주> E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<저주> E단조', 'Malédiction in E minor', 'song', 'S. 121', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<저주> E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b5584aa-8da7-30d0-adb6-bbabb543f214'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b5584aa-8da7-30d0-adb6-bbabb543f214'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<저주> E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b5584aa-8da7-30d0-adb6-bbabb543f214'
);


-- S. 123 헝가리 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리 환상곡', 'Fantasia on Hungarian Folk Melodies', 'song', 'S. 123', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91a50e75-b848-39e6-a3a7-a00f1409b1fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91a50e75-b848-39e6-a3a7-a00f1409b1fe'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91a50e75-b848-39e6-a3a7-a00f1409b1fe'
);


-- S. 124 피아노 협주곡 1번 E♭장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85774df8-4b47-40ca-a135-d455eeb8cd3f', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 450 AND p.composer_id = 30
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85774df8-4b47-40ca-a135-d455eeb8cd3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:549a796b-e6f1-435d-b10d-f27ca444d95e', 2, 'II', 'Quasi adagio', 'II. Quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 450 AND p.composer_id = 30
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:549a796b-e6f1-435d-b10d-f27ca444d95e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74025515-9cc2-4a60-8b6a-c7152f900a75', 3, 'III', 'Allegretto vivace – Allegro animato', 'III. Allegretto vivace – Allegro animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 450 AND p.composer_id = 30
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74025515-9cc2-4a60-8b6a-c7152f900a75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73b32631-9327-4ce1-bd68-f052c784ae88', 4, 'IV', 'Allegro marziale animato', 'IV. Allegro marziale animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 450 AND p.composer_id = 30
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73b32631-9327-4ce1-bd68-f052c784ae88'
);


-- S. 125 피아노 협주곡 2번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번 A장조', 'Piano Concerto No. 2 in A major', 'song', 'S. 125', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1652cc0-12cd-42a8-9910-eea995a9e1cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1652cc0-12cd-42a8-9910-eea995a9e1cb'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 협주곡 2번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1652cc0-12cd-42a8-9910-eea995a9e1cb'
);


-- S. 126ii <죽음의 무도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<죽음의 무도>', 'Totentanz', 'song', 'S. 126ii', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<죽음의 무도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32eb27c7-1f61-3061-b2b7-bde4bd474e32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32eb27c7-1f61-3061-b2b7-bde4bd474e32'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<죽음의 무도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32eb27c7-1f61-3061-b2b7-bde4bd474e32'
);


-- S. 126b 바이올린과 피아노를 위한 2개의 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 2개의 왈츠', 'Two Waltzes for Violin and Piano', 'album', 'S. 126b', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 2개의 왈츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24bb9269-5672-4ca2-9ab7-fae0ae559496'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24bb9269-5672-4ca2-9ab7-fae0ae559496'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '바이올린과 피아노를 위한 2개의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24bb9269-5672-4ca2-9ab7-fae0ae559496'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeca4941-e7f6-4751-ae6e-5ca93697d5be', 1, NULL, 'A장조', 'No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '바이올린과 피아노를 위한 2개의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeca4941-e7f6-4751-ae6e-5ca93697d5be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:870fe745-7f86-4e26-8e33-48d5321887ee', 2, NULL, 'A장조 (<아마존> 발레 주제)', 'No. 2 in A major (Waltz from the ballet Die Amazonen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '바이올린과 피아노를 위한 2개의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:870fe745-7f86-4e26-8e33-48d5321887ee'
);


-- S. 127 듀오 소나타 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '듀오 소나타 C#단조', 'Duo (Sonata) in C# minor', 'album', 'S. 127', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '듀오 소나타 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bca67fa8-9631-4838-b022-34014715284f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bca67fa8-9631-4838-b022-34014715284f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '듀오 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bca67fa8-9631-4838-b022-34014715284f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76d0c398-1f7b-4697-8069-87dcaf931b64', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '듀오 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76d0c398-1f7b-4697-8069-87dcaf931b64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58a20605-64fb-471d-813e-d66d15d85f96', 2, 'II', '주제와 변주', 'II. Tema con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '듀오 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58a20605-64fb-471d-813e-d66d15d85f96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c2f5356-de0d-4593-a295-ca98047d3a65', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '듀오 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c2f5356-de0d-4593-a295-ca98047d3a65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbed01d6-d74c-435a-a5a4-ae62bb4ffd2d', 4, 'IV', 'Allegro con brio', 'IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '듀오 소나타 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbed01d6-d74c-435a-a5a4-ae62bb4ffd2d'
);


-- S. 128 "르 마랭" 주제에 의한 그랑 듀오 콘세르탕

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"르 마랭" 주제에 의한 그랑 듀오 콘세르탕', 'Grand duo concertant sur la romance de M. Lafont "Le marin"', 'song', 'S. 128', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"르 마랭" 주제에 의한 그랑 듀오 콘세르탕'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f62d4c6b-9a9c-47d7-a532-de840350fd4b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f62d4c6b-9a9c-47d7-a532-de840350fd4b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '"르 마랭" 주제에 의한 그랑 듀오 콘세르탕' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f62d4c6b-9a9c-47d7-a532-de840350fd4b'
);


-- S. 129 <결혼 축가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<결혼 축가>', 'Epithalam', 'song', 'S. 129', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<결혼 축가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eea44f7a-319f-451f-a983-fcf85a4c3a76'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eea44f7a-319f-451f-a983-fcf85a4c3a76'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<결혼 축가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eea44f7a-319f-451f-a983-fcf85a4c3a76'
);


-- S. 135 <리하르트 바그너의 무덤에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<리하르트 바그너의 무덤에서>', 'Am Grabe Richard Wagners', 'song', 'S. 135', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<리하르트 바그너의 무덤에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd269ec4c-df80-47d1-a125-0293b96d0f39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd269ec4c-df80-47d1-a125-0293b96d0f39'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<리하르트 바그너의 무덤에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd269ec4c-df80-47d1-a125-0293b96d0f39'
);


-- S. 139 초절기교 연습곡 S. 139

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '초절기교 연습곡 S. 139', '12 Transcendental Études, S. 139', 'album', NULL, 'S.', '139', 1851, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '초절기교 연습곡 S. 139'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '675ac1b7-fff4-4975-a93b-cd32fbc16f4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '675ac1b7-fff4-4975-a93b-cd32fbc16f4a'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '675ac1b7-fff4-4975-a93b-cd32fbc16f4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14fb6614-ead1-47ec-b774-1709482b87f2', 1, NULL, 'C장조 "전주곡"', 'No. 1 in C major "Preludio"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14fb6614-ead1-47ec-b774-1709482b87f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4b29441-5bcc-4bc2-974b-a47c8e1908d5', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4b29441-5bcc-4bc2-974b-a47c8e1908d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:601b44d8-032b-410d-a166-d8726bda71c0', 3, NULL, 'F장조 "풍경"', 'No. 3 in F major "Paysage"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:601b44d8-032b-410d-a166-d8726bda71c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 143 AND linked.composer_id = 30), 'musicbrainz:3ea62b96-e31e-4797-8d7b-cdeadbc6f27f', 4, NULL, 'D단조 "마제파"', 'No. 4 in D minor "Mazeppa"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ea62b96-e31e-4797-8d7b-cdeadbc6f27f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:406b1c30-84b4-4365-92af-ca67240f5940', 5, NULL, 'B♭장조 "도깨비불"', 'No. 5 in B♭ major "Feux follets"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:406b1c30-84b4-4365-92af-ca67240f5940'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3928f759-c763-4cd0-9eff-7d28c4216fac', 6, NULL, 'G단조 "환영"', 'No. 6 in G minor "Vision"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3928f759-c763-4cd0-9eff-7d28c4216fac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b93bad4-0721-46e4-8f58-500c784d554c', 7, NULL, 'E♭장조 "영웅"', 'No. 7 in E♭ major "Eroica"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b93bad4-0721-46e4-8f58-500c784d554c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:903cd6b1-7c38-4fb1-9c79-0922ed1729c9', 8, NULL, 'C단조 "사냥"', 'No. 8 in C minor "Wilde Jagd"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:903cd6b1-7c38-4fb1-9c79-0922ed1729c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e199b78f-62c9-4979-9db6-5e2025159b9b', 9, NULL, 'A♭장조 "회상"', 'No. 9 in A♭ major "Ricordanza"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e199b78f-62c9-4979-9db6-5e2025159b9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86be8932-9d20-495a-ab56-76b56e8095b7', 10, NULL, 'F단조', 'No. 10 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86be8932-9d20-495a-ab56-76b56e8095b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:602e1001-0823-4108-a016-b18f03ac8954', 11, NULL, 'D♭장조 "저녁의 선율"', 'No. 11 in D♭ major "Harmonies du soir"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:602e1001-0823-4108-a016-b18f03ac8954'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b116c976-d5a0-497c-b76a-54db9e2a6b93', 12, NULL, 'B♭단조 "눈보라"', 'No. 12 in B♭ minor "Chasse-neige"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '초절기교 연습곡 S. 139' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b116c976-d5a0-497c-b76a-54db9e2a6b93'
);


-- S. 141 파가니니 대연습곡 S. 141

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파가니니 대연습곡 S. 141', '6 Grandes études de Paganini, S. 141', 'album', NULL, 'S.', '141', 1851, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파가니니 대연습곡 S. 141'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5346c5d4-ae67-46c6-981b-553c0a6ad583'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5346c5d4-ae67-46c6-981b-553c0a6ad583'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파가니니 대연습곡 S. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5346c5d4-ae67-46c6-981b-553c0a6ad583'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e828543-9344-39cc-8027-63f399d08dec', 1, NULL, 'G단조 "트레몰로"', 'No. 1 in G minor "Tremolo"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파가니니 대연습곡 S. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e828543-9344-39cc-8027-63f399d08dec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32be0f66-0a50-352d-a2b1-12a6181494d6', 2, NULL, 'E♭장조 "옥타브"', 'No. 2 in E♭ major "Octave"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파가니니 대연습곡 S. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32be0f66-0a50-352d-a2b1-12a6181494d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 140 AND linked.composer_id = 30), 'musicbrainz:b6a880ce-35bc-357e-aade-a251fc021a66', 3, NULL, 'G#단조 "라 캄파넬라"', 'No. 3 in G# minor "La campanella"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파가니니 대연습곡 S. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6a880ce-35bc-357e-aade-a251fc021a66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85c3ecaf-d99a-34fb-9f2e-017103629796', 4, NULL, 'E장조 "아르페지오"', 'No. 4 in E major "Arpeggio"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파가니니 대연습곡 S. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85c3ecaf-d99a-34fb-9f2e-017103629796'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e49db9a5-62c6-3df1-929d-874092fabb61', 5, NULL, 'E장조 "사냥"', 'No. 5 in E major "La chasse"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파가니니 대연습곡 S. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e49db9a5-62c6-3df1-929d-874092fabb61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:033e587a-6cbb-3c83-a28a-33e43c012a64', 6, NULL, 'A단조 "주제와 변주"', 'No. 6 in A minor "Theme and Variations"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '파가니니 대연습곡 S. 141' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:033e587a-6cbb-3c83-a28a-33e43c012a64'
);


-- S. 143 연습곡 E단조 "아브 이라토"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연습곡 E단조 "아브 이라토"', 'Étude in E minor "Ab irato"', 'song', 'S. 143', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연습곡 E단조 "아브 이라토"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6800fae2-f02a-338d-aa8e-e2d67b00b4ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6800fae2-f02a-338d-aa8e-e2d67b00b4ab'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '연습곡 E단조 "아브 이라토"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6800fae2-f02a-338d-aa8e-e2d67b00b4ab'
);


-- S. 144 3개의 연주회용 연습곡 S. 144

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 연주회용 연습곡 S. 144', '3 Études de concert, S. 144', 'album', NULL, 'S.', '144', 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 연주회용 연습곡 S. 144'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9527e1b-13d9-4ef5-8d99-5af2e7f6f895'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9527e1b-13d9-4ef5-8d99-5af2e7f6f895'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 연주회용 연습곡 S. 144' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9527e1b-13d9-4ef5-8d99-5af2e7f6f895'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16746656-dc9a-337f-9ef9-3ee954f3733e', 1, NULL, 'A♭장조 "탄식"', 'No. 1 in A♭ major "Il lamento"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 연주회용 연습곡 S. 144' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16746656-dc9a-337f-9ef9-3ee954f3733e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fa00411-288d-36da-b1f5-f6ed08d64b5a', 2, NULL, 'F단조 "가벼움"', 'No. 2 in F minor "La leggierezza"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 연주회용 연습곡 S. 144' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fa00411-288d-36da-b1f5-f6ed08d64b5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebacd0a3-ee0d-32e6-9279-441c068918ea', 3, NULL, 'D♭장조 "한숨"', 'No. 3 in D♭ major "Un sospiro"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 연주회용 연습곡 S. 144' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebacd0a3-ee0d-32e6-9279-441c068918ea'
);


-- S. 145 2개의 연주회용 연습곡 S. 145

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 연주회용 연습곡 S. 145', '2 Konzertetüden, S. 145', 'album', NULL, 'S.', '145', 1862, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 연주회용 연습곡 S. 145'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd392438e-3c33-45da-9d75-797c6e7dfd6e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd392438e-3c33-45da-9d75-797c6e7dfd6e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 연주회용 연습곡 S. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd392438e-3c33-45da-9d75-797c6e7dfd6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:456d35b0-fb23-38de-967d-e8e29b0c8cb8', 1, NULL, 'D♭장조 "숲의 속삭임"', 'No. 1 in D♭ major "Waldesrauschen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 연주회용 연습곡 S. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:456d35b0-fb23-38de-967d-e8e29b0c8cb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa55df70-75a7-3304-9859-7c06587c0c38', 2, NULL, 'F#단조 "난쟁이의 춤"', 'No. 2 in F# minor "Gnomenreigen"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 연주회용 연습곡 S. 145' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa55df70-75a7-3304-9859-7c06587c0c38'
);


-- S. 146 <기술적 연습곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<기술적 연습곡>', 'Technische Studien', 'song', 'S. 146', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<기술적 연습곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53b8d703-243f-46e1-9ec4-9e70a2e40296'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '53b8d703-243f-46e1-9ec4-9e70a2e40296'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<기술적 연습곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53b8d703-243f-46e1-9ec4-9e70a2e40296'
);


-- S. 147 디아벨리 왈츠에 의한 변주 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '디아벨리 왈츠에 의한 변주 C단조', 'Variation on a Waltz by Diabelli in C minor', 'song', 'S. 147', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '디아벨리 왈츠에 의한 변주 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '986477ad-5db6-4b88-97ea-87defc3be3ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '986477ad-5db6-4b88-97ea-87defc3be3ab'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '디아벨리 왈츠에 의한 변주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '986477ad-5db6-4b88-97ea-87defc3be3ab'
);


-- S. 148 8개의 변주곡 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8개의 변주곡 A♭장조', '8 Variations in A♭ major', 'song', 'S. 148', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8개의 변주곡 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9fdf3f6b-df59-4c26-bb7a-7a17af9b352c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9fdf3f6b-df59-4c26-bb7a-7a17af9b352c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '8개의 변주곡 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9fdf3f6b-df59-4c26-bb7a-7a17af9b352c'
);


-- S. 149 로시니 주제에 의한 7개의 화려한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로시니 주제에 의한 7개의 화려한 변주곡', '7 Variations brillantes sur un thème de Rossini', 'song', 'S. 149', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로시니 주제에 의한 7개의 화려한 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e797589-53b0-4fc6-915a-b4586d845140'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8e797589-53b0-4fc6-915a-b4586d845140'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '로시니 주제에 의한 7개의 화려한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8e797589-53b0-4fc6-915a-b4586d845140'
);


-- S. 151 알레그로 디 브라부라 E♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그로 디 브라부라 E♭단조', 'Allegro di bravura in E♭ minor', 'song', 'S. 151', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그로 디 브라부라 E♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecec0fbc-b851-45f2-badf-9dfafb6e8116'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ecec0fbc-b851-45f2-badf-9dfafb6e8116'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '알레그로 디 브라부라 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecec0fbc-b851-45f2-badf-9dfafb6e8116'
);


-- S. 151a 아다지오 논 트로포

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오 논 트로포', 'Adagio non troppo', 'song', 'S. 151a', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오 논 트로포'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f7bc055-338f-4938-9081-dedb8cc5d6b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f7bc055-338f-4938-9081-dedb8cc5d6b7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '아다지오 논 트로포' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f7bc055-338f-4938-9081-dedb8cc5d6b7'
);


-- S. 152 론도 디 브라부라 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 디 브라부라 E단조', 'Rondo di bravura in E minor', 'song', 'S. 152', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 디 브라부라 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ddc2ce9-9689-41e4-86c5-24087d9e6f4d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ddc2ce9-9689-41e4-86c5-24087d9e6f4d'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '론도 디 브라부라 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ddc2ce9-9689-41e4-86c5-24087d9e6f4d'
);


-- S. 152a 피아노곡 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 A♭장조', 'Klavierstück in A♭ major', 'song', 'S. 152a', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 A♭장조'
);


-- S. 153 스케르초 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 G단조', 'Scherzo in G minor', 'song', 'S. 153', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb94feaf-a28f-4e7e-8a4d-bf6a62d32a57'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb94feaf-a28f-4e7e-8a4d-bf6a62d32a57'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '스케르초 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb94feaf-a28f-4e7e-8a4d-bf6a62d32a57'
);


-- S. 155 피아노 모음곡 <환영>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <환영>', 'Apparitions', 'album', 'S. 155', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <환영>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11a0e16a-ba65-46ff-8aaf-f37ee2bceede'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11a0e16a-ba65-46ff-8aaf-f37ee2bceede'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11a0e16a-ba65-46ff-8aaf-f37ee2bceede'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46ec2c03-0b36-438f-b6cd-d1ffe74604ab', 1, NULL, 'F#장조', 'No. 1 in F# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46ec2c03-0b36-438f-b6cd-d1ffe74604ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4071f6b0-bd90-436d-86fc-3768a6d60a97', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4071f6b0-bd90-436d-86fc-3768a6d60a97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f3db99a-66bf-4f10-9dd9-59c8a10697aa', 3, NULL, '슈베르트 왈츠에 의한 환상곡', 'No. 3 Fantaisie sur une valse de François Schubert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <환영>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f3db99a-66bf-4f10-9dd9-59c8a10697aa'
);


-- S. 156 피아노 모음곡 <나그네의 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <나그네의 앨범>', 'Album d''un voyageur', 'album', 'S. 156', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <나그네의 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83ae0cb4-3ed1-4703-bf98-5fcc4d49fe3b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '83ae0cb4-3ed1-4703-bf98-5fcc4d49fe3b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83ae0cb4-3ed1-4703-bf98-5fcc4d49fe3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d', 1, NULL, '인상과 시 (Impressions et poésies)', 'I. Impressions et poésies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d0f3eab-ad46-4586-9fcc-c07c18d8475f', 1, NULL, '리옹 (Lyon)', 'Lyon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0f3eab-ad46-4586-9fcc-c07c18d8475f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:745b54c9-dc61-4f9c-a1d1-611cd15072d9', 2, NULL, '발렌슈타트 호수 (Le lac de Wallenstadt)', 'Le lac de Wallenstadt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:745b54c9-dc61-4f9c-a1d1-611cd15072d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:01d0f40b-ffa7-4344-9a5c-044e75d887c7', 3, NULL, '샘가에서 (Au bord d''une source)', 'Au bord d''une source', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01d0f40b-ffa7-4344-9a5c-044e75d887c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d521ec11-b273-4a13-a5e4-03f91c9bc182', 4, NULL, '제네바의 종 (Les cloches de Genève)', 'Les cloches de G[enève]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d521ec11-b273-4a13-a5e4-03f91c9bc182'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bed6ab15-b0a7-48db-90af-bf1e2537302b', 5, NULL, '오베르만의 골짜기 (Vallée d''Obermann)', 'Vallée d''Obermann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bed6ab15-b0a7-48db-90af-bf1e2537302b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82f2cd35-a618-4c9b-98f7-4693d2ef4c4f', 6, NULL, '빌헬름 텔의 성당 (La chapelle de Guillaume Tell)', 'La chapelle de Guillaume Tell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82f2cd35-a618-4c9b-98f7-4693d2ef4c4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc6dfbd5-d67d-4f5a-808e-4b0d807afc25', 7, NULL, '시편 (Psaume)', 'Psaume (de l''église à Genève)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7c5f3e8e-5f22-44d2-bcf9-333ed6e9f83d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc6dfbd5-d67d-4f5a-808e-4b0d807afc25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d', 2, NULL, '알프스의 선율의 꽃 (Fleurs mélodiques des Alpes)', 'II. Fleurs mélodiques des Alpes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c16cad7-184b-4179-aeae-587dca1ef3a7', 1, NULL, 'C장조', 'No. 8 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c16cad7-184b-4179-aeae-587dca1ef3a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73733ec0-5574-4435-8a4e-8faed040779c', 2, NULL, 'E단조', 'No. 9 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73733ec0-5574-4435-8a4e-8faed040779c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f771fd88-d4cb-4dcd-90d4-94344a45ff88', 3, NULL, 'G장조', 'No. 10 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f771fd88-d4cb-4dcd-90d4-94344a45ff88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69e406ff-45ec-4910-8ea9-2d37e8535222', 4, NULL, 'G장조', 'No. 11 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69e406ff-45ec-4910-8ea9-2d37e8535222'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f49deeb-ca87-4262-816d-9c2bbca4a74a', 5, NULL, 'G단조', 'No. 12 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f49deeb-ca87-4262-816d-9c2bbca4a74a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5974f144-c8f4-4962-9bbb-2e5a569df9e3', 6, NULL, 'E장조', 'No. 13 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5974f144-c8f4-4962-9bbb-2e5a569df9e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc34d622-6e20-43b7-acb6-3eed26c2b705', 7, NULL, 'A♭장조', 'No. 14 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc34d622-6e20-43b7-acb6-3eed26c2b705'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d12be8c-3aca-4726-84b7-ecd41d5a6cba', 8, NULL, 'D♭장조', 'No. 15 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d12be8c-3aca-4726-84b7-ecd41d5a6cba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47a68d11-edfb-46fd-9677-5037f4893b5f', 9, NULL, 'G장조', 'No. 16 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91183c7f-d187-4b51-a117-a7173b5e587d'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47a68d11-edfb-46fd-9677-5037f4893b5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65b8cd0f-099e-4240-9177-e58878354229', 3, NULL, '패러프레이즈 (Paraphrases)', 'III. Paraphrases', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65b8cd0f-099e-4240-9177-e58878354229'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85cd847f-e310-445c-9c4c-f529b7d145db', 1, NULL, '소 부르는 노래 (Ranz de vaches)', 'Ranz de vaches (Montée aux Alpes: Improvisata)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65b8cd0f-099e-4240-9177-e58878354229'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85cd847f-e310-445c-9c4c-f529b7d145db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:add9f963-2c8a-4a77-8a0e-5030147c5025', 2, NULL, '산속의 저녁 (Un soir dans les montagnes)', 'Un soir dans les montagnes (Nocturne pastoral)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65b8cd0f-099e-4240-9177-e58878354229'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:add9f963-2c8a-4a77-8a0e-5030147c5025'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c9f92e6-548d-4d5a-8195-2d718499cbf5', 3, NULL, '염소 부르는 노래 (Ranz de chèvres)', 'Ranz de chèvres de F. Huber (Allegro finale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65b8cd0f-099e-4240-9177-e58878354229'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <나그네의 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c9f92e6-548d-4d5a-8195-2d718499cbf5'
);


-- S. 156a 피아노 모음곡 <3개의 스위스 소품>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <3개의 스위스 소품>', 'Trois morceaux suisses', 'album', 'S. 156a', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <3개의 스위스 소품>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '054d120e-9786-4379-84b1-85954bae4370'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '054d120e-9786-4379-84b1-85954bae4370'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <3개의 스위스 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '054d120e-9786-4379-84b1-85954bae4370'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9dc421a-cd57-4151-9b89-529ee3e471dc', 1, NULL, '소 부르는 노래 (Ranz de vaches)', 'Ranz de vaches (Mélodie de Ferdinand Huber, avec variations)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <3개의 스위스 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9dc421a-cd57-4151-9b89-529ee3e471dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e778f939-eb56-4e76-ac83-8881ed3ac5e1', 2, NULL, '산속의 저녁 (Un soir dans la montagne)', 'Un soir dans la montagne (Mélodie d''Ernest Knop)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <3개의 스위스 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e778f939-eb56-4e76-ac83-8881ed3ac5e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a3e3e03-7826-4edc-a111-680bf618c823', 3, NULL, '염소 부르는 노래 (Ranz de chèvres)', 'Ranz de chèvres (Rondeau)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <3개의 스위스 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a3e3e03-7826-4edc-a111-680bf618c823'
);


-- S. 157 두 개의 스위스 선율에 의한 낭만적 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 개의 스위스 선율에 의한 낭만적 환상곡', 'Fantaisie romantique sur deux mélodies suisses', 'song', 'S. 157', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 개의 스위스 선율에 의한 낭만적 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4aecd810-7ba0-4be6-8171-35f7bfb8b9dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4aecd810-7ba0-4be6-8171-35f7bfb8b9dd'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '두 개의 스위스 선율에 의한 낭만적 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4aecd810-7ba0-4be6-8171-35f7bfb8b9dd'
);


-- S. 157d 콰지 마주르카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콰지 마주르카', 'Quasi mazurka', 'song', 'S. 157d', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콰지 마주르카'
);


-- S. 160 피아노 모음곡 <순례의 해 제1년: 스위스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <순례의 해 제1년: 스위스>', 'Années de pèlerinage I: Suisse', 'album', 'S. 160', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <순례의 해 제1년: 스위스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5800420-373c-46b3-af4c-173295812817'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5800420-373c-46b3-af4c-173295812817'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5800420-373c-46b3-af4c-173295812817'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5804701d-54a6-4c9d-afb9-3e01d6704e5a', 1, NULL, '빌헬름 텔의 성당 (Chapelle de Guillaume Tell)', 'Chapelle de Guillaume Tell', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5804701d-54a6-4c9d-afb9-3e01d6704e5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67bb0266-41c3-4a0a-86ff-9735b608bfa2', 2, NULL, '발렌슈타트 호수에서 (Au lac de Wallenstadt)', 'Au lac de Wallenstadt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67bb0266-41c3-4a0a-86ff-9735b608bfa2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd78778a-3d31-4ac0-9809-398bf0a2ddeb', 3, NULL, '전원곡 (Pastorale)', 'Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd78778a-3d31-4ac0-9809-398bf0a2ddeb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ed7e1b0-d7ff-35ed-be6c-561041de97b5', 4, NULL, '샘가에서 (Au bord d''une source)', 'Au bord d''une source', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ed7e1b0-d7ff-35ed-be6c-561041de97b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:711c761a-c766-41b4-a509-68240d5f259e', 5, NULL, '뇌우 (Orage)', 'Orage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:711c761a-c766-41b4-a509-68240d5f259e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b428b55c-1f68-4a34-a643-a65a6b791b65', 6, NULL, '오베르만의 골짜기 (Vallée d''Obermann)', 'Vallée d''Obermann', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b428b55c-1f68-4a34-a643-a65a6b791b65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a47f337-9e3b-44d0-b36d-2d59293b633f', 7, NULL, '목가 (Églogue)', 'Eglogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a47f337-9e3b-44d0-b36d-2d59293b633f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8a09f21-a7cd-49e5-aac7-60f0e427a7ce', 8, NULL, '향수 (Le mal du pays)', 'Le mal du pays (Heimweh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8a09f21-a7cd-49e5-aac7-60f0e427a7ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:676f6953-af37-465e-8af6-711cf727567c', 9, NULL, '제네바의 종 (Les cloches de Genève)', 'Les cloches de Genève', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제1년: 스위스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:676f6953-af37-465e-8af6-711cf727567c'
);


-- S. 161 피아노 모음곡 <순례의 해 제2년: 이탈리아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <순례의 해 제2년: 이탈리아>', 'Années de pèlerinage II: Italie', 'album', 'S. 161', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '727049da-e7fe-4213-844f-780be027a2c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '727049da-e7fe-4213-844f-780be027a2c9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '727049da-e7fe-4213-844f-780be027a2c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebf07653-914c-46b4-869c-ae69a1e20bfa', 1, NULL, '혼례 (Sposalizio)', 'Sposalizio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebf07653-914c-46b4-869c-ae69a1e20bfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0c88a4e-e296-49fa-8ee0-2d54ebf1b6ee', 2, NULL, '생각에 잠긴 사람 (Il penseroso)', 'Il penseroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0c88a4e-e296-49fa-8ee0-2d54ebf1b6ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c125008d-921a-49da-8568-5dc6aac973dd', 3, NULL, '살바토르 로사의 칸초네타 (Canzonetta del Salvator Rosa)', 'Canzonetta del Salvator Rosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c125008d-921a-49da-8568-5dc6aac973dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:37a20c08-a7ad-3ea6-8647-b9666170bcb2', 4, NULL, '페트라르카의 소네트 47번 (Sonetto 47 del Petrarca)', 'Sonetto 47 del Petrarca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37a20c08-a7ad-3ea6-8647-b9666170bcb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:191f15d6-b828-3758-a23e-51417fa006c5', 5, NULL, '페트라르카의 소네트 104번 (Sonetto 104 del Petrarca)', 'Sonetto 104 del Petrarca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:191f15d6-b828-3758-a23e-51417fa006c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03d57967-0170-3686-bcaf-021ee19e72f1', 6, NULL, '페트라르카의 소네트 123번 (Sonetto 123 del Petrarca)', 'Sonetto 123 del Petrarca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d57967-0170-3686-bcaf-021ee19e72f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd803a97-de2e-44e6-9082-13f48a1afd3e', 7, NULL, '단테를 읽고: 소나타풍 환상곡 (Après une lecture du Dante: Fantasia quasi Sonata)', 'Après une lecture du Dante (Fantasia quasi Sonata)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년: 이탈리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd803a97-de2e-44e6-9082-13f48a1afd3e'
);


-- S. 162 피아노 모음곡 <순례의 해 제2년 보유: 베네치아와 나폴리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <순례의 해 제2년 보유: 베네치아와 나폴리>', 'Années de pèlerinage II, Supplément: Venezia e Napoli', 'album', 'S. 162', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <순례의 해 제2년 보유: 베네치아와 나폴리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dd9bc61-4d9f-40eb-8d50-84c52447aa0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dd9bc61-4d9f-40eb-8d50-84c52447aa0f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년 보유: 베네치아와 나폴리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dd9bc61-4d9f-40eb-8d50-84c52447aa0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2af1ff39-a716-4fc4-948e-9f516774a139', 1, NULL, '곤돌라 뱃노래 (Gondoliera)', 'Gondoliera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년 보유: 베네치아와 나폴리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2af1ff39-a716-4fc4-948e-9f516774a139'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c8f029f-ae59-49eb-8ce9-2bec46cfe063', 2, NULL, '칸초네 (Canzone)', 'Canzone', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년 보유: 베네치아와 나폴리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c8f029f-ae59-49eb-8ce9-2bec46cfe063'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab1b5891-e692-361b-b854-8748797dc6fe', 3, NULL, '타란텔라 (Tarantella)', 'Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제2년 보유: 베네치아와 나폴리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab1b5891-e692-361b-b854-8748797dc6fe'
);


-- S. 163 피아노 모음곡 <순례의 해 제3년>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <순례의 해 제3년>', 'Années de pèlerinage III', 'album', 'S. 163', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <순례의 해 제3년>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fb12d62-1eac-4b5c-adf2-209fb072a516'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5fb12d62-1eac-4b5c-adf2-209fb072a516'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제3년>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5fb12d62-1eac-4b5c-adf2-209fb072a516'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35943e36-dc25-4f7c-9747-fdaaab4a20c1', 1, NULL, '삼종기도! 수호천사에게 드리는 기도 (Angelus! Prière aux anges gardiens)', 'Angelus! Prière aux anges gardiens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제3년>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35943e36-dc25-4f7c-9747-fdaaab4a20c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a90d941-aabe-45c5-a4d7-db08f0ffd47d', 2, NULL, '에스테 장의 사이프러스에게: 애가 I (Aux cyprès de la Villa d''Este: Thrénodie I)', 'Aux cyprès de la Villa d''Este (Thrénodie I)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제3년>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a90d941-aabe-45c5-a4d7-db08f0ffd47d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:739010d6-8bb1-4d71-a70c-e49cbc8a944d', 3, NULL, '에스테 장의 사이프러스에게: 애가 II (Aux cyprès de la Villa d''Este: Thrénodie II)', 'Aux cyprès de la Villa d''Este (Thrénodie II)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제3년>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:739010d6-8bb1-4d71-a70c-e49cbc8a944d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdd04666-9c32-3f15-b7e3-23883c67cfe2', 4, NULL, '에스테 장의 분수 (Les jeux d''eaux à la Villa d''Este)', 'Les jeux d''eaux à la Villa d''Este', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제3년>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdd04666-9c32-3f15-b7e3-23883c67cfe2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84c4a9d4-db63-4b97-85ce-ce08b35d96f0', 5, NULL, '눈물 어린 것들, 헝가리 선법으로 (Sunt lacrymae rerum, en mode hongrois)', 'Sunt lacrymae rerum, en mode hongrois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제3년>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84c4a9d4-db63-4b97-85ce-ce08b35d96f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2525fd3-dfc1-4596-b13c-d25f61745070', 6, NULL, '장송 행진곡 (Marche funèbre)', 'Marche funèbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제3년>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2525fd3-dfc1-4596-b13c-d25f61745070'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ff4010a-c7ed-460d-85e8-2aec2be9df82', 7, NULL, '마음을 드높이 (Sursum corda)', 'Sursum corda (Erhebet eure Herzen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <순례의 해 제3년>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ff4010a-c7ed-460d-85e8-2aec2be9df82'
);


-- S. 163a/1 앨범의 한 페이지 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 F#단조', 'Album Leaf in F# minor', 'song', 'S. 163a/1', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06f6c2ad-c4c2-4a0c-be9c-fab12462aab5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06f6c2ad-c4c2-4a0c-be9c-fab12462aab5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06f6c2ad-c4c2-4a0c-be9c-fab12462aab5'
);


-- S. 163a/2 안단티노 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 E♭장조', 'Andantino in E♭ major', 'song', 'S. 163a/2', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f318c9e-cd8c-4262-b019-0ee9826029c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f318c9e-cd8c-4262-b019-0ee9826029c3'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '안단티노 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f318c9e-cd8c-4262-b019-0ee9826029c3'
);


-- S. 163b 앨범의 한 페이지 A♭장조 "아, 어머니께 말씀드릴게요"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A♭장조 "아, 어머니께 말씀드릴게요"', 'Album Leaf in A♭ major "Ah! vous dirai-je, maman"', 'song', 'S. 163b', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A♭장조 "아, 어머니께 말씀드릴게요"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dfc8a13-6d4a-447c-84db-177604b0aaab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2dfc8a13-6d4a-447c-84db-177604b0aaab'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A♭장조 "아, 어머니께 말씀드릴게요"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dfc8a13-6d4a-447c-84db-177604b0aaab'
);


-- S. 163c 앨범의 한 페이지 C단조 "프레스부르크"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 C단조 "프레스부르크"', 'Album Leaf in C minor "Pressburg"', 'song', 'S. 163c', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 C단조 "프레스부르크"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '226fa185-b067-43f1-9218-1c14770fdfd9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '226fa185-b067-43f1-9218-1c14770fdfd9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 C단조 "프레스부르크"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '226fa185-b067-43f1-9218-1c14770fdfd9'
);


-- S. 163d 앨범의 한 페이지 E장조 "라이프치히"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E장조 "라이프치히"', 'Album Leaf in E major "Leipzig"', 'song', 'S. 163d', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E장조 "라이프치히"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e254535-e10f-4655-adfe-b730f4fa3e1d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e254535-e10f-4655-adfe-b730f4fa3e1d'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 E장조 "라이프치히"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e254535-e10f-4655-adfe-b730f4fa3e1d'
);


-- S. 163e 앨범의 한 페이지 C장조 "콰지 마주레크"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 C장조 "콰지 마주레크"', 'Album Leaf in C major "Quasi mazurek"', 'song', 'S. 163e', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 C장조 "콰지 마주레크"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8edd52e2-6fd2-4409-be4d-e7c6a9e762b6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8edd52e2-6fd2-4409-be4d-e7c6a9e762b6'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 C장조 "콰지 마주레크"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8edd52e2-6fd2-4409-be4d-e7c6a9e762b6'
);


-- S. 164a 앨범의 한 페이지 E장조 "빈"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E장조 "빈"', 'Album Leaf in E major "Vienna"', 'song', 'S. 164a', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E장조 "빈"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8db3fe77-ca64-4ec9-9c6d-cf80656f7507'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8db3fe77-ca64-4ec9-9c6d-cf80656f7507'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 E장조 "빈"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8db3fe77-ca64-4ec9-9c6d-cf80656f7507'
);


-- S. 164b 앨범의 한 페이지 E♭장조 "라이프치히"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E♭장조 "라이프치히"', 'Album Leaf in E♭ major "Leipzig"', 'song', 'S. 164b', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E♭장조 "라이프치히"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8192ee7-a1ec-4250-8a7a-76885570a409'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8192ee7-a1ec-4250-8a7a-76885570a409'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 E♭장조 "라이프치히"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8192ee7-a1ec-4250-8a7a-76885570a409'
);


-- S. 164c 앨범의 한 페이지 "엑서터 전주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 "엑서터 전주곡"', 'Album Leaf "Exeter Preludio"', 'song', 'S. 164c', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 "엑서터 전주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '712e65f1-8454-4c4a-ab11-b9917bdf6404'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '712e65f1-8454-4c4a-ab11-b9917bdf6404'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 "엑서터 전주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '712e65f1-8454-4c4a-ab11-b9917bdf6404'
);


-- S. 164d 앨범의 한 페이지 E장조 "데트몰트"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E장조 "데트몰트"', 'Album Leaf in E major "Detmold"', 'song', 'S. 164d', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E장조 "데트몰트"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87b7d49e-b63a-48a7-a1f0-edffb920c5be'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '87b7d49e-b63a-48a7-a1f0-edffb920c5be'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 E장조 "데트몰트"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '87b7d49e-b63a-48a7-a1f0-edffb920c5be'
);


-- S. 164e/2 앨범의 한 페이지 B♭단조 "머저르"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 B♭단조 "머저르"', 'Album Leaf in B♭ minor "Magyar"', 'song', 'S. 164e/2', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 B♭단조 "머저르"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92cf46a4-eb9b-4480-b9dc-e74179737325'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92cf46a4-eb9b-4480-b9dc-e74179737325'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 B♭단조 "머저르"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92cf46a4-eb9b-4480-b9dc-e74179737325'
);


-- S. 164e/3 앨범의 한 페이지 D♭장조 "머저르"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 D♭장조 "머저르"', 'Album Leaf in D♭ major "Magyar"', 'song', 'S. 164e/3', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 D♭장조 "머저르"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '704cb82b-edb4-484b-98ca-e57c3bd036a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '704cb82b-edb4-484b-98ca-e57c3bd036a5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 D♭장조 "머저르"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '704cb82b-edb4-484b-98ca-e57c3bd036a5'
);


-- S. 164g 앨범의 한 페이지 C장조 "베를린 전주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 C장조 "베를린 전주곡"', 'Album Leaf in C major "Berlin Preludio"', 'song', 'S. 164g', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 C장조 "베를린 전주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d8404fd-6666-4d9c-854d-5b894de73172'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d8404fd-6666-4d9c-854d-5b894de73172'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 C장조 "베를린 전주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d8404fd-6666-4d9c-854d-5b894de73172'
);


-- S. 164h 앨범의 한 페이지 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 D장조', 'Album Leaf in D major', 'song', 'S. 164h', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbb4ce8f-2b2e-4474-818f-7f215f3c6955'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dbb4ce8f-2b2e-4474-818f-7f215f3c6955'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbb4ce8f-2b2e-4474-818f-7f215f3c6955'
);


-- S. 164j 앨범의 한 페이지 "전주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 "전주곡"', 'Album Leaf "Preludio"', 'song', 'S. 164j', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 "전주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f97777c-6b59-467f-9f23-013845d422d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f97777c-6b59-467f-9f23-013845d422d9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 "전주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f97777c-6b59-467f-9f23-013845d422d9'
);


-- S. 164k 앨범의 한 페이지 D♭장조 "모데라토"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 D♭장조 "모데라토"', 'Album Leaf in D♭ major "Moderato"', 'song', 'S. 164k', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 D♭장조 "모데라토"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0597f955-a456-454a-b885-d5c784414cbb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0597f955-a456-454a-b885-d5c784414cbb'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 D♭장조 "모데라토"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0597f955-a456-454a-b885-d5c784414cbb'
);


-- S. 164l 앨범의 한 페이지 C장조 "아다지오 – 렐리조소"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 C장조 "아다지오 – 렐리조소"', 'Album Leaf in C major "Adagio – religioso"', 'song', 'S. 164l', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 C장조 "아다지오 – 렐리조소"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'feb60c19-df17-47bc-9e22-da7268d74a4f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'feb60c19-df17-47bc-9e22-da7268d74a4f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 C장조 "아다지오 – 렐리조소"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'feb60c19-df17-47bc-9e22-da7268d74a4f'
);


-- S. 165 <앨범의 페이지들> A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<앨범의 페이지들> A♭장조', 'Feuilles d''album in A♭ major', 'song', 'S. 165', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<앨범의 페이지들> A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1c350d0-726e-4282-9fa6-8d960c6de2d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1c350d0-726e-4282-9fa6-8d960c6de2d9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<앨범의 페이지들> A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1c350d0-726e-4282-9fa6-8d960c6de2d9'
);


-- S. 166 왈츠 형식의 앨범의 한 페이지 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 형식의 앨범의 한 페이지 A장조', 'Albumblatt in Walzerform in A major', 'song', 'S. 166', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 형식의 앨범의 한 페이지 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fadc861d-0bb4-4f0b-8833-4c7fd18ae4ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fadc861d-0bb4-4f0b-8833-4c7fd18ae4ac'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '왈츠 형식의 앨범의 한 페이지 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fadc861d-0bb4-4f0b-8833-4c7fd18ae4ac'
);


-- S. 166a 앨범의 한 페이지 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E장조', 'Album Leaf in E major', 'song', 'S. 166a', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c4b3f5c-8b20-46ad-b333-c25a66dce031'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c4b3f5c-8b20-46ad-b333-c25a66dce031'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c4b3f5c-8b20-46ad-b333-c25a66dce031'
);


-- S. 166b 앨범의 한 페이지 A♭장조 "포르투갈"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A♭장조 "포르투갈"', 'Album Leaf in A♭ major "Portugal"', 'song', 'S. 166b', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A♭장조 "포르투갈"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbe04ecf-13b1-4618-be1c-4484946d24fa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cbe04ecf-13b1-4618-be1c-4484946d24fa'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A♭장조 "포르투갈"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cbe04ecf-13b1-4618-be1c-4484946d24fa'
);


-- S. 166c 앨범의 한 페이지 A♭장조 (S. 166c)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A♭장조 (S. 166c)', 'Album Leaf in A♭ major (S. 166c)', 'song', 'S. 166c', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A♭장조 (S. 166c)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '442cd802-47c5-405e-90a9-e98f5d15c0d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '442cd802-47c5-405e-90a9-e98f5d15c0d5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A♭장조 (S. 166c)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '442cd802-47c5-405e-90a9-e98f5d15c0d5'
);


-- S. 166d 앨범의 한 페이지 "리옹 전주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 "리옹 전주곡"', 'Album Leaf "Lyon Prélude"', 'song', 'S. 166d', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 "리옹 전주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29e54d5a-f1de-49bf-b97b-4736e5e15eb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29e54d5a-f1de-49bf-b97b-4736e5e15eb7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 "리옹 전주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29e54d5a-f1de-49bf-b97b-4736e5e15eb7'
);


-- S. 166e 앨범의 한 페이지 "모든 조성의 전주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 "모든 조성의 전주곡"', 'Album Leaf "Prélude omnitonique"', 'song', 'S. 166e', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 "모든 조성의 전주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd02104a9-47bb-4829-a121-2cb2f41b590e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd02104a9-47bb-4829-a121-2cb2f41b590e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 "모든 조성의 전주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd02104a9-47bb-4829-a121-2cb2f41b590e'
);


-- S. 166f 앨범의 한 페이지 F#장조 "브라운슈바이크 전주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 F#장조 "브라운슈바이크 전주곡"', 'Album Leaf in F# major "Braunschweig Preludio"', 'song', 'S. 166f', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 F#장조 "브라운슈바이크 전주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72d85762-5e59-48c9-b271-2079d8d79c53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72d85762-5e59-48c9-b271-2079d8d79c53'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 F#장조 "브라운슈바이크 전주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72d85762-5e59-48c9-b271-2079d8d79c53'
);


-- S. 166g 앨범의 한 페이지 A단조 "세레나데"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A단조 "세레나데"', 'Album Leaf in A minor "Serenade"', 'song', 'S. 166g', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A단조 "세레나데"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a62b3c1-454e-4f86-8d14-c96bb8cda6d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a62b3c1-454e-4f86-8d14-c96bb8cda6d8'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A단조 "세레나데"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a62b3c1-454e-4f86-8d14-c96bb8cda6d8'
);


-- S. 166j 앨범의 한 페이지 G장조 "안단테 렐리조사멘테"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 G장조 "안단테 렐리조사멘테"', 'Album Leaf in G major "Andante religiosamente"', 'song', 'S. 166j', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 G장조 "안단테 렐리조사멘테"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3cd7aebf-0fbc-4c9e-a60a-28817ab20512'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3cd7aebf-0fbc-4c9e-a60a-28817ab20512'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 G장조 "안단테 렐리조사멘테"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3cd7aebf-0fbc-4c9e-a60a-28817ab20512'
);


-- S. 166k 앨범의 한 페이지 A장조 "프리스카"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A장조 "프리스카"', 'Album Leaf in A major "Friska"', 'song', 'S. 166k', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A장조 "프리스카"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e536102-24a2-493b-85eb-073f010e650f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e536102-24a2-493b-85eb-073f010e650f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A장조 "프리스카"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e536102-24a2-493b-85eb-073f010e650f'
);


-- S. 166l/1 앨범의 한 페이지 A♭장조 (S. 166l/1)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A♭장조 (S. 166l/1)', 'Album Leaf in A♭ major (S. 166l/1)', 'song', 'S. 166l/1', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A♭장조 (S. 166l/1)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3decbac4-e8f4-42a8-9d8c-19953fb3132b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3decbac4-e8f4-42a8-9d8c-19953fb3132b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A♭장조 (S. 166l/1)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3decbac4-e8f4-42a8-9d8c-19953fb3132b'
);


-- S. 166l/2 앨범의 한 페이지 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 G단조', 'Album Leaf in G minor', 'song', 'S. 166l/2', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd49c1c9-ebb3-4912-bc8a-6b169e461b7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd49c1c9-ebb3-4912-bc8a-6b169e461b7d'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd49c1c9-ebb3-4912-bc8a-6b169e461b7d'
);


-- S. 166m 마리 폰 자인비트겐슈타인 공녀를 위한 앨범의 페이지들

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마리 폰 자인비트겐슈타인 공녀를 위한 앨범의 페이지들', 'Albumblätter für Prinzessin Marie von Sayn-Wittgenstein', 'album', 'S. 166m', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마리 폰 자인비트겐슈타인 공녀를 위한 앨범의 페이지들'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a67a0a-8bb3-46d7-b8e4-d2e30b12316b', 1, NULL, '백합 (Lilie)', 'Lilie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '마리 폰 자인비트겐슈타인 공녀를 위한 앨범의 페이지들' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a67a0a-8bb3-46d7-b8e4-d2e30b12316b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83c71974-110a-46d6-9f19-b58c06cce748', 2, NULL, 'Hryc', 'Hryc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '마리 폰 자인비트겐슈타인 공녀를 위한 앨범의 페이지들' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83c71974-110a-46d6-9f19-b58c06cce748'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac678e43-f864-4c66-aa90-e03034503390', 3, NULL, '마주레크 A장조', 'Mazurek in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '마리 폰 자인비트겐슈타인 공녀를 위한 앨범의 페이지들' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac678e43-f864-4c66-aa90-e03034503390'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83d8956c-d9bc-452b-a3b9-c5cd931e3715', 4, NULL, '크라코비악 F장조', 'Krakowiak in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '마리 폰 자인비트겐슈타인 공녀를 위한 앨범의 페이지들' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83d8956c-d9bc-452b-a3b9-c5cd931e3715'
);


-- S. 166p 앨범의 한 페이지 A♭장조 "안단티노"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A♭장조 "안단티노"', 'Album Leaf in A♭ major "Andantino"', 'song', 'S. 166p', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A♭장조 "안단티노"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f5245d7-c261-4259-b16c-8cf9eb0c54e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f5245d7-c261-4259-b16c-8cf9eb0c54e1'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A♭장조 "안단티노"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f5245d7-c261-4259-b16c-8cf9eb0c54e1'
);


-- S. 166q 앨범의 한 페이지 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 G장조', 'Album Leaf in G major', 'song', 'S. 166q', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05d5ae68-09c6-459d-9d1a-8dd6ba169bb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05d5ae68-09c6-459d-9d1a-8dd6ba169bb7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05d5ae68-09c6-459d-9d1a-8dd6ba169bb7'
);


-- S. 166s 앨범의 한 페이지 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A장조', 'Album Leaf in A major', 'song', 'S. 166s', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '945fd971-8ff9-42ff-b6d9-b3a4dec32048'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '945fd971-8ff9-42ff-b6d9-b3a4dec32048'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '945fd971-8ff9-42ff-b6d9-b3a4dec32048'
);


-- S. 167g 앨범의 한 페이지 D♭장조 "비바체 마 논 트로포"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 D♭장조 "비바체 마 논 트로포"', 'Album Leaf in D♭ major "Vivace ma non troppo"', 'song', 'S. 167g', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 D♭장조 "비바체 마 논 트로포"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09b73a1e-0fbb-4a32-a1e0-7388c86d9231'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09b73a1e-0fbb-4a32-a1e0-7388c86d9231'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 D♭장조 "비바체 마 논 트로포"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09b73a1e-0fbb-4a32-a1e0-7388c86d9231'
);


-- S. 167h 앨범의 한 페이지 (S. 167h)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 (S. 167h)', 'Album Leaf (S. 167h)', 'song', 'S. 167h', NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 (S. 167h)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '638d7adf-c88d-4f3a-b4a8-a8b6d2b63435'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '638d7adf-c88d-4f3a-b4a8-a8b6d2b63435'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 (S. 167h)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '638d7adf-c88d-4f3a-b4a8-a8b6d2b63435'
);


-- S. 167j 앨범의 한 페이지 G단조 "반음계 푸가"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 G단조 "반음계 푸가"', 'Album Leaf in G minor "Fugue chromatique"', 'song', 'S. 167j', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 G단조 "반음계 푸가"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5654efd5-3038-485a-9473-df1ed087e41c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5654efd5-3038-485a-9473-df1ed087e41c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 G단조 "반음계 푸가"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5654efd5-3038-485a-9473-df1ed087e41c'
);


-- S. 167n 앨범의 한 페이지 A장조 "알레그레토"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 A장조 "알레그레토"', 'Album Leaf in A major "Allegretto"', 'song', 'S. 167n', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 A장조 "알레그레토"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43b6eb8b-1c6f-4e11-94ae-1ca5ab5c7806'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43b6eb8b-1c6f-4e11-94ae-1ca5ab5c7806'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 A장조 "알레그레토"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43b6eb8b-1c6f-4e11-94ae-1ca5ab5c7806'
);


-- S. 167o 앨범의 한 페이지 E♭장조 "행진곡 빠르기로"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E♭장조 "행진곡 빠르기로"', 'Album Leaf in E♭ major "Tempo di marcia"', 'song', 'S. 167o', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E♭장조 "행진곡 빠르기로"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d37fd6a-7ed3-480b-a0bc-50acac22a07a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d37fd6a-7ed3-480b-a0bc-50acac22a07a'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 E♭장조 "행진곡 빠르기로"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d37fd6a-7ed3-480b-a0bc-50acac22a07a'
);


-- S. 167r 앨범의 한 페이지 E♭장조 "안단테"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 E♭장조 "안단테"', 'Album Leaf in E♭ major "Andante"', 'song', 'S. 167r', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 E♭장조 "안단테"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd64ac043-7656-4f11-8b21-b50c14bd7af5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd64ac043-7656-4f11-8b21-b50c14bd7af5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 E♭장조 "안단테"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd64ac043-7656-4f11-8b21-b50c14bd7af5'
);


-- S. 167s 앨범의 한 페이지 C장조 "리옹"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앨범의 한 페이지 C장조 "리옹"', 'Album Leaf in C major "Lyon"', 'song', 'S. 167s', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앨범의 한 페이지 C장조 "리옹"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53f41b2c-3932-41a2-847c-e77268f78480'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '53f41b2c-3932-41a2-847c-e77268f78480'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '앨범의 한 페이지 C장조 "리옹"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53f41b2c-3932-41a2-847c-e77268f78480'
);


-- S. 168b 녹턴 A장조 "사색"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 A장조 "사색"', 'Pensées (Nocturne) in A major', 'song', 'S. 168b', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 A장조 "사색"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da2ed5bf-fd54-4fbb-83fb-536c0542d9e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da2ed5bf-fd54-4fbb-83fb-536c0542d9e7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '녹턴 A장조 "사색"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da2ed5bf-fd54-4fbb-83fb-536c0542d9e7'
);


-- S. 169 로망스 E단조 "오, 왜 그런가"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 E단조 "오, 왜 그런가"', 'Romance in E minor "O pourquoi donc"', 'song', 'S. 169', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 E단조 "오, 왜 그런가"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'babafe21-79e0-467b-82ea-f18e3d41654f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'babafe21-79e0-467b-82ea-f18e3d41654f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '로망스 E단조 "오, 왜 그런가"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'babafe21-79e0-467b-82ea-f18e3d41654f'
);


-- S. 170 발라드 1번 D♭장조 "십자군의 노래"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 1번 D♭장조 "십자군의 노래"', 'Ballade No. 1 in D♭ major "Le chant du croisé"', 'song', 'S. 170', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 1번 D♭장조 "십자군의 노래"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4603f0f1-0efc-4367-a960-82a72e89f74d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4603f0f1-0efc-4367-a960-82a72e89f74d'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '발라드 1번 D♭장조 "십자군의 노래"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4603f0f1-0efc-4367-a960-82a72e89f74d'
);


-- S. 171 발라드 2번 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발라드 2번 B단조', 'Ballade No. 2 in B minor', 'song', 'S. 171', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발라드 2번 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f89040d-7e69-4c91-b08a-fa2fe27c5238'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f89040d-7e69-4c91-b08a-fa2fe27c5238'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '발라드 2번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f89040d-7e69-4c91-b08a-fa2fe27c5238'
);


-- S. 172 피아노 모음곡 <위안>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <위안>', 'Consolations, S. 172', 'album', 'S. 172', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <위안>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0563d96-5a40-4aa7-a0a6-eb12a3b302a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f0563d96-5a40-4aa7-a0a6-eb12a3b302a5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <위안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0563d96-5a40-4aa7-a0a6-eb12a3b302a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2e75aec-3241-4d1a-8260-212b78b13530', 1, NULL, 'E장조', 'No. 1 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <위안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2e75aec-3241-4d1a-8260-212b78b13530'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b1dd91a-420a-4909-abdf-2ca99afb528d', 2, NULL, 'E장조', 'No. 2 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <위안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b1dd91a-420a-4909-abdf-2ca99afb528d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae7a5de6-bbec-3786-aa01-4516f695b360', 3, NULL, 'D♭장조', 'No. 3 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <위안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae7a5de6-bbec-3786-aa01-4516f695b360'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e902cec4-4e07-4a06-8330-e3822152a185', 4, NULL, 'D♭장조', 'No. 4 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <위안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e902cec4-4e07-4a06-8330-e3822152a185'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3e434a5-667f-428f-91fe-8ab8bd7a6746', 5, NULL, 'E장조', 'No. 5 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <위안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3e434a5-667f-428f-91fe-8ab8bd7a6746'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0256e417-5015-4408-90e5-75b3966320d1', 6, NULL, 'E장조', 'No. 6 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <위안>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0256e417-5015-4408-90e5-75b3966320d1'
);


-- S. 172b <스타바트 마테르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<스타바트 마테르>', 'Stabat mater', 'song', 'S. 172b', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<스타바트 마테르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2cd6363-18c6-4fb6-a2a8-f06c2af7a083'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2cd6363-18c6-4fb6-a2a8-f06c2af7a083'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<스타바트 마테르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2cd6363-18c6-4fb6-a2a8-f06c2af7a083'
);


-- S. 173 피아노 모음곡 <시적이고 종교적인 선율>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <시적이고 종교적인 선율>', 'Harmonies poétiques et religieuses, S. 173', 'album', 'S. 173', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <시적이고 종교적인 선율>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49d54dc0-fa0e-473b-933d-a5c217511761'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49d54dc0-fa0e-473b-933d-a5c217511761'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49d54dc0-fa0e-473b-933d-a5c217511761'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:940208cf-11fc-379c-abfe-6ee869a581c9', 1, NULL, '기원 (Invocation)', 'Invocation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:940208cf-11fc-379c-abfe-6ee869a581c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:098b2ace-5e31-4481-8692-6ce43220b70c', 2, NULL, '아베 마리아 (Ave Maria)', 'Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:098b2ace-5e31-4481-8692-6ce43220b70c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc3c513c-f4bb-3c80-b626-da4fb873e589', 3, NULL, '고독 속의 신의 축복 (Bénédiction de Dieu dans la solitude)', 'Bénédiction de Dieu dans la solitude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc3c513c-f4bb-3c80-b626-da4fb873e589'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b1170fe-a626-3915-aba6-d7c5c40d2d42', 4, NULL, '죽은 이들의 회상 (Pensée des morts)', 'Pensée des morts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b1170fe-a626-3915-aba6-d7c5c40d2d42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59d77d24-871e-447b-9b5e-c8a014189596', 5, NULL, '주님의 기도 (Pater noster)', 'Pater noster', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59d77d24-871e-447b-9b5e-c8a014189596'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f741bec-8793-4d84-b84b-62d34a4ab320', 6, NULL, '잠에서 깬 아이의 찬가 (Hymne de l''enfant à son réveil)', 'Hymne de l''enfant à son réveil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f741bec-8793-4d84-b84b-62d34a4ab320'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9f8ed1d-ece6-3875-bc3c-1ff4d02467a3', 7, NULL, '장송 (Funérailles)', 'Funérailles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9f8ed1d-ece6-3875-bc3c-1ff4d02467a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2e3cc2f-f534-40b4-b26d-791b6617c383', 8, NULL, '팔레스트리나풍 미제레레 (Miserere d''après Palestrina)', 'Miserere d''après Palestrina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2e3cc2f-f534-40b4-b26d-791b6617c383'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49d6d22b-5318-4b44-aacb-f540d4cbe942', 9, NULL, '안단테 라그리모소 (Andante lagrimoso)', 'Andante lagrimoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49d6d22b-5318-4b44-aacb-f540d4cbe942'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78955e2b-a86e-302f-8536-962f8fd97270', 10, NULL, '사랑의 찬가 (Cantique d''amour)', 'Cantique d''amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <시적이고 종교적인 선율>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78955e2b-a86e-302f-8536-962f8fd97270'
);


-- S. 173a 2개의 찬가 S. 173a

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 찬가 S. 173a', '2 Hymnes, S. 173a', 'album', NULL, 'S.', '173a', 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 찬가 S. 173a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s173a:1', 1, NULL, '밤의 찬가 (Hymne de la nuit)', 'Hymne de la nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 찬가 S. 173a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s173a:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:liszt:liszt-s173a:2', 2, NULL, '아침의 찬가 (Hymne du matin)', 'Hymne du matin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 찬가 S. 173a' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:liszt:liszt-s173a:2'
);


-- S. 174 자장가 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '자장가 D♭장조', 'Berceuse in D♭ major', 'song', 'S. 174', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '자장가 D♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d7bc909-cc9f-4500-83d6-9edf6df6ea31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d7bc909-cc9f-4500-83d6-9edf6df6ea31'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '자장가 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d7bc909-cc9f-4500-83d6-9edf6df6ea31'
);


-- S. 175 피아노 모음곡 <2개의 전설>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <2개의 전설>', 'Deux légendes', 'album', 'S. 175', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <2개의 전설>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4463460-6834-4a18-bd94-2e24e76353e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4463460-6834-4a18-bd94-2e24e76353e8'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <2개의 전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4463460-6834-4a18-bd94-2e24e76353e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3852f73c-7024-45ea-8700-bb3b43454084', 1, NULL, '새들에게 설교하는 아시시의 성 프란치스코 (St François d''Assise: la prédication aux oiseaux)', 'St François d''Assise: la prédication aux oiseaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <2개의 전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3852f73c-7024-45ea-8700-bb3b43454084'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10e0643c-6524-4279-a737-76dd39d4d984', 2, NULL, '물 위를 걷는 파올라의 성 프란치스코 (St François de Paule marchant sur les flots)', 'St François de Paule: marchant sur les flots', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <2개의 전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10e0643c-6524-4279-a737-76dd39d4d984'
);


-- S. 176 대연주회 독주곡 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대연주회 독주곡 E단조', 'Grosses Konzertsolo in E minor', 'song', 'S. 176', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대연주회 독주곡 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25c90bfc-d24e-4edd-accc-3e70e9854985'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25c90bfc-d24e-4edd-accc-3e70e9854985'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '대연주회 독주곡 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25c90bfc-d24e-4edd-accc-3e70e9854985'
);


-- S. 177 스케르초와 행진곡 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초와 행진곡 D단조', 'Scherzo und Marsch in D minor', 'song', 'S. 177', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초와 행진곡 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ef51a2d-72bb-4479-a04e-3511e96b12a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ef51a2d-72bb-4479-a04e-3511e96b12a0'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '스케르초와 행진곡 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ef51a2d-72bb-4479-a04e-3511e96b12a0'
);


-- S. 178 피아노 소나타 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 B단조', 'Piano Sonata in B minor', 'song', 'S. 178', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df6d181d-989e-3aa7-a1e5-63cfd6b9f048'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df6d181d-989e-3aa7-a1e5-63cfd6b9f048'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 소나타 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df6d181d-989e-3aa7-a1e5-63cfd6b9f048'
);


-- S. 179 전주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며"', 'Prelude in F minor "Weinen, Klagen, Sorgen, Zagen"', 'song', 'S. 179', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5edbbfcc-fefc-3dae-81e7-95f106b0ef0c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5edbbfcc-fefc-3dae-81e7-95f106b0ef0c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '전주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5edbbfcc-fefc-3dae-81e7-95f106b0ef0c'
);


-- S. 180 바흐 주제에 의한 변주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바흐 주제에 의한 변주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며"', 'Variations on a Theme by Bach in F minor "Weinen, Klagen, Sorgen, Zagen"', 'song', 'S. 180', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바흐 주제에 의한 변주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79a88c1c-7e63-3d52-a723-c730260aa901'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79a88c1c-7e63-3d52-a723-c730260aa901'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '바흐 주제에 의한 변주곡 F단조 "울며, 탄식하며, 근심하며, 두려워하며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79a88c1c-7e63-3d52-a723-c730260aa901'
);


-- S. 182 아베 마리아 E장조 "로마의 종"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아베 마리아 E장조 "로마의 종"', 'Ave Maria in E major "Die Glocken von Rom"', 'song', 'S. 182', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아베 마리아 E장조 "로마의 종"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02f86b10-d7d1-4fc7-b4e4-41a6049944f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02f86b10-d7d1-4fc7-b4e4-41a6049944f1'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '아베 마리아 E장조 "로마의 종"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02f86b10-d7d1-4fc7-b4e4-41a6049944f1'
);


-- S. 183/1 알렐루야 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알렐루야 F장조', 'Alleluja in F major', 'song', 'S. 183/1', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알렐루야 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9dd63af2-05bd-44ec-bfb4-5346830fa29f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9dd63af2-05bd-44ec-bfb4-5346830fa29f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '알렐루야 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9dd63af2-05bd-44ec-bfb4-5346830fa29f'
);


-- S. 184 <우르비 에트 오르비>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<우르비 에트 오르비>', 'Urbi et orbi (Bénédiction papale)', 'song', 'S. 184', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<우르비 에트 오르비>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03b384d2-0e37-4e11-82a2-9711b680835f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03b384d2-0e37-4e11-82a2-9711b680835f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<우르비 에트 오르비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03b384d2-0e37-4e11-82a2-9711b680835f'
);


-- S. 185 피아노곡 <Vexilla regis prodeunt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 <Vexilla regis prodeunt>', 'Vexilla regis prodeunt', 'song', 'S. 185', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 <Vexilla regis prodeunt>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca54ff5b-c495-425c-849e-15e65b9ba4bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca54ff5b-c495-425c-849e-15e65b9ba4bf'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노곡 <Vexilla regis prodeunt>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca54ff5b-c495-425c-849e-15e65b9ba4bf'
);


-- S. 186 피아노 모음곡 <크리스마스 트리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <크리스마스 트리>', 'Weihnachtsbaum', 'album', 'S. 186', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <크리스마스 트리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4506930c-8911-496c-aa4b-bb9ecc5f8a06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4506930c-8911-496c-aa4b-bb9ecc5f8a06'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4506930c-8911-496c-aa4b-bb9ecc5f8a06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f57e43fb-f1c2-42ec-b888-bce6142d07aa', 1, NULL, '옛 크리스마스 노래 (Psallite)', 'Altes Weihnachtslied (Psallite)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f57e43fb-f1c2-42ec-b888-bce6142d07aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a7ac6be-eab7-4a11-a6df-7d760ee4c834', 2, NULL, '오 거룩한 밤 (O heilige Nacht!)', 'O heilige Nacht!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a7ac6be-eab7-4a11-a6df-7d760ee4c834'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2faaf891-1e16-40ad-a1a4-691890b74718', 3, NULL, '구유 곁의 목자들 (Die Hirten an der Krippe)', 'Die Hirten an der Krippe ("In dulci jubilo")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2faaf891-1e16-40ad-a1a4-691890b74718'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:febef3e5-f676-45b6-a530-9ea613f7208a', 4, NULL, '아데스테 피델레스 (Adeste fideles)', 'Adeste fideles (Gleichsam als Marsch der heiligen drei Könige)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:febef3e5-f676-45b6-a530-9ea613f7208a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f4147ff-84d6-4957-a00c-f4f6bf75db23', 5, NULL, '스케르초소 (Scherzoso)', 'Scherzoso (Man zündet die Kerzen des Baumes an)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f4147ff-84d6-4957-a00c-f4f6bf75db23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60191556-481d-4b58-bc11-d29ee56123da', 6, NULL, '카리용 (Carillon)', 'Carillon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60191556-481d-4b58-bc11-d29ee56123da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2001bd3b-b9cf-4aed-a9ba-c53ab12a46d3', 7, NULL, '자장가 (Schlummerlied)', 'Schlummerlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2001bd3b-b9cf-4aed-a9ba-c53ab12a46d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee2d5016-4f5b-4052-9e73-de34c5ebba19', 8, NULL, '옛 프로방스 크리스마스 노래 (Altes provenzalisches Weihnachtslied)', 'Altes provenzalisches Weihnachtslied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee2d5016-4f5b-4052-9e73-de34c5ebba19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b31d1ff1-148a-4ea7-b620-c9c15b73c397', 9, NULL, '저녁 종 (Abendglocken)', 'Abendglocken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b31d1ff1-148a-4ea7-b620-c9c15b73c397'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:321bf459-c5ec-4ba4-a576-212b739d3e9a', 10, NULL, '옛날 (Ehemals)', 'Ehemals', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:321bf459-c5ec-4ba4-a576-212b739d3e9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9bf777a-4a4e-41e9-9319-82d47e6148c6', 11, NULL, '헝가리풍 (Ungarisch)', 'Ungarisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9bf777a-4a4e-41e9-9319-82d47e6148c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6cb3795-7d0f-4d34-866d-86beccd93be7', 12, NULL, '폴란드풍 (Polnisch)', 'Polnisch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <크리스마스 트리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6cb3795-7d0f-4d34-866d-86beccd93be7'
);


-- S. 187 <성 도로테아> E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<성 도로테아> E장조', 'Sancta Dorothea in E major', 'song', 'S. 187', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<성 도로테아> E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6ab407a-f1c9-4b66-8a4a-a88e2c7105f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6ab407a-f1c9-4b66-8a4a-a88e2c7105f7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<성 도로테아> E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6ab407a-f1c9-4b66-8a4a-a88e2c7105f7'
);


-- S. 187b <체념> E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<체념> E장조', 'Resignazione in E major', 'song', 'S. 187b', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<체념> E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c100ae30-bbb4-4e26-833e-1a2a2b89b2ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c100ae30-bbb4-4e26-833e-1a2a2b89b2ef'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<체념> E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c100ae30-bbb4-4e26-833e-1a2a2b89b2ef'
);


-- S. 188 <주님의 거룩한 변모 축일에>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<주님의 거룩한 변모 축일에>', 'In festo transfigurationis Domini nostri Jesu Christi', 'song', 'S. 188', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<주님의 거룩한 변모 축일에>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5c3b4d2-f1b2-44fb-9c43-a2a74e88c631'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5c3b4d2-f1b2-44fb-9c43-a2a74e88c631'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<주님의 거룩한 변모 축일에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5c3b4d2-f1b2-44fb-9c43-a2a74e88c631'
);


-- S. 189 피아노곡 1번 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 1번 A♭장조', 'Klavierstück No. 1 in A♭ major', 'song', 'S. 189', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 1번 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae3fdb67-ab37-4211-bc69-85b7a8dfd9c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae3fdb67-ab37-4211-bc69-85b7a8dfd9c5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노곡 1번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae3fdb67-ab37-4211-bc69-85b7a8dfd9c5'
);


-- S. 189b 피아노곡 2번 D♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 2번 D♭장조', 'Klavierstück No. 2 in D♭ major', 'song', 'S. 189b', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 2번 D♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '802b1d53-5c86-49ed-a785-90a7698f7b08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '802b1d53-5c86-49ed-a785-90a7698f7b08'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노곡 2번 D♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '802b1d53-5c86-49ed-a785-90a7698f7b08'
);


-- S. 191 즉흥곡 F#장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 F#장조', 'Impromptu in F# major', 'song', 'S. 191', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 F#장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd2966bf-1ad5-3006-9d85-c5d44de7e810'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd2966bf-1ad5-3006-9d85-c5d44de7e810'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '즉흥곡 F#장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd2966bf-1ad5-3006-9d85-c5d44de7e810'
);


-- S. 192 5개의 피아노곡 S. 192

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 피아노곡 S. 192', '5 Klavierstücke, S. 192', 'album', NULL, 'S.', '192', 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 피아노곡 S. 192'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'daf16573-8d2a-4711-ae82-749111bf1846'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'daf16573-8d2a-4711-ae82-749111bf1846'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '5개의 피아노곡 S. 192' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'daf16573-8d2a-4711-ae82-749111bf1846'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35f0f119-867a-4918-bbde-cf36bb38c558', 1, NULL, 'E장조', 'No. 1 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '5개의 피아노곡 S. 192' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35f0f119-867a-4918-bbde-cf36bb38c558'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02ee5daa-a11a-4ea4-9ed7-5f357a725ec7', 2, NULL, 'A♭장조', 'No. 2 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '5개의 피아노곡 S. 192' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02ee5daa-a11a-4ea4-9ed7-5f357a725ec7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1b859b8-27a8-3ced-b4d0-4ad2366cfe93', 3, NULL, 'F#장조', 'No. 3 in F# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '5개의 피아노곡 S. 192' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1b859b8-27a8-3ced-b4d0-4ad2366cfe93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b106a3a-18f0-41b8-9970-8cc546396343', 4, NULL, 'F#장조', 'No. 4 in F# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '5개의 피아노곡 S. 192' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b106a3a-18f0-41b8-9970-8cc546396343'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baa1af47-3d27-4f25-bea6-0efad23621c6', 5, NULL, '"한숨!" (Sospiri!)', 'No. 5 "Sospiri!"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '5개의 피아노곡 S. 192' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baa1af47-3d27-4f25-bea6-0efad23621c6'
);


-- S. 193 피아노곡 F#장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노곡 F#장조', 'Klavierstück in F# major', 'song', 'S. 193', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노곡 F#장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd7f51dd-82f7-4ec5-b9d5-a42480d1e47a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd7f51dd-82f7-4ec5-b9d5-a42480d1e47a'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노곡 F#장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd7f51dd-82f7-4ec5-b9d5-a42480d1e47a'
);


-- S. 196 비가 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비가 1번', 'Elegy No. 1', 'song', 'S. 196', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비가 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01b33ce1-056c-431f-bed2-00a9b0eb7f55'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '01b33ce1-056c-431f-bed2-00a9b0eb7f55'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '비가 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01b33ce1-056c-431f-bed2-00a9b0eb7f55'
);


-- S. 197 비가 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비가 2번', 'Elegy No. 2', 'song', 'S. 197', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비가 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77324781-1bb7-4038-a588-f51566c8f01d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '77324781-1bb7-4038-a588-f51566c8f01d'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '비가 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77324781-1bb7-4038-a588-f51566c8f01d'
);


-- S. 197a 토카타 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타 C장조', 'Toccata in C major', 'song', 'S. 197a', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd83ac468-498f-447e-a081-8d2864d1ad76'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd83ac468-498f-447e-a081-8d2864d1ad76'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '토카타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd83ac468-498f-447e-a081-8d2864d1ad76'
);


-- S. 197b <카이저 빌헬름!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<카이저 빌헬름!>', 'Kaiser Wilhelm!', 'song', 'S. 197b', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<카이저 빌헬름!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e77c1fb6-a031-4161-9f49-04635f20fe99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e77c1fb6-a031-4161-9f49-04635f20fe99'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<카이저 빌헬름!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e77c1fb6-a031-4161-9f49-04635f20fe99'
);


-- S. 198 <요람의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<요람의 노래>', 'Wiegenlied (Chant du berceau)', 'song', 'S. 198', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<요람의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da2fa55d-aa95-434c-86fc-2638908aff2f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'da2fa55d-aa95-434c-86fc-2638908aff2f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<요람의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'da2fa55d-aa95-434c-86fc-2638908aff2f'
);


-- S. 199 <잿빛 구름>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<잿빛 구름>', 'Nuages gris (Trübe Wolken)', 'song', 'S. 199', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<잿빛 구름>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '058b6015-1d38-315e-9e0b-939648743034'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '058b6015-1d38-315e-9e0b-939648743034'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<잿빛 구름>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '058b6015-1d38-315e-9e0b-939648743034'
);


-- S. 200/2 <슬픈 곤돌라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<슬픈 곤돌라>', 'La lugubre gondola', 'song', 'S. 200/2', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<슬픈 곤돌라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '615ae7e7-9ba4-4227-a673-2a631471542b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '615ae7e7-9ba4-4227-a673-2a631471542b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<슬픈 곤돌라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '615ae7e7-9ba4-4227-a673-2a631471542b'
);


-- S. 201 <R.W. – 베네치아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<R.W. – 베네치아>', 'R.W. – Venezia', 'song', 'S. 201', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<R.W. – 베네치아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f51f96fa-e6ff-3a48-a0d1-39cc62668be4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f51f96fa-e6ff-3a48-a0d1-39cc62668be4'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<R.W. – 베네치아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f51f96fa-e6ff-3a48-a0d1-39cc62668be4'
);


-- S. 203 <잠 못 이루고! 물음과 대답>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<잠 못 이루고! 물음과 대답>', 'Schlaflos! Frage und Antwort', 'song', 'S. 203', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<잠 못 이루고! 물음과 대답>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56d5bc26-2098-4bc3-ae4c-b7f2c66a4974'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56d5bc26-2098-4bc3-ae4c-b7f2c66a4974'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<잠 못 이루고! 물음과 대답>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56d5bc26-2098-4bc3-ae4c-b7f2c66a4974'
);


-- S. 204 <명상>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<명상>', 'Recueillement', 'song', 'S. 204', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<명상>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05887f64-ea57-4cc5-91c3-7c6340bbdf36'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05887f64-ea57-4cc5-91c3-7c6340bbdf36'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<명상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05887f64-ea57-4cc5-91c3-7c6340bbdf36'
);


-- S. 205a 피아노 모음곡 <헝가리 역사 인물 초상>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <헝가리 역사 인물 초상>', 'Historische ungarische Bildnisse', 'album', 'S. 205a', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <헝가리 역사 인물 초상>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51d46639-6f2d-44cd-b8a2-035d9d0129af'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51d46639-6f2d-44cd-b8a2-035d9d0129af'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 역사 인물 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51d46639-6f2d-44cd-b8a2-035d9d0129af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c597b48-53b5-4dd6-94dc-f97b1e7f774d', 1, NULL, '세체니 이슈트반 (Széchenyi István)', 'Széchenyi István', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 역사 인물 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c597b48-53b5-4dd6-94dc-f97b1e7f774d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70d402da-0170-443e-80dc-082ed48b39e0', 2, NULL, '데아크 페렌츠 (Deák Ferenc)', 'Deák Ferenc', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 역사 인물 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70d402da-0170-443e-80dc-082ed48b39e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fd185b4-f3af-4cc1-aa45-19b2727ee771', 3, NULL, '텔레키 라슬로 (Teleki László)', 'Teleki László', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 역사 인물 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fd185b4-f3af-4cc1-aa45-19b2727ee771'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cf24a06-8e74-4c13-8e9a-bb0ef5adfed8', 4, NULL, '외트뵈시 요제프 (Eötvös József)', 'Eötvös József', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 역사 인물 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cf24a06-8e74-4c13-8e9a-bb0ef5adfed8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d52ca678-5978-48bf-b5d2-09601ce7c2f2', 5, NULL, '뵈뢰슈머르티 미하이 (Vörösmarty Mihály)', 'Vörösmarty Mihály', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 역사 인물 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d52ca678-5978-48bf-b5d2-09601ce7c2f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5a29d9b-ff7f-4173-9875-f84227c21e1c', 6, NULL, '페퇴피 샨도르 (Petőfi Sándor)', 'Petőfi Sándor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 역사 인물 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5a29d9b-ff7f-4173-9875-f84227c21e1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1999faf-f41b-4248-91d3-d500dd139335', 7, NULL, '모소니 미하이 (Mosonyi Mihály)', 'Mosonyi Mihály', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 역사 인물 초상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1999faf-f41b-4248-91d3-d500dd139335'
);


-- S. 206 장송 전주곡과 장송 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '장송 전주곡과 장송 행진곡', 'Trauervorspiel und Trauermarsch', 'album', 'S. 206', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '장송 전주곡과 장송 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e08e1bf-6c4e-4682-af35-1b0446614baa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e08e1bf-6c4e-4682-af35-1b0446614baa'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '장송 전주곡과 장송 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e08e1bf-6c4e-4682-af35-1b0446614baa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c32a48b-c869-4f55-90d7-306d349ef566', 1, NULL, '장송 전주곡 (Preludio funebre)', 'Preludio funebre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '장송 전주곡과 장송 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c32a48b-c869-4f55-90d7-306d349ef566'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65f42eb5-b1ae-42cc-b96e-e3ca00faef0d', 2, NULL, '장송 행진곡 (Marcia funebre)', 'Marcia funebre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '장송 전주곡과 장송 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65f42eb5-b1ae-42cc-b96e-e3ca00faef0d'
);


-- S. 207 녹턴 "꿈속에서"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 "꿈속에서"', 'En rêve (Nocturne)', 'song', 'S. 207', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 "꿈속에서"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52dec80f-710e-390c-ada0-d4b89eef87fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52dec80f-710e-390c-ada0-d4b89eef87fb'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '녹턴 "꿈속에서"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52dec80f-710e-390c-ada0-d4b89eef87fb'
);


-- S. 207a 보로딘의 폴카에 의한 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '보로딘의 폴카에 의한 전주곡', 'Prélude à la Polka de Borodine', 'song', 'S. 207a', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '보로딘의 폴카에 의한 전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9a9c090-082d-451b-aff7-0eafb9e2f39e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9a9c090-082d-451b-aff7-0eafb9e2f39e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '보로딘의 폴카에 의한 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9a9c090-082d-451b-aff7-0eafb9e2f39e'
);


-- S. 208 <불길한 별!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<불길한 별!>', 'Unstern! (Sinistre, disastro)', 'song', 'S. 208', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<불길한 별!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5ada308-36df-4dd1-96ea-3c22bb5c0f1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5ada308-36df-4dd1-96ea-3c22bb5c0f1a'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<불길한 별!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5ada308-36df-4dd1-96ea-3c22bb5c0f1a'
);


-- S. 209a 왈츠 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 E♭장조', 'Waltz in E♭ major', 'song', 'S. 209a', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '257b5476-0a2d-40c2-a0a7-6e05d04c1ca8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '257b5476-0a2d-40c2-a0a7-6e05d04c1ca8'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '왈츠 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '257b5476-0a2d-40c2-a0a7-6e05d04c1ca8'
);


-- S. 210b 왈츠 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 A장조', 'Waltz in A major', 'song', 'S. 210b', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '073a6d8a-d39c-480e-a370-3f5561181587'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '073a6d8a-d39c-480e-a370-3f5561181587'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '왈츠 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '073a6d8a-d39c-480e-a370-3f5561181587'
);


-- S. 211 렌틀러 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '렌틀러 A♭장조', 'Ländler in A♭ major', 'song', 'S. 211', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '렌틀러 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d1c2c69-2a3f-401a-8ce4-6bfe368b2fa8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d1c2c69-2a3f-401a-8ce4-6bfe368b2fa8'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '렌틀러 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d1c2c69-2a3f-401a-8ce4-6bfe368b2fa8'
);


-- S. 211a 렌틀러 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '렌틀러 D장조', 'Ländler in D major', 'song', 'S. 211a', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '렌틀러 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c40447f4-ede2-48f7-9556-03dbf99ae5ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c40447f4-ede2-48f7-9556-03dbf99ae5ba'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '렌틀러 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c40447f4-ede2-48f7-9556-03dbf99ae5ba'
);


-- S. 212ii 작은 왈츠 "상트페테르부르크의 추억"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 왈츠 "상트페테르부르크의 추억"', 'Petite valse favorite "Souvenir de St Pétersbourg"', 'song', 'S. 212ii', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 왈츠 "상트페테르부르크의 추억"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c828e4a0-529c-4ad1-88ce-bac79d7a96fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c828e4a0-529c-4ad1-88ce-bac79d7a96fc'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '작은 왈츠 "상트페테르부르크의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c828e4a0-529c-4ad1-88ce-bac79d7a96fc'
);


-- S. 212a <마리를 위한 왈츠>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<마리를 위한 왈츠>', 'Valse pour Marie', 'song', 'S. 212a', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<마리를 위한 왈츠>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7342c1f4-9852-456a-90a3-e8b24440560f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7342c1f4-9852-456a-90a3-e8b24440560f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<마리를 위한 왈츠>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7342c1f4-9852-456a-90a3-e8b24440560f'
);


-- S. 213 즉흥 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥 왈츠', 'Valse-Impromptu', 'song', 'S. 213', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥 왈츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14d864d0-5caf-47cb-996c-bc43fcfb0868'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14d864d0-5caf-47cb-996c-bc43fcfb0868'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '즉흥 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14d864d0-5caf-47cb-996c-bc43fcfb0868'
);


-- S. 214 3개의 카프리스 왈츠 S. 214

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 카프리스 왈츠 S. 214', '3 Caprices-Valses, S. 214', 'album', NULL, 'S.', '214', 1852, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 카프리스 왈츠 S. 214'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dda1300-828a-4cc6-a3f6-55336513c381'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dda1300-828a-4cc6-a3f6-55336513c381'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 카프리스 왈츠 S. 214' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dda1300-828a-4cc6-a3f6-55336513c381'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f3db8da-5b30-4103-a673-960be0dcffeb', 1, NULL, 'B♭장조 "화려한 왈츠"', 'No. 1 in B♭ major "Valse de bravoure"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 카프리스 왈츠 S. 214' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f3db8da-5b30-4103-a673-960be0dcffeb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee9c239e-e856-4eb2-86eb-ed2499986dfa', 2, NULL, 'E장조 "우울한 왈츠"', 'No. 2 in E major "Valse mélancolique"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 카프리스 왈츠 S. 214' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee9c239e-e856-4eb2-86eb-ed2499986dfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e8846bb-4ef8-4f17-8ced-d1ddf19ccb3e', 3, NULL, 'A장조 "<루치아>와 <파리시나> 주제에 의한 연주회용 왈츠"', 'No. 3 in A major "Valse de concert sur deux motifs de Lucia et Parisina"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 카프리스 왈츠 S. 214' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e8846bb-4ef8-4f17-8ced-d1ddf19ccb3e'
);


-- S. 214a <펠레나르본 부인의 회전목마>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<펠레나르본 부인의 회전목마>', 'Carrousel de Madame Pelet-Narbonne', 'song', 'S. 214a', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<펠레나르본 부인의 회전목마>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16c8c63c-085d-418e-bff3-ed8016d3f6af'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16c8c63c-085d-418e-bff3-ed8016d3f6af'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<펠레나르본 부인의 회전목마>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16c8c63c-085d-418e-bff3-ed8016d3f6af'
);


-- S. 215 잊힌 왈츠 S. 215

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '잊힌 왈츠 S. 215', '4 Valses oubliées, S. 215', 'album', NULL, 'S.', '215', 1884, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '잊힌 왈츠 S. 215'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd45aab77-ae3f-4a03-8fc5-c4ed80df7ce5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd45aab77-ae3f-4a03-8fc5-c4ed80df7ce5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '잊힌 왈츠 S. 215' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd45aab77-ae3f-4a03-8fc5-c4ed80df7ce5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f94d7961-9493-3acf-9665-024f11391bd7', 1, NULL, 'F#장조', 'No. 1 in F# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '잊힌 왈츠 S. 215' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f94d7961-9493-3acf-9665-024f11391bd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:306a10bf-3fb5-4e68-bf5b-fe61bf10ba16', 2, NULL, 'A♭장조', 'No. 2 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '잊힌 왈츠 S. 215' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:306a10bf-3fb5-4e68-bf5b-fe61bf10ba16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61e53698-085b-4304-8933-42c84f955b04', 3, NULL, 'D♭장조', 'No. 3 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '잊힌 왈츠 S. 215' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61e53698-085b-4304-8933-42c84f955b04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c67c64ce-6602-4a23-89f0-9b83d98e76ca', 4, NULL, '잊힌 왈츠 4번', 'No. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '잊힌 왈츠 S. 215' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c67c64ce-6602-4a23-89f0-9b83d98e76ca'
);


-- S. 216 메피스토 왈츠 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '메피스토 왈츠 3번', 'Mephisto Waltz No. 3', 'song', 'S. 216', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '메피스토 왈츠 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92a33503-42e6-4691-a05f-bda7d79f14a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '92a33503-42e6-4691-a05f-bda7d79f14a5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '메피스토 왈츠 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '92a33503-42e6-4691-a05f-bda7d79f14a5'
);


-- S. 216a <조성 없는 바가텔>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<조성 없는 바가텔>', 'Bagatelle sans tonalité', 'song', 'S. 216a', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<조성 없는 바가텔>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc30c3a8-705d-39ca-9cab-5dbdf2234641'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc30c3a8-705d-39ca-9cab-5dbdf2234641'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<조성 없는 바가텔>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc30c3a8-705d-39ca-9cab-5dbdf2234641'
);


-- S. 216b 메피스토 왈츠 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '메피스토 왈츠 4번', 'Mephisto Waltz No. 4', 'song', 'S. 216b', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '메피스토 왈츠 4번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72737507-332b-4bef-8e77-6f7c21289f97'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72737507-332b-4bef-8e77-6f7c21289f97'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '메피스토 왈츠 4번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72737507-332b-4bef-8e77-6f7c21289f97'
);


-- S. 217 메피스토 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '메피스토 폴카', 'Mephisto Polka', 'song', 'S. 217', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '메피스토 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '525f5a6c-8281-4658-aebd-917d30c740a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '525f5a6c-8281-4658-aebd-917d30c740a0'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '메피스토 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '525f5a6c-8281-4658-aebd-917d30c740a0'
);


-- S. 218 갈롭 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갈롭 A단조', 'Galop in A minor', 'song', 'S. 218', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갈롭 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb202f8c-c921-4e8f-a856-b85613e90f5e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb202f8c-c921-4e8f-a856-b85613e90f5e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '갈롭 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb202f8c-c921-4e8f-a856-b85613e90f5e'
);


-- S. 219 반음계적 대갈롭 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '반음계적 대갈롭 E♭장조', 'Grand galop chromatique in E♭ major', 'song', 'S. 219', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '반음계적 대갈롭 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c59ef1de-ea0c-4136-aebd-d5cb9d762623'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c59ef1de-ea0c-4136-aebd-d5cb9d762623'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '반음계적 대갈롭 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c59ef1de-ea0c-4136-aebd-d5cb9d762623'
);


-- S. 220 <무도회 갈롭>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<무도회 갈롭>', 'Galop de bal', 'song', 'S. 220', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<무도회 갈롭>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3872d79-d0db-4cf4-bca8-b33c61bb3883'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3872d79-d0db-4cf4-bca8-b33c61bb3883'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<무도회 갈롭>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3872d79-d0db-4cf4-bca8-b33c61bb3883'
);


-- S. 221 화려한 마주르카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '화려한 마주르카', 'Mazurka brillante', 'song', 'S. 221', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '화려한 마주르카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8face98d-5079-439e-addd-cfa7bbfebb15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8face98d-5079-439e-addd-cfa7bbfebb15'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '화려한 마주르카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8face98d-5079-439e-addd-cfa7bbfebb15'
);


-- S. 223 2개의 폴로네즈 S. 223

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 폴로네즈 S. 223', '2 Polonaises, S. 223', 'album', NULL, 'S.', '223', 1851, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 폴로네즈 S. 223'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '479d8607-8e71-4c8a-b828-8bd1fff0f49b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '479d8607-8e71-4c8a-b828-8bd1fff0f49b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 폴로네즈 S. 223' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '479d8607-8e71-4c8a-b828-8bd1fff0f49b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2ab314b-e3ef-405f-bacf-8e1a5b8c218e', 1, NULL, 'C단조 "우울한 폴로네즈"', 'No. 1 in C minor "Polonaise mélancolique"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 폴로네즈 S. 223' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2ab314b-e3ef-405f-bacf-8e1a5b8c218e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cda9b452-9dba-4ec7-a184-e2dd55e73522', 2, NULL, 'E장조', 'No. 2 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 폴로네즈 S. 223' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cda9b452-9dba-4ec7-a184-e2dd55e73522'
);


-- S. 224 <죽음의 차르다시>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<죽음의 차르다시>', 'Csárdás macabre', 'song', 'S. 224', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<죽음의 차르다시>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c85a820-2c31-30bf-851a-e8e8589751b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c85a820-2c31-30bf-851a-e8e8589751b8'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<죽음의 차르다시>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c85a820-2c31-30bf-851a-e8e8589751b8'
);


-- S. 225 2개의 차르다시 S. 225

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 차르다시 S. 225', '2 Csárdás, S. 225', 'album', NULL, 'S.', '225', 1884, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 차르다시 S. 225'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc43a46d-c85b-42e7-b5b1-1cd2b152797c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc43a46d-c85b-42e7-b5b1-1cd2b152797c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 차르다시 S. 225' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc43a46d-c85b-42e7-b5b1-1cd2b152797c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7dc1e93-467d-4f7c-90bd-8e3d4cdfefcd', 1, NULL, '차르다시', 'No. 1 Csárdás', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 차르다시 S. 225' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7dc1e93-467d-4f7c-90bd-8e3d4cdfefcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06d761f4-e92b-3a0b-844a-0034d2801663', 2, NULL, '고집스러운 차르다시 (Csárdás obstinée)', 'No. 2 Csárdás obstinée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '2개의 차르다시 S. 225' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06d761f4-e92b-3a0b-844a-0034d2801663'
);


-- S. 226 <축전 전주곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<축전 전주곡>', 'Festvorspiel (Preludio pomposo)', 'song', 'S. 226', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<축전 전주곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61cad569-490f-4d4a-95db-24a2bb7cf60e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61cad569-490f-4d4a-95db-24a2bb7cf60e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<축전 전주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61cad569-490f-4d4a-95db-24a2bb7cf60e'
);


-- S. 228 <경의의 행진곡> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<경의의 행진곡> C장조', 'Huldigungsmarsch in C major', 'song', 'S. 228', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<경의의 행진곡> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '372d55b0-c8b0-4d26-af9b-8fb0ae603007'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '372d55b0-c8b0-4d26-af9b-8fb0ae603007'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<경의의 행진곡> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '372d55b0-c8b0-4d26-af9b-8fb0ae603007'
);


-- S. 229 <바위에서 바다로!> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<바위에서 바다로!> E♭장조', 'Vom Fels zum Meer! (Deutscher Siegesmarsch) in E♭ major', 'song', 'S. 229', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<바위에서 바다로!> E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca2c0ef8-20fb-453c-a766-a25affec8269'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca2c0ef8-20fb-453c-a766-a25affec8269'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바위에서 바다로!> E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca2c0ef8-20fb-453c-a766-a25affec8269'
);


-- S. 229a 헝가리 행진곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리 행진곡 B♭장조', 'Ungarischer Marsch in B♭ major', 'song', 'S. 229a', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리 행진곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '149904cb-4125-4c84-85ef-9f75db9371f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '149904cb-4125-4c84-85ef-9f75db9371f9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 행진곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '149904cb-4125-4c84-85ef-9f75db9371f9'
);


-- S. 230 <뷜로 행진곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<뷜로 행진곡>', 'Bülow-Marsch', 'song', 'S. 230', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<뷜로 행진곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '617d1182-d7d2-4f82-90f5-787e75de50c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '617d1182-d7d2-4f82-90f5-787e75de50c7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<뷜로 행진곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '617d1182-d7d2-4f82-90f5-787e75de50c7'
);


-- S. 230a <축전 폴로네즈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<축전 폴로네즈>', 'Festpolonaise', 'song', 'S. 230a', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<축전 폴로네즈>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '830b38fb-ab97-45f2-a42e-54c41c4b37aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '830b38fb-ab97-45f2-a42e-54c41c4b37aa'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<축전 폴로네즈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '830b38fb-ab97-45f2-a42e-54c41c4b37aa'
);


-- S. 231 헝가리풍 영웅 행진곡 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리풍 영웅 행진곡 A단조', 'Heroischer Marsch im ungarischen Stil in A minor', 'song', 'S. 231', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리풍 영웅 행진곡 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51060480-af5c-4139-a8fb-8e7cc6643cb6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51060480-af5c-4139-a8fb-8e7cc6643cb6'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리풍 영웅 행진곡 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51060480-af5c-4139-a8fb-8e7cc6643cb6'
);


-- S. 233 헝가리 급행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리 급행진곡', 'Ungarischer Geschwindmarsch', 'song', 'S. 233', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리 급행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7abd9ef3-ad64-4dc2-b408-b6d4b7e18178'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7abd9ef3-ad64-4dc2-b408-b6d4b7e18178'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 급행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7abd9ef3-ad64-4dc2-b408-b6d4b7e18178'
);


-- S. 233a 승리 행진곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '승리 행진곡 E♭장조', 'Siegesmarsch in E♭ major', 'song', 'S. 233a', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '승리 행진곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5db942e8-1a42-499f-a8ff-4b990f06593a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5db942e8-1a42-499f-a8ff-4b990f06593a'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '승리 행진곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5db942e8-1a42-499f-a8ff-4b990f06593a'
);


-- S. 233b 헝가리 행진곡 E♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리 행진곡 E♭단조', 'Marche hongroise in E♭ minor', 'song', 'S. 233b', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리 행진곡 E♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e245b73-793f-49dd-a521-5cb752264872'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e245b73-793f-49dd-a521-5cb752264872'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 행진곡 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e245b73-793f-49dd-a521-5cb752264872'
);


-- S. 242 피아노 모음곡 <헝가리 민요와 광시곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <헝가리 민요와 광시곡>', 'Magyar dalok & Magyar rapszódiák', 'album', 'S. 242', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <헝가리 민요와 광시곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5f84bfe-dd84-4621-bb91-69213066d175'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5f84bfe-dd84-4621-bb91-69213066d175'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5f84bfe-dd84-4621-bb91-69213066d175'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967', 1, NULL, '헝가리 민요 (Magyar dalok)', 'Magyar dalok (Ungarische Nationalmelodien)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc3253f5-49d4-4b31-bc43-c353b9df93f0', 1, NULL, 'C단조', 'No. 1 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc3253f5-49d4-4b31-bc43-c353b9df93f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89df7f1c-ce23-4e2f-affd-991e2786273c', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89df7f1c-ce23-4e2f-affd-991e2786273c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab146693-689b-4958-9766-6d9f8594f5e1', 3, NULL, 'D♭장조', 'No. 3 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab146693-689b-4958-9766-6d9f8594f5e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9353422-cf82-46ce-9a74-41ddcb2de801', 4, NULL, 'C#장조', 'No. 4 in C# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9353422-cf82-46ce-9a74-41ddcb2de801'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32a64f51-ea5d-4ed2-9667-912655a5c216', 5, NULL, 'D♭장조', 'No. 5 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32a64f51-ea5d-4ed2-9667-912655a5c216'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fb1d23c-0a76-4eec-89a1-294a1c4ea0fa', 6, NULL, 'G단조', 'No. 6 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb1d23c-0a76-4eec-89a1-294a1c4ea0fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a3557746-db8b-4b7b-a144-b3abfd58eb4c', 7, NULL, 'E♭장조', 'No. 7 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3557746-db8b-4b7b-a144-b3abfd58eb4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f99c5158-9177-4609-98d8-c6bafcde6747', 8, NULL, 'F단조', 'No. 8 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f99c5158-9177-4609-98d8-c6bafcde6747'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc5d778f-11fd-45a4-9351-57be1f4a8401', 9, NULL, 'A단조', 'No. 9 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc5d778f-11fd-45a4-9351-57be1f4a8401'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e9f79d7-7a35-44ce-b2ee-f2461ebd603a', 10, NULL, 'D장조', 'No. 10 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e9f79d7-7a35-44ce-b2ee-f2461ebd603a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:844a4ba0-dc4e-4b12-8244-ed5ebefd690e', 11, NULL, 'B♭장조', 'No. 11 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f2a9901-6da1-4813-929b-9a2402830967'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:844a4ba0-dc4e-4b12-8244-ed5ebefd690e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840', 2, NULL, '헝가리 광시곡 (Magyar rapszódiák)', 'Magyar rapszódiák', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1dcc87ed-090b-401e-b32e-e9c5f947699f', 1, NULL, 'E단조 "영웅적 비가"', 'No. 12 in E minor "Héroïde élégiaque"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dcc87ed-090b-401e-b32e-e9c5f947699f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:104337f9-55f1-4634-8740-6274fc5110f3', 2, NULL, 'A단조 "라코치 행진곡"', 'No. 13 in A minor "Rákóczi-Marsch"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:104337f9-55f1-4634-8740-6274fc5110f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39a454c3-09bb-4df5-8045-aa0fd6e9d3d2', 3, NULL, 'A단조', 'No. 14 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39a454c3-09bb-4df5-8045-aa0fd6e9d3d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fd0e2f3e-8b92-46da-b656-b7c95c8ae762', 4, NULL, 'D단조', 'No. 15 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd0e2f3e-8b92-46da-b656-b7c95c8ae762'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6cb006c0-1e9b-4f50-a041-d5d46b9794cc', 5, NULL, 'E장조', 'No. 16 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cb006c0-1e9b-4f50-a041-d5d46b9794cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9894cb27-2e6f-411a-8a01-158507b74ce0', 6, NULL, 'A단조', 'No. 17 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9894cb27-2e6f-411a-8a01-158507b74ce0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f63b8a0a-f851-454c-a086-221361e3e433', 7, NULL, 'C#단조', 'No. 18 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f63b8a0a-f851-454c-a086-221361e3e433'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ba45ef2d-da7d-4e22-a6b9-0ecd4f983fd4', 8, NULL, 'F#단조', 'No. 19 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba45ef2d-da7d-4e22-a6b9-0ecd4f983fd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b10665e3-0378-4e2c-928e-a700b7110b10', 9, NULL, 'G단조 "루마니아 광시곡"', 'No. 20 in G minor "Romanian Rhapsody"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b10665e3-0378-4e2c-928e-a700b7110b10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b276ce60-4dc5-4ab1-9c69-0947f56bcce8', 10, NULL, 'E단조', 'No. 21 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b276ce60-4dc5-4ab1-9c69-0947f56bcce8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21f2c02a-ddad-48d9-b964-023ac5967ce8', 11, NULL, 'E♭장조 "페스트의 사육제"', 'No. 22 in E♭ major "Pester Karneval"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f2c02a-ddad-48d9-b964-023ac5967ce8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:26a32219-5273-49c2-94a0-c8295719a19f', 12, NULL, 'C#단조 "꿈과 환상"', 'No. 23 in C# minor "Rêves et fantaisies"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08fc1eda-dc84-4fa2-aea3-0832fe6c7840'
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <헝가리 민요와 광시곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26a32219-5273-49c2-94a0-c8295719a19f'
);


-- S. 243 3개의 헝가리 민족 선율 S. 243

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 헝가리 민족 선율 S. 243', 'Ungarische Nationalmelodien, S. 243', 'album', NULL, 'S.', '243', 1843, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 헝가리 민족 선율 S. 243'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93d4a190-4fd7-49d7-9fbe-3ee1e5ab3b44'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93d4a190-4fd7-49d7-9fbe-3ee1e5ab3b44'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 헝가리 민족 선율 S. 243' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93d4a190-4fd7-49d7-9fbe-3ee1e5ab3b44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c28bde3-8252-4095-83e0-b3735338ab44', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 헝가리 민족 선율 S. 243' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c28bde3-8252-4095-83e0-b3735338ab44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80115f37-51a0-4163-95ab-d5d345ebf7bc', 2, NULL, 'C#장조', 'No. 2 in C# major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 헝가리 민족 선율 S. 243' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80115f37-51a0-4163-95ab-d5d345ebf7bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea089c4d-af51-45f2-af03-45f2f034101f', 3, NULL, 'B♭장조 "전주곡"', 'No. 3 in B♭ major "Prélude"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '3개의 헝가리 민족 선율 S. 243' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea089c4d-af51-45f2-af03-45f2f034101f'
);


-- S. 244 헝가리 광시곡 S. 244

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '헝가리 광시곡 S. 244', '19 Hungarian Rhapsodies, S. 244', 'album', NULL, 'S.', '244', 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '헝가리 광시곡 S. 244'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c90ffa1-763e-4ece-a3c2-3454c5322e99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c90ffa1-763e-4ece-a3c2-3454c5322e99'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c90ffa1-763e-4ece-a3c2-3454c5322e99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd4f29c0-913c-30e7-ba12-a80df7cc29d6', 1, NULL, 'C#단조', 'No. 1 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd4f29c0-913c-30e7-ba12-a80df7cc29d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 141 AND linked.composer_id = 30), 'musicbrainz:90929826-5064-3212-89c1-689be90e1d4d', 2, NULL, 'C#단조', 'No. 2 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90929826-5064-3212-89c1-689be90e1d4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70aa1627-ec28-31b8-a823-920225247cea', 3, NULL, 'B♭장조', 'No. 3 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70aa1627-ec28-31b8-a823-920225247cea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0244bddc-3154-3cf0-a3f1-67ccc0757e97', 4, NULL, 'E♭장조', 'No. 4 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0244bddc-3154-3cf0-a3f1-67ccc0757e97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d3d9e28-799d-3447-b68d-e323577b44af', 5, NULL, 'E단조 "영웅적 비가"', 'No. 5 in E minor "Héroïde-élégiaque"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d3d9e28-799d-3447-b68d-e323577b44af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:661afb89-7e18-3d22-a1a3-837903ee7d51', 6, NULL, 'D♭장조', 'No. 6 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:661afb89-7e18-3d22-a1a3-837903ee7d51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ac20b4-6e04-3f30-ae1e-35b35ee7182e', 7, NULL, 'D단조', 'No. 7 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ac20b4-6e04-3f30-ae1e-35b35ee7182e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea322940-a46f-30a5-aa13-303303aa2b89', 8, NULL, 'F#단조', 'No. 8 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea322940-a46f-30a5-aa13-303303aa2b89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:009854cb-461d-3027-ae5b-e962d1706b72', 9, NULL, 'E♭장조 "페스트의 사육제"', 'No. 9 in E♭ major "Pester Karneval"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:009854cb-461d-3027-ae5b-e962d1706b72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:780ebd17-8c00-3009-a0df-a6ea2c7b2e1c', 10, NULL, 'E장조 "전주곡"', 'No. 10 in E major "Preludio"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:780ebd17-8c00-3009-a0df-a6ea2c7b2e1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60b5e34c-041c-3903-9ec8-b2715d8401fb', 11, NULL, 'A단조', 'No. 11 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60b5e34c-041c-3903-9ec8-b2715d8401fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a49c5e9-e72b-3da0-a24a-ce856ea17698', 12, NULL, 'C#단조', 'No. 12 in C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a49c5e9-e72b-3da0-a24a-ce856ea17698'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83279d7d-8516-3e20-8234-d482efa526e2', 13, NULL, 'A단조', 'No. 13 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83279d7d-8516-3e20-8234-d482efa526e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6c3ba95-5192-37da-9222-30e9dc829588', 14, NULL, 'F단조', 'No. 14 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6c3ba95-5192-37da-9222-30e9dc829588'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5454927e-701a-3c59-a53f-e033e7765712', 15, NULL, 'A단조 "라코치 행진곡"', 'No. 15 in A minor "Rákóczi-Marsch"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5454927e-701a-3c59-a53f-e033e7765712'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ec8ca47-e9b1-3bb5-8fe5-4ebab9b82072', 16, NULL, 'A단조', 'No. 16 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ec8ca47-e9b1-3bb5-8fe5-4ebab9b82072'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28282d2c-455d-33b5-be0d-10781bcc6e77', 17, NULL, 'D단조', 'No. 17 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28282d2c-455d-33b5-be0d-10781bcc6e77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e27d10d-ee41-389b-994b-d2e28fd1b3e3', 18, NULL, 'F#단조', 'No. 18 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e27d10d-ee41-389b-994b-d2e28fd1b3e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b16b7f3-c421-3f56-a657-14c589e9c301', 19, NULL, 'D단조', 'No. 19 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '헝가리 광시곡 S. 244' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b16b7f3-c421-3f56-a657-14c589e9c301'
);


-- S. 248ii 나폴리의 노래 "녹턴"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '나폴리의 노래 "녹턴"', 'Canzone napolitana (Notturno)', 'song', 'S. 248ii', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '나폴리의 노래 "녹턴"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '656f6a8a-7b92-4e86-b531-a4ae6c27debe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '656f6a8a-7b92-4e86-b531-a4ae6c27debe'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '나폴리의 노래 "녹턴"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '656f6a8a-7b92-4e86-b531-a4ae6c27debe'
);


-- S. 249 피아노 모음곡 <보로닌체의 이삭줍기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <보로닌체의 이삭줍기>', 'Glanes de Woronince', 'album', 'S. 249', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <보로닌체의 이삭줍기>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67312b13-7726-46bf-92de-816b3b2270e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '67312b13-7726-46bf-92de-816b3b2270e7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <보로닌체의 이삭줍기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67312b13-7726-46bf-92de-816b3b2270e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60b3144c-d020-45b1-b351-9bdf14e6f7a0', 1, NULL, '우크라이나 발라드 (Ballade d''Ukraïne)', 'Ballade d''Ukraïne (Dumka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <보로닌체의 이삭줍기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60b3144c-d020-45b1-b351-9bdf14e6f7a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c352794-43a1-4701-9c12-0495a03f361d', 2, NULL, '폴란드 선율 (Mélodies polonaises)', 'Mélodies polonaises', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <보로닌체의 이삭줍기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c352794-43a1-4701-9c12-0495a03f361d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edc4bcfc-adff-450b-8c6e-37b0aba3bb56', 3, NULL, '애가 (Complainte)', 'Complainte (Dumka)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <보로닌체의 이삭줍기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edc4bcfc-adff-450b-8c6e-37b0aba3bb56'
);


-- S. 253 스페인 선율에 의한 대연주회 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스페인 선율에 의한 대연주회 환상곡', 'Grosse Konzertfantasie über spanische Weisen', 'song', 'S. 253', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스페인 선율에 의한 대연주회 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33b2c04f-9876-4dcd-adba-13eed30a74a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '33b2c04f-9876-4dcd-adba-13eed30a74a0'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '스페인 선율에 의한 대연주회 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '33b2c04f-9876-4dcd-adba-13eed30a74a0'
);


-- S. 254 스페인 광시곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스페인 광시곡', 'Rhapsodie espagnole', 'song', 'S. 254', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스페인 광시곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea5e7834-8ceb-48f9-a59a-88428432ad93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea5e7834-8ceb-48f9-a59a-88428432ad93'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '스페인 광시곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea5e7834-8ceb-48f9-a59a-88428432ad93'
);


-- S. 258ii <비창 협주곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<비창 협주곡>', 'Concerto pathétique for two pianos', 'song', 'S. 258ii', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<비창 협주곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1003411a-9cbd-41b9-910d-a636b082a539'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1003411a-9cbd-41b9-910d-a636b082a539'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<비창 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1003411a-9cbd-41b9-910d-a636b082a539'
);


-- S. 259 코랄 "Ad nos, ad salutarem undam"에 의한 환상곡과 푸가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코랄 "Ad nos, ad salutarem undam"에 의한 환상곡과 푸가', 'Fantasy and Fugue on the Chorale "Ad nos, ad salutarem undam"', 'song', 'S. 259', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코랄 "Ad nos, ad salutarem undam"에 의한 환상곡과 푸가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0026e668-049f-4c91-81b5-77be3cecf0d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0026e668-049f-4c91-81b5-77be3cecf0d5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '코랄 "Ad nos, ad salutarem undam"에 의한 환상곡과 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0026e668-049f-4c91-81b5-77be3cecf0d5'
);


-- S. 260ii B-A-C-H 주제에 의한 전주곡과 푸가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'B-A-C-H 주제에 의한 전주곡과 푸가', 'Prelude and Fugue on the Name B-A-C-H', 'song', 'S. 260ii', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'B-A-C-H 주제에 의한 전주곡과 푸가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e463c75-f791-4749-af6d-3273707f4ffa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e463c75-f791-4749-af6d-3273707f4ffa'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = 'B-A-C-H 주제에 의한 전주곡과 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e463c75-f791-4749-af6d-3273707f4ffa'
);


-- S. 261 오르간곡 <교황 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간곡 <교황 찬가>', 'Pio IX (Der Papsthymnus)', 'song', 'S. 261', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간곡 <교황 찬가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7760c621-b37f-4051-8b2f-2ba640fa389c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7760c621-b37f-4051-8b2f-2ba640fa389c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간곡 <교황 찬가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7760c621-b37f-4051-8b2f-2ba640fa389c'
);


-- S. 262 오르간곡 <Ora pro nobis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간곡 <Ora pro nobis>', 'Ora pro nobis', 'song', 'S. 262', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간곡 <Ora pro nobis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '225b6f03-b7e9-4302-bda1-aef8cb782bbb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '225b6f03-b7e9-4302-bda1-aef8cb782bbb'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간곡 <Ora pro nobis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '225b6f03-b7e9-4302-bda1-aef8cb782bbb'
);


-- S. 264 오르간 미사

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 미사', 'Missa pro organo lectarum celebrationi missarum adjumento inserviens', 'album', 'S. 264', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 미사'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cb29586-d6ec-4434-b0d0-91e979c68a86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4cb29586-d6ec-4434-b0d0-91e979c68a86'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4cb29586-d6ec-4434-b0d0-91e979c68a86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6b286f4-e74b-4b70-9da7-3d0545cd9297', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6b286f4-e74b-4b70-9da7-3d0545cd9297'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03a08065-21d6-48ab-a921-0c0559a4a1d3', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a08065-21d6-48ab-a921-0c0559a4a1d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf7d9dcc-69fe-47a9-b6a6-094edfb9d692', 3, 'III', '그라두알레', 'III. Graduale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf7d9dcc-69fe-47a9-b6a6-094edfb9d692'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d50c567-594e-4ccf-af0a-99afb83d8fcd', 4, 'IV', '크레도', 'IV. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d50c567-594e-4ccf-af0a-99afb83d8fcd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10b9e2b2-3d3d-47d4-ba1b-fad459041d23', 5, 'V', '오페르토리움', 'V. Offertorium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10b9e2b2-3d3d-47d4-ba1b-fad459041d23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd023abe-e3a3-4c47-a76c-1d94e2f66efb', 6, 'VI', '상투스', 'VI. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd023abe-e3a3-4c47-a76c-1d94e2f66efb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:daeb4488-7ba3-4ed3-8f91-198a891c02ee', 7, 'VII', '베네딕투스', 'VII. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daeb4488-7ba3-4ed3-8f91-198a891c02ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:528fdd49-5eb8-48c9-9752-810be7a1da5c', 8, 'VIII', '아뉴스 데이', 'VIII. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:528fdd49-5eb8-48c9-9752-810be7a1da5c'
);


-- S. 268/1 오르간곡 <Introitus>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간곡 <Introitus>', 'Introitus', 'song', 'S. 268/1', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간곡 <Introitus>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce40336e-4bd7-4a67-bdb9-bad2ebd15604'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce40336e-4bd7-4a67-bdb9-bad2ebd15604'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '오르간곡 <Introitus>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce40336e-4bd7-4a67-bdb9-bad2ebd15604'
);


-- S. 269/3 가곡 <Angiolin dal biondo crin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Angiolin dal biondo crin>', 'Angiolin dal biondo crin', 'song', 'S. 269/3', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Angiolin dal biondo crin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6b6d02c-7b59-4428-b47f-da66fc5f4331'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e6b6d02c-7b59-4428-b47f-da66fc5f4331'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Angiolin dal biondo crin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e6b6d02c-7b59-4428-b47f-da66fc5f4331'
);


-- S. 271 가곡 <Il m'aimait tant>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Il m''aimait tant>', 'Il m''aimait tant', 'song', 'S. 271', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Il m''aimait tant>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51c6964c-3e17-4494-8e45-c5d788b5b909'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51c6964c-3e17-4494-8e45-c5d788b5b909'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Il m''aimait tant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51c6964c-3e17-4494-8e45-c5d788b5b909'
);


-- S. 272/2 가곡 <Im Rhein, im schönen Strome>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Im Rhein, im schönen Strome>', 'Im Rhein, im schönen Strome', 'song', 'S. 272/2', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Im Rhein, im schönen Strome>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff9e3d00-5a34-4719-8b24-1e0fc949b505'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff9e3d00-5a34-4719-8b24-1e0fc949b505'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Im Rhein, im schönen Strome>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff9e3d00-5a34-4719-8b24-1e0fc949b505'
);


-- S. 273/2 가곡 <Die Loreley>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die Loreley>', 'Die Loreley', 'song', 'S. 273/2', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die Loreley>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2db36b6-5144-4ee2-b817-0b40ae67f6e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a2db36b6-5144-4ee2-b817-0b40ae67f6e2'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Die Loreley>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2db36b6-5144-4ee2-b817-0b40ae67f6e2'
);


-- S. 274/2 가곡 <Die Zelle in Nonnenwerth>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die Zelle in Nonnenwerth>', 'Die Zelle in Nonnenwerth', 'song', 'S. 274/2', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die Zelle in Nonnenwerth>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '533f6a91-17be-4d6d-935a-593a72c8b0d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '533f6a91-17be-4d6d-935a-593a72c8b0d5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Die Zelle in Nonnenwerth>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '533f6a91-17be-4d6d-935a-593a72c8b0d5'
);


-- S. 275/3 가곡 <Mignons Lied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mignons Lied>', 'Mignons Lied', 'song', 'S. 275/3', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mignons Lied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7149b608-7cb1-4cf2-9989-2023a2a928ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7149b608-7cb1-4cf2-9989-2023a2a928ed'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Mignons Lied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7149b608-7cb1-4cf2-9989-2023a2a928ed'
);


-- S. 276/2 가곡 <Comment, disaient-ils>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Comment, disaient-ils>', 'Comment, disaient-ils', 'song', 'S. 276/2', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Comment, disaient-ils>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1e7e76f-d7b1-4f60-9399-57bdb604f0d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1e7e76f-d7b1-4f60-9399-57bdb604f0d7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Comment, disaient-ils>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1e7e76f-d7b1-4f60-9399-57bdb604f0d7'
);


-- S. 277/2 가곡 <Bist du>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Bist du>', 'Bist du', 'song', 'S. 277/2', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Bist du>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd4d9069-39d6-4eb2-88b2-bfafb03b02b4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd4d9069-39d6-4eb2-88b2-bfafb03b02b4'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Bist du>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd4d9069-39d6-4eb2-88b2-bfafb03b02b4'
);


-- S. 278/2 가곡 <Es war ein König in Thule>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Es war ein König in Thule>', 'Es war ein König in Thule', 'song', 'S. 278/2', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Es war ein König in Thule>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c175d9b-9f3b-49e9-8a29-f25a365a5268'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c175d9b-9f3b-49e9-8a29-f25a365a5268'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Es war ein König in Thule>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c175d9b-9f3b-49e9-8a29-f25a365a5268'
);


-- S. 279/4 가곡 <Der du von dem Himmel bist>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der du von dem Himmel bist>', 'Der du von dem Himmel bist', 'song', 'S. 279/4', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der du von dem Himmel bist>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1acafde7-9a6f-4fa6-b73f-7cb2e1a0c5d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1acafde7-9a6f-4fa6-b73f-7cb2e1a0c5d9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Der du von dem Himmel bist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1acafde7-9a6f-4fa6-b73f-7cb2e1a0c5d9'
);


-- S. 280/2 가곡 <Freudvoll und leidvoll I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Freudvoll und leidvoll I>', 'Freudvoll und leidvoll I', 'song', 'S. 280/2', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Freudvoll und leidvoll I>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13e87655-6989-4a09-aa8e-4f0857fc907f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13e87655-6989-4a09-aa8e-4f0857fc907f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Freudvoll und leidvoll I>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13e87655-6989-4a09-aa8e-4f0857fc907f'
);


-- S. 280a 가곡 <Freudvoll und leidvoll II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Freudvoll und leidvoll II>', 'Freudvoll und leidvoll II', 'song', 'S. 280a', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Freudvoll und leidvoll II>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'feb56185-d475-4495-a294-a521adda7c13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'feb56185-d475-4495-a294-a521adda7c13'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Freudvoll und leidvoll II>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'feb56185-d475-4495-a294-a521adda7c13'
);


-- S. 281 가곡 <Die Vätergruft>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die Vätergruft>', 'Die Vätergruft', 'song', 'S. 281', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die Vätergruft>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc0afe49-5154-44dd-8811-1c2803f92154'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc0afe49-5154-44dd-8811-1c2803f92154'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Die Vätergruft>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc0afe49-5154-44dd-8811-1c2803f92154'
);


-- S. 282/2 가곡 <Oh! quand je dors>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Oh! quand je dors>', 'Oh! quand je dors', 'song', 'S. 282/2', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Oh! quand je dors>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '495ce4e0-c867-414c-902b-2152d741428e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '495ce4e0-c867-414c-902b-2152d741428e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Oh! quand je dors>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '495ce4e0-c867-414c-902b-2152d741428e'
);


-- S. 283/2 가곡 <Enfant, si j'étais roi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Enfant, si j''étais roi>', 'Enfant, si j''étais roi', 'song', 'S. 283/2', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Enfant, si j''étais roi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c17bb38-b90f-4aab-9b2f-fbf973c4e8ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c17bb38-b90f-4aab-9b2f-fbf973c4e8ed'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Enfant, si j''étais roi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c17bb38-b90f-4aab-9b2f-fbf973c4e8ed'
);


-- S. 284/2 가곡 <S'il est un charmant gazon>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <S''il est un charmant gazon>', 'S''il est un charmant gazon', 'song', 'S. 284/2', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <S''il est un charmant gazon>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '804b69cf-b9cd-48a0-8440-d806716f7f2c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '804b69cf-b9cd-48a0-8440-d806716f7f2c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <S''il est un charmant gazon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '804b69cf-b9cd-48a0-8440-d806716f7f2c'
);


-- S. 285 가곡 <La tombe et la rose>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La tombe et la rose>', 'La tombe et la rose', 'song', 'S. 285', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La tombe et la rose>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5be991a-36c7-489a-a327-4648284def68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5be991a-36c7-489a-a327-4648284def68'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <La tombe et la rose>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5be991a-36c7-489a-a327-4648284def68'
);


-- S. 286 가곡 <Gastibelza>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gastibelza>', 'Gastibelza', 'song', 'S. 286', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gastibelza>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aadaac92-ce04-451b-906f-e2acf5c74391'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aadaac92-ce04-451b-906f-e2acf5c74391'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Gastibelza>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aadaac92-ce04-451b-906f-e2acf5c74391'
);


-- S. 287/2 가곡 <Du bist wie eine Blume>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Du bist wie eine Blume>', 'Du bist wie eine Blume', 'song', 'S. 287/2', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Du bist wie eine Blume>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e410c47-1456-4395-8533-375e04f3115b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4e410c47-1456-4395-8533-375e04f3115b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Du bist wie eine Blume>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e410c47-1456-4395-8533-375e04f3115b'
);


-- S. 288/1 가곡 <Was Liebe sei I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Was Liebe sei I>', 'Was Liebe sei I', 'song', 'S. 288/1', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Was Liebe sei I>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ab9dd10-d38e-4a6c-8d06-eb2a807ce230'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ab9dd10-d38e-4a6c-8d06-eb2a807ce230'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Was Liebe sei I>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ab9dd10-d38e-4a6c-8d06-eb2a807ce230'
);


-- S. 288/2 가곡 <Was Liebe sei II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Was Liebe sei II>', 'Was Liebe sei II', 'song', 'S. 288/2', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Was Liebe sei II>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '286e8791-06fc-41f1-978a-4e36a1ce808a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '286e8791-06fc-41f1-978a-4e36a1ce808a'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Was Liebe sei II>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '286e8791-06fc-41f1-978a-4e36a1ce808a'
);


-- S. 288/3 가곡 <Was Liebe sei III>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Was Liebe sei III>', 'Was Liebe sei III', 'song', 'S. 288/3', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Was Liebe sei III>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cb1d5ea-b8f1-4566-b1a6-881aefb1f4a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1cb1d5ea-b8f1-4566-b1a6-881aefb1f4a7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Was Liebe sei III>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1cb1d5ea-b8f1-4566-b1a6-881aefb1f4a7'
);


-- S. 289/2 가곡 <Vergiftet sind meine Lieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Vergiftet sind meine Lieder>', 'Vergiftet sind meine Lieder', 'song', 'S. 289/2', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Vergiftet sind meine Lieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a73f975-3b99-4d89-9133-a31d1050149f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a73f975-3b99-4d89-9133-a31d1050149f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Vergiftet sind meine Lieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a73f975-3b99-4d89-9133-a31d1050149f'
);


-- S. 290/2 가곡 <Morgens steh' ich auf und frage>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Morgens steh'' ich auf und frage>', 'Morgens steh'' ich auf und frage', 'song', 'S. 290/2', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Morgens steh'' ich auf und frage>'
);


-- S. 291/2 가곡 <Die tote Nachtigall>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die tote Nachtigall>', 'Die tote Nachtigall', 'song', 'S. 291/2', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die tote Nachtigall>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '361448c2-4dc0-4a28-ba97-51dfeac7f452'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '361448c2-4dc0-4a28-ba97-51dfeac7f452'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Die tote Nachtigall>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '361448c2-4dc0-4a28-ba97-51dfeac7f452'
);


-- S. 293/2 가곡 <Jeanne d'Arc au bûcher>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Jeanne d''Arc au bûcher>', 'Jeanne d''Arc au bûcher', 'song', 'S. 293/2', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Jeanne d''Arc au bûcher>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e402647f-17a0-429f-9c6b-47b79eaa1a79'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e402647f-17a0-429f-9c6b-47b79eaa1a79'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Jeanne d''Arc au bûcher>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e402647f-17a0-429f-9c6b-47b79eaa1a79'
);


-- S. 294/2 가곡 <Es rauschen die Winde>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Es rauschen die Winde>', 'Es rauschen die Winde', 'song', 'S. 294/2', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Es rauschen die Winde>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46c16364-14f8-42a6-9a74-046c20604fad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46c16364-14f8-42a6-9a74-046c20604fad'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Es rauschen die Winde>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46c16364-14f8-42a6-9a74-046c20604fad'
);


-- S. 295 가곡 <Wo weilt er?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Wo weilt er?>', 'Wo weilt er?', 'song', 'S. 295', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Wo weilt er?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f27e7bf-040b-49f4-8776-a164ed5ad3f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f27e7bf-040b-49f4-8776-a164ed5ad3f1'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Wo weilt er?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f27e7bf-040b-49f4-8776-a164ed5ad3f1'
);


-- S. 296 가곡 <Ich möchte hingehn>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ich möchte hingehn>', 'Ich möchte hingehn', 'song', 'S. 296', NULL, NULL, 1856, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ich möchte hingehn>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c917fd93-a3b7-46d1-8426-c989cd7ae658'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c917fd93-a3b7-46d1-8426-c989cd7ae658'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Ich möchte hingehn>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c917fd93-a3b7-46d1-8426-c989cd7ae658'
);


-- S. 297/2 가곡 <Wer nie sein Brot mit Tränen aß>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Wer nie sein Brot mit Tränen aß>', 'Wer nie sein Brot mit Tränen aß', 'song', 'S. 297/2', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Wer nie sein Brot mit Tränen aß>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a93afb4-5294-4d2f-b6d9-9fa7253212c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a93afb4-5294-4d2f-b6d9-9fa7253212c4'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Wer nie sein Brot mit Tränen aß>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a93afb4-5294-4d2f-b6d9-9fa7253212c4'
);


-- S. 298/2 가곡 <O lieb, so lang du lieben kannst>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <O lieb, so lang du lieben kannst>', 'O lieb, so lang du lieben kannst', 'song', 'S. 298/2', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <O lieb, so lang du lieben kannst>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcbab98c-92fe-3f7b-8152-877a70c7070e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fcbab98c-92fe-3f7b-8152-877a70c7070e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <O lieb, so lang du lieben kannst>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcbab98c-92fe-3f7b-8152-877a70c7070e'
);


-- S. 298a 가곡 <Über die Aeolsharfe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Über die Aeolsharfe>', 'Über die Aeolsharfe', 'song', 'S. 298a', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Über die Aeolsharfe>'
);


-- S. 299/2 가곡 <Isten veled>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Isten veled>', 'Isten veled', 'song', 'S. 299/2', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Isten veled>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40c3d666-049d-42b0-9cb5-b991280d5f0c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '40c3d666-049d-42b0-9cb5-b991280d5f0c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Isten veled>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '40c3d666-049d-42b0-9cb5-b991280d5f0c'
);


-- S. 300 가곡 <Le Juif errant>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le Juif errant>', 'Le Juif errant', 'song', 'S. 300', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le Juif errant>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d582095-2743-4ddd-a031-1ed2cd0c9d28'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d582095-2743-4ddd-a031-1ed2cd0c9d28'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Le Juif errant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d582095-2743-4ddd-a031-1ed2cd0c9d28'
);


-- S. 301/2 가곡 <Kling leise, mein Lied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Kling leise, mein Lied>', 'Kling leise, mein Lied', 'song', 'S. 301/2', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Kling leise, mein Lied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dcbe491-7cc6-458e-8b79-f91b3e2fc2d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dcbe491-7cc6-458e-8b79-f91b3e2fc2d9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Kling leise, mein Lied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dcbe491-7cc6-458e-8b79-f91b3e2fc2d9'
);


-- S. 301a 가곡 <Oh pourquoi donc>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Oh pourquoi donc>', 'Oh pourquoi donc', 'song', 'S. 301a', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Oh pourquoi donc>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '445f8ad0-cb3e-4b54-bf56-1b02bf1277d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '445f8ad0-cb3e-4b54-bf56-1b02bf1277d2'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Oh pourquoi donc>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '445f8ad0-cb3e-4b54-bf56-1b02bf1277d2'
);


-- S. 302 가곡 <Die Macht der Musik>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die Macht der Musik>', 'Die Macht der Musik', 'song', 'S. 302', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die Macht der Musik>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6687b60e-6954-4533-bf77-990aa3e3e705'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6687b60e-6954-4533-bf77-990aa3e3e705'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Die Macht der Musik>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6687b60e-6954-4533-bf77-990aa3e3e705'
);


-- S. 303 가곡 <Weimars Toten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Weimars Toten>', 'Weimars Toten', 'song', 'S. 303', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Weimars Toten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3296afdb-2cf6-43d7-a41c-4a1c901caef7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3296afdb-2cf6-43d7-a41c-4a1c901caef7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Weimars Toten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3296afdb-2cf6-43d7-a41c-4a1c901caef7'
);


-- S. 304 가곡 <Le vieux vagabond>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le vieux vagabond>', 'Le vieux vagabond', 'song', 'S. 304', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le vieux vagabond>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '324442ba-4759-44be-980a-76d991fa0164'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '324442ba-4759-44be-980a-76d991fa0164'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Le vieux vagabond>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '324442ba-4759-44be-980a-76d991fa0164'
);


-- S. 305/2 가곡 <Schwebe, schwebe, blaues Auge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Schwebe, schwebe, blaues Auge>', 'Schwebe, schwebe, blaues Auge', 'song', 'S. 305/2', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Schwebe, schwebe, blaues Auge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f843642-d7f5-45a5-b7ca-1c2ec2b86aa9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f843642-d7f5-45a5-b7ca-1c2ec2b86aa9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Schwebe, schwebe, blaues Auge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f843642-d7f5-45a5-b7ca-1c2ec2b86aa9'
);


-- S. 306/2 가곡 <Über allen Gipfeln ist Ruh>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Über allen Gipfeln ist Ruh>', 'Über allen Gipfeln ist Ruh', 'song', 'S. 306/2', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Über allen Gipfeln ist Ruh>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4d567b8-18e5-4e48-842e-c09b866680fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4d567b8-18e5-4e48-842e-c09b866680fe'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Über allen Gipfeln ist Ruh>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4d567b8-18e5-4e48-842e-c09b866680fe'
);


-- S. 306a 가곡 <Quand tu chantes bercée>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Quand tu chantes bercée>', 'Quand tu chantes bercée', 'song', 'S. 306a', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Quand tu chantes bercée>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fbbe5e38-69d6-4ed0-a40f-914cdfaba989'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fbbe5e38-69d6-4ed0-a40f-914cdfaba989'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Quand tu chantes bercée>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fbbe5e38-69d6-4ed0-a40f-914cdfaba989'
);


-- S. 306b 가곡 <Göttliche Gedanken, selige Gefühle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Göttliche Gedanken, selige Gefühle>', 'Göttliche Gedanken, selige Gefühle', 'song', 'S. 306b', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Göttliche Gedanken, selige Gefühle>'
);


-- S. 307 가곡 <Hohe Liebe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Hohe Liebe>', 'Hohe Liebe', 'song', 'S. 307', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Hohe Liebe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b33cf58-1d18-48b2-a5ec-19e3152f811c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b33cf58-1d18-48b2-a5ec-19e3152f811c'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Hohe Liebe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b33cf58-1d18-48b2-a5ec-19e3152f811c'
);


-- S. 308 가곡 <Gestorben war ich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gestorben war ich>', 'Gestorben war ich', 'song', 'S. 308', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gestorben war ich>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3dc69d02-6bbd-4e5e-8d27-b3c6f2c2f45e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3dc69d02-6bbd-4e5e-8d27-b3c6f2c2f45e'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Gestorben war ich>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3dc69d02-6bbd-4e5e-8d27-b3c6f2c2f45e'
);


-- S. 309 가곡 <Ein Fichtenbaum steht einsam I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ein Fichtenbaum steht einsam I>', 'Ein Fichtenbaum steht einsam I', 'song', 'S. 309', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ein Fichtenbaum steht einsam I>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f60d7f4c-bc13-4450-8b2d-ad766027bb31'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f60d7f4c-bc13-4450-8b2d-ad766027bb31'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Ein Fichtenbaum steht einsam I>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f60d7f4c-bc13-4450-8b2d-ad766027bb31'
);


-- S. 309a 가곡 <Ein Fichtenbaum steht einsam II>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ein Fichtenbaum steht einsam II>', 'Ein Fichtenbaum steht einsam II', 'song', 'S. 309a', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ein Fichtenbaum steht einsam II>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26c6897f-e8ed-42c4-9ec6-29b62dfffa61'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '26c6897f-e8ed-42c4-9ec6-29b62dfffa61'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Ein Fichtenbaum steht einsam II>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26c6897f-e8ed-42c4-9ec6-29b62dfffa61'
);


-- S. 310 가곡 <Nimm einen Strahl der Sonne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Nimm einen Strahl der Sonne>', 'Nimm einen Strahl der Sonne', 'song', 'S. 310', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Nimm einen Strahl der Sonne>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75b446c9-2ad6-420f-8098-cd940cfca4d0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75b446c9-2ad6-420f-8098-cd940cfca4d0'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Nimm einen Strahl der Sonne>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75b446c9-2ad6-420f-8098-cd940cfca4d0'
);


-- S. 311/2 가곡 <Anfangs wollt' ich fast verzagen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Anfangs wollt'' ich fast verzagen>', 'Anfangs wollt'' ich fast verzagen', 'song', 'S. 311/2', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Anfangs wollt'' ich fast verzagen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0545201-7a03-4edd-8d47-a59bc0eb03b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f0545201-7a03-4edd-8d47-a59bc0eb03b9'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Anfangs wollt'' ich fast verzagen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f0545201-7a03-4edd-8d47-a59bc0eb03b9'
);


-- S. 312 가곡 <Wie singt die Lerche schön>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Wie singt die Lerche schön>', 'Wie singt die Lerche schön', 'song', 'S. 312', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Wie singt die Lerche schön>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6e614fa-300d-46f3-b440-ab37eb397699'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd6e614fa-300d-46f3-b440-ab37eb397699'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Wie singt die Lerche schön>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd6e614fa-300d-46f3-b440-ab37eb397699'
);


-- S. 313 가곡 <Weimars Volkslied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Weimars Volkslied>', 'Weimars Volkslied', 'song', 'S. 313', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Weimars Volkslied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e19f90d9-b685-417a-8345-1a5fea5ca5ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e19f90d9-b685-417a-8345-1a5fea5ca5ac'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Weimars Volkslied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e19f90d9-b685-417a-8345-1a5fea5ca5ac'
);


-- S. 314 가곡 <Es muss ein Wunderbares sein>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Es muss ein Wunderbares sein>', 'Es muss ein Wunderbares sein', 'song', 'S. 314', NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Es muss ein Wunderbares sein>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93c87593-813b-3303-9843-3514d2d5fa13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93c87593-813b-3303-9843-3514d2d5fa13'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Es muss ein Wunderbares sein>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93c87593-813b-3303-9843-3514d2d5fa13'
);


-- S. 315 가곡 <Ich liebe dich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ich liebe dich>', 'Ich liebe dich', 'song', 'S. 315', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ich liebe dich>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4b54990-cce0-4982-ba6a-5b27f3cb1777'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f4b54990-cce0-4982-ba6a-5b27f3cb1777'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Ich liebe dich>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4b54990-cce0-4982-ba6a-5b27f3cb1777'
);


-- S. 317 가곡 <Lasst mich ruhen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lasst mich ruhen>', 'Lasst mich ruhen', 'song', 'S. 317', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lasst mich ruhen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7410202-81bc-4307-a669-a2526cdb1683'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7410202-81bc-4307-a669-a2526cdb1683'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Lasst mich ruhen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7410202-81bc-4307-a669-a2526cdb1683'
);


-- S. 318 가곡 <In Liebeslust>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <In Liebeslust>', 'In Liebeslust', 'song', 'S. 318', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <In Liebeslust>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62a5b003-0c9d-40e3-98ca-5bf408755dc8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62a5b003-0c9d-40e3-98ca-5bf408755dc8'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <In Liebeslust>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62a5b003-0c9d-40e3-98ca-5bf408755dc8'
);


-- S. 319 가곡 <Ich scheide>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ich scheide>', 'Ich scheide', 'song', 'S. 319', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ich scheide>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6352bc24-202c-4fbf-95ce-e40977cae68d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6352bc24-202c-4fbf-95ce-e40977cae68d'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Ich scheide>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6352bc24-202c-4fbf-95ce-e40977cae68d'
);


-- S. 320 가곡 <Die drei Zigeuner>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die drei Zigeuner>', 'Die drei Zigeuner', 'song', 'S. 320', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die drei Zigeuner>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '267c2470-131b-4286-9e50-e7939a46f1f4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '267c2470-131b-4286-9e50-e7939a46f1f4'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Die drei Zigeuner>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '267c2470-131b-4286-9e50-e7939a46f1f4'
);


-- S. 321 가곡 <Die stille Wasserrose>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die stille Wasserrose>', 'Die stille Wasserrose', 'song', 'S. 321', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die stille Wasserrose>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f8b98a5-f6d1-48e7-bae8-7d8dd35f62c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f8b98a5-f6d1-48e7-bae8-7d8dd35f62c8'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Die stille Wasserrose>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f8b98a5-f6d1-48e7-bae8-7d8dd35f62c8'
);


-- S. 322 가곡 <Wieder möcht' ich dir begegnen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Wieder möcht'' ich dir begegnen>', 'Wieder möcht'' ich dir begegnen', 'song', 'S. 322', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Wieder möcht'' ich dir begegnen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81ede032-cd28-4135-ab1c-355674d2f81f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81ede032-cd28-4135-ab1c-355674d2f81f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Wieder möcht'' ich dir begegnen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81ede032-cd28-4135-ab1c-355674d2f81f'
);


-- S. 323 가곡 <Jugendglück>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Jugendglück>', 'Jugendglück', 'song', 'S. 323', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Jugendglück>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7750bbb-d8a8-419d-8308-69be65634a82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7750bbb-d8a8-419d-8308-69be65634a82'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Jugendglück>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7750bbb-d8a8-419d-8308-69be65634a82'
);


-- S. 324 가곡 <Blume und Duft>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Blume und Duft>', 'Blume und Duft', 'song', 'S. 324', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Blume und Duft>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7516cf0e-dac7-40b9-aab5-727f659f9a7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7516cf0e-dac7-40b9-aab5-727f659f9a7f'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Blume und Duft>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7516cf0e-dac7-40b9-aab5-727f659f9a7f'
);


-- S. 324a 가곡 <Не брани меня, мой друг>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Не брани меня, мой друг>', 'Не брани меня, мой друг', 'song', 'S. 324a', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Не брани меня, мой друг>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4fd30b1-d0fb-45bc-bfdd-4807483a04b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4fd30b1-d0fb-45bc-bfdd-4807483a04b8'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Не брани меня, мой друг>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4fd30b1-d0fb-45bc-bfdd-4807483a04b8'
);


-- S. 325 가곡 <Die Fischerstochter>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die Fischerstochter>', 'Die Fischerstochter', 'song', 'S. 325', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die Fischerstochter>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c67b9e31-4ede-4f13-8fd0-9d13078bc022'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c67b9e31-4ede-4f13-8fd0-9d13078bc022'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Die Fischerstochter>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c67b9e31-4ede-4f13-8fd0-9d13078bc022'
);


-- S. 326 가곡 <La perla>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La perla>', 'La perla', 'song', 'S. 326', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La perla>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '444a5726-2129-4b66-8a0c-d29dfee2dc81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '444a5726-2129-4b66-8a0c-d29dfee2dc81'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <La perla>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '444a5726-2129-4b66-8a0c-d29dfee2dc81'
);


-- S. 327 가곡 <J'ai perdu ma force et ma vie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <J''ai perdu ma force et ma vie>', 'J''ai perdu ma force et ma vie', 'song', 'S. 327', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <J''ai perdu ma force et ma vie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75fc169a-ffd2-44c9-b75f-4868082070dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75fc169a-ffd2-44c9-b75f-4868082070dc'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <J''ai perdu ma force et ma vie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75fc169a-ffd2-44c9-b75f-4868082070dc'
);


-- S. 328 가곡 <Ihr Glocken von Marling>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ihr Glocken von Marling>', 'Ihr Glocken von Marling', 'song', 'S. 328', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ihr Glocken von Marling>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4d3b67a-c9f9-4a5c-a2b3-8cbb2b155401'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4d3b67a-c9f9-4a5c-a2b3-8cbb2b155401'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Ihr Glocken von Marling>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4d3b67a-c9f9-4a5c-a2b3-8cbb2b155401'
);


-- S. 329 가곡 <Und sprich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Und sprich>', 'Und sprich', 'song', 'S. 329', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Und sprich>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39654c7e-b5a8-4d08-84e9-fb2fe6dd1b75'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '39654c7e-b5a8-4d08-84e9-fb2fe6dd1b75'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Und sprich>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39654c7e-b5a8-4d08-84e9-fb2fe6dd1b75'
);


-- S. 330 가곡 <Sei still>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sei still>', 'Sei still', 'song', 'S. 330', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sei still>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a74081a8-67e4-4897-95cb-a0e9bce77d91'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a74081a8-67e4-4897-95cb-a0e9bce77d91'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Sei still>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a74081a8-67e4-4897-95cb-a0e9bce77d91'
);


-- S. 331 가곡 <Gebet>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gebet>', 'Gebet', 'song', 'S. 331', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gebet>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'abe6df61-a758-465d-b767-6719149c5582'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'abe6df61-a758-465d-b767-6719149c5582'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Gebet>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'abe6df61-a758-465d-b767-6719149c5582'
);


-- S. 332 가곡 <Einst>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Einst>', 'Einst', 'song', 'S. 332', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Einst>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae61e702-4d31-44f8-8ba2-671e99d0f7e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae61e702-4d31-44f8-8ba2-671e99d0f7e5'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Einst>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae61e702-4d31-44f8-8ba2-671e99d0f7e5'
);


-- S. 333 가곡 <An Edlitam>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <An Edlitam>', 'An Edlitam', 'song', 'S. 333', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <An Edlitam>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '640f2d57-0094-48e4-b072-5d0a99830f1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '640f2d57-0094-48e4-b072-5d0a99830f1a'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <An Edlitam>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '640f2d57-0094-48e4-b072-5d0a99830f1a'
);


-- S. 334 가곡 <Der Glückliche>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Glückliche>', 'Der Glückliche', 'song', 'S. 334', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Glückliche>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90a6e80a-6f0f-43ba-98a8-2402833b7a50'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90a6e80a-6f0f-43ba-98a8-2402833b7a50'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Der Glückliche>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90a6e80a-6f0f-43ba-98a8-2402833b7a50'
);


-- S. 335 가곡 <Go Not, Happy Day>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Go Not, Happy Day>', 'Go Not, Happy Day', 'song', 'S. 335', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Go Not, Happy Day>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '862d238c-2df7-4da8-bbda-645e2a0b2344'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '862d238c-2df7-4da8-bbda-645e2a0b2344'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Go Not, Happy Day>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '862d238c-2df7-4da8-bbda-645e2a0b2344'
);


-- S. 336 가곡 <Verlassen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Verlassen>', 'Verlassen', 'song', 'S. 336', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Verlassen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'baaffd1a-6c6a-4ce5-a6d2-f068302d0e97'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'baaffd1a-6c6a-4ce5-a6d2-f068302d0e97'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Verlassen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'baaffd1a-6c6a-4ce5-a6d2-f068302d0e97'
);


-- S. 337 가곡 <Des Tages laute Stimmen schweigen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Des Tages laute Stimmen schweigen>', 'Des Tages laute Stimmen schweigen', 'song', 'S. 337', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Des Tages laute Stimmen schweigen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '760f79ac-9e5c-44e5-bb5d-205806c751e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '760f79ac-9e5c-44e5-bb5d-205806c751e7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Des Tages laute Stimmen schweigen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '760f79ac-9e5c-44e5-bb5d-205806c751e7'
);


-- S. 338 가곡 <Und wir dachten der Toten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Und wir dachten der Toten>', 'Und wir dachten der Toten', 'song', 'S. 338', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Und wir dachten der Toten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '087b1ce5-e71f-49ee-86bd-0e5a6325d8e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '087b1ce5-e71f-49ee-86bd-0e5a6325d8e7'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Und wir dachten der Toten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '087b1ce5-e71f-49ee-86bd-0e5a6325d8e7'
);


-- S. 339 가곡 <A magyarok Istene>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <A magyarok Istene>', 'A magyarok Istene', 'song', 'S. 339', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <A magyarok Istene>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a23d3b95-14fb-4a4d-b588-2b47202c3785'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a23d3b95-14fb-4a4d-b588-2b47202c3785'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <A magyarok Istene>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a23d3b95-14fb-4a4d-b588-2b47202c3785'
);


-- S. 340 가곡 <Magyar király-dal>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Magyar király-dal>', 'Magyar király-dal', 'song', 'S. 340', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Magyar király-dal>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b409390-f5b0-4c57-bb39-ad0d8c2c2106'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b409390-f5b0-4c57-bb39-ad0d8c2c2106'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Magyar király-dal>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b409390-f5b0-4c57-bb39-ad0d8c2c2106'
);


-- S. 341 가곡 <Ave Maria IV>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ave Maria IV>', 'Ave Maria IV', 'song', 'S. 341', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ave Maria IV>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab424136-48f9-4f8e-919b-b67eb4f040d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab424136-48f9-4f8e-919b-b67eb4f040d6'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Ave Maria IV>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab424136-48f9-4f8e-919b-b67eb4f040d6'
);


-- S. 342/3 가곡 <Le Crucifix>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le Crucifix>', 'Le Crucifix', 'song', 'S. 342/3', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le Crucifix>'
);


-- S. 343 가곡 <Sancta Caecilia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sancta Caecilia>', 'Sancta Caecilia', 'song', 'S. 343', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sancta Caecilia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75385a47-b318-4fcf-a4e4-fcbcf5dc6f6b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75385a47-b318-4fcf-a4e4-fcbcf5dc6f6b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <Sancta Caecilia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75385a47-b318-4fcf-a4e4-fcbcf5dc6f6b'
);


-- S. 344 가곡 <O Meer im Abendstrahl>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <O Meer im Abendstrahl>', 'O Meer im Abendstrahl', 'song', 'S. 344', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <O Meer im Abendstrahl>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '630bc1e9-f562-4296-b09d-8334cd763461'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '630bc1e9-f562-4296-b09d-8334cd763461'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡 <O Meer im Abendstrahl>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '630bc1e9-f562-4296-b09d-8334cd763461'
);


-- S. 270b 가곡집 <페트라르카의 3개의 소네트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <페트라르카의 3개의 소네트>', 'Tre sonetti di Petrarca (second version)', 'album', 'S. 270b', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <페트라르카의 3개의 소네트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1f11b7d-bdbc-4dad-9fdc-73da44259837'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1f11b7d-bdbc-4dad-9fdc-73da44259837'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <페트라르카의 3개의 소네트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1f11b7d-bdbc-4dad-9fdc-73da44259837'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a902984-3eca-4e1a-bbce-078c7d3cf578', 1, NULL, 'Benedetto sia ''l giorno', 'Benedetto sia ''l giorno (Sei gesegnet immerdar)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <페트라르카의 3개의 소네트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a902984-3eca-4e1a-bbce-078c7d3cf578'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee8e0049-c159-4a0d-8c7b-a6b4603a9a03', 2, NULL, 'Pace non trovo', 'Pace non trovo (Fried'' ist versagt mir)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <페트라르카의 3개의 소네트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee8e0049-c159-4a0d-8c7b-a6b4603a9a03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9430351-7954-4d10-920b-9529e2914979', 3, NULL, 'I'' vidi in terra angelici costumi', 'I vidi in terra (So sah ich denn auf Erden Engelsfrieden und Glanz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <페트라르카의 3개의 소네트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9430351-7954-4d10-920b-9529e2914979'
);


-- S. 292b 가곡집 <실러의 '빌헬름 텔'에 의한 3개의 가곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <실러의 ''빌헬름 텔''에 의한 3개의 가곡>', 'Lieder aus Schillers Wilhelm Tell (second version)', 'album', 'S. 292b', NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <실러의 ''빌헬름 텔''에 의한 3개의 가곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '349bd444-c864-456d-bf9c-03472fc1564b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '349bd444-c864-456d-bf9c-03472fc1564b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <실러의 ''빌헬름 텔''에 의한 3개의 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '349bd444-c864-456d-bf9c-03472fc1564b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93bc6352-aef5-47b9-846f-a9546eb9c7c4', 1, NULL, 'Der Fischerknabe', 'Der Fischerknabe (Es lächelt der See)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <실러의 ''빌헬름 텔''에 의한 3개의 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93bc6352-aef5-47b9-846f-a9546eb9c7c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:423fc0fc-d10d-431d-8cc9-22428ae57271', 2, NULL, 'Der Hirt', 'Der Hirt (Ihr Matten lebt wohl)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <실러의 ''빌헬름 텔''에 의한 3개의 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:423fc0fc-d10d-431d-8cc9-22428ae57271'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4895d6d5-f069-4f98-b0c8-05721bea33eb', 3, NULL, 'Der Alpenjäger', 'Der Alpenjäger (Es donnern die Höh''n)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <실러의 ''빌헬름 텔''에 의한 3개의 가곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4895d6d5-f069-4f98-b0c8-05721bea33eb'
);


-- S. 316 가곡집 <Muttergottes-Sträusslein zum Mai-Monate>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <Muttergottes-Sträusslein zum Mai-Monate>', 'Muttergottes-Sträusslein zum Mai-Monate', 'album', 'S. 316', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <Muttergottes-Sträusslein zum Mai-Monate>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea21c855-9290-42eb-9a64-da029dfa9447'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea21c855-9290-42eb-9a64-da029dfa9447'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <Muttergottes-Sträusslein zum Mai-Monate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea21c855-9290-42eb-9a64-da029dfa9447'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46aedd3b-0b3c-41f1-a68c-c5f47aacf8e8', 1, NULL, 'Das Veilchen', 'Das Veilchen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <Muttergottes-Sträusslein zum Mai-Monate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46aedd3b-0b3c-41f1-a68c-c5f47aacf8e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:687633b5-ca0d-499e-86c1-980212a99a8b', 2, NULL, 'Die Schlüsselblumen', 'Die Schlüsselblumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '가곡집 <Muttergottes-Sträusslein zum Mai-Monate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:687633b5-ca0d-499e-86c1-980212a99a8b'
);


-- S. 345 <바르트부르크의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<바르트부르크의 노래>', 'Wartburg-Lieder', 'album', 'S. 345', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<바르트부르크의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81c44292-f6d0-40a3-b3e5-55d7fb947656'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81c44292-f6d0-40a3-b3e5-55d7fb947656'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바르트부르크의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81c44292-f6d0-40a3-b3e5-55d7fb947656'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e45ad588-24ec-42b1-baa6-fede4f24f90e', 1, NULL, 'An Frau Minne', 'An Frau Minne (Die Erde ist erschlossen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바르트부르크의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e45ad588-24ec-42b1-baa6-fede4f24f90e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5327bec5-e08e-4a0a-be42-996808cc5df7', 2, NULL, 'Wolfram von Eschenbach', 'Wolfram von Eschenbach (Als wir mit deutschen Klingen)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바르트부르크의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5327bec5-e08e-4a0a-be42-996808cc5df7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:602a2698-634e-49e2-b271-2c5a234b519a', 3, NULL, 'Heinrich von Ofterdingen', 'Heinrich von Ofterdingen (Hab'' ich geträumt?)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바르트부르크의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:602a2698-634e-49e2-b271-2c5a234b519a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40c3f5a2-0c7e-4747-9c33-d16750d4226f', 4, NULL, 'Walther von der Vogelweide', 'Walther von der Vogelweide (Beim Scheiden der Sonne erschimmert)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바르트부르크의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40c3f5a2-0c7e-4747-9c33-d16750d4226f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b47986a-0751-4bc4-9dde-fd77b952cdda', 5, NULL, 'Der tugendhafte Schreiber', 'Der tugendhafte Schreiber (Ich schrieb allzeit nur wenig)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바르트부르크의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b47986a-0751-4bc4-9dde-fd77b952cdda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d17f3c7b-4b03-4102-87d6-1135bc163a63', 6, NULL, 'Biterolf und der Schmied von Ruhla', 'Biterolf und der Schmied von Ruhla (Thüringens Wälder senden den Waidmann und den Schmied)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바르트부르크의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d17f3c7b-4b03-4102-87d6-1135bc163a63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef1dcb93-6db2-4525-8926-29b264da7227', 7, NULL, 'Reimar der Alte', 'Reimar der Alte (Wo liebende Herzen sich innig vermählt)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '<바르트부르크의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef1dcb93-6db2-4525-8926-29b264da7227'
);


-- S. 346 멜로드라마 <Lenore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <Lenore>', 'Lenore', 'song', 'S. 346', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <Lenore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bb629e9-d8ac-43f7-8a6a-7dfb64872c86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bb629e9-d8ac-43f7-8a6a-7dfb64872c86'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '멜로드라마 <Lenore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bb629e9-d8ac-43f7-8a6a-7dfb64872c86'
);


-- S. 347 멜로드라마 <Vor hundert Jahren>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <Vor hundert Jahren>', 'Vor hundert Jahren', 'song', 'S. 347', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <Vor hundert Jahren>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13893d2e-9cbe-4ebf-a365-e39912819576'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13893d2e-9cbe-4ebf-a365-e39912819576'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '멜로드라마 <Vor hundert Jahren>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13893d2e-9cbe-4ebf-a365-e39912819576'
);


-- S. 348 멜로드라마 <Der traurige Mönch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <Der traurige Mönch>', 'Der traurige Mönch', 'song', 'S. 348', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <Der traurige Mönch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd318a262-1e6d-4a6d-af94-ebd5067c6593'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd318a262-1e6d-4a6d-af94-ebd5067c6593'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '멜로드라마 <Der traurige Mönch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd318a262-1e6d-4a6d-af94-ebd5067c6593'
);


-- S. 349 멜로드라마 <Des toten Dichters Liebe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <Des toten Dichters Liebe>', 'Des toten Dichters Liebe', 'song', 'S. 349', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <Des toten Dichters Liebe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3460f1a6-478d-4b05-b6c3-4cadc5e988b0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3460f1a6-478d-4b05-b6c3-4cadc5e988b0'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '멜로드라마 <Des toten Dichters Liebe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3460f1a6-478d-4b05-b6c3-4cadc5e988b0'
);


-- S. 350 멜로드라마 <Der blinde Sänger>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <Der blinde Sänger>', 'Der blinde Sänger', 'song', 'S. 350', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <Der blinde Sänger>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbd7bfc9-c5ea-4e32-a7d9-71ba4b9428fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbd7bfc9-c5ea-4e32-a7d9-71ba4b9428fd'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '멜로드라마 <Der blinde Sänger>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbd7bfc9-c5ea-4e32-a7d9-71ba4b9428fd'
);


-- S. 514 메피스토 왈츠 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '메피스토 왈츠 1번', 'Mephisto Waltz No. 1 (Der Tanz in der Dorfschenke)', 'song', 'S. 514', NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '메피스토 왈츠 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '982af684-2449-35de-abdb-04dfcd61358b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '982af684-2449-35de-abdb-04dfcd61358b'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '메피스토 왈츠 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '982af684-2449-35de-abdb-04dfcd61358b'
);


-- S. 515 메피스토 왈츠 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '메피스토 왈츠 2번', 'Mephisto Waltz No. 2', 'song', 'S. 515', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '메피스토 왈츠 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd85798e2-a2b2-4c37-a8e2-b6afa03bfa45'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd85798e2-a2b2-4c37-a8e2-b6afa03bfa45'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '메피스토 왈츠 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd85798e2-a2b2-4c37-a8e2-b6afa03bfa45'
);


-- S. 541 피아노 모음곡 <사랑의 꿈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <사랑의 꿈>', 'Liebesträume, S. 541', 'album', 'S. 541', NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 30
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <사랑의 꿈>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '879ddafd-4b41-4437-ab7f-18b1db2f9c0d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '879ddafd-4b41-4437-ab7f-18b1db2f9c0d'
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <사랑의 꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '879ddafd-4b41-4437-ab7f-18b1db2f9c0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f86dc270-4e8b-3f02-b550-e79805de6f28', 1, NULL, 'A♭장조 "고귀한 사랑"', 'No. 1 in A♭ major "Hohe Liebe"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <사랑의 꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f86dc270-4e8b-3f02-b550-e79805de6f28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fcf43d7-06a3-42bc-9dbb-a73b04eca718', 2, NULL, 'E♭장조 "축복받은 죽음"', 'No. 2 in E♭ major "Seliger Tod"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <사랑의 꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fcf43d7-06a3-42bc-9dbb-a73b04eca718'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 139 AND linked.composer_id = 30), 'musicbrainz:0edc5a7d-48e1-393e-9a88-3ed0ce05aee0', 3, NULL, 'A♭장조 "오, 사랑할 수 있는 한 사랑하라"', 'No. 3 in A♭ major "O lieb, so lang du lieben kannst"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 30 AND p.title = '피아노 모음곡 <사랑의 꿈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0edc5a7d-48e1-393e-9a88-3ed0ce05aee0'
);

