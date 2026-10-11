-- 푸치니 작품을 출판 단위로 채운다(카탈로그: 없음). 작품 44개(묶음 1, 다악장 1, 낱곡 42),
-- 새 작품 41개, 기존 작품 3개, part 8개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   오페라 12편은 part 없이 둔다(<일 트리티코> 세 편은 각각). 210·213 은 운영에 MBID 가 없어 MB work 를 식별자로 더한다.
--   대목 작품 211·214 는 그대로 둔다.
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

-- None 오페라 <요정 빌리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <요정 빌리>', 'Opera <Le Villi>', 'song', NULL, NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <요정 빌리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fbf18b70-376b-43a4-a437-a06324ce9480'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fbf18b70-376b-43a4-a437-a06324ce9480'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <요정 빌리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fbf18b70-376b-43a4-a437-a06324ce9480'
);


-- None 오페라 <에드가르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <에드가르>', 'Opera <Edgar>', 'song', NULL, NULL, NULL, 1889, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <에드가르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29948c88-f729-45b5-b87c-b8712f6de9e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29948c88-f729-45b5-b87c-b8712f6de9e1'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <에드가르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29948c88-f729-45b5-b87c-b8712f6de9e1'
);


-- None 오페라 <마농 레스코>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <마농 레스코>', 'Opera <Manon Lescaut>', 'song', NULL, NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <마농 레스코>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8a080c3-3ba7-40f7-b170-4e615f7929f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8a080c3-3ba7-40f7-b170-4e615f7929f8'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <마농 레스코>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8a080c3-3ba7-40f7-b170-4e615f7929f8'
);


-- None 오페라 <라 보엠>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '765c54af-eff4-40ce-8f86-d8aa1c8138d4'
FROM pieces p
WHERE p.id = 210 AND p.composer_id = 48
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '765c54af-eff4-40ce-8f86-d8aa1c8138d4'
);


-- None 오페라 <나비부인>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e83a319a-4568-4077-88a4-f8f4db416926'
FROM pieces p
WHERE p.id = 213 AND p.composer_id = 48
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e83a319a-4568-4077-88a4-f8f4db416926'
);


-- None 오페라 <서부의 아가씨>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <서부의 아가씨>', 'Opera <La fanciulla del West>', 'song', NULL, NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <서부의 아가씨>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2bf662c-25bd-4bd4-b466-f33d07bbe73a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2bf662c-25bd-4bd4-b466-f33d07bbe73a'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <서부의 아가씨>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2bf662c-25bd-4bd4-b466-f33d07bbe73a'
);


-- None 오페라 <제비>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <제비>', 'Opera <La rondine>', 'song', NULL, NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <제비>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9f4c8bc-72df-44c6-bdd9-fa33ef4cf991'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e9f4c8bc-72df-44c6-bdd9-fa33ef4cf991'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <제비>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9f4c8bc-72df-44c6-bdd9-fa33ef4cf991'
);


-- None 오페라 <외투>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <외투>', 'Opera <Il tabarro>', 'song', NULL, NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <외투>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02e32045-8aec-4cc7-be68-22e5ecdb4901'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '02e32045-8aec-4cc7-be68-22e5ecdb4901'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <외투>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '02e32045-8aec-4cc7-be68-22e5ecdb4901'
);


-- None 오페라 <수녀 안젤리카>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <수녀 안젤리카>', 'Opera <Suor Angelica>', 'song', NULL, NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <수녀 안젤리카>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b56f54a4-c0ed-4594-822f-ef30ea17ba1b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b56f54a4-c0ed-4594-822f-ef30ea17ba1b'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <수녀 안젤리카>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b56f54a4-c0ed-4594-822f-ef30ea17ba1b'
);


-- None 오페라 <잔니 스키키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <잔니 스키키>', 'Opera <Gianni Schicchi>', 'song', NULL, NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <잔니 스키키>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7603e8fd-9dd7-48f5-b40b-01b0fb4482b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7603e8fd-9dd7-48f5-b40b-01b0fb4482b9'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <잔니 스키키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7603e8fd-9dd7-48f5-b40b-01b0fb4482b9'
);


-- None 오페라 <투란도트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <투란도트>', 'Opera <Turandot>', 'song', NULL, NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <투란도트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f617e5ae-572c-46a9-9902-1d53774c01aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f617e5ae-572c-46a9-9902-1d53774c01aa'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '오페라 <투란도트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f617e5ae-572c-46a9-9902-1d53774c01aa'
);


-- None 미사 A♭장조 "대영광 미사"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 A♭장조 "대영광 미사"', 'Messa a 4 voci in A♭ major "Messa di Gloria"', 'album', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 A♭장조 "대영광 미사"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35cd868d-3285-4b45-8289-c17120cff69f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35cd868d-3285-4b45-8289-c17120cff69f'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '미사 A♭장조 "대영광 미사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35cd868d-3285-4b45-8289-c17120cff69f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d77acba8-a2b5-3b59-a3cd-f6cdf2c334f7', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '미사 A♭장조 "대영광 미사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d77acba8-a2b5-3b59-a3cd-f6cdf2c334f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e22da055-7644-38de-a700-bde6c38c6b02', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '미사 A♭장조 "대영광 미사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e22da055-7644-38de-a700-bde6c38c6b02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1926940e-fd3b-3a33-b036-38e3684927d1', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '미사 A♭장조 "대영광 미사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1926940e-fd3b-3a33-b036-38e3684927d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:359c2d1f-85ad-3963-bc18-523de37997fe', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '미사 A♭장조 "대영광 미사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:359c2d1f-85ad-3963-bc18-523de37997fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aef69656-e535-3d97-84bf-13ca70323737', 5, 'V', '아뉴스 데이', 'V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '미사 A♭장조 "대영광 미사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aef69656-e535-3d97-84bf-13ca70323737'
);


-- None 레퀴엠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레퀴엠', 'Requiem', 'song', NULL, NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레퀴엠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '566ba110-9acb-4dae-9d3f-625fc1cd34b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '566ba110-9acb-4dae-9d3f-625fc1cd34b8'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '레퀴엠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '566ba110-9acb-4dae-9d3f-625fc1cd34b8'
);


-- None 모테트 <Plaudite populi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Plaudite populi>', 'Plaudite populi (Mottetto per San Paolino)', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Plaudite populi>'
);


-- None 성가 <Vexilla regis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Vexilla regis>', 'Vexilla regis', 'song', NULL, NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Vexilla regis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c285f93-e4ad-4f1c-8f57-5e59eaaf85dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c285f93-e4ad-4f1c-8f57-5e59eaaf85dd'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '성가 <Vexilla regis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c285f93-e4ad-4f1c-8f57-5e59eaaf85dd'
);


-- None 성가 <Salve del ciel Regina>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Salve del ciel Regina>', 'Salve del ciel Regina', 'song', NULL, NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Salve del ciel Regina>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcd2c957-6594-45b2-a6bf-7b5e07a139e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bcd2c957-6594-45b2-a6bf-7b5e07a139e9'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '성가 <Salve del ciel Regina>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcd2c957-6594-45b2-a6bf-7b5e07a139e9'
);


-- None 가곡 <A te>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <A te>', 'A te', 'song', NULL, NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <A te>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f0c4a59-9420-45ea-bf1c-54834621a976'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f0c4a59-9420-45ea-bf1c-54834621a976'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <A te>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f0c4a59-9420-45ea-bf1c-54834621a976'
);


-- None 가곡 <Mentìa l'avviso>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mentìa l''avviso>', 'Mentìa l''avviso', 'song', NULL, NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mentìa l''avviso>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ff54c6d-85a8-4c28-abea-11fe1d4dda37'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ff54c6d-85a8-4c28-abea-11fe1d4dda37'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Mentìa l''avviso>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ff54c6d-85a8-4c28-abea-11fe1d4dda37'
);


-- None 가곡 <Storiella d'amore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Storiella d''amore>', 'Storiella d''amore', 'song', NULL, NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Storiella d''amore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '245b0725-c378-4568-a16a-6b379e11835c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '245b0725-c378-4568-a16a-6b379e11835c'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Storiella d''amore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '245b0725-c378-4568-a16a-6b379e11835c'
);


-- None 가곡 <Sole e amore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sole e amore>', 'Sole e amore', 'song', NULL, NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sole e amore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f61b401-5ccb-3a8c-822f-28e4224c1388'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f61b401-5ccb-3a8c-822f-28e4224c1388'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Sole e amore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f61b401-5ccb-3a8c-822f-28e4224c1388'
);


-- None 가곡 <Avanti Urania!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Avanti Urania!>', 'Avanti Urania!', 'song', NULL, NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Avanti Urania!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '12ba2f1d-cd6e-42b8-b8a5-581ec628f4fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '12ba2f1d-cd6e-42b8-b8a5-581ec628f4fb'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Avanti Urania!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '12ba2f1d-cd6e-42b8-b8a5-581ec628f4fb'
);


-- None 가곡 <Inno a Diana>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Inno a Diana>', 'Inno a Diana', 'song', NULL, NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Inno a Diana>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b8c7399-5d4f-4fe2-b58e-7247598767b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b8c7399-5d4f-4fe2-b58e-7247598767b9'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Inno a Diana>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b8c7399-5d4f-4fe2-b58e-7247598767b9'
);


-- None 가곡 <E l'uccellino>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <E l''uccellino>', 'E l''uccellino', 'song', NULL, NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <E l''uccellino>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd80443a3-5bb0-46b2-9b70-bae7ae2ebd00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd80443a3-5bb0-46b2-9b70-bae7ae2ebd00'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <E l''uccellino>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd80443a3-5bb0-46b2-9b70-bae7ae2ebd00'
);


-- None 가곡 <Terra e mare>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Terra e mare>', 'Terra e mare', 'song', NULL, NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Terra e mare>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdd941db-8987-49d1-9af0-22d949ee900a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdd941db-8987-49d1-9af0-22d949ee900a'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Terra e mare>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdd941db-8987-49d1-9af0-22d949ee900a'
);


-- None 가곡 <Canto d'anime>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Canto d''anime>', 'Canto d''anime', 'song', NULL, NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Canto d''anime>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58458238-30fe-3fa8-964f-dd8314107c54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58458238-30fe-3fa8-964f-dd8314107c54'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Canto d''anime>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58458238-30fe-3fa8-964f-dd8314107c54'
);


-- None 찬가 <Dios y Patria>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <Dios y Patria>', 'Dios y Patria', 'song', NULL, NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <Dios y Patria>'
);


-- None 가곡 <Casa mia, casa mia>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Casa mia, casa mia>', 'Casa mia, casa mia', 'song', NULL, NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Casa mia, casa mia>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '745afbdb-03a8-40c7-ba85-4c4ec5fa6515'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '745afbdb-03a8-40c7-ba85-4c4ec5fa6515'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Casa mia, casa mia>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '745afbdb-03a8-40c7-ba85-4c4ec5fa6515'
);


-- None 가곡 <Sogno d'or>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sogno d''or>', 'Sogno d''or', 'song', NULL, NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sogno d''or>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '116c93e0-3145-4b65-b94f-de90855f8781'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '116c93e0-3145-4b65-b94f-de90855f8781'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Sogno d''or>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '116c93e0-3145-4b65-b94f-de90855f8781'
);


-- None 가곡 <Morire?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Morire?>', 'Morire?', 'song', NULL, NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Morire?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ab3fb7a-d840-33c6-8293-14748f294986'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ab3fb7a-d840-33c6-8293-14748f294986'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '가곡 <Morire?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ab3fb7a-d840-33c6-8293-14748f294986'
);


-- None 찬가 <Inno a Roma>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '찬가 <Inno a Roma>', 'Inno a Roma', 'song', NULL, NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '찬가 <Inno a Roma>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '686a5fd5-c6dd-4198-92c6-2fe9ac1c8923'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '686a5fd5-c6dd-4198-92c6-2fe9ac1c8923'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '찬가 <Inno a Roma>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '686a5fd5-c6dd-4198-92c6-2fe9ac1c8923'
);


-- None 관현악 전주곡 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 전주곡 E단조', 'Preludio a orchestra in E minor', 'song', NULL, NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 전주곡 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '257ddf18-881e-4c9c-8b07-c9a35407dd18'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '257ddf18-881e-4c9c-8b07-c9a35407dd18'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '관현악 전주곡 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '257ddf18-881e-4c9c-8b07-c9a35407dd18'
);


-- None 교향적 전주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 전주곡 A장조', 'Preludio sinfonico in A major', 'song', NULL, NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 전주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8196e27b-de09-39bd-a859-535d592791ef'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8196e27b-de09-39bd-a859-535d592791ef'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '교향적 전주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8196e27b-de09-39bd-a859-535d592791ef'
);


-- None 라르고 아다제토 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '라르고 아다제토 F장조', 'Largo Adagetto in F major', 'song', NULL, NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '라르고 아다제토 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc027c5c-e1af-4a01-acea-4d253d6d1b2e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc027c5c-e1af-4a01-acea-4d253d6d1b2e'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '라르고 아다제토 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc027c5c-e1af-4a01-acea-4d253d6d1b2e'
);


-- None 교향적 카프리치오

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 카프리치오', 'Capriccio sinfonico', 'song', NULL, NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 카프리치오'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '490bd136-b11b-4e07-a90d-5eba61598705'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '490bd136-b11b-4e07-a90d-5eba61598705'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '교향적 카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '490bd136-b11b-4e07-a90d-5eba61598705'
);


-- None 작은 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 왈츠', 'Piccolo valzer', 'song', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 왈츠'
);


-- None 행진곡 <Scossa elettrica>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Scossa elettrica>', 'Scossa elettrica', 'song', NULL, NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Scossa elettrica>'
);


-- None 피아노 소품 (1916)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소품 (1916)', 'Pezzo per pianoforte (1916)', 'song', NULL, NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소품 (1916)'
);


-- None 현악 4중주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 D장조', 'String Quartet in D major', 'song', NULL, NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a3b63ec-05fb-4753-9181-f57f8edb3266'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7a3b63ec-05fb-4753-9181-f57f8edb3266'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a3b63ec-05fb-4753-9181-f57f8edb3266'
);


-- None 현악 4중주를 위한 아다지오 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 아다지오 A장조', 'Adagio in A major for string quartet', 'song', NULL, NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 아다지오 A장조'
);


-- None 현악 4중주를 위한 3개의 미뉴에트

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 3개의 미뉴에트', '3 Minuetti for string quartet', 'album', NULL, NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 3개의 미뉴에트'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84fb9c3b-b461-4c91-8fb2-8535cb641a6a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84fb9c3b-b461-4c91-8fb2-8535cb641a6a'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '현악 4중주를 위한 3개의 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84fb9c3b-b461-4c91-8fb2-8535cb641a6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb8dec7a-9ee0-403a-8477-eaf0b021ff53', 1, NULL, 'A장조. Moderato', 'No. 1. A major. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '현악 4중주를 위한 3개의 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb8dec7a-9ee0-403a-8477-eaf0b021ff53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0bf32eb-911d-4f3c-9a92-6a4d07ecfa79', 2, NULL, 'A장조. Allegretto', 'No. 2. A major. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '현악 4중주를 위한 3개의 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0bf32eb-911d-4f3c-9a92-6a4d07ecfa79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecf7a0dd-db98-4137-ba6f-6f90b01e3c19', 3, NULL, 'A장조. Assai mosso', 'No. 3. A major. Assai mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '현악 4중주를 위한 3개의 미뉴에트' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecf7a0dd-db98-4137-ba6f-6f90b01e3c19'
);


-- None 현악 4중주를 위한 스케르초 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 스케르초 A단조', 'Scherzo in A minor for string quartet', 'song', NULL, NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 스케르초 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c887dcd-2958-4d50-b58e-4c3610532c3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c887dcd-2958-4d50-b58e-4c3610532c3e'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '현악 4중주를 위한 스케르초 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c887dcd-2958-4d50-b58e-4c3610532c3e'
);


-- None 현악 4중주를 위한 스케르초 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 스케르초 D단조', 'Scherzo in D minor for string quartet', 'song', NULL, NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 스케르초 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26482e4d-084e-434e-bb9b-d6d8237074cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '26482e4d-084e-434e-bb9b-d6d8237074cb'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '현악 4중주를 위한 스케르초 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26482e4d-084e-434e-bb9b-d6d8237074cb'
);


-- None 현악 4중주곡 <국화>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주곡 <국화>', 'Crisantemi', 'song', NULL, NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 48
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주곡 <국화>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '633da7e1-7778-46b2-8dd0-cbd3b57637fe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '633da7e1-7778-46b2-8dd0-cbd3b57637fe'
FROM pieces p
WHERE p.composer_id = 48 AND p.title = '현악 4중주곡 <국화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '633da7e1-7778-46b2-8dd0-cbd3b57637fe'
);

