-- 베르디 작품을 출판 단위로 채운다(카탈로그: 없음). 작품 55개(묶음 3, 다악장 3, 낱곡 49),
-- 새 작품 51개, 기존 작품 4개, part 33개, 그 아래 12개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   오페라 28편(개작 <예루살렘>·<아롤도> 포함)은 part 없이 둔다. 레퀴엠(152)에는 악장과 Dies irae·Offertorio 아래 곡을 붙인다.
--   대목 작품 151 은 그대로 두고 <나부코> 전체는 따로 넣는다.
--
-- 공통: 자료는 seed_pipeline/curation/catalog-wave2-2026-10-12/<작곡가>/catalog.json 이고, 본문은 그 폴더의
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

-- None 오페라 <오베르토>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오베르토>', 'Opera <Oberto, conte di San Bonifacio>', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오베르토>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff74f9c1-f096-4869-aa30-5c047b770267'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff74f9c1-f096-4869-aa30-5c047b770267'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <오베르토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff74f9c1-f096-4869-aa30-5c047b770267'
);


-- None 오페라 <하루만의 임금님>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <하루만의 임금님>', 'Opera <Un giorno di regno>', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <하루만의 임금님>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '319a4300-f557-43ab-8f7a-9e5a2004466e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '319a4300-f557-43ab-8f7a-9e5a2004466e'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <하루만의 임금님>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '319a4300-f557-43ab-8f7a-9e5a2004466e'
);


-- None 오페라 <나부코>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <나부코>', 'Opera <Nabucco>', 'song', NULL, NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <나부코>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '445fc058-1596-3903-94a7-3ad4f38410c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '445fc058-1596-3903-94a7-3ad4f38410c6'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <나부코>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '445fc058-1596-3903-94a7-3ad4f38410c6'
);


-- None 오페라 <제1차 십자군의 롬바르디아인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <제1차 십자군의 롬바르디아인>', 'Opera <I Lombardi alla prima crociata>', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <제1차 십자군의 롬바르디아인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a10ad121-fe49-41a1-8cc8-ac2a37993df6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a10ad121-fe49-41a1-8cc8-ac2a37993df6'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <제1차 십자군의 롬바르디아인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a10ad121-fe49-41a1-8cc8-ac2a37993df6'
);


-- None 오페라 <에르나니>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <에르나니>', 'Opera <Ernani>', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <에르나니>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b0c1526-566f-4cee-9e89-012df89473ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b0c1526-566f-4cee-9e89-012df89473ab'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <에르나니>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b0c1526-566f-4cee-9e89-012df89473ab'
);


-- None 오페라 <두 사람의 포스카리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <두 사람의 포스카리>', 'Opera <I due Foscari>', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <두 사람의 포스카리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2da695e-b9f7-4191-a832-03d9bc8592ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2da695e-b9f7-4191-a832-03d9bc8592ed'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <두 사람의 포스카리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2da695e-b9f7-4191-a832-03d9bc8592ed'
);


-- None 오페라 <조반나 다르코>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <조반나 다르코>', 'Opera <Giovanna d''Arco>', 'song', NULL, NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <조반나 다르코>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1471e76d-16af-4a24-8fc9-dbf7c3520f58'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1471e76d-16af-4a24-8fc9-dbf7c3520f58'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <조반나 다르코>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1471e76d-16af-4a24-8fc9-dbf7c3520f58'
);


-- None 오페라 <알지라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <알지라>', 'Opera <Alzira>', 'song', NULL, NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <알지라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec06a274-9c68-4b05-8597-4aadcc24ef76'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec06a274-9c68-4b05-8597-4aadcc24ef76'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <알지라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec06a274-9c68-4b05-8597-4aadcc24ef76'
);


-- None 오페라 <아틸라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아틸라>', 'Opera <Attila>', 'song', NULL, NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아틸라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '996e4173-8665-47c0-90ec-137719ad6930'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '996e4173-8665-47c0-90ec-137719ad6930'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <아틸라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '996e4173-8665-47c0-90ec-137719ad6930'
);


-- None 오페라 <맥베스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <맥베스>', 'Opera <Macbeth>', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <맥베스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ba64e41-8036-4591-87a5-0120123a10cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ba64e41-8036-4591-87a5-0120123a10cf'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <맥베스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ba64e41-8036-4591-87a5-0120123a10cf'
);


-- None 오페라 <군도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <군도>', 'Opera <I masnadieri>', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <군도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a90d20e3-62ec-4b2b-a838-7b71991ea456'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a90d20e3-62ec-4b2b-a838-7b71991ea456'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <군도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a90d20e3-62ec-4b2b-a838-7b71991ea456'
);


-- None 오페라 <예루살렘>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <예루살렘>', 'Opera <Jérusalem>', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <예루살렘>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efb90abe-46df-4bed-96c1-02b21f2970c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efb90abe-46df-4bed-96c1-02b21f2970c6'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <예루살렘>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efb90abe-46df-4bed-96c1-02b21f2970c6'
);


-- None 오페라 <해적>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <해적>', 'Opera <Il corsaro>', 'song', NULL, NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <해적>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '859199f5-1b6e-4edc-a1f1-f3f4e623a7e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '859199f5-1b6e-4edc-a1f1-f3f4e623a7e8'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <해적>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '859199f5-1b6e-4edc-a1f1-f3f4e623a7e8'
);


-- None 오페라 <레냐노 전투>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <레냐노 전투>', 'Opera <La battaglia di Legnano>', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <레냐노 전투>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd6181cb-9565-4788-aa19-447eb8820a5a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd6181cb-9565-4788-aa19-447eb8820a5a'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <레냐노 전투>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd6181cb-9565-4788-aa19-447eb8820a5a'
);


-- None 오페라 <루이자 밀러>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <루이자 밀러>', 'Opera <Luisa Miller>', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <루이자 밀러>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1facfcc8-146a-46a9-909d-a0efbc177042'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1facfcc8-146a-46a9-909d-a0efbc177042'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <루이자 밀러>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1facfcc8-146a-46a9-909d-a0efbc177042'
);


-- None 오페라 <스티펠리오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <스티펠리오>', 'Opera <Stiffelio>', 'song', NULL, NULL, NULL, 1850, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <스티펠리오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a4c83a4-4f6b-41d7-8ad8-1ef134be1339'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a4c83a4-4f6b-41d7-8ad8-1ef134be1339'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <스티펠리오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a4c83a4-4f6b-41d7-8ad8-1ef134be1339'
);


-- None 오페라 <일 트로바토레>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <일 트로바토레>', 'Opera <Il trovatore>', 'song', NULL, NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <일 트로바토레>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74301cbd-06b5-4c36-a022-e91fe0ea2e88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74301cbd-06b5-4c36-a022-e91fe0ea2e88'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <일 트로바토레>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74301cbd-06b5-4c36-a022-e91fe0ea2e88'
);


-- None 오페라 <시칠리아인의 저녁 기도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <시칠리아인의 저녁 기도>', 'Opera <Les vêpres siciliennes>', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <시칠리아인의 저녁 기도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c09c5824-9102-4306-bd75-1328607c5ffd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c09c5824-9102-4306-bd75-1328607c5ffd'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <시칠리아인의 저녁 기도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c09c5824-9102-4306-bd75-1328607c5ffd'
);


-- None 오페라 <시몬 보카네그라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <시몬 보카네그라>', 'Opera <Simon Boccanegra>', 'song', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <시몬 보카네그라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dafacd6-50d3-4584-8bd3-676db44a9f99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2dafacd6-50d3-4584-8bd3-676db44a9f99'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <시몬 보카네그라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dafacd6-50d3-4584-8bd3-676db44a9f99'
);


-- None 오페라 <아롤도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아롤도>', 'Opera <Aroldo>', 'song', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아롤도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b544f549-8da2-4a58-a5a4-5849c2cdb9e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b544f549-8da2-4a58-a5a4-5849c2cdb9e1'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <아롤도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b544f549-8da2-4a58-a5a4-5849c2cdb9e1'
);


-- None 오페라 <가면무도회>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <가면무도회>', 'Opera <Un ballo in maschera>', 'song', NULL, NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <가면무도회>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f048a0f0-f6c0-4ba9-ba0b-54925f7663b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f048a0f0-f6c0-4ba9-ba0b-54925f7663b7'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <가면무도회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f048a0f0-f6c0-4ba9-ba0b-54925f7663b7'
);


-- None 오페라 <운명의 힘>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <운명의 힘>', 'Opera <La forza del destino>', 'song', NULL, NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <운명의 힘>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d9b73da-c368-3e80-93d1-26f8c3bd9e77'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d9b73da-c368-3e80-93d1-26f8c3bd9e77'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <운명의 힘>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d9b73da-c368-3e80-93d1-26f8c3bd9e77'
);


-- None 오페라 <돈 카를로스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <돈 카를로스>', 'Opera <Don Carlos>', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <돈 카를로스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4549bef1-de98-46ee-b5cb-86e3a2fbbd9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4549bef1-de98-46ee-b5cb-86e3a2fbbd9e'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <돈 카를로스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4549bef1-de98-46ee-b5cb-86e3a2fbbd9e'
);


-- None 오페라 <오텔로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오텔로>', 'Opera <Otello>', 'song', NULL, NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오텔로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b1f0523-969a-44eb-8ee5-001b0f30343b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b1f0523-969a-44eb-8ee5-001b0f30343b'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <오텔로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b1f0523-969a-44eb-8ee5-001b0f30343b'
);


-- None 오페라 <팔스타프>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <팔스타프>', 'Opera <Falstaff>', 'song', NULL, NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <팔스타프>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1bea26a-cdf4-42d4-a41c-9be972745775'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1bea26a-cdf4-42d4-a41c-9be972745775'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '오페라 <팔스타프>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1bea26a-cdf4-42d4-a41c-9be972745775'
);


-- None 6개의 로망스 (1838)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 (1838)', 'Sei romanze (1838)', 'album', NULL, NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 (1838)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eae0f11f-5646-4442-bece-c2dcf7f9ac46'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eae0f11f-5646-4442-bece-c2dcf7f9ac46'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1838)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eae0f11f-5646-4442-bece-c2dcf7f9ac46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e5ad345-98f0-4b08-b2bc-4879ebbcbeaa', 1, NULL, 'Non t''accostar all''urna', 'No. 1. Non t''accostar all''urna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1838)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e5ad345-98f0-4b08-b2bc-4879ebbcbeaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4706628c-925e-4788-b877-6806e59db2f6', 2, NULL, 'More, Elisa, lo stanco poeta', 'No. 2. More, Elisa, lo stanco poeta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1838)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4706628c-925e-4788-b877-6806e59db2f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a698814e-d68a-4177-bb4b-fd5294bdefb7', 3, NULL, 'In solitaria stanza', 'No. 3. In solitaria stanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1838)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a698814e-d68a-4177-bb4b-fd5294bdefb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58eaec29-41e1-4f8f-be59-51b58dd698ae', 4, NULL, 'Nell''orror di notte oscura', 'No. 4. Nell''orror di notte oscura', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1838)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58eaec29-41e1-4f8f-be59-51b58dd698ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e54a663a-4c0c-47fe-8c0a-4cc60034d6fe', 5, NULL, 'Perduta ho la pace', 'No. 5. Perduta ho la pace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1838)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e54a663a-4c0c-47fe-8c0a-4cc60034d6fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:debc15d9-4456-4f65-ad1a-40192833e0ec', 6, NULL, 'Deh, pietoso, oh Addolorata', 'No. 6. Deh, pietoso, oh Addolorata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1838)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:debc15d9-4456-4f65-ad1a-40192833e0ec'
);


-- None 가곡 <L'esule>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''esule>', 'L''esule', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''esule>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '482142d3-7100-4dd4-a128-fd5476459349'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '482142d3-7100-4dd4-a128-fd5476459349'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '가곡 <L''esule>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '482142d3-7100-4dd4-a128-fd5476459349'
);


-- None 가곡 <La seduzione>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La seduzione>', 'La seduzione', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La seduzione>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3d7d2af-0ae9-4e7c-80e4-591cb49b21f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b3d7d2af-0ae9-4e7c-80e4-591cb49b21f7'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '가곡 <La seduzione>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3d7d2af-0ae9-4e7c-80e4-591cb49b21f7'
);


-- None 녹턴 <Guarda che bianca luna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '녹턴 <Guarda che bianca luna>', 'Notturno "Guarda che bianca luna"', 'song', NULL, NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '녹턴 <Guarda che bianca luna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f57b889b-a2ef-4ecb-860b-5f209e1ab296'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f57b889b-a2ef-4ecb-860b-5f209e1ab296'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '녹턴 <Guarda che bianca luna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f57b889b-a2ef-4ecb-860b-5f209e1ab296'
);


-- None 6개의 로망스 (1845)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 (1845)', 'Album di sei romanze (1845)', 'album', NULL, NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 (1845)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79e3bf0d-37ff-46dd-b365-c36f0d799337'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79e3bf0d-37ff-46dd-b365-c36f0d799337'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1845)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79e3bf0d-37ff-46dd-b365-c36f0d799337'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d73c681-eb6a-453a-87fc-e1f348561532', 1, NULL, 'Il tramonto', 'No. 1. Il tramonto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1845)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d73c681-eb6a-453a-87fc-e1f348561532'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9668596c-8b49-44c4-aa71-3c0926001fba', 2, NULL, 'La zingara', 'No. 2. La zingara', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1845)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9668596c-8b49-44c4-aa71-3c0926001fba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f821bcb-c729-4375-93b2-72c2e886dbec', 3, NULL, 'Ad una stella', 'No. 3. Ad una stella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1845)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f821bcb-c729-4375-93b2-72c2e886dbec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1e090a8-c651-4bb2-8536-44a56bec160e', 4, NULL, 'Lo spazzacamino', 'No. 4. Lo spazzacamino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1845)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1e090a8-c651-4bb2-8536-44a56bec160e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42273bc3-143c-438d-b723-47744cae082c', 5, NULL, 'Il mistero', 'No. 5. Il mistero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1845)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42273bc3-143c-438d-b723-47744cae082c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ab5ca43-5a57-4001-a748-b0b43e4167fc', 6, NULL, 'Brindisi', 'No. 6. Brindisi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '6개의 로망스 (1845)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ab5ca43-5a57-4001-a748-b0b43e4167fc'
);


-- None 가곡 <Il poveretto>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Il poveretto>', 'Il poveretto', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Il poveretto>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ab0f8fe-89f2-44fc-8162-598ab79a09a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ab0f8fe-89f2-44fc-8162-598ab79a09a9'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '가곡 <Il poveretto>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ab0f8fe-89f2-44fc-8162-598ab79a09a9'
);


-- None 가곡 <L'abandonnée>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''abandonnée>', 'L''abandonnée', 'song', NULL, NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''abandonnée>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ab68249-ee74-47ba-8990-907ac6e0ca70'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ab68249-ee74-47ba-8990-907ac6e0ca70'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '가곡 <L''abandonnée>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ab68249-ee74-47ba-8990-907ac6e0ca70'
);


-- None 가곡 <Stornello>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Stornello>', 'Stornello', 'song', NULL, NULL, NULL, 1869, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Stornello>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4af8336-db60-4df4-a9c0-84e0fd086c0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4af8336-db60-4df4-a9c0-84e0fd086c0f'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '가곡 <Stornello>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4af8336-db60-4df4-a9c0-84e0fd086c0f'
);


-- None 가곡 <Pietà, Signor>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pietà, Signor>', 'Pietà, Signor', 'song', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pietà, Signor>'
);


-- None 파테르 노스테르

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파테르 노스테르', 'Pater noster', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파테르 노스테르'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '365506de-76ac-48f3-b838-d6d67934a052'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '365506de-76ac-48f3-b838-d6d67934a052'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '파테르 노스테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '365506de-76ac-48f3-b838-d6d67934a052'
);


-- None 레퀴엠

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee35601c-cc42-4165-b9d6-098cd4164d12', 1, 'I', '레퀴엠과 키리에', 'I. Requiem e Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee35601c-cc42-4165-b9d6-098cd4164d12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c', 2, 'II', '디에스 이레', 'II. Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ffe50aa-b471-4e33-be06-61fd3625a4e3', 1, NULL, 'Dies irae', 'Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ffe50aa-b471-4e33-be06-61fd3625a4e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d74ab43b-c1ea-48b1-851a-63652566505b', 2, NULL, 'Tuba mirum', 'Tuba mirum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d74ab43b-c1ea-48b1-851a-63652566505b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b229a9f7-b2b5-3d61-b483-143177594b91', 3, NULL, 'Mors stupebit', 'Mors stupebit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b229a9f7-b2b5-3d61-b483-143177594b91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c23be7c2-2cb6-4697-87e5-79e065b45540', 4, NULL, 'Liber scriptus', 'Liber scriptus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c23be7c2-2cb6-4697-87e5-79e065b45540'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25bf5d36-70da-415e-9b56-a392839ee1eb', 5, NULL, 'Quid sum miser', 'Quid sum miser', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25bf5d36-70da-415e-9b56-a392839ee1eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1903c6c-89fc-43fa-b0fc-57fb88a432fa', 6, NULL, 'Rex tremendae', 'Rex tremendae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1903c6c-89fc-43fa-b0fc-57fb88a432fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91957a85-f4ce-43c4-9ea5-03c6e32dcaf6', 7, NULL, 'Recordare', 'Recordare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91957a85-f4ce-43c4-9ea5-03c6e32dcaf6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0a7c4f6b-9a80-4806-86b3-09edcea57709', 8, NULL, 'Ingemisco', 'Ingemisco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a7c4f6b-9a80-4806-86b3-09edcea57709'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c54cfc9-3e29-49d1-af55-1aee63f605f6', 9, NULL, 'Confutatis', 'Confutatis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c54cfc9-3e29-49d1-af55-1aee63f605f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80571667-bbb7-4e28-84dd-5f4c5d603e59', 10, NULL, 'Lacrymosa', 'Lacrymosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:30d13bf9-9a61-39e4-8199-62f59b98d46c'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80571667-bbb7-4e28-84dd-5f4c5d603e59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:070884d7-349d-4ff3-94cd-5c9c23102c63', 3, 'III', '봉헌송', 'III. Offertorio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:070884d7-349d-4ff3-94cd-5c9c23102c63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e0cabf1-ce33-334b-9baf-92a79fec728e', 1, NULL, 'Domine Jesu Christe', 'Domine Jesu Christe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:070884d7-349d-4ff3-94cd-5c9c23102c63'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e0cabf1-ce33-334b-9baf-92a79fec728e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbcb2973-7175-3551-a444-a615b48a5259', 2, NULL, 'Hostias', 'Hostias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:070884d7-349d-4ff3-94cd-5c9c23102c63'
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbcb2973-7175-3551-a444-a615b48a5259'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a4bcbd4-8626-3e3f-be8b-cf0d193c696e', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a4bcbd4-8626-3e3f-be8b-cf0d193c696e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b2dbe07-80d0-3e4e-a014-12227e044731', 5, 'V', '아뉴스 데이', 'V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b2dbe07-80d0-3e4e-a014-12227e044731'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cb393b8-b374-34a3-864a-a0f9baa623f0', 6, 'VI', '룩스 에테르나', 'VI. Lux aeterna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cb393b8-b374-34a3-864a-a0f9baa623f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89dbb8f4-b109-450f-8751-acc57fc8abff', 7, 'VII', '리베라 메', 'VII. Libera me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 152 AND p.composer_id = 32
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89dbb8f4-b109-450f-8751-acc57fc8abff'
);


-- None 아베 마리아 (1880)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아베 마리아 (1880)', 'Ave Maria (1880)', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아베 마리아 (1880)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed75a796-aff5-32ad-b2c0-b40397323d88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed75a796-aff5-32ad-b2c0-b40397323d88'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '아베 마리아 (1880)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed75a796-aff5-32ad-b2c0-b40397323d88'
);


-- None 4개의 종교 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 종교 소품', 'Quattro pezzi sacri', 'album', NULL, NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 종교 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2019482-1a4c-4c51-bcc8-9e6946481515'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2019482-1a4c-4c51-bcc8-9e6946481515'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '4개의 종교 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2019482-1a4c-4c51-bcc8-9e6946481515'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16dcfd19-e429-478e-8fe2-2f46349f0952', 1, NULL, '아베 마리아', 'No. 1. Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '4개의 종교 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16dcfd19-e429-478e-8fe2-2f46349f0952'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58e4c955-5340-4580-8d05-905d08a73d38', 2, NULL, '스타바트 마테르', 'No. 2. Stabat Mater', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '4개의 종교 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58e4c955-5340-4580-8d05-905d08a73d38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de3b075a-bef4-4bd6-85f9-f86790c664a5', 3, NULL, 'Laudi alla Vergine Maria', 'No. 3. Laudi alla Vergine Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '4개의 종교 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3b075a-bef4-4bd6-85f9-f86790c664a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1249a835-dfde-4474-823b-ccbbe32ee334', 4, NULL, '테 데움', 'No. 4. Te Deum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '4개의 종교 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1249a835-dfde-4474-823b-ccbbe32ee334'
);


-- None 탄툼 에르고 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '탄툼 에르고 G장조', 'Tantum ergo in G major', 'song', NULL, NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '탄툼 에르고 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7fb8c41-3ad0-4730-93e8-9b0978244455'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7fb8c41-3ad0-4730-93e8-9b0978244455'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '탄툼 에르고 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7fb8c41-3ad0-4730-93e8-9b0978244455'
);


-- None 탄툼 에르고 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '탄툼 에르고 F장조', 'Tantum ergo in F major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '탄툼 에르고 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11f2fef1-6b29-4785-845e-79bfc64f4a4e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11f2fef1-6b29-4785-845e-79bfc64f4a4e'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '탄툼 에르고 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11f2fef1-6b29-4785-845e-79bfc64f4a4e'
);


-- None 미사 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 E♭장조', 'Messa in E♭ major', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88cd01d9-36ce-475f-9087-b23950a10ad5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88cd01d9-36ce-475f-9087-b23950a10ad5'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '미사 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88cd01d9-36ce-475f-9087-b23950a10ad5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe45dfe8-269b-46fb-9ab6-b99b5d1201bd', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '미사 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe45dfe8-269b-46fb-9ab6-b99b5d1201bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58b8a286-6eb0-423d-bd09-eedcc3ee2e3b', 2, 'II', '크리스테', 'II. Christe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '미사 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58b8a286-6eb0-423d-bd09-eedcc3ee2e3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b37c5f3-46e8-457d-928a-debfcf777ccc', 3, 'III', '키리에', 'III. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '미사 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b37c5f3-46e8-457d-928a-debfcf777ccc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:574ce36a-1a23-42bc-a7e5-ae16fa240154', 4, 'IV', '글로리아', 'IV. Gloria in excelsis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '미사 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:574ce36a-1a23-42bc-a7e5-ae16fa240154'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cba8dd2-5968-4b07-8dd0-4e2082a83fd7', 5, 'V', 'Qui tollis', 'V. Qui tollis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '미사 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cba8dd2-5968-4b07-8dd0-4e2082a83fd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bcdd597-a3cf-4de8-9e44-ad80f0f1a246', 6, 'VI', 'Cum Sancto Spiritu', 'VI. Cum Sancto Spiritu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '미사 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bcdd597-a3cf-4de8-9e44-ad80f0f1a246'
);


-- None 라우다테 푸에리 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '라우다테 푸에리 D장조', 'Laudate pueri in D major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '라우다테 푸에리 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6199a72e-a648-4a53-b06d-68896014ef48'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6199a72e-a648-4a53-b06d-68896014ef48'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '라우다테 푸에리 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6199a72e-a648-4a53-b06d-68896014ef48'
);


-- None 퀴 톨리스 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '퀴 톨리스 F장조', 'Qui tollis in F major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '퀴 톨리스 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8434c94-f318-4c21-bd2b-2f780daab8f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8434c94-f318-4c21-bd2b-2f780daab8f9'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '퀴 톨리스 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8434c94-f318-4c21-bd2b-2f780daab8f9'
);


-- None 찬가 <Suona la tromba>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <Suona la tromba>', 'Suona la tromba', 'song', NULL, NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <Suona la tromba>'
);


-- None 칸타타 <여러 나라의 찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <여러 나라의 찬가>', 'Inno delle nazioni (Hymn of the Nations)', 'song', NULL, NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <여러 나라의 찬가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4579a6bf-e9d1-4e86-94e5-f91fe6abc915'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4579a6bf-e9d1-4e86-94e5-f91fe6abc915'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '칸타타 <여러 나라의 찬가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4579a6bf-e9d1-4e86-94e5-f91fe6abc915'
);


-- None 말 없는 로망스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '말 없는 로망스', 'Romanza senza parole', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '말 없는 로망스'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f3c5731-b5fb-40bb-a225-92311f79c972'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f3c5731-b5fb-40bb-a225-92311f79c972'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '말 없는 로망스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f3c5731-b5fb-40bb-a225-92311f79c972'
);


-- None 왈츠 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 F장조', 'Waltz in F major', 'song', NULL, NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8437982b-1c9d-4661-a698-8d0cf2980b3a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8437982b-1c9d-4661-a698-8d0cf2980b3a'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '왈츠 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8437982b-1c9d-4661-a698-8d0cf2980b3a'
);


-- None 신포니아 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 B♭장조', 'Sinfonia in B♭ major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 B♭장조'
);


-- None 신포니아 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 C장조', 'Sinfonia in C major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4315a042-8599-401c-a208-a61780f54a78'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4315a042-8599-401c-a208-a61780f54a78'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '신포니아 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4315a042-8599-401c-a208-a61780f54a78'
);


-- None 신포니아 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 D장조', 'Sinfonia in D major', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 D장조'
);


-- None 현악 4중주 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 E단조', 'String Quartet in E minor', 'album', NULL, NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe020fe7-df93-426f-9c3d-8889a267a4fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe020fe7-df93-426f-9c3d-8889a267a4fb'
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '현악 4중주 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe020fe7-df93-426f-9c3d-8889a267a4fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389fdd46-9e63-4249-8e55-684ddf9f7861', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '현악 4중주 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389fdd46-9e63-4249-8e55-684ddf9f7861'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fe14214-cfaa-4073-9302-19219f52ef96', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '현악 4중주 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fe14214-cfaa-4073-9302-19219f52ef96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ed525f3-4893-4eb5-bc18-7d5991910979', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '현악 4중주 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ed525f3-4893-4eb5-bc18-7d5991910979'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:650baee0-8e3e-4ceb-9eb7-7712ccb579ef', 4, 'IV', '스케르초 푸가. Allegro assai mosso', 'IV. Scherzo Fuga. Allegro assai mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 32 AND p.title = '현악 4중주 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:650baee0-8e3e-4ceb-9eb7-7712ccb579ef'
);


-- None 바이올린과 피아노를 위한 <Stramberia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 <Stramberia>', 'Stramberia for violin and piano', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 32
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 <Stramberia>'
);

