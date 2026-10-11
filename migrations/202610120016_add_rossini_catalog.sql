-- 로시니 작품을 출판 단위로 채운다(카탈로그: EC(자료에만)). 작품 127개(묶음 18, 다악장 4, 낱곡 105),
-- 새 작품 126개, 기존 작품 1개, part 210개, 그 아래 35개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   오페라 39편(개작 <코린트의 포위>·<모세와 파라오> 포함)은 part 없이 둔다. <노년의 과오> 14권은 권마다 묶음.
--   대목 작품 168·169(서곡)는 그대로 두고 오페라는 따로 넣는다.
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

-- None 오페라 <데메트리오와 폴리비오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <데메트리오와 폴리비오>', 'Opera <Demetrio e Polibio>', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <데메트리오와 폴리비오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '821e5ae0-1375-4df4-8696-f504dc635cf5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '821e5ae0-1375-4df4-8696-f504dc635cf5'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <데메트리오와 폴리비오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '821e5ae0-1375-4df4-8696-f504dc635cf5'
);


-- None 오페라 <결혼 어음>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <결혼 어음>', 'Opera <La cambiale di matrimonio>', 'song', NULL, NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <결혼 어음>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ba2e434-ee48-44bb-8058-0ed80565cd98'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ba2e434-ee48-44bb-8058-0ed80565cd98'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <결혼 어음>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ba2e434-ee48-44bb-8058-0ed80565cd98'
);


-- None 오페라 <터무니없는 오해>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <터무니없는 오해>', 'Opera <L''equivoco stravagante>', 'song', NULL, NULL, NULL, 1811, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <터무니없는 오해>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6dc97c62-f8ad-4f25-b116-2844222313dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6dc97c62-f8ad-4f25-b116-2844222313dc'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <터무니없는 오해>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6dc97c62-f8ad-4f25-b116-2844222313dc'
);


-- None 오페라 <행복한 착각>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <행복한 착각>', 'Opera <L''inganno felice>', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <행복한 착각>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d0a11e8-589b-4cc4-b33c-2872fa7c73cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3d0a11e8-589b-4cc4-b33c-2872fa7c73cf'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <행복한 착각>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d0a11e8-589b-4cc4-b33c-2872fa7c73cf'
);


-- None 오페라 <바빌로니아의 키로스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <바빌로니아의 키로스>', 'Opera <Ciro in Babilonia>', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <바빌로니아의 키로스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1f40d35-1a57-4e4c-b941-0b0a318e6255'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1f40d35-1a57-4e4c-b941-0b0a318e6255'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <바빌로니아의 키로스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1f40d35-1a57-4e4c-b941-0b0a318e6255'
);


-- None 오페라 <비단 사다리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <비단 사다리>', 'Opera <La scala di seta>', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <비단 사다리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32d80f02-aea3-42a7-9581-02d1bd415722'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32d80f02-aea3-42a7-9581-02d1bd415722'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <비단 사다리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32d80f02-aea3-42a7-9581-02d1bd415722'
);


-- None 오페라 <시금석>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <시금석>', 'Opera <La pietra del paragone>', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <시금석>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f10a9bb5-30f0-4c74-a17d-1db394e8de63'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f10a9bb5-30f0-4c74-a17d-1db394e8de63'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <시금석>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f10a9bb5-30f0-4c74-a17d-1db394e8de63'
);


-- None 오페라 <도둑의 기회>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <도둑의 기회>', 'Opera <L''occasione fa il ladro>', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <도둑의 기회>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ccac32a-65a4-4b67-8025-65440da26355'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9ccac32a-65a4-4b67-8025-65440da26355'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <도둑의 기회>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9ccac32a-65a4-4b67-8025-65440da26355'
);


-- None 오페라 <브루스키노 씨>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <브루스키노 씨>', 'Opera <Il signor Bruschino>', 'song', NULL, NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <브루스키노 씨>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77887635-b7d3-4bfe-8de8-5a27f1af0904'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '77887635-b7d3-4bfe-8de8-5a27f1af0904'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <브루스키노 씨>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '77887635-b7d3-4bfe-8de8-5a27f1af0904'
);


-- None 오페라 <탄크레디>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <탄크레디>', 'Opera <Tancredi>', 'song', NULL, NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <탄크레디>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e174d4e0-39c9-4917-bd20-9a80b147190a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e174d4e0-39c9-4917-bd20-9a80b147190a'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <탄크레디>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e174d4e0-39c9-4917-bd20-9a80b147190a'
);


-- None 오페라 <알제리의 이탈리아 여인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <알제리의 이탈리아 여인>', 'Opera <L''italiana in Algeri>', 'song', NULL, NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <알제리의 이탈리아 여인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3eb0c94b-aafb-3721-8c83-f3c8e23217a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3eb0c94b-aafb-3721-8c83-f3c8e23217a6'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <알제리의 이탈리아 여인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3eb0c94b-aafb-3721-8c83-f3c8e23217a6'
);


-- None 오페라 <팔미라의 아우렐리아노>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <팔미라의 아우렐리아노>', 'Opera <Aureliano in Palmira>', 'song', NULL, NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <팔미라의 아우렐리아노>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c7f6e0c-092a-4757-93bf-a7a5b7bb42c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c7f6e0c-092a-4757-93bf-a7a5b7bb42c2'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <팔미라의 아우렐리아노>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c7f6e0c-092a-4757-93bf-a7a5b7bb42c2'
);


-- None 오페라 <이탈리아의 터키인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <이탈리아의 터키인>', 'Opera <Il turco in Italia>', 'song', NULL, NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <이탈리아의 터키인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ffc5ad2-b77c-4e15-a6d3-8ae5ef134f1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ffc5ad2-b77c-4e15-a6d3-8ae5ef134f1f'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <이탈리아의 터키인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ffc5ad2-b77c-4e15-a6d3-8ae5ef134f1f'
);


-- None 오페라 <시기스몬도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <시기스몬도>', 'Opera <Sigismondo>', 'song', NULL, NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <시기스몬도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8dba7736-f8a3-42e9-bcae-cb47635fea01'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8dba7736-f8a3-42e9-bcae-cb47635fea01'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <시기스몬도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8dba7736-f8a3-42e9-bcae-cb47635fea01'
);


-- None 오페라 <잉글랜드 여왕 엘리자베타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <잉글랜드 여왕 엘리자베타>', 'Opera <Elisabetta, regina d''Inghilterra>', 'song', NULL, NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <잉글랜드 여왕 엘리자베타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7228a43a-3267-4043-a6d7-81261d122e23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7228a43a-3267-4043-a6d7-81261d122e23'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <잉글랜드 여왕 엘리자베타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7228a43a-3267-4043-a6d7-81261d122e23'
);


-- None 오페라 <토르발도와 도를리스카>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <토르발도와 도를리스카>', 'Opera <Torvaldo e Dorliska>', 'song', NULL, NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <토르발도와 도를리스카>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b49cf467-e4ab-4074-9e22-89d030d0c9d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b49cf467-e4ab-4074-9e22-89d030d0c9d7'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <토르발도와 도를리스카>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b49cf467-e4ab-4074-9e22-89d030d0c9d7'
);


-- None 오페라 <신문>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <신문>', 'Opera <La gazzetta>', 'song', NULL, NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <신문>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14f77252-f95f-48f1-a8ad-5be19fef2c93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14f77252-f95f-48f1-a8ad-5be19fef2c93'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <신문>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14f77252-f95f-48f1-a8ad-5be19fef2c93'
);


-- None 오페라 <오텔로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오텔로>', 'Opera <Otello>', 'song', NULL, NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오텔로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e556b548-6525-42c1-a837-ad5ca1cb2e7b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e556b548-6525-42c1-a837-ad5ca1cb2e7b'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <오텔로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e556b548-6525-42c1-a837-ad5ca1cb2e7b'
);


-- None 오페라 <라 체네렌톨라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <라 체네렌톨라>', 'Opera <La Cenerentola>', 'song', NULL, NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <라 체네렌톨라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ca5f83a-b198-3f3c-86bd-2c93437abe01'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ca5f83a-b198-3f3c-86bd-2c93437abe01'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <라 체네렌톨라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ca5f83a-b198-3f3c-86bd-2c93437abe01'
);


-- None 오페라 <도둑 까치>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <도둑 까치>', 'Opera <La gazza ladra>', 'song', NULL, NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <도둑 까치>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '676bdcd4-d732-3123-96c6-088d6c95251b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '676bdcd4-d732-3123-96c6-088d6c95251b'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <도둑 까치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '676bdcd4-d732-3123-96c6-088d6c95251b'
);


-- None 오페라 <아르미다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아르미다>', 'Opera <Armida>', 'song', NULL, NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아르미다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '569beb65-2504-4888-a659-f470428aa8a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '569beb65-2504-4888-a659-f470428aa8a0'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <아르미다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '569beb65-2504-4888-a659-f470428aa8a0'
);


-- None 오페라 <부르고뉴의 아델라이데>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <부르고뉴의 아델라이데>', 'Opera <Adelaide di Borgogna>', 'song', NULL, NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <부르고뉴의 아델라이데>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8df7cfd5-5bda-4a09-9205-75ac2924c8ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8df7cfd5-5bda-4a09-9205-75ac2924c8ba'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <부르고뉴의 아델라이데>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8df7cfd5-5bda-4a09-9205-75ac2924c8ba'
);


-- None 오페라 <이집트의 모세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <이집트의 모세>', 'Opera <Mosè in Egitto>', 'song', NULL, NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <이집트의 모세>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '665f7ff3-f9ab-4737-9628-394d237f1f99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '665f7ff3-f9ab-4737-9628-394d237f1f99'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <이집트의 모세>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '665f7ff3-f9ab-4737-9628-394d237f1f99'
);


-- None 오페라 <아디나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아디나>', 'Opera <Adina>', 'song', NULL, NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아디나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '157953e1-ad6e-4b9b-9196-d8323dc48caf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '157953e1-ad6e-4b9b-9196-d8323dc48caf'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <아디나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '157953e1-ad6e-4b9b-9196-d8323dc48caf'
);


-- None 오페라 <리치아르도와 조라이데>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <리치아르도와 조라이데>', 'Opera <Ricciardo e Zoraide>', 'song', NULL, NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <리치아르도와 조라이데>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05f19a82-79d8-4d09-b5ff-c3a828305304'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05f19a82-79d8-4d09-b5ff-c3a828305304'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <리치아르도와 조라이데>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05f19a82-79d8-4d09-b5ff-c3a828305304'
);


-- None 오페라 <에르미오네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <에르미오네>', 'Opera <Ermione>', 'song', NULL, NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <에르미오네>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '493589e2-1919-478d-8b90-c07eef146799'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '493589e2-1919-478d-8b90-c07eef146799'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <에르미오네>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '493589e2-1919-478d-8b90-c07eef146799'
);


-- None 오페라 <에두아르도와 크리스티나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <에두아르도와 크리스티나>', 'Opera <Eduardo e Cristina>', 'song', NULL, NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <에두아르도와 크리스티나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df4edfdd-c1c4-472d-ac3d-d153a9ce46d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df4edfdd-c1c4-472d-ac3d-d153a9ce46d6'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <에두아르도와 크리스티나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df4edfdd-c1c4-472d-ac3d-d153a9ce46d6'
);


-- None 오페라 <호수의 여인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <호수의 여인>', 'Opera <La donna del lago>', 'song', NULL, NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <호수의 여인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6526fc48-c423-46dd-808f-85bbef005aa5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6526fc48-c423-46dd-808f-85bbef005aa5'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <호수의 여인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6526fc48-c423-46dd-808f-85bbef005aa5'
);


-- None 오페라 <비앙카와 팔리에로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <비앙카와 팔리에로>', 'Opera <Bianca e Falliero>', 'song', NULL, NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <비앙카와 팔리에로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6b9ef1a-c814-4346-9c46-d6deaed6dd9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6b9ef1a-c814-4346-9c46-d6deaed6dd9e'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <비앙카와 팔리에로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6b9ef1a-c814-4346-9c46-d6deaed6dd9e'
);


-- None 오페라 <마호메트 2세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <마호메트 2세>', 'Opera <Maometto II>', 'song', NULL, NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <마호메트 2세>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8ed8627-ad7e-4712-a9f8-24bda9fed995'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8ed8627-ad7e-4712-a9f8-24bda9fed995'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <마호메트 2세>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8ed8627-ad7e-4712-a9f8-24bda9fed995'
);


-- None 오페라 <샤브란의 마틸데>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <샤브란의 마틸데>', 'Opera <Matilde di Shabran>', 'song', NULL, NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <샤브란의 마틸데>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5778e2f7-ed41-4073-90a9-47e659a01f13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5778e2f7-ed41-4073-90a9-47e659a01f13'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <샤브란의 마틸데>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5778e2f7-ed41-4073-90a9-47e659a01f13'
);


-- None 오페라 <젤미라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <젤미라>', 'Opera <Zelmira>', 'song', NULL, NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <젤미라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7f9895a-11b6-4006-9672-363c9f3a8498'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7f9895a-11b6-4006-9672-363c9f3a8498'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <젤미라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7f9895a-11b6-4006-9672-363c9f3a8498'
);


-- None 오페라 <세미라미데>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <세미라미데>', 'Opera <Semiramide>', 'song', NULL, NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <세미라미데>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2598d21a-350c-3b8a-ba66-1d2aca6e71a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2598d21a-350c-3b8a-ba66-1d2aca6e71a9'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <세미라미데>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2598d21a-350c-3b8a-ba66-1d2aca6e71a9'
);


-- None 오페라 <랭스 여행>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <랭스 여행>', 'Opera <Il viaggio a Reims>', 'song', NULL, NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <랭스 여행>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8582ecad-919f-4e92-8554-426717b67c5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8582ecad-919f-4e92-8554-426717b67c5f'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <랭스 여행>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8582ecad-919f-4e92-8554-426717b67c5f'
);


-- None 오페라 <코린트의 포위>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <코린트의 포위>', 'Opera <Le siège de Corinthe>', 'song', NULL, NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <코린트의 포위>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f0b3716-3dda-4812-825b-9acf7c2434a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f0b3716-3dda-4812-825b-9acf7c2434a3'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <코린트의 포위>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f0b3716-3dda-4812-825b-9acf7c2434a3'
);


-- None 오페라 <모세와 파라오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <모세와 파라오>', 'Opera <Moïse et Pharaon>', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <모세와 파라오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0f65ce1-a18e-47e4-99fe-331446ad9b04'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0f65ce1-a18e-47e4-99fe-331446ad9b04'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <모세와 파라오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0f65ce1-a18e-47e4-99fe-331446ad9b04'
);


-- None 오페라 <오리 백작>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <오리 백작>', 'Opera <Le comte Ory>', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <오리 백작>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19be4b58-84d1-468d-9972-fbf4b759b448'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19be4b58-84d1-468d-9972-fbf4b759b448'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <오리 백작>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19be4b58-84d1-468d-9972-fbf4b759b448'
);


-- None 오페라 <윌리엄 텔>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <윌리엄 텔>', 'Opera <Guillaume Tell>', 'song', NULL, NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <윌리엄 텔>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ce190e3-3a91-4341-9fbb-201281357935'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ce190e3-3a91-4341-9fbb-201281357935'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오페라 <윌리엄 텔>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ce190e3-3a91-4341-9fbb-201281357935'
);


-- None 부수음악 <콜로노스의 오이디푸스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <콜로노스의 오이디푸스>', 'Edipo a Colono', 'song', NULL, NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <콜로노스의 오이디푸스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3fb360a-ee98-4bac-bddc-7e7ad5c4f850'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3fb360a-ee98-4bac-bddc-7e7ad5c4f850'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '부수음악 <콜로노스의 오이디푸스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3fb360a-ee98-4bac-bddc-7e7ad5c4f850'
);


-- None 칸타타 <Il pianto d'armonia sulla morte di Orfeo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Il pianto d''armonia sulla morte di Orfeo>', 'Il pianto d''armonia sulla morte di Orfeo', 'song', NULL, NULL, NULL, 1808, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Il pianto d''armonia sulla morte di Orfeo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efafd4cc-e372-488c-9c96-14a985b5f0ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'efafd4cc-e372-488c-9c96-14a985b5f0ec'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '칸타타 <Il pianto d''armonia sulla morte di Orfeo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'efafd4cc-e372-488c-9c96-14a985b5f0ec'
);


-- None 칸타타 <La morte di Didone>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <La morte di Didone>', 'La morte di Didone', 'song', NULL, NULL, NULL, 1811, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <La morte di Didone>'
);


-- None 칸타타 <Dalle quete e pallid'ombre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Dalle quete e pallid''ombre>', 'Dalle quete e pallid''ombre', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Dalle quete e pallid''ombre>'
);


-- None 칸타타 <Egle ed Irene>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Egle ed Irene>', 'Egle ed Irene', 'song', NULL, NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Egle ed Irene>'
);


-- None 칸타타 <L'aurora>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <L''aurora>', 'L''aurora', 'song', NULL, NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <L''aurora>'
);


-- None 칸타타 <Le nozze di Teti e di Peleo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Le nozze di Teti e di Peleo>', 'Le nozze di Teti e di Peleo', 'song', NULL, NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Le nozze di Teti e di Peleo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06f005c4-187d-434a-9ee1-b4d4c55cc89d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06f005c4-187d-434a-9ee1-b4d4c55cc89d'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '칸타타 <Le nozze di Teti e di Peleo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06f005c4-187d-434a-9ee1-b4d4c55cc89d'
);


-- None 칸타타 <Omaggio umiliato>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Omaggio umiliato>', 'Omaggio umiliato', 'song', NULL, NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Omaggio umiliato>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3f8e532-c75c-4e81-bad4-168601b1ac59'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3f8e532-c75c-4e81-bad4-168601b1ac59'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '칸타타 <Omaggio umiliato>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3f8e532-c75c-4e81-bad4-168601b1ac59'
);


-- None 칸타타 <1819년 5월 9일>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <1819년 5월 9일>', 'Cantata... 9 maggio 1819', 'song', NULL, NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <1819년 5월 9일>'
);


-- None 칸타타 <La riconoscenza>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <La riconoscenza>', 'La riconoscenza (Argene e Melania)', 'song', NULL, NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <La riconoscenza>'
);


-- None 칸타타 <Giunone>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Giunone>', 'Giunone', 'song', NULL, NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Giunone>'
);


-- None 칸타타 <Il vero omaggio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Il vero omaggio>', 'Il vero omaggio', 'song', NULL, NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Il vero omaggio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bc24e54-23b8-4631-a84d-2c39deb71ee3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bc24e54-23b8-4631-a84d-2c39deb71ee3'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '칸타타 <Il vero omaggio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bc24e54-23b8-4631-a84d-2c39deb71ee3'
);


-- None 칸타타 <Omaggio pastorale>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Omaggio pastorale>', 'Omaggio pastorale', 'song', NULL, NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Omaggio pastorale>'
);


-- None 칸타타 <Il pianto delle muse in morte di Lord Byron>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Il pianto delle muse in morte di Lord Byron>', 'Il pianto delle muse in morte di Lord Byron', 'song', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Il pianto delle muse in morte di Lord Byron>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e385fd3-c029-4a45-8758-f2eec8fcfa37'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7e385fd3-c029-4a45-8758-f2eec8fcfa37'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '칸타타 <Il pianto delle muse in morte di Lord Byron>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e385fd3-c029-4a45-8758-f2eec8fcfa37'
);


-- None 아구아도 아들 세례 칸타타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아구아도 아들 세례 칸타타', 'Cantata per il battesimo del figlio del banchiere Aguado', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아구아도 아들 세례 칸타타'
);


-- None 칸타타 <L'armonica cetra del nume>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <L''armonica cetra del nume>', 'L''armonica cetra del nume', 'song', NULL, NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <L''armonica cetra del nume>'
);


-- None 교황 비오 9세를 기리는 칸타타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교황 비오 9세를 기리는 칸타타', 'Cantata in onore del sommo pontefice Pio IX', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교황 비오 9세를 기리는 칸타타'
);


-- None 6개의 현악 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 현악 소나타', '6 Sonate a quattro (String Sonatas)', 'album', NULL, NULL, NULL, 1804, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 현악 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '299afd59-cc75-45cb-958f-a553cbe0982f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '299afd59-cc75-45cb-958f-a553cbe0982f'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '299afd59-cc75-45cb-958f-a553cbe0982f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea8e9fc8-03cf-4fa7-86b8-01ce2d95a291', 1, NULL, '현악 소나타 1번 G장조', 'Sonata No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea8e9fc8-03cf-4fa7-86b8-01ce2d95a291'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1fd85e8-e267-3bf6-b623-46e17fbc2a84', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea8e9fc8-03cf-4fa7-86b8-01ce2d95a291'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1fd85e8-e267-3bf6-b623-46e17fbc2a84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32ad08fc-9c41-3684-b14e-09a10fb7110a', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea8e9fc8-03cf-4fa7-86b8-01ce2d95a291'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32ad08fc-9c41-3684-b14e-09a10fb7110a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8237007-f694-3bd0-809d-b14c0784e099', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea8e9fc8-03cf-4fa7-86b8-01ce2d95a291'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8237007-f694-3bd0-809d-b14c0784e099'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49cbbcc6-7a31-4c4a-8ac4-2edf0a16f68e', 2, NULL, '현악 소나타 2번 A장조', 'Sonata No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49cbbcc6-7a31-4c4a-8ac4-2edf0a16f68e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:15c705df-2f52-3501-b18e-389456d34f9c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cbbcc6-7a31-4c4a-8ac4-2edf0a16f68e'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15c705df-2f52-3501-b18e-389456d34f9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fa49631-2b37-3758-b3e7-f9e406f24f0f', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cbbcc6-7a31-4c4a-8ac4-2edf0a16f68e'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fa49631-2b37-3758-b3e7-f9e406f24f0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f260e037-68f6-3e48-9b4a-afe24dcc04b1', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:49cbbcc6-7a31-4c4a-8ac4-2edf0a16f68e'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f260e037-68f6-3e48-9b4a-afe24dcc04b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00e1fbb5-0a34-4e9f-bfd1-482711660163', 3, NULL, '현악 소나타 3번 C장조', 'Sonata No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00e1fbb5-0a34-4e9f-bfd1-482711660163'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48d1ba38-d0db-33d6-b4ec-85dcb1bd70d2', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00e1fbb5-0a34-4e9f-bfd1-482711660163'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48d1ba38-d0db-33d6-b4ec-85dcb1bd70d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c8f0fa7-f92c-3bdc-b636-d0cd5a73e5b5', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00e1fbb5-0a34-4e9f-bfd1-482711660163'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c8f0fa7-f92c-3bdc-b636-d0cd5a73e5b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:404b24ea-b9fa-3d73-a589-7c1b8d683b2c', 3, 'III', 'Moderato', 'III. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00e1fbb5-0a34-4e9f-bfd1-482711660163'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:404b24ea-b9fa-3d73-a589-7c1b8d683b2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:063e4c84-e7df-43ae-9286-a7c216ebf033', 4, NULL, '현악 소나타 4번 B♭장조', 'Sonata No. 4 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:063e4c84-e7df-43ae-9286-a7c216ebf033'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54b30bbc-62b2-323a-9104-aa3b06e34784', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:063e4c84-e7df-43ae-9286-a7c216ebf033'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54b30bbc-62b2-323a-9104-aa3b06e34784'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85673937-553e-3cf5-81ca-89fdc4808d0c', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:063e4c84-e7df-43ae-9286-a7c216ebf033'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85673937-553e-3cf5-81ca-89fdc4808d0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aab09922-1cae-35fe-b9d9-f8a0658d3d09', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:063e4c84-e7df-43ae-9286-a7c216ebf033'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aab09922-1cae-35fe-b9d9-f8a0658d3d09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81b44b18-5f89-41d7-8782-73d86e0ac24d', 5, NULL, '현악 소나타 5번 E♭장조', 'Sonata No. 5 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81b44b18-5f89-41d7-8782-73d86e0ac24d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a47b372a-f19d-3a7c-a0c1-a69ec746c62d', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81b44b18-5f89-41d7-8782-73d86e0ac24d'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a47b372a-f19d-3a7c-a0c1-a69ec746c62d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e2b41ed4-4aa9-3cec-a1b8-a8a290306871', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81b44b18-5f89-41d7-8782-73d86e0ac24d'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2b41ed4-4aa9-3cec-a1b8-a8a290306871'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bee5c60-6011-328a-9b71-81e29c92f9b5', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:81b44b18-5f89-41d7-8782-73d86e0ac24d'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bee5c60-6011-328a-9b71-81e29c92f9b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb5aaa31-dc5d-42f1-a982-e4846df7e1ef', 6, NULL, '현악 소나타 6번 D장조', 'Sonata No. 6 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb5aaa31-dc5d-42f1-a982-e4846df7e1ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46478f0b-bf21-360c-a146-33fe3183d253', 1, 'I', 'Allegro spiritoso', 'I. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb5aaa31-dc5d-42f1-a982-e4846df7e1ef'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46478f0b-bf21-360c-a146-33fe3183d253'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c693d4b-7f8a-31ce-b60b-db8d3c486a73', 2, 'II', 'Andante assai', 'II. Andante assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb5aaa31-dc5d-42f1-a982-e4846df7e1ef'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c693d4b-7f8a-31ce-b60b-db8d3c486a73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b4e62bd-4e43-39d8-bc92-3a9ce95d1919', 3, 'III', 'Allegro "폭풍"', 'III. Allegro "Tempesta"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb5aaa31-dc5d-42f1-a982-e4846df7e1ef'
WHERE p.composer_id = 36 AND p.title = '6개의 현악 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b4e62bd-4e43-39d8-bc92-3a9ce95d1919'
);


-- None 신포니아 D장조 "알 콘벤텔로"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 D장조 "알 콘벤텔로"', 'Sinfonia "al Conventello" in D major', 'song', NULL, NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 D장조 "알 콘벤텔로"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '881d41dd-07b1-4594-bd69-87a0f79f0272'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '881d41dd-07b1-4594-bd69-87a0f79f0272'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '신포니아 D장조 "알 콘벤텔로"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '881d41dd-07b1-4594-bd69-87a0f79f0272'
);


-- None 2대의 호른을 위한 5개의 2중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2대의 호른을 위한 5개의 2중주', '5 Duets for two horns', 'song', NULL, NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2대의 호른을 위한 5개의 2중주'
);


-- None 신포니아 D장조 "볼로냐"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 D장조 "볼로냐"', 'Sinfonia "di Bologna" in D major', 'song', NULL, NULL, NULL, 1808, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 D장조 "볼로냐"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3667c004-fe0a-4a8b-9b44-5fb46ac51e8c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3667c004-fe0a-4a8b-9b44-5fb46ac51e8c'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '신포니아 D장조 "볼로냐"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3667c004-fe0a-4a8b-9b44-5fb46ac51e8c'
);


-- None 신포니아 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 E♭장조', 'Sinfonia in E♭ major', 'song', NULL, NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e45339c-7434-4553-9987-117a74d7b966'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e45339c-7434-4553-9987-117a74d7b966'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '신포니아 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e45339c-7434-4553-9987-117a74d7b966'
);


-- None 콘트라베이스 오블리가토 신포니아

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콘트라베이스 오블리가토 신포니아', 'Sinfonia "obbligata a contrabbasso"', 'song', NULL, NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콘트라베이스 오블리가토 신포니아'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f25a346-d7df-4c78-a8c8-12d66ec7c331'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f25a346-d7df-4c78-a8c8-12d66ec7c331'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '콘트라베이스 오블리가토 신포니아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f25a346-d7df-4c78-a8c8-12d66ec7c331'
);


-- None 클라리넷 변주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 변주곡 C장조', 'Variations for clarinet and orchestra in C major', 'song', NULL, NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 변주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc4745eb-b127-4d54-b602-c8a675144132'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc4745eb-b127-4d54-b602-c8a675144132'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '클라리넷 변주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc4745eb-b127-4d54-b602-c8a675144132'
);


-- None 관악 4중주를 위한 안단테와 주제와 변주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 4중주를 위한 안단테와 주제와 변주', 'Andante e tema con variazioni (1812)', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 4중주를 위한 안단테와 주제와 변주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0fc76b54-76a7-4870-9e2e-ad2628f6ef3b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0fc76b54-76a7-4870-9e2e-ad2628f6ef3b'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '관악 4중주를 위한 안단테와 주제와 변주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0fc76b54-76a7-4870-9e2e-ad2628f6ef3b'
);


-- None 클라리넷 서주, 주제와 변주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 서주, 주제와 변주 E♭장조', 'Introduction, Theme and Variations for clarinet and orchestra in E♭ major', 'song', NULL, NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 서주, 주제와 변주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71faa3b8-8519-4e78-9a31-79e211c0eece'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '71faa3b8-8519-4e78-9a31-79e211c0eece'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '클라리넷 서주, 주제와 변주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '71faa3b8-8519-4e78-9a31-79e211c0eece'
);


-- None 하프와 바이올린을 위한 안단테와 주제와 변주 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프와 바이올린을 위한 안단테와 주제와 변주 F장조', 'Andante e tema con variazioni for harp and violin in F major', 'song', NULL, NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프와 바이올린을 위한 안단테와 주제와 변주 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb109347-4a97-48a2-ae7a-559ebdb36c02'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb109347-4a97-48a2-ae7a-559ebdb36c02'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '하프와 바이올린을 위한 안단테와 주제와 변주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb109347-4a97-48a2-ae7a-559ebdb36c02'
);


-- None 행진곡 <Passo doppio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Passo doppio>', 'Passo doppio', 'song', NULL, NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Passo doppio>'
);


-- None 왈츠 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 E♭장조', 'Waltz in E♭ major', 'song', NULL, NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe625f8e-4094-4f8e-8c21-08793652a4a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe625f8e-4094-4f8e-8c21-08793652a4a8'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '왈츠 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe625f8e-4094-4f8e-8c21-08793652a4a8'
);


-- None 작은 합주를 위한 세레나타 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 합주를 위한 세레나타 E♭장조', 'Serenata per piccolo complesso in E♭ major', 'song', NULL, NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 합주를 위한 세레나타 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd18333fc-b3a3-450f-bd69-be41e2794d45'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd18333fc-b3a3-450f-bd69-be41e2794d45'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 합주를 위한 세레나타 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd18333fc-b3a3-450f-bd69-be41e2794d45'
);


-- None 첼로와 콘트라베이스를 위한 2중주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 콘트라베이스를 위한 2중주 D장조', 'Duetto for cello and double bass in D major', 'album', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 콘트라베이스를 위한 2중주 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8450fee5-eaaf-441c-9784-86555fb5deac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8450fee5-eaaf-441c-9784-86555fb5deac'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '첼로와 콘트라베이스를 위한 2중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8450fee5-eaaf-441c-9784-86555fb5deac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68a2c8c7-60d0-4662-b0df-e9282313c617', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '첼로와 콘트라베이스를 위한 2중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68a2c8c7-60d0-4662-b0df-e9282313c617'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:563dc97f-f2b3-4830-9680-f636396eb950', 2, 'II', 'Andante molto', 'II. Andante molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '첼로와 콘트라베이스를 위한 2중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:563dc97f-f2b3-4830-9680-f636396eb950'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15e6a95a-f2de-44d4-9a55-ea3edf1aef64', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '첼로와 콘트라베이스를 위한 2중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15e6a95a-f2de-44d4-9a55-ea3edf1aef64'
);


-- None 4대의 호른을 위한 <Le rendez-vous de chasse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4대의 호른을 위한 <Le rendez-vous de chasse>', 'Le rendez-vous de chasse', 'song', NULL, NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4대의 호른을 위한 <Le rendez-vous de chasse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cae62fa3-cf4d-4a88-978d-98a91079b7ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cae62fa3-cf4d-4a88-978d-98a91079b7ba'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '4대의 호른을 위한 <Le rendez-vous de chasse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cae62fa3-cf4d-4a88-978d-98a91079b7ba'
);


-- None 클라리넷과 피아노를 위한 환상곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷과 피아노를 위한 환상곡 E♭장조', 'Fantaisie for clarinet and piano in E♭ major', 'song', NULL, NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷과 피아노를 위한 환상곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c3964c0-d8e5-4aaa-9d22-2fd53c3855cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c3964c0-d8e5-4aaa-9d22-2fd53c3855cf'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '클라리넷과 피아노를 위한 환상곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c3964c0-d8e5-4aaa-9d22-2fd53c3855cf'
);


-- None 3개의 군대 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 군대 행진곡', 'Trois marches militaires', 'song', NULL, NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 군대 행진곡'
);


-- None 피아노를 위한 스케르초 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노를 위한 스케르초 A단조', 'Scherzo for piano in A minor', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노를 위한 스케르초 A단조'
);


-- None 술탄 압뒬메지트를 위한 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '술탄 압뒬메지트를 위한 행진곡', 'Marcia (pas redoublé) for Sultan Abdülmecid', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '술탄 압뒬메지트를 위한 행진곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e98158e-5177-4a34-9bbf-50ec445461ca'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e98158e-5177-4a34-9bbf-50ec445461ca'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '술탄 압뒬메지트를 위한 행진곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e98158e-5177-4a34-9bbf-50ec445461ca'
);


-- None 팡파르 <La corona d'Italia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '팡파르 <La corona d''Italia>', 'La corona d''Italia', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '팡파르 <La corona d''Italia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11074bb3-c306-4986-9d03-4daf22220c9f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11074bb3-c306-4986-9d03-4daf22220c9f'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '팡파르 <La corona d''Italia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11074bb3-c306-4986-9d03-4daf22220c9f'
);


-- None 쿠오니암

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쿠오니암', 'Quoniam', 'song', NULL, NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쿠오니암'
);


-- None 대영광 미사

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대영광 미사', 'Messa di Gloria', 'album', NULL, NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대영광 미사'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07048e12-598b-4943-a8c7-4b42263cd88f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07048e12-598b-4943-a8c7-4b42263cd88f'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07048e12-598b-4943-a8c7-4b42263cd88f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69511ad0-0576-46a6-a48a-2d19215bd49a', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69511ad0-0576-46a6-a48a-2d19215bd49a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9be18273-8fcd-4481-87c7-bac8e43ade82', 2, 'II', '글로리아', 'II. Gloria in excelsis Deo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9be18273-8fcd-4481-87c7-bac8e43ade82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:598fa7f8-73f3-4c94-8ec9-3bdfa1ef65c2', 3, 'III', 'Laudamus te', 'III. Laudamus te', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:598fa7f8-73f3-4c94-8ec9-3bdfa1ef65c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd8f9838-46c2-4b5b-8f2d-a7847d5cf774', 4, 'IV', 'Gratias agimus tibi', 'IV. Gratias agimus tibi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd8f9838-46c2-4b5b-8f2d-a7847d5cf774'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48dfb084-ad94-4ca2-92b5-4804371eb1ef', 5, 'V', 'Domine Deus', 'V. Domine Deus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48dfb084-ad94-4ca2-92b5-4804371eb1ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ab0ce39-bec9-4ab9-9d13-422a49051463', 6, 'VI', 'Qui tollis', 'VI. Qui tollis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ab0ce39-bec9-4ab9-9d13-422a49051463'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b68eaea7-88b6-4715-8785-87a1a72ca003', 7, 'VII', 'Quoniam tu solus sanctus', 'VII. Quoniam tu solus sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b68eaea7-88b6-4715-8785-87a1a72ca003'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a89e97b-9444-4386-9990-b631f6b562ea', 8, 'VIII', 'Cum Sancto Spiritu', 'VIII. Cum Sancto Spiritu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '대영광 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a89e97b-9444-4386-9990-b631f6b562ea'
);


-- None 기도 <Deh tu pietoso cielo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기도 <Deh tu pietoso cielo>', 'Preghiera "Deh tu pietoso cielo"', 'song', NULL, NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기도 <Deh tu pietoso cielo>'
);


-- None 탄툼 에르고 (1824)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '탄툼 에르고 (1824)', 'Tantum ergo (1824)', 'song', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '탄툼 에르고 (1824)'
);


-- None 스타바트 마테르

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스타바트 마테르', 'Stabat Mater', 'album', NULL, NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스타바트 마테르'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcbe6a0d-bdec-41ba-95ef-1639d05ae934'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dcbe6a0d-bdec-41ba-95ef-1639d05ae934'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dcbe6a0d-bdec-41ba-95ef-1639d05ae934'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6dd3e1b-1058-410f-b042-0d7ec425b691', 1, 'I', '도입. Stabat mater dolorosa', 'I. Introduzione. Stabat mater dolorosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6dd3e1b-1058-410f-b042-0d7ec425b691'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70c7eb9b-bb60-37e8-a794-69a6ce3e2b7d', 2, 'II', '아리아. Cujus animam gementem', 'II. Aria. Cujus animam gementem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70c7eb9b-bb60-37e8-a794-69a6ce3e2b7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d15c89d-61af-4c83-bd2a-6ce3660aafb6', 3, 'III', '2중창. Quis est homo', 'III. Duetto. Quis est homo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d15c89d-61af-4c83-bd2a-6ce3660aafb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04986d17-3f73-4d51-b3f2-44cda4d8d5b4', 4, 'IV', '아리아. Pro peccatis suae gentis', 'IV. Aria. Pro peccatis suae gentis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04986d17-3f73-4d51-b3f2-44cda4d8d5b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eac0db34-67c7-473a-a73a-a155bf8da590', 5, 'V', '합창과 레치타티보. Eja mater, fons amoris', 'V. Coro e recitativo. Eja mater, fons amoris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eac0db34-67c7-473a-a73a-a155bf8da590'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab6ad937-11d5-4808-b81e-08fbaa363809', 6, 'VI', '4중창. Sancta mater, istud agas', 'VI. Quartetto. Sancta mater, istud agas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab6ad937-11d5-4808-b81e-08fbaa363809'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94433a5a-7409-4a59-b8db-494f93ca0b86', 7, 'VII', '카바티나. Fac ut portem', 'VII. Cavatina. Fac ut portem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94433a5a-7409-4a59-b8db-494f93ca0b86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e1647fa-da5a-4db7-838c-20ad05044262', 8, 'VIII', '아리아와 합창. Inflammatus et accensus', 'VIII. Aria e coro. Inflammatus et accensus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e1647fa-da5a-4db7-838c-20ad05044262'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b4188a0-9009-43be-92cc-c2a6ba4e6b94', 9, 'IX', '4중창. Quando corpus morietur', 'IX. Quartetto. Quando corpus morietur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b4188a0-9009-43be-92cc-c2a6ba4e6b94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f018fc8-c80f-4ad2-9287-2477b4b753c7', 10, 'X', '피날레. In sempiterna saecula. Amen', 'X. Finale. In sempiterna saecula. Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '스타바트 마테르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f018fc8-c80f-4ad2-9287-2477b4b753c7'
);


-- None 3개의 종교 합창곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 종교 합창곡', 'Trois chœurs religieux', 'album', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 종교 합창곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a46bd8b1-dc29-4136-839c-55ea0c40d546'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a46bd8b1-dc29-4136-839c-55ea0c40d546'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '3개의 종교 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a46bd8b1-dc29-4136-839c-55ea0c40d546'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c2bc1f6-70b7-4313-84c2-5bbb41169b3f', 1, NULL, '믿음 (La foi)', 'No. 1. La foi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '3개의 종교 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c2bc1f6-70b7-4313-84c2-5bbb41169b3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe442091-9a64-4473-b29a-3acbb9bd701d', 2, NULL, '소망 (L''espérance)', 'No. 2. L''espérance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '3개의 종교 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe442091-9a64-4473-b29a-3acbb9bd701d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a76c3ef-869f-4431-bcec-988b49dbc4c9', 3, NULL, '사랑 (La charité)', 'No. 3. La charité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '3개의 종교 합창곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a76c3ef-869f-4431-bcec-988b49dbc4c9'
);


-- None 탄툼 에르고 (1847)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '탄툼 에르고 (1847)', 'Tantum ergo (1847)', 'song', NULL, NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '탄툼 에르고 (1847)'
);


-- None 오 살루타리스 호스티아 (1857)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오 살루타리스 호스티아 (1857)', 'O salutaris hostia (1857)', 'song', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오 살루타리스 호스티아 (1857)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '307b4f48-c2bf-4030-9558-7b8b9b1d1733'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '307b4f48-c2bf-4030-9558-7b8b9b1d1733'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '오 살루타리스 호스티아 (1857)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '307b4f48-c2bf-4030-9558-7b8b9b1d1733'
);


-- None 라우스 데오

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '라우스 데오', 'Laus Deo', 'song', NULL, NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '라우스 데오'
);


-- None 작은 장엄 미사

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 장엄 미사', 'Petite messe solennelle', 'album', NULL, NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 장엄 미사'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b68d30f-acbd-4fb9-8e01-67e44823c21c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b68d30f-acbd-4fb9-8e01-67e44823c21c'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b68d30f-acbd-4fb9-8e01-67e44823c21c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3564ef53-357c-3100-a05f-35038fb8584d', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3564ef53-357c-3100-a05f-35038fb8584d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rossini:rossini-petite-messe:2', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rossini:rossini-petite-messe:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f6307b4d-3be5-3bb8-b8cc-8f8e64fc28f3', 1, NULL, 'Gloria in excelsis Deo', 'Gloria in excelsis Deo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:2'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6307b4d-3be5-3bb8-b8cc-8f8e64fc28f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:92436f0f-d14a-35da-bab2-85dd05371845', 2, NULL, 'Gratias agimus tibi', 'Gratias agimus tibi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:2'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92436f0f-d14a-35da-bab2-85dd05371845'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2af99bc4-f525-32c3-a9e2-1ffad7401f22', 3, NULL, 'Domine Deus', 'Domine Deus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:2'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2af99bc4-f525-32c3-a9e2-1ffad7401f22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb9add8c-b8a7-3958-9b92-e0f838d16fc6', 4, NULL, 'Qui tollis', 'Qui tollis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:2'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb9add8c-b8a7-3958-9b92-e0f838d16fc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22f0bf51-e1a8-375a-a7a5-ab033a74cac7', 5, NULL, 'Quoniam tu solus sanctus', 'Quoniam tu solus sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:2'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22f0bf51-e1a8-375a-a7a5-ab033a74cac7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8371a5e9-1e9a-3ee3-af51-d2f487de70b2', 6, NULL, 'Cum Sancto Spiritu', 'Cum Sancto Spiritu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:2'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8371a5e9-1e9a-3ee3-af51-d2f487de70b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rossini:rossini-petite-messe:3', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rossini:rossini-petite-messe:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:033cfcc0-8e32-3c75-8f01-e40cf770479e', 1, NULL, 'Credo in unum Deum', 'Credo in unum Deum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:3'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:033cfcc0-8e32-3c75-8f01-e40cf770479e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d36f034c-a54c-362b-843b-6afdc9868b2f', 2, NULL, 'Crucifixus', 'Crucifixus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:3'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d36f034c-a54c-362b-843b-6afdc9868b2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a1c6179-e9bd-3e95-ac3c-8bd8d8a3f09d', 3, NULL, 'Et resurrexit', 'Et resurrexit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:rossini:rossini-petite-messe:3'
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a1c6179-e9bd-3e95-ac3c-8bd8d8a3f09d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:536e8ca6-2deb-3610-a62c-d382ebab8df8', 4, 'IV', '종교적 전주곡', 'IV. Preludio religioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:536e8ca6-2deb-3610-a62c-d382ebab8df8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58612c6f-6a9d-3912-aa22-9cc26a5efb3c', 5, 'V', '상투스', 'V. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58612c6f-6a9d-3912-aa22-9cc26a5efb3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a454f98-d2de-3a59-8ce7-1ad2583715d0', 6, 'VI', 'O salutaris hostia', 'VI. O salutaris hostia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a454f98-d2de-3a59-8ce7-1ad2583715d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3de406a7-70b2-3db6-b991-4f89d00122a9', 7, 'VII', '아뉴스 데이', 'VII. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '작은 장엄 미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3de406a7-70b2-3db6-b991-4f89d00122a9'
);


-- None 가곡 <Se il vuol la molinara>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Se il vuol la molinara>', 'Se il vuol la molinara', 'song', NULL, NULL, NULL, 1801, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Se il vuol la molinara>'
);


-- None 가곡 <Dolce aurette che spirate>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dolce aurette che spirate>', 'Dolce aurette che spirate', 'song', NULL, NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dolce aurette che spirate>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '322e0708-6eb0-4eb6-82d8-68c46c6af7b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '322e0708-6eb0-4eb6-82d8-68c46c6af7b7'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <Dolce aurette che spirate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '322e0708-6eb0-4eb6-82d8-68c46c6af7b7'
);


-- None 가곡 <La mia pace io già perdei>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La mia pace io già perdei>', 'La mia pace io già perdei', 'song', NULL, NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La mia pace io già perdei>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b018e74f-0ca7-488d-8034-898f466a5434'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b018e74f-0ca7-488d-8034-898f466a5434'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <La mia pace io già perdei>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b018e74f-0ca7-488d-8034-898f466a5434'
);


-- None 가곡 <Qual voce, quai note>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Qual voce, quai note>', 'Qual voce, quai note', 'song', NULL, NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Qual voce, quai note>'
);


-- None 가곡 <Alla voce della gloria>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Alla voce della gloria>', 'Alla voce della gloria', 'song', NULL, NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Alla voce della gloria>'
);


-- None 가곡 <Amore mi assisti>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Amore mi assisti>', 'Amore mi assisti', 'song', NULL, NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Amore mi assisti>'
);


-- None 가곡 <Il trovatore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Il trovatore>', 'Il trovatore "Chi m''ascolta il canto usato"', 'song', NULL, NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Il trovatore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6eea3ad1-1827-4a17-9af5-3409fe7d2372'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6eea3ad1-1827-4a17-9af5-3409fe7d2372'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <Il trovatore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6eea3ad1-1827-4a17-9af5-3409fe7d2372'
);


-- None 4중창 <Il carnevale di Venezia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4중창 <Il carnevale di Venezia>', 'Il carnevale di Venezia', 'song', NULL, NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4중창 <Il carnevale di Venezia>'
);


-- None 가곡 <Beltà crudele>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Beltà crudele>', 'Beltà crudele', 'song', NULL, NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Beltà crudele>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e04dec9-5628-4cc7-86cd-c289d47d98ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e04dec9-5628-4cc7-86cd-c289d47d98ee'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <Beltà crudele>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e04dec9-5628-4cc7-86cd-c289d47d98ee'
);


-- None 가곡 <La pastorella>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La pastorella>', 'La pastorella', 'song', NULL, NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La pastorella>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91653134-4756-4051-aedc-2a99422b732d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '91653134-4756-4051-aedc-2a99422b732d'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <La pastorella>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '91653134-4756-4051-aedc-2a99422b732d'
);


-- None 가곡 <Canzonetta spagnuola>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Canzonetta spagnuola>', 'Canzonetta spagnuola', 'song', NULL, NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Canzonetta spagnuola>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bec8306b-cb11-4485-8222-25ac8b610b46'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bec8306b-cb11-4485-8222-25ac8b610b46'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <Canzonetta spagnuola>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bec8306b-cb11-4485-8222-25ac8b610b46'
);


-- None 가곡 <Infelice ch'io son>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Infelice ch''io son>', 'Infelice ch''io son', 'song', NULL, NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Infelice ch''io son>'
);


-- None 가곡 <Addio ai viennesi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Addio ai viennesi>', 'Addio ai viennesi', 'song', NULL, NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Addio ai viennesi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8443ebbc-5a4c-4e64-90a1-a369cb58d955'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8443ebbc-5a4c-4e64-90a1-a369cb58d955'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <Addio ai viennesi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8443ebbc-5a4c-4e64-90a1-a369cb58d955'
);


-- None 가곡 <Dall'oriente l'astro del giorno>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Dall''oriente l''astro del giorno>', 'Dall''oriente l''astro del giorno', 'song', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Dall''oriente l''astro del giorno>'
);


-- None 가곡 <Ridiamo, cantiamo, che tutto sen va>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ridiamo, cantiamo, che tutto sen va>', 'Ridiamo, cantiamo, che tutto sen va', 'song', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ridiamo, cantiamo, che tutto sen va>'
);


-- None 가곡 <In giorno sì bello>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <In giorno sì bello>', 'In giorno sì bello', 'song', NULL, NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <In giorno sì bello>'
);


-- None 3개의 실내 4중창

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 실내 4중창', 'Tre quartetti da camera', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 실내 4중창'
);


-- None 가곡 <Les adieux à Rome>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Les adieux à Rome>', 'Les adieux à Rome', 'song', NULL, NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Les adieux à Rome>'
);


-- None 2중창 <Orage et beau temps>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Orage et beau temps>', 'Orage et beau temps', 'song', NULL, NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Orage et beau temps>'
);


-- None 가곡 <La passeggiata>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La passeggiata>', 'La passeggiata "Or che di fiori adorno"', 'song', NULL, NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La passeggiata>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '903fbe70-9219-4a3c-b838-87560fa89e22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '903fbe70-9219-4a3c-b838-87560fa89e22'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <La passeggiata>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '903fbe70-9219-4a3c-b838-87560fa89e22'
);


-- None 가곡 <La dichiarazione>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La dichiarazione>', 'La dichiarazione', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La dichiarazione>'
);


-- None 가곡집 <음악의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 <음악의 밤>', 'Les soirées musicales', 'album', NULL, NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 <음악의 밤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44f1723f-3e46-41a0-8860-695463387ac6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44f1723f-3e46-41a0-8860-695463387ac6'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44f1723f-3e46-41a0-8860-695463387ac6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2963691-c6e1-4693-8385-65fa65020c33', 1, NULL, 'La promessa', 'No. 1. La promessa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2963691-c6e1-4693-8385-65fa65020c33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1050585-fe97-4b3f-aed7-99cdf70fbf38', 2, NULL, 'Il rimprovero', 'No. 2. Il rimprovero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1050585-fe97-4b3f-aed7-99cdf70fbf38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4c12154-9085-487f-80b0-9ee4882a1afa', 3, NULL, 'La partenza', 'No. 3. La partenza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4c12154-9085-487f-80b0-9ee4882a1afa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c43254bc-2bcb-4ee0-96e4-7b649fe0dc07', 4, NULL, 'L''orgia', 'No. 4. L''orgia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c43254bc-2bcb-4ee0-96e4-7b649fe0dc07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96258e40-db32-468d-a69e-a9532b07bb13', 5, NULL, 'L''invito', 'No. 5. L''invito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96258e40-db32-468d-a69e-a9532b07bb13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f165877-da5a-4cd7-9892-a595d5a220a3', 6, NULL, 'La pastorella dell''Alpi', 'No. 6. La pastorella dell''Alpi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f165877-da5a-4cd7-9892-a595d5a220a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47f20ab7-e9c9-4d04-97a6-a76e13ddb106', 7, NULL, 'La gita in gondola', 'No. 7. La gita in gondola', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f20ab7-e9c9-4d04-97a6-a76e13ddb106'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:effef583-b89e-3916-86c1-0776b116b141', 8, NULL, 'La danza', 'No. 8. La danza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:effef583-b89e-3916-86c1-0776b116b141'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97f6ec22-ef69-4eec-82f9-a0f8896033f3', 9, NULL, 'La regata veneziana', 'No. 9. La regata veneziana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97f6ec22-ef69-4eec-82f9-a0f8896033f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ab88419-38f7-45d6-b0e8-25253988e996', 10, NULL, 'La pesca', 'No. 10. La pesca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ab88419-38f7-45d6-b0e8-25253988e996'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57da4e37-8aea-4e18-ac36-1f03c3af5469', 11, NULL, 'La serenata', 'No. 11. La serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57da4e37-8aea-4e18-ac36-1f03c3af5469'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db482d8e-528d-4863-aa58-e2f63290928c', 12, NULL, 'Li marinari', 'No. 12. Li marinari', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡집 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db482d8e-528d-4863-aa58-e2f63290928c'
);


-- None 2개의 녹턴

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 녹턴', 'Deux nocturnes', 'album', NULL, NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 녹턴'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rossini:rossini-deux-nocturnes:1', 1, NULL, 'Adieu à l''Italie', 'No. 1. Adieu à l''Italie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '2개의 녹턴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rossini:rossini-deux-nocturnes:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rossini:rossini-deux-nocturnes:2', 2, NULL, 'Le départ', 'No. 2. Le départ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '2개의 녹턴' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rossini:rossini-deux-nocturnes:2'
);


-- None 가곡 <Nizza>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Nizza>', 'Nizza', 'song', NULL, NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Nizza>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f91e130-54d2-42fb-92e0-7b88849363da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f91e130-54d2-42fb-92e0-7b88849363da'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <Nizza>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f91e130-54d2-42fb-92e0-7b88849363da'
);


-- None 가곡 <L'âme délaissée>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''âme délaissée>', 'L''âme délaissée', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''âme délaissée>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '952eb9af-05d1-4ad1-8038-a672ffa981dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '952eb9af-05d1-4ad1-8038-a672ffa981dd'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '가곡 <L''âme délaissée>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '952eb9af-05d1-4ad1-8038-a672ffa981dd'
);


-- None 가곡 <Francesca da Rimini>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Francesca da Rimini>', 'Francesca da Rimini', 'song', NULL, NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Francesca da Rimini>'
);


-- None 가곡 <Mi lagnerò tacendo> (1858)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mi lagnerò tacendo> (1858)', 'Mi lagnerò tacendo (1858)', 'song', NULL, NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mi lagnerò tacendo> (1858)'
);


-- None <노년의 과오> 1권 <이탈리아 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 1권 <이탈리아 앨범>', 'Péchés de vieillesse, Vol. 1 "Album italiano"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 1권 <이탈리아 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d466cd2-4ade-4a5e-846b-c25d95a52c39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d466cd2-4ade-4a5e-846b-c25d95a52c39'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d466cd2-4ade-4a5e-846b-c25d95a52c39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fd381af-6514-4712-b234-7e2bd3dcb397', 1, NULL, 'I gondolieri', 'No. 1. I gondolieri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fd381af-6514-4712-b234-7e2bd3dcb397'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38173910-b509-4a00-bef6-f630879a49c5', 2, NULL, 'La lontananza', 'No. 2. La lontananza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38173910-b509-4a00-bef6-f630879a49c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1270981-00c1-418a-af4a-1e7321a3f1df', 3, NULL, 'Tirana alla spagnola (rossinizzata)', 'No. 3. Tirana alla spagnola (rossinizzata)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1270981-00c1-418a-af4a-1e7321a3f1df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3873856f-e5fd-4cd3-9e12-4ebb6290b49c', 4, NULL, 'L''ultimo ricordo', 'No. 4. L''ultimo ricordo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3873856f-e5fd-4cd3-9e12-4ebb6290b49c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18ff03f0-cfe2-4c4b-b21c-262787156bf5', 5, NULL, 'La fioraja fiorentina', 'No. 5. La fioraja fiorentina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18ff03f0-cfe2-4c4b-b21c-262787156bf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6db4f241-cd63-40b7-b4ac-907bd6bfde26', 6, NULL, 'Le gittane', 'No. 6. Le gittane', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6db4f241-cd63-40b7-b4ac-907bd6bfde26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87abfc5a-32cd-4520-b225-e0e63d803430', 7, NULL, 'Ave Maria (su due note)', 'No. 7. Ave Maria (su due note)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87abfc5a-32cd-4520-b225-e0e63d803430'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a219948f-d873-4ed3-8e3f-2e9192aea61b', 8, NULL, 'La regata veneziana: Anzoleta avanti la regata', 'No. 8. La regata veneziana: Anzoleta avanti la regata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a219948f-d873-4ed3-8e3f-2e9192aea61b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad98c036-2762-48ef-bb2b-eb014033b927', 9, NULL, 'La regata veneziana: Anzoleta co passa la regata', 'No. 9. La regata veneziana: Anzoleta co passa la regata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad98c036-2762-48ef-bb2b-eb014033b927'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:389aba7c-dfa6-4c9b-9c33-0e425aadb37f', 10, NULL, 'La regata veneziana: Anzoleta dopo la regata', 'No. 10. La regata veneziana: Anzoleta dopo la regata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:389aba7c-dfa6-4c9b-9c33-0e425aadb37f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b590cce9-347c-457d-8886-75b1797b4d73', 11, NULL, 'Il fanciullo smarrito', 'No. 11. Il fanciullo smarrito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b590cce9-347c-457d-8886-75b1797b4d73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ade9e99-e2e0-4bfa-9353-c81545bcf197', 12, NULL, 'La passeggiata', 'No. 12. La passeggiata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 1권 <이탈리아 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ade9e99-e2e0-4bfa-9353-c81545bcf197'
);


-- None <노년의 과오> 2권 <프랑스 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 2권 <프랑스 앨범>', 'Péchés de vieillesse, Vol. 2 "Album français"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 2권 <프랑스 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b08ca638-dd85-414a-b534-9f53447e61c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b08ca638-dd85-414a-b534-9f53447e61c2'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b08ca638-dd85-414a-b534-9f53447e61c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eff53693-3d29-47fe-8da6-a7fc13fcfb04', 1, NULL, 'Toast pour le nouvel an', 'No. 1. Toast pour le nouvel an', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eff53693-3d29-47fe-8da6-a7fc13fcfb04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bec3f7d-121b-46c2-9350-82088e0217fc', 2, NULL, 'Roméo', 'No. 2. Roméo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bec3f7d-121b-46c2-9350-82088e0217fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f617389a-9f81-4803-b9b8-b5193bfcc517', 3, NULL, 'La grande coquette (Ariette Pompadour)', 'No. 3. La grande coquette (Ariette Pompadour)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f617389a-9f81-4803-b9b8-b5193bfcc517'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ade9517a-aa9d-4f92-8837-44e943e56412', 4, NULL, 'Un sou (Complainte à deux voix)', 'No. 4. Un sou (Complainte à deux voix)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ade9517a-aa9d-4f92-8837-44e943e56412'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f2771ef-5b67-4eb8-8aa6-72bdbb93dfdd', 5, NULL, 'Chanson de Zora (La petite bohémienne)', 'No. 5. Chanson de Zora (La petite bohémienne)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f2771ef-5b67-4eb8-8aa6-72bdbb93dfdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18eb6d2e-974c-48d8-bcb5-f90ccdfad87f', 6, NULL, 'La nuit de Noël', 'No. 6. La nuit de Noël', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18eb6d2e-974c-48d8-bcb5-f90ccdfad87f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9c16dd5-242d-49a4-a290-ea507418ee64', 7, NULL, 'Le dodo des enfants', 'No. 7. Le dodo des enfants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9c16dd5-242d-49a4-a290-ea507418ee64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cc8fa6a-8e7c-4ffb-9934-56e7e55bd29a', 8, NULL, 'Le lazzarone (Chansonnette de cabaret)', 'No. 8. Le lazzarone (Chansonnette de cabaret)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cc8fa6a-8e7c-4ffb-9934-56e7e55bd29a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feda2221-e5fe-40b8-8ffd-c70e2ea94295', 9, NULL, 'Adieux à la vie! (Élégie sur une seule note)', 'No. 9. Adieux à la vie! (Élégie sur une seule note)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feda2221-e5fe-40b8-8ffd-c70e2ea94295'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1db80ab6-fa47-4d0b-b6f6-0fb1bc532c21', 10, NULL, 'Soupirs et sourires (Nocturne)', 'No. 10. Soupirs et sourires (Nocturne)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1db80ab6-fa47-4d0b-b6f6-0fb1bc532c21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:050add86-c7ea-41c5-8524-62fe88421e38', 11, NULL, 'L''orpheline du Tyrol (Ballade élégie)', 'No. 11. L''orpheline du Tyrol (Ballade élégie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:050add86-c7ea-41c5-8524-62fe88421e38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f413e1ef-a83d-458a-8b56-ac3d2d015dc5', 12, NULL, 'Chœur de chasseurs démocrates', 'No. 12. Chœur de chasseurs démocrates', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 2권 <프랑스 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f413e1ef-a83d-458a-8b56-ac3d2d015dc5'
);


-- None <노년의 과오> 3권 <남겨 둔 곡들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 3권 <남겨 둔 곡들>', 'Péchés de vieillesse, Vol. 3 "Morceaux réservés"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 3권 <남겨 둔 곡들>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78ca96c8-956a-4949-85d8-0fafc603c34f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78ca96c8-956a-4949-85d8-0fafc603c34f'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78ca96c8-956a-4949-85d8-0fafc603c34f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fadbebe3-879c-4a93-a6de-e18ed184b5cf', 1, NULL, 'Quelques mesures de chant funèbre: à mon pauvre ami Meyerbeer', 'No. 1. Quelques mesures de chant funèbre: à mon pauvre ami Meyerbeer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fadbebe3-879c-4a93-a6de-e18ed184b5cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1369a104-63a4-46e6-a83b-db3181828941', 2, NULL, 'L''esule', 'No. 2. L''esule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1369a104-63a4-46e6-a83b-db3181828941'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4474666d-4d51-4f51-aed4-aaceb40666a6', 3, NULL, 'Les amants de Séville (Tirana)', 'No. 3. Les amants de Séville (Tirana)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4474666d-4d51-4f51-aed4-aaceb40666a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3db7b84a-cc81-4a54-ac3a-97eb2c006036', 4, NULL, 'Ave Maria', 'No. 4. Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3db7b84a-cc81-4a54-ac3a-97eb2c006036'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f61eb308-e1b7-42b4-add3-5180f30a257c', 5, NULL, 'L''amour à Pékin (Petite mélodie sur la gamme chinoise)', 'No. 5. L''amour à Pékin (Petite mélodie sur la gamme chinoise)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f61eb308-e1b7-42b4-add3-5180f30a257c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:095e0adf-5dd1-4141-9d91-99aa653967d0', 6, NULL, 'Le chant des Titans', 'No. 6. Le chant des Titans', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:095e0adf-5dd1-4141-9d91-99aa653967d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae5c48d1-36d8-4c3d-9f32-e6bb8c47218c', 7, NULL, 'Preghiera', 'No. 7. Preghiera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae5c48d1-36d8-4c3d-9f32-e6bb8c47218c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa3a2acd-4c7d-4390-8665-a7afc86167fa', 8, NULL, 'Au chevet d''un mourant (Élégie)', 'No. 8. Au chevet d''un mourant (Élégie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa3a2acd-4c7d-4390-8665-a7afc86167fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00505b30-a502-485f-bc03-91a5a5e65c03', 9, NULL, 'Le Sylvain (Romance)', 'No. 9. Le Sylvain (Romance)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00505b30-a502-485f-bc03-91a5a5e65c03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75de5132-cd17-4cc4-9dc7-bc09009709d2', 10, NULL, 'Cantemus', 'No. 10. Cantemus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75de5132-cd17-4cc4-9dc7-bc09009709d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05fd04e1-252d-4a7d-a3da-1734601f8bff', 11, NULL, 'Ariette à l''ancienne', 'No. 11. Ariette à l''ancienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05fd04e1-252d-4a7d-a3da-1734601f8bff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb0b8ce5-b56b-402b-9f7c-9ab93890e478', 12, NULL, 'Le départ des promis (Tyrolienne sentimentale)', 'No. 12. Le départ des promis (Tyrolienne sentimentale)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 3권 <남겨 둔 곡들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb0b8ce5-b56b-402b-9f7c-9ab93890e478'
);


-- None <노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>', 'Péchés de vieillesse, Vol. 4 "Quatre hors d''œuvres et quatre mendiants"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '012dde11-252b-4c0b-9df4-4b9de892c943'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '012dde11-252b-4c0b-9df4-4b9de892c943'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '012dde11-252b-4c0b-9df4-4b9de892c943'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf4a8c5f-27c7-4618-a19b-0b67fa001cef', 1, NULL, '네 가지 전채', 'Quatre hors d''œuvres', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf4a8c5f-27c7-4618-a19b-0b67fa001cef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd7b5304-073d-498a-85c5-ee99c3a47523', 1, NULL, 'Les radis', 'No. 1. Les radis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf4a8c5f-27c7-4618-a19b-0b67fa001cef'
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd7b5304-073d-498a-85c5-ee99c3a47523'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28061e27-0cb0-4e8a-a0de-af39c84cba63', 2, NULL, 'Les anchois', 'No. 2. Les anchois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf4a8c5f-27c7-4618-a19b-0b67fa001cef'
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28061e27-0cb0-4e8a-a0de-af39c84cba63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:571c2b1a-bd1a-4855-a13f-667e37c80376', 3, NULL, 'Les cornichons', 'No. 3. Les cornichons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf4a8c5f-27c7-4618-a19b-0b67fa001cef'
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:571c2b1a-bd1a-4855-a13f-667e37c80376'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37548e35-4624-47fd-b7fb-5901b88ae640', 4, NULL, 'Le beurre', 'No. 4. Le beurre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf4a8c5f-27c7-4618-a19b-0b67fa001cef'
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37548e35-4624-47fd-b7fb-5901b88ae640'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:686e6793-942c-41e6-931c-5d448fd57d01', 2, NULL, '네 가지 마른 과일', 'Quatre mendiants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:686e6793-942c-41e6-931c-5d448fd57d01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b402a8b-c52b-4529-9ea1-86925e7d1e53', 1, NULL, 'Les figues sèches', 'No. 1. Les figues sèches', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:686e6793-942c-41e6-931c-5d448fd57d01'
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b402a8b-c52b-4529-9ea1-86925e7d1e53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04548d67-5a41-463b-8fd2-df2054912aea', 2, NULL, 'Les amandes', 'No. 2. Les amandes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:686e6793-942c-41e6-931c-5d448fd57d01'
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04548d67-5a41-463b-8fd2-df2054912aea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7153514-5971-4dcf-9caf-143e473d63cc', 3, NULL, 'Les raisins', 'No. 3. Les raisins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:686e6793-942c-41e6-931c-5d448fd57d01'
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7153514-5971-4dcf-9caf-143e473d63cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c113de68-a0ad-42fb-b995-013124d618f6', 4, NULL, 'Les noisettes', 'No. 4. Les noisettes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:686e6793-942c-41e6-931c-5d448fd57d01'
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 4권 <네 가지 전채와 네 가지 마른 과일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c113de68-a0ad-42fb-b995-013124d618f6'
);


-- None <노년의 과오> 5권 <사춘기 아이들을 위한 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>', 'Péchés de vieillesse, Vol. 5 "Album pour les enfants adolescents"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10d5ab3f-b02a-4f2f-9b78-52cbadb0183d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '10d5ab3f-b02a-4f2f-9b78-52cbadb0183d'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10d5ab3f-b02a-4f2f-9b78-52cbadb0183d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8a01202-fe0e-45c0-a5f9-c0fa51dfe71c', 1, NULL, 'Première communion', 'No. 1. Première communion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8a01202-fe0e-45c0-a5f9-c0fa51dfe71c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d6bb28f-51df-4497-8a7c-151b0b2a6aea', 2, NULL, 'Thème naïf et variations idem', 'No. 2. Thème naïf et variations idem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d6bb28f-51df-4497-8a7c-151b0b2a6aea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6375d1c-fb5f-4fa0-bd45-739c4b435257', 3, NULL, 'Saltarello à l''italienne', 'No. 3. Saltarello à l''italienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6375d1c-fb5f-4fa0-bd45-739c4b435257'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8eaa25fd-97d3-4565-a6f9-45dfef514e93', 4, NULL, 'Prélude moresque', 'No. 4. Prélude moresque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8eaa25fd-97d3-4565-a6f9-45dfef514e93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c059ff43-bcd2-4c3f-a70e-ac1c0e2dffb9', 5, NULL, 'Valse lugubre', 'No. 5. Valse lugubre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c059ff43-bcd2-4c3f-a70e-ac1c0e2dffb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfd1118c-894d-4041-8d36-a8d76aaba7b7', 6, NULL, 'Impromptu anodin', 'No. 6. Impromptu anodin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfd1118c-894d-4041-8d36-a8d76aaba7b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f1d53aa-8533-4ebd-9de6-0a9d84fbba3c', 7, NULL, 'L''innocence italienne; La candeur française', 'No. 7. L''innocence italienne; La candeur française', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f1d53aa-8533-4ebd-9de6-0a9d84fbba3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dbe9fb4-3bc1-492b-9950-89c218f33c05', 8, NULL, 'Prélude convulsif', 'No. 8. Prélude convulsif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dbe9fb4-3bc1-492b-9950-89c218f33c05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b05922ea-f739-4c90-84da-b1cb454e953d', 9, NULL, 'La lagune de Venise à l''expiration de l''année 1861!!!', 'No. 9. La lagune de Venise à l''expiration de l''année 1861!!!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b05922ea-f739-4c90-84da-b1cb454e953d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae2660a1-280b-443d-9d5f-e3cfe5735a58', 10, NULL, 'Ouf! Les petits pois', 'No. 10. Ouf! Les petits pois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae2660a1-280b-443d-9d5f-e3cfe5735a58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f7379ef-4452-445a-9506-ed6e9e7bf7cc', 11, NULL, 'Un sauté', 'No. 11. Un sauté', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f7379ef-4452-445a-9506-ed6e9e7bf7cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2b6a0f9-8cf8-4420-984c-b022928088e9', 12, NULL, 'Hachis romantique', 'No. 12. Hachis romantique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 5권 <사춘기 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2b6a0f9-8cf8-4420-984c-b022928088e9'
);


-- None <노년의 과오> 6권 <영리한 아이들을 위한 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>', 'Péchés de vieillesse, Vol. 6 "Album pour les enfants dégourdis"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f2e0d51-554c-48e8-b636-d3334d44158f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f2e0d51-554c-48e8-b636-d3334d44158f'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f2e0d51-554c-48e8-b636-d3334d44158f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81c6dec8-27d0-4cc9-8106-5dc43417982f', 1, NULL, 'Mon prélude hygiénique du matin', 'No. 1. Mon prélude hygiénique du matin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81c6dec8-27d0-4cc9-8106-5dc43417982f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf855439-c3aa-4f63-bba8-bb3c3c8f20e0', 2, NULL, 'Prélude baroque', 'No. 2. Prélude baroque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf855439-c3aa-4f63-bba8-bb3c3c8f20e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7521a084-84cf-4025-81ab-e19d5c8128ad', 3, NULL, 'Memento homo', 'No. 3. Memento homo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7521a084-84cf-4025-81ab-e19d5c8128ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:667157b9-5d8a-40cc-9a1b-f52eb75e0a76', 4, NULL, 'Assez de memento: dansons', 'No. 4. Assez de memento: dansons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:667157b9-5d8a-40cc-9a1b-f52eb75e0a76'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:832dc75b-7642-472e-9ad2-04ec32934970', 5, NULL, 'La Pesarese', 'No. 5. La Pesarese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:832dc75b-7642-472e-9ad2-04ec32934970'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:376354be-559a-4c21-90a7-b4d23e100483', 6, NULL, 'Valse torturée', 'No. 6. Valse torturée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:376354be-559a-4c21-90a7-b4d23e100483'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:062fa877-ab8f-4845-acbf-fb65eead099e', 7, NULL, 'Une caresse à ma femme', 'No. 7. Une caresse à ma femme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:062fa877-ab8f-4845-acbf-fb65eead099e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46f19945-095f-47cc-b8a4-f8ec146fb3da', 8, NULL, 'Barcarole', 'No. 8. Barcarole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46f19945-095f-47cc-b8a4-f8ec146fb3da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b4dc147-c737-4661-bf12-61c9e0fef1eb', 9, NULL, 'Un petit train de plaisir comico-imitatif', 'No. 9. Un petit train de plaisir comico-imitatif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b4dc147-c737-4661-bf12-61c9e0fef1eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ac777e0-640f-4812-ad14-56178933c5d5', 10, NULL, 'Fausse couche de polka-mazurka', 'No. 10. Fausse couche de polka-mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ac777e0-640f-4812-ad14-56178933c5d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b618551f-3ea3-4bbf-9c65-64807ed2c950', 11, NULL, 'Étude asthmatique', 'No. 11. Étude asthmatique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b618551f-3ea3-4bbf-9c65-64807ed2c950'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:589d34e7-bc25-4980-bc3c-ececc590ced0', 12, NULL, 'Un enterrement en carnaval', 'No. 12. Un enterrement en carnaval', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 6권 <영리한 아이들을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:589d34e7-bc25-4980-bc3c-ececc590ced0'
);


-- None <노년의 과오> 7권 <오두막 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 7권 <오두막 앨범>', 'Péchés de vieillesse, Vol. 7 "Album de chaumière"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 7권 <오두막 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0199b21b-9ba4-415c-97cf-47e3f832cec4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0199b21b-9ba4-415c-97cf-47e3f832cec4'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0199b21b-9ba4-415c-97cf-47e3f832cec4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a27f81b6-c5d1-483c-94b0-b782ee4c9032', 1, NULL, 'Gymnastique d''écartement', 'No. 1. Gymnastique d''écartement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a27f81b6-c5d1-483c-94b0-b782ee4c9032'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62140fe1-c0a6-4186-910e-0eaaf4b144a9', 2, NULL, 'Prélude fugassé', 'No. 2. Prélude fugassé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62140fe1-c0a6-4186-910e-0eaaf4b144a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4686d47a-5c72-4445-8769-7603e70f1244', 3, NULL, 'Petite polka chinoise', 'No. 3. Petite polka chinoise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4686d47a-5c72-4445-8769-7603e70f1244'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe0be57a-4e09-4f76-bc5d-a0fcb0a51985', 4, NULL, 'Petite valse de boudoir', 'No. 4. Petite valse de boudoir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe0be57a-4e09-4f76-bc5d-a0fcb0a51985'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5f5aae7-ef73-488d-8648-8b3aa4de0e4a', 5, NULL, 'Prélude inoffensif', 'No. 5. Prélude inoffensif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5f5aae7-ef73-488d-8648-8b3aa4de0e4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74d9b391-d901-4de4-826a-1322258d4d46', 6, NULL, 'Petite valse: L''huile de ricin', 'No. 6. Petite valse: L''huile de ricin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74d9b391-d901-4de4-826a-1322258d4d46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57470ded-75c9-47e8-b4e6-7f2c1ef1ea3b', 7, NULL, 'Un profond sommeil; Un réveil en sursaut', 'No. 7. Un profond sommeil; Un réveil en sursaut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57470ded-75c9-47e8-b4e6-7f2c1ef1ea3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88d4cefa-f2c0-40e1-a3c4-9dd18f5aad08', 8, NULL, 'Plain-chant chinois', 'No. 8. Plain-chant chinois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88d4cefa-f2c0-40e1-a3c4-9dd18f5aad08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84855225-7681-4656-b571-9866e7dfdce3', 9, NULL, 'Un cauchemar', 'No. 9. Un cauchemar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84855225-7681-4656-b571-9866e7dfdce3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96ff61cc-6039-438d-b593-7f10997fb8ee', 10, NULL, 'Valse boiteuse', 'No. 10. Valse boiteuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96ff61cc-6039-438d-b593-7f10997fb8ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fa0009f-8a3d-45a2-9fed-3e2069faa22e', 11, NULL, 'Une pensée à Florence', 'No. 11. Une pensée à Florence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fa0009f-8a3d-45a2-9fed-3e2069faa22e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92aa74d8-fc78-4aad-aac9-00e6dcbe3a0d', 12, NULL, 'Marche', 'No. 12. Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 7권 <오두막 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92aa74d8-fc78-4aad-aac9-00e6dcbe3a0d'
);


-- None <노년의 과오> 8권 <성관 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 8권 <성관 앨범>', 'Péchés de vieillesse, Vol. 8 "Album de château"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 8권 <성관 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8d7b612-0152-425b-9a4b-501f54c12b08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8d7b612-0152-425b-9a4b-501f54c12b08'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8d7b612-0152-425b-9a4b-501f54c12b08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72e234ca-1e2c-40ba-857d-19896bc54bcc', 1, NULL, 'Spécimen de l''ancien régime', 'No. 1. Spécimen de l''ancien régime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72e234ca-1e2c-40ba-857d-19896bc54bcc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e93b1b9-ffbb-48a7-aa3a-62693456e1f0', 2, NULL, 'Prélude pétulant-rococo', 'No. 2. Prélude pétulant-rococo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e93b1b9-ffbb-48a7-aa3a-62693456e1f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1824a3d3-fd0d-4934-9cbf-5c851ff6258d', 3, NULL, 'Un regret; Un espoir', 'No. 3. Un regret; Un espoir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1824a3d3-fd0d-4934-9cbf-5c851ff6258d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c39c10bf-7f41-4542-a4c7-57f1efd6fb56', 4, NULL, 'Boléro tartare', 'No. 4. Boléro tartare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c39c10bf-7f41-4542-a4c7-57f1efd6fb56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e04c65a-d86a-4c6a-bcf8-cb1207b20f09', 5, NULL, 'Prélude prétentieux', 'No. 5. Prélude prétentieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e04c65a-d86a-4c6a-bcf8-cb1207b20f09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8287fc9e-51f7-4c25-81e8-6882412586c9', 6, NULL, 'Spécimen de mon temps', 'No. 6. Spécimen de mon temps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8287fc9e-51f7-4c25-81e8-6882412586c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9c83f87-9517-4486-99a9-1d37e1fe8ba0', 7, NULL, 'Valse anti-dansante', 'No. 7. Valse anti-dansante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9c83f87-9517-4486-99a9-1d37e1fe8ba0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4d7fdd3-55d7-4a19-967b-1a8e03daefb3', 8, NULL, 'Prélude semipastorale', 'No. 8. Prélude semipastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4d7fdd3-55d7-4a19-967b-1a8e03daefb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:607d05ef-78a2-4bb6-b632-33aae6d455a1', 9, NULL, 'Tarantelle pur sang (avec Traversée de la procession)', 'No. 9. Tarantelle pur sang (avec Traversée de la procession)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:607d05ef-78a2-4bb6-b632-33aae6d455a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71d54b07-e737-48d1-99db-58815afc2c17', 10, NULL, 'Un rêve', 'No. 10. Un rêve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71d54b07-e737-48d1-99db-58815afc2c17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6666d777-5f67-456e-b3c6-1a3078310437', 11, NULL, 'Prélude soi-disant dramatique', 'No. 11. Prélude soi-disant dramatique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6666d777-5f67-456e-b3c6-1a3078310437'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e2b5a95-b469-4134-bd91-65823df6983e', 12, NULL, 'Spécimen de l''avenir', 'No. 12. Spécimen de l''avenir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 8권 <성관 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e2b5a95-b469-4134-bd91-65823df6983e'
);


-- None <노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>', 'Péchés de vieillesse, Vol. 9 "Album pour piano, violon, violoncelle, harmonium et cor"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2cfa3d44-65d4-4804-9529-d52b928c9168'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2cfa3d44-65d4-4804-9529-d52b928c9168'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2cfa3d44-65d4-4804-9529-d52b928c9168'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2fcf76cf-d584-4bc4-9857-fb7af30b9668', 1, NULL, 'Mélodie candide', 'No. 1. Mélodie candide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fcf76cf-d584-4bc4-9857-fb7af30b9668'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84ad04f4-523e-4754-89c9-0f13abf5fa12', 2, NULL, 'Chansonnette', 'No. 2. Chansonnette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84ad04f4-523e-4754-89c9-0f13abf5fa12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8bc7fd5-7e17-4b9d-8438-d2fe79eddebd', 3, NULL, 'La Savoie aimante', 'No. 3. La Savoie aimante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8bc7fd5-7e17-4b9d-8438-d2fe79eddebd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b54e1285-50e6-4cdf-a757-62e02522ac57', 4, NULL, 'Un mot à Paganini (Élégie)', 'No. 4. Un mot à Paganini (Élégie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b54e1285-50e6-4cdf-a757-62e02522ac57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4daa863-e150-4f5b-9d1d-61dbfcf0759f', 5, NULL, 'Impromptu tarantellisé', 'No. 5. Impromptu tarantellisé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4daa863-e150-4f5b-9d1d-61dbfcf0759f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:752da9b9-ecc7-48a9-a442-8ca7d468d93a', 6, NULL, 'Échantillon du chant de Noël à l''italienne', 'No. 6. Échantillon du chant de Noël à l''italienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:752da9b9-ecc7-48a9-a442-8ca7d468d93a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ecc49f6-1c90-436c-854d-60e272ec4616', 7, NULL, 'Marche et réminiscences pour mon dernier voyage', 'No. 7. Marche et réminiscences pour mon dernier voyage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ecc49f6-1c90-436c-854d-60e272ec4616'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4b7c9e2-e677-4f40-b43d-6d4de6a7ad41', 8, NULL, 'Prélude, thème et variations', 'No. 8. Prélude, thème et variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b7c9e2-e677-4f40-b43d-6d4de6a7ad41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12f97473-887b-412c-9b16-693349b4f507', 9, NULL, 'Prélude italien', 'No. 9. Prélude italien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12f97473-887b-412c-9b16-693349b4f507'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c2d2c23-399b-4263-9b98-e0ea4afd546d', 10, NULL, 'Une larme: thème et variations', 'No. 10. Une larme: thème et variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c2d2c23-399b-4263-9b98-e0ea4afd546d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e07fa62-caac-45b1-8bda-62afb8941e39', 11, NULL, 'Échantillon de blague mélodique sur les noires de la main droite', 'No. 11. Échantillon de blague mélodique sur les noires de la main droite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e07fa62-caac-45b1-8bda-62afb8941e39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fcc2a3f-d678-471e-8159-a8300b94e0f4', 12, NULL, 'Petite fanfare à quatre mains', 'No. 12. Petite fanfare à quatre mains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 9권 <피아노, 바이올린, 첼로, 하모늄과 호른을 위한 앨범>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fcc2a3f-d678-471e-8159-a8300b94e0f4'
);


-- None <노년의 과오> 10권 <피아노 소품집>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 10권 <피아노 소품집>', 'Péchés de vieillesse, Vol. 10 "Miscellanée pour piano"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 10권 <피아노 소품집>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcd06f67-131e-44a3-9fd7-53c4025daa70'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fcd06f67-131e-44a3-9fd7-53c4025daa70'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 10권 <피아노 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcd06f67-131e-44a3-9fd7-53c4025daa70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27269c52-68f9-40cb-a106-b5e7251c4859', 1, NULL, 'Prélude blagueur', 'No. 1. Prélude blagueur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 10권 <피아노 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27269c52-68f9-40cb-a106-b5e7251c4859'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b39e51b-cea3-4c77-8c65-725a194e8be0', 2, NULL, 'Des tritons s''il vous plaît (Montée–descente)', 'No. 2. Des tritons s''il vous plaît (Montée–descente)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 10권 <피아노 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b39e51b-cea3-4c77-8c65-725a194e8be0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe59588c-1b9b-4f90-bdcb-0498e5cede6b', 3, NULL, 'Petite pensée', 'No. 3. Petite pensée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 10권 <피아노 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe59588c-1b9b-4f90-bdcb-0498e5cede6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f074f7d-0f09-4959-b848-9bc1d919666d', 4, NULL, 'Une bagatelle', 'No. 4. Une bagatelle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 10권 <피아노 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f074f7d-0f09-4959-b848-9bc1d919666d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7523a32e-f0bc-443d-93d6-b9f6729b6634', 5, NULL, 'Mélodie italienne (Une bagatelle): In nomine Patris', 'No. 5. Mélodie italienne (Une bagatelle): In nomine Patris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 10권 <피아노 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7523a32e-f0bc-443d-93d6-b9f6729b6634'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d31b8d32-6a9e-4ff7-9a2e-b01b8bfbc2ad', 6, NULL, 'Petit caprice (style Offenbach)', 'No. 6. Petit caprice (style Offenbach)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 10권 <피아노 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d31b8d32-6a9e-4ff7-9a2e-b01b8bfbc2ad'
);


-- None <노년의 과오> 11권 <성악 소품집>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 11권 <성악 소품집>', 'Péchés de vieillesse, Vol. 11 "Miscellanée de musique vocale"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 11권 <성악 소품집>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e12487dd-6133-42a6-a69f-a7ec67bf2c2c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e12487dd-6133-42a6-a69f-a7ec67bf2c2c'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e12487dd-6133-42a6-a69f-a7ec67bf2c2c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0b3f8a7-047b-43d2-b3e3-78586cbb4b3e', 1, NULL, 'Ariette villageoise', 'No. 1. Ariette villageoise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0b3f8a7-047b-43d2-b3e3-78586cbb4b3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f421180-8d32-4606-814d-0055543dc08f', 2, NULL, 'La chanson du bébé', 'No. 2. La chanson du bébé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f421180-8d32-4606-814d-0055543dc08f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a1a0565-37f9-4ec0-aae6-bae945753348', 3, NULL, 'Amour sans espoir (Tirana à l''espagnole rossinisée)', 'No. 3. Amour sans espoir (Tirana à l''espagnole rossinisée)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a1a0565-37f9-4ec0-aae6-bae945753348'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8fc5b45-b3bd-4562-87b1-64801b42bddd', 4, NULL, 'À ma belle mère (Requiem aeternam)', 'No. 4. À ma belle mère (Requiem aeternam)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8fc5b45-b3bd-4562-87b1-64801b42bddd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02a9001b-c7bc-4042-9e40-fa2cf45e11bb', 5, NULL, 'O salutaris, de campagne', 'No. 5. O salutaris, de campagne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02a9001b-c7bc-4042-9e40-fa2cf45e11bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cac429f-db70-4df0-9ee0-b1ad85e752a0', 6, NULL, 'Aragonese (Mi lagnerò tacendo)', 'No. 6. Aragonese (Mi lagnerò tacendo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cac429f-db70-4df0-9ee0-b1ad85e752a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6c08e5e-d80c-4b1e-ba98-72a4b63440e7', 7, NULL, 'Arietta all''antica, dedotta dal O salutaris ostia', 'No. 7. Arietta all''antica, dedotta dal O salutaris ostia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6c08e5e-d80c-4b1e-ba98-72a4b63440e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81b000bb-00bd-4d00-b0ba-f3991be45f53', 8, NULL, 'Il candore in fuga', 'No. 8. Il candore in fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81b000bb-00bd-4d00-b0ba-f3991be45f53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7c7e6a4c-ae2a-4583-85a4-5b079aeda956', 9, NULL, 'Salve amabilis Maria', 'No. 9. Salve amabilis Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7c7e6a4c-ae2a-4583-85a4-5b079aeda956'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a17b3b41-46a7-4c4d-9cdf-6dc90687e375', 10, NULL, 'Giovanna d''Arco', 'No. 10. Giovanna d''Arco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 11권 <성악 소품집>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a17b3b41-46a7-4c4d-9cdf-6dc90687e375'
);


-- None <노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>', 'Péchés de vieillesse, Vol. 12 "Quelques riens pour album"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff1eed58-12e9-4500-bc35-82a40f504844'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff1eed58-12e9-4500-bc35-82a40f504844'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff1eed58-12e9-4500-bc35-82a40f504844'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17fae53b-3610-4085-bc99-a6db26722102', 1, NULL, 'Allegretto', 'No. 1. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17fae53b-3610-4085-bc99-a6db26722102'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87550b32-3b4d-40d6-810c-130781e6a3e4', 2, NULL, 'Allegretto moderato', 'No. 2. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87550b32-3b4d-40d6-810c-130781e6a3e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1bf7801-01ff-440b-a78c-bbbad40b0173', 3, NULL, 'Allegretto moderato', 'No. 3. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1bf7801-01ff-440b-a78c-bbbad40b0173'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bec9d2f6-ba5c-4225-b221-056b7ef8bd8e', 4, NULL, 'Andante sostenuto', 'No. 4. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bec9d2f6-ba5c-4225-b221-056b7ef8bd8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92b7c901-2712-4615-86d2-742849a666f4', 5, NULL, 'Allegretto moderato', 'No. 5. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92b7c901-2712-4615-86d2-742849a666f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c05c434c-585d-44bf-8245-01527f683253', 6, NULL, 'Andante maestoso', 'No. 6. Andante maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c05c434c-585d-44bf-8245-01527f683253'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d349812-ed57-4587-88ff-14c6ebb8213d', 7, NULL, 'Andantino mosso', 'No. 7. Andantino mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d349812-ed57-4587-88ff-14c6ebb8213d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a83ef531-d868-4295-bcd0-5140f4ffc969', 8, NULL, 'Andantino sostenuto', 'No. 8. Andantino sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a83ef531-d868-4295-bcd0-5140f4ffc969'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff01ea32-c241-4fd1-9865-7c4d8e5e755b', 9, NULL, 'Allegretto moderato', 'No. 9. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff01ea32-c241-4fd1-9865-7c4d8e5e755b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d4bc8af-4cce-46c0-b4d3-89f06411c26e', 10, NULL, 'Andantino mosso', 'No. 10. Andantino mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d4bc8af-4cce-46c0-b4d3-89f06411c26e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93a9c63b-89de-4531-8920-efd0c21f6bc8', 11, NULL, 'Andantino mosso', 'No. 11. Andantino mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93a9c63b-89de-4531-8920-efd0c21f6bc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bf051f1-1a25-4993-80e5-11224592acf6', 12, NULL, 'Allegretto moderato (Danse sibérienne)', 'No. 12. Allegretto moderato (Danse sibérienne)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bf051f1-1a25-4993-80e5-11224592acf6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e15e5384-873a-4728-afc1-c47c1f4f782c', 13, NULL, 'Allegretto brillante', 'No. 13. Allegretto brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e15e5384-873a-4728-afc1-c47c1f4f782c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79d384d6-0878-49b7-8b0e-9cb6815a37cd', 14, NULL, 'Allegro vivace', 'No. 14. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79d384d6-0878-49b7-8b0e-9cb6815a37cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:036bdf63-513d-4099-afc2-038db909e743', 15, NULL, 'Petite galette allemande. Allegro brillante', 'No. 15. Petite galette allemande. Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:036bdf63-513d-4099-afc2-038db909e743'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:191dd845-7c95-497c-a789-4ed25c2699b7', 16, NULL, 'Douces réminiscences. Andantino', 'No. 16. Douces réminiscences. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:191dd845-7c95-497c-a789-4ed25c2699b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:699e73be-a9ce-495f-85a0-822c569f389a', 17, NULL, 'Andantino mosso quasi allegretto', 'No. 17. Andantino mosso quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:699e73be-a9ce-495f-85a0-822c569f389a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e3bffd8-25b7-4808-8faf-15b47b54f1b3', 18, NULL, 'Andantino mosso', 'No. 18. Andantino mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e3bffd8-25b7-4808-8faf-15b47b54f1b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e977ba-aa9f-45e8-a3ee-470c5fcca180', 19, NULL, 'Allegretto moderato', 'No. 19. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e977ba-aa9f-45e8-a3ee-470c5fcca180'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b906d54d-223c-41a1-a424-7d78bdab4d0f', 20, NULL, 'Allegretto brillante', 'No. 20. Allegretto brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b906d54d-223c-41a1-a424-7d78bdab4d0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5d297a4-0e82-4579-a890-616396292265', 21, NULL, 'Andantino sostenuto', 'No. 21. Andantino sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5d297a4-0e82-4579-a890-616396292265'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54ac4dae-4930-496c-b50c-8cc3dc6c28ba', 22, NULL, 'Thème et variations sur le mode mineur. Andantino mosso', 'No. 22. Thème et variations sur le mode mineur. Andantino mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54ac4dae-4930-496c-b50c-8cc3dc6c28ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e983635-60f8-4d14-8ff2-c1ab72c0c145', 23, NULL, 'Thème et variations sur le mode majeur. Allegretto moderato', 'No. 23. Thème et variations sur le mode majeur. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e983635-60f8-4d14-8ff2-c1ab72c0c145'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d29f3c03-f165-4586-8c30-9985c93c76ca', 24, NULL, 'Un rien sur le mode enharmonique. Adagio', 'No. 24. Un rien sur le mode enharmonique. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 12권 <앨범을 위한 몇 가지 하찮은 곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d29f3c03-f165-4586-8c30-9985c93c76ca'
);


-- None <노년의 과오> 13권 <대수롭지 않은 음악>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 13권 <대수롭지 않은 음악>', 'Péchés de vieillesse, Vol. 13 "Musique anodine"', 'album', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 13권 <대수롭지 않은 음악>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d688ca7-519c-449e-9ac0-68045886efa8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d688ca7-519c-449e-9ac0-68045886efa8'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 13권 <대수롭지 않은 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d688ca7-519c-449e-9ac0-68045886efa8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47b04af5-344a-4cd4-8064-df2ef6077477', 1, NULL, 'Prélude. Allegretto moderato', 'Prélude. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 13권 <대수롭지 않은 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47b04af5-344a-4cd4-8064-df2ef6077477'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:961db7f7-7d39-431f-8c8f-54647d554fc9', 2, NULL, 'Mi lagnerò tacendo. Andantino (콘트랄토)', 'No. 1. Mi lagnerò tacendo. Andantino (contralto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 13권 <대수롭지 않은 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:961db7f7-7d39-431f-8c8f-54647d554fc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fe1d4d4-0fbe-48aa-9da9-0a490651758f', 3, NULL, 'Mi lagnerò tacendo. Andantino mosso (바리톤)', 'No. 2. Mi lagnerò tacendo. Andantino mosso (baritone)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 13권 <대수롭지 않은 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fe1d4d4-0fbe-48aa-9da9-0a490651758f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:988b149b-9361-40ec-8bf2-aa97e6597836', 4, NULL, 'Mi lagnerò tacendo. Andantino moderato (소프라노)', 'No. 3. Mi lagnerò tacendo. Andantino moderato (soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 13권 <대수롭지 않은 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:988b149b-9361-40ec-8bf2-aa97e6597836'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77c6fccb-7c86-427c-b864-86eb2c0bf386', 5, NULL, 'Mi lagnerò tacendo. Allegretto moderato (소프라노)', 'No. 4. Mi lagnerò tacendo. Allegretto moderato (soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 13권 <대수롭지 않은 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77c6fccb-7c86-427c-b864-86eb2c0bf386'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:accc2363-3298-499c-9d18-a8bdbd8974fb', 6, NULL, 'Mi lagnerò tacendo. Andantino moderato (메조소프라노)', 'No. 5. Mi lagnerò tacendo. Andantino moderato (mezzo-soprano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 13권 <대수롭지 않은 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:accc2363-3298-499c-9d18-a8bdbd8974fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db971bb7-fcd7-410b-92a6-ee158b47d9b7', 7, NULL, 'Mi lagnerò tacendo. Allegretto moderato (바리톤)', 'No. 6. Mi lagnerò tacendo. Allegretto moderato (baritone)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 13권 <대수롭지 않은 음악>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db971bb7-fcd7-410b-92a6-ee158b47d9b7'
);


-- None <노년의 과오> 14권 <그 밖의 노년의 과오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<노년의 과오> 14권 <그 밖의 노년의 과오>', 'Péchés de vieillesse, Vol. 14 "Altri péchés de vieillesse"', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 36
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e6859c0-5f10-4bce-88bf-a8e77513cefa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e6859c0-5f10-4bce-88bf-a8e77513cefa'
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e6859c0-5f10-4bce-88bf-a8e77513cefa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b7cb44a-583f-46da-8a51-0914ab0543a9', 1, NULL, 'Canone perpetuo', 'No. 1. Canone perpetuo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b7cb44a-583f-46da-8a51-0914ab0543a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72bbb003-78d3-4cdd-b1c9-b3a0e3d56b4e', 2, NULL, 'Canone antisavant', 'No. 2. Canone antisavant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72bbb003-78d3-4cdd-b1c9-b3a0e3d56b4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2378f681-3bb3-46f0-a619-7604c7020a53', 3, NULL, 'La vénitienne (Canzonetta)', 'No. 3. La vénitienne (Canzonetta)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2378f681-3bb3-46f0-a619-7604c7020a53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07751319-58ef-4965-b2e1-fcd64cfcfac9', 4, NULL, 'Petite promenade de Passy à Courbevoie', 'No. 4. Petite promenade de Passy à Courbevoie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07751319-58ef-4965-b2e1-fcd64cfcfac9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2021cf65-29ac-4923-b155-7b8f116c7b6e', 5, NULL, 'Une réjouissance', 'No. 5. Une réjouissance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2021cf65-29ac-4923-b155-7b8f116c7b6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0612ea48-21c4-45ee-9c5f-bf56cdbce4d4', 6, NULL, 'Encore un peu de blague', 'No. 6. Encore un peu de blague', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0612ea48-21c4-45ee-9c5f-bf56cdbce4d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3fee781-1cb2-4af3-bb5b-c1bbc08b02a7', 7, NULL, 'Tourniquet sur la gamme chromatique, ascendante et descendante', 'No. 7. Tourniquet sur la gamme chromatique, ascendante et descendante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3fee781-1cb2-4af3-bb5b-c1bbc08b02a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a78bc892-a152-4a96-b788-c26d359f1416', 8, NULL, 'Ritournelle gothique', 'No. 8. Ritournelle gothique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a78bc892-a152-4a96-b788-c26d359f1416'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:485f2a72-5097-457e-bee1-26fc222151fe', 9, NULL, 'Un rien (pour album)', 'No. 9. Un rien (pour album)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:485f2a72-5097-457e-bee1-26fc222151fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:978cf2a2-796a-44f9-9239-7c009f978c2b', 10, NULL, 'Metastasio (pour album)', 'No. 10. Metastasio (pour album)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:978cf2a2-796a-44f9-9239-7c009f978c2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba3c399-0342-4287-8c16-0eb569371cb1', 11, NULL, 'Brindisi', 'No. 11. Brindisi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba3c399-0342-4287-8c16-0eb569371cb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:909a71ef-0234-4cc3-8d87-70ebe3676a7b', 12, NULL, 'Solo pour violoncelle (Allegro agitato)', 'No. 12. Solo pour violoncelle (Allegro agitato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:909a71ef-0234-4cc3-8d87-70ebe3676a7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4b9bd8a-5d98-4c9c-849b-f4ec5ba80f49', 13, NULL, 'Questo palpito soave', 'No. 13. Questo palpito soave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4b9bd8a-5d98-4c9c-849b-f4ec5ba80f49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f74e67d-ed21-41d0-942a-fb572e4e2c42', 14, NULL, 'L''ultimo pensiero', 'No. 14. L''ultimo pensiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 36 AND p.title = '<노년의 과오> 14권 <그 밖의 노년의 과오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f74e67d-ed21-41d0-942a-fb572e4e2c42'
);

