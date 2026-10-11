-- 무소르크스키 작품을 출판 단위로 채운다(카탈로그: 없음). 작품 76개(묶음 5, 다악장 0, 낱곡 71),
-- 새 작품 72개, 기존 작품 4개, part 34개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   원작 기준으로 넣고 남의 편곡판은 뺀다(<결혼>·<호반시치나>·<소로친치 장터>는 원작 이름, 남이 완성).
--   189 <전람회의 그림>은 프롬나드 포함 15곡 묶음. 190 라벨 편곡판은 그대로. 191 은 기존 식별자만 둔다.
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

-- None 오페라 <결혼>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <결혼>', 'Marriage (Zhenit''ba)', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <결혼>'
);


-- None 오페라 <보리스 고두노프>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b77915a-4e7a-43d2-88e7-7d3a5a303885'
FROM pieces p
WHERE p.id = 192 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b77915a-4e7a-43d2-88e7-7d3a5a303885'
);


-- None 오페라 <호반시치나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <호반시치나>', 'Khovanshchina', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <호반시치나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14ea1c96-ed3c-46fd-9bef-a025698dbd55'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14ea1c96-ed3c-46fd-9bef-a025698dbd55'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '오페라 <호반시치나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14ea1c96-ed3c-46fd-9bef-a025698dbd55'
);


-- None 오페라 <소로친치 장터>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <소로친치 장터>', 'The Fair at Sorochyntsi', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <소로친치 장터>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5343f607-a904-4a44-b212-c9974212c6c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5343f607-a904-4a44-b212-c9974212c6c2'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '오페라 <소로친치 장터>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5343f607-a904-4a44-b212-c9974212c6c2'
);


-- None 스케르초 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 B♭장조', 'Scherzo in B♭ major', 'song', NULL, NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6ac75a4-8193-48ad-8608-1373214ea9e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6ac75a4-8193-48ad-8608-1373214ea9e1'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '스케르초 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6ac75a4-8193-48ad-8608-1373214ea9e1'
);


-- None <밤의 행진곡풍으로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<밤의 행진곡풍으로>', 'Alla marcia notturna', 'song', NULL, NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<밤의 행진곡풍으로>'
);


-- None 교향적 인테르메초 B단조 "고전 양식으로"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 인테르메초 B단조 "고전 양식으로"', 'Intermezzo symphonique in modo classico in B minor', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 인테르메초 B단조 "고전 양식으로"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82a3acd8-4118-430e-9676-37594b7f06a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82a3acd8-4118-430e-9676-37594b7f06a2'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '교향적 인테르메초 B단조 "고전 양식으로"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82a3acd8-4118-430e-9676-37594b7f06a2'
);


-- None 행진곡 <카르스 점령>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <카르스 점령>', 'The Capture of Kars, March', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <카르스 점령>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f4bdb6f-0bc3-3293-ac6c-804b7bcd85fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f4bdb6f-0bc3-3293-ac6c-804b7bcd85fd'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '행진곡 <카르스 점령>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f4bdb6f-0bc3-3293-ac6c-804b7bcd85fd'
);


-- None 폴카 <기수>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <기수>', 'Porte-enseigne Polka', 'song', NULL, NULL, NULL, 1852, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <기수>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd38cbec4-49c7-4d9b-890e-7a19ac969519'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd38cbec4-49c7-4d9b-890e-7a19ac969519'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '폴카 <기수>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd38cbec4-49c7-4d9b-890e-7a19ac969519'
);


-- None <어린 시절의 추억>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<어린 시절의 추억>', 'Souvenir d''enfance', 'song', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<어린 시절의 추억>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f125203-072e-4ea2-a7a8-4bbf1e0e7a87'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f125203-072e-4ea2-a7a8-4bbf1e0e7a87'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '<어린 시절의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f125203-072e-4ea2-a7a8-4bbf1e0e7a87'
);


-- None 스케르초 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 C#단조', 'Scherzo in C# minor', 'song', NULL, NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8ed1166-1df0-41f8-bc1c-796607472c1b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8ed1166-1df0-41f8-bc1c-796607472c1b'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '스케르초 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8ed1166-1df0-41f8-bc1c-796607472c1b'
);


-- None 열정적인 즉흥곡 "벨토프와 류바의 회상"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '열정적인 즉흥곡 "벨토프와 류바의 회상"', 'Impromptu passionné "Recollection of Beltov and Lyuba"', 'song', NULL, NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '열정적인 즉흥곡 "벨토프와 류바의 회상"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36a9f70a-365e-3768-9589-cdf99c5335e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '36a9f70a-365e-3768-9589-cdf99c5335e1'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '열정적인 즉흥곡 "벨토프와 류바의 회상"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36a9f70a-365e-3768-9589-cdf99c5335e1'
);


-- None <아이들의 장난>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아이들의 장난>', 'Ein Kinderscherz', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아이들의 장난>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cebd41cd-b1a6-43c3-ad1c-94a98cc3a78f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cebd41cd-b1a6-43c3-ad1c-94a98cc3a78f'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '<아이들의 장난>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cebd41cd-b1a6-43c3-ad1c-94a98cc3a78f'
);


-- None 피아노 모음곡 <어린 시절의 회상에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <어린 시절의 회상에서>', 'From Memories of Childhood', 'album', NULL, NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <어린 시절의 회상에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbfb8ab1-c89d-4b7b-ac86-2faf3e82f6ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dbfb8ab1-c89d-4b7b-ac86-2faf3e82f6ed'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '피아노 모음곡 <어린 시절의 회상에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbfb8ab1-c89d-4b7b-ac86-2faf3e82f6ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1288522-19de-429a-ae7d-3b11de620514', 1, NULL, '유모와 나 (Nyanya i ya)', 'Nyanya i ya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '피아노 모음곡 <어린 시절의 회상에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1288522-19de-429a-ae7d-3b11de620514'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3298cd6e-af39-4f1b-9073-9d6c7cadc95f', 2, NULL, '첫 벌 (Pervoe nakazanie)', 'Pervoe nakazanie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '피아노 모음곡 <어린 시절의 회상에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3298cd6e-af39-4f1b-9073-9d6c7cadc95f'
);


-- None 몽상

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '몽상', 'Rêverie (Duma)', 'song', NULL, NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '몽상'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c098bf76-c85f-39bb-92a5-c13992652bb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c098bf76-c85f-39bb-92a5-c13992652bb7'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '몽상' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c098bf76-c85f-39bb-92a5-c13992652bb7'
);


-- None <변덕스러운 여인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<변덕스러운 여인>', 'La capricieuse', 'song', NULL, NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<변덕스러운 여인>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16f02963-cb01-42f8-83b5-22914462c659'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16f02963-cb01-42f8-83b5-22914462c659'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '<변덕스러운 여인>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16f02963-cb01-42f8-83b5-22914462c659'
);


-- None 스케르치노 <재봉사>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르치노 <재봉사>', 'La couturière (The Seamstress), Scherzino', 'song', NULL, NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르치노 <재봉사>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b94e444c-c3ad-49de-9fc5-fbf253fb41e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b94e444c-c3ad-49de-9fc5-fbf253fb41e2'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '스케르치노 <재봉사>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b94e444c-c3ad-49de-9fc5-fbf253fb41e2'
);


-- None 피아노 모음곡 <전람회의 그림>

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cd18a7a-808a-4876-8cb7-10394e9b8c0d', 1, NULL, '프롬나드', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cd18a7a-808a-4876-8cb7-10394e9b8c0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed82919c-c9bd-41ca-acdc-8b333aecd3d3', 2, NULL, '난쟁이 (Gnomus)', 'Gnomus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed82919c-c9bd-41ca-acdc-8b333aecd3d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd534287-9746-4b89-8eb5-2dcc20f17326', 3, NULL, '프롬나드', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd534287-9746-4b89-8eb5-2dcc20f17326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b37738a-91cc-4f49-89ac-b1b8c3590f25', 4, NULL, '옛 성 (Il vecchio castello)', 'Il vecchio castello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b37738a-91cc-4f49-89ac-b1b8c3590f25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83e50808-48ca-40d6-b5fa-d5050e082b7f', 5, NULL, '프롬나드', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83e50808-48ca-40d6-b5fa-d5050e082b7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad5d15d7-536f-4f07-8197-0937b50ebdf7', 6, NULL, '튈르리 궁전 (Tuileries)', 'Tuileries (Dispute d''enfants après jeux)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad5d15d7-536f-4f07-8197-0937b50ebdf7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:571aaa7c-c738-4d6d-8d08-1698f9d5cd93', 7, NULL, '비들로 (Bydło)', 'Bydło', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:571aaa7c-c738-4d6d-8d08-1698f9d5cd93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9761cf7-2ddd-4ad8-869d-c5b671b5e321', 8, NULL, '프롬나드', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9761cf7-2ddd-4ad8-869d-c5b671b5e321'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9054fc6b-c402-49ef-bc13-c16770c48996', 9, NULL, '껍질을 덜 깬 병아리들의 발레', 'Ballet of the Unhatched Chicks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9054fc6b-c402-49ef-bc13-c16770c48996'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6545185-503e-41e0-950b-00cca0dd8f27', 10, NULL, '사무엘 골덴베르크와 슈뮐레', '"Samuel" Goldenberg und "Schmuÿle"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6545185-503e-41e0-950b-00cca0dd8f27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5ac2337-c888-4fbf-a83d-d208c6ed70f2', 11, NULL, '프롬나드', 'Promenade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5ac2337-c888-4fbf-a83d-d208c6ed70f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a542068d-8f81-487b-891a-c28ac50a822d', 12, NULL, '리모주의 시장 (Limoges. Le marché)', 'Limoges. Le marché (La grande nouvelle)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a542068d-8f81-487b-891a-c28ac50a822d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dbf50aa-cafb-41af-b99d-8ab90ad6eef7', 13, NULL, '카타콤 – 죽은 이들과 함께 죽은 언어로', 'Catacombae (Sepulcrum romanum) – Cum mortuis in lingua mortua', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dbf50aa-cafb-41af-b99d-8ab90ad6eef7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d703c40-3c63-4944-9440-01c2bb6a034a', 14, NULL, '닭다리 위의 오두막 (바바 야가)', 'The Hut on Hen''s Legs (Baba Yaga)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d703c40-3c63-4944-9440-01c2bb6a034a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52dcff83-0ecc-4465-9b2c-a75a1bd71a1f', 15, NULL, '키예프의 대문', 'The Bogatyr Gates (In the Capital in Kiev)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 189 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52dcff83-0ecc-4465-9b2c-a75a1bd71a1f'
);


-- None <크림 남쪽 기슭에서> "아유다그의 구르주프"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<크림 남쪽 기슭에서> "아유다그의 구르주프"', 'On the Southern Shore of the Crimea "Gurzuf at Ayu-Dag"', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<크림 남쪽 기슭에서> "아유다그의 구르주프"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '914ffc68-f93c-4769-8d4e-2132df9471f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '914ffc68-f93c-4769-8d4e-2132df9471f5'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '<크림 남쪽 기슭에서> "아유다그의 구르주프"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '914ffc68-f93c-4769-8d4e-2132df9471f5'
);


-- None 카프리치오 <크림 남쪽 기슭 가까이> "바이다르키"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카프리치오 <크림 남쪽 기슭 가까이> "바이다르키"', 'Capriccio "Near the Southern Shore of the Crimea" (Baydarki)', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카프리치오 <크림 남쪽 기슭 가까이> "바이다르키"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22776860-20e7-43e8-9292-508ab205c03f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22776860-20e7-43e8-9292-508ab205c03f'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '카프리치오 <크림 남쪽 기슭 가까이> "바이다르키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22776860-20e7-43e8-9292-508ab205c03f'
);


-- None 명상 "앨범의 한 장"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '명상 "앨범의 한 장"', 'Méditation (Feuillet d''album)', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '명상 "앨범의 한 장"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9504c241-71e3-39c8-8ec5-15160efeede6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9504c241-71e3-39c8-8ec5-15160efeede6'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '명상 "앨범의 한 장"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9504c241-71e3-39c8-8ec5-15160efeede6'
);


-- None <눈물>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<눈물>', 'Une larme', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<눈물>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e9ce186-3786-49be-858d-58e7650200a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e9ce186-3786-49be-858d-58e7650200a0'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '<눈물>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e9ce186-3786-49be-858d-58e7650200a0'
);


-- None <시골에서> "환상곡풍으로"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<시골에서> "환상곡풍으로"', 'Au village (Quasi fantasia)', 'song', NULL, NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<시골에서> "환상곡풍으로"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f73f058-9e70-406f-90bd-b1f6266b35de'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f73f058-9e70-406f-90bd-b1f6266b35de'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '<시골에서> "환상곡풍으로"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f73f058-9e70-406f-90bd-b1f6266b35de'
);


-- None 합창곡 <센나케리브의 패배>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <센나케리브의 패배>', 'The Destruction of Sennacherib', 'song', NULL, NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <센나케리브의 패배>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74ed7820-c0d5-3085-bc15-c0d55d099979'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74ed7820-c0d5-3085-bc15-c0d55d099979'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '합창곡 <센나케리브의 패배>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74ed7820-c0d5-3085-bc15-c0d55d099979'
);


-- None 합창곡 <여호수아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <여호수아>', 'Iisus Navin (Joshua)', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <여호수아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0cf847e-a5fc-3986-b466-5df5173e1a45'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e0cf847e-a5fc-3986-b466-5df5173e1a45'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '합창곡 <여호수아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0cf847e-a5fc-3986-b466-5df5173e1a45'
);


-- None 가곡 <Gde ty, zvyozdochka?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gde ty, zvyozdochka?>', 'Gde ty, zvyozdochka? (Where Art Thou, Little Star?)', 'song', NULL, NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gde ty, zvyozdochka?>'
);


-- None 가곡 <Meines Herzens Sehnsucht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Meines Herzens Sehnsucht>', 'Meines Herzens Sehnsucht (Thou Longing of My Heart)', 'song', NULL, NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Meines Herzens Sehnsucht>'
);


-- None 가곡 <Otchego, skazhi, dusha-devitsa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Otchego, skazhi, dusha-devitsa>', 'Otchego, skazhi, dusha-devitsa (Tell Me Why, Fair Maiden)', 'song', NULL, NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Otchego, skazhi, dusha-devitsa>'
);


-- None 가곡 <Vesyolyy chas>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Vesyolyy chas>', 'Vesyolyy chas (The Joyous Hour)', 'song', NULL, NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Vesyolyy chas>'
);


-- None 가곡 <List'ya shumeli unylo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <List''ya shumeli unylo>', 'List''ya shumeli unylo (Leaves Rustled Sadly)', 'song', NULL, NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <List''ya shumeli unylo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f137dfea-3e18-41c7-926b-8371f7033dff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f137dfea-3e18-41c7-926b-8371f7033dff'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <List''ya shumeli unylo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f137dfea-3e18-41c7-926b-8371f7033dff'
);


-- None 가곡 <Chto vam slova lyubvi?>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Chto vam slova lyubvi?>', 'Chto vam slova lyubvi? (What Are Words of Love to You?)', 'song', NULL, NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Chto vam slova lyubvi?>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8443cd9a-4f5a-48ba-ac77-137fe4b59277'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8443cd9a-4f5a-48ba-ac77-137fe4b59277'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Chto vam slova lyubvi?>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8443cd9a-4f5a-48ba-ac77-137fe4b59277'
);


-- None 가곡 <Mnogo yest' u menya teremov i sadov>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mnogo yest'' u menya teremov i sadov>', 'Mnogo yest'' u menya teremov i sadov (Many Are My Palaces and Gardens)', 'song', NULL, NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mnogo yest'' u menya teremov i sadov>'
);


-- None 가곡 <Pesn' startsa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pesn'' startsa>', 'Pesn'' startsa (Old Man''s Song)', 'song', NULL, NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pesn'' startsa>'
);


-- None 가곡 <Tsar' Saul>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tsar'' Saul>', 'Tsar'' Saul (Tsar Saul)', 'song', NULL, NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tsar'' Saul>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '307421f3-6f8e-4dd1-85cf-2049df96f555'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '307421f3-6f8e-4dd1-85cf-2049df96f555'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Tsar'' Saul>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '307421f3-6f8e-4dd1-85cf-2049df96f555'
);


-- None 가곡 <No yesli by s toboyu ya vstretit'sya mogla>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <No yesli by s toboyu ya vstretit''sya mogla>', 'No yesli by s toboyu ya vstretit''sya mogla (But If I Could Meet Thee Again)', 'song', NULL, NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <No yesli by s toboyu ya vstretit''sya mogla>'
);


-- None 가곡 <Duyut vetry, vetry buynye>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Duyut vetry, vetry buynye>', 'Duyut vetry, vetry buynye (The Winds Blow, the Wild Winds)', 'song', NULL, NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Duyut vetry, vetry buynye>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9e6934a-2b25-41d0-ba8f-cb25114dec47'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9e6934a-2b25-41d0-ba8f-cb25114dec47'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Duyut vetry, vetry buynye>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9e6934a-2b25-41d0-ba8f-cb25114dec47'
);


-- None 가곡 <Kalistrat>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Kalistrat>', 'Kalistrat', 'song', NULL, NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Kalistrat>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11b6874c-f2e3-47f8-a8f3-daddf2f42690'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '11b6874c-f2e3-47f8-a8f3-daddf2f42690'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Kalistrat>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '11b6874c-f2e3-47f8-a8f3-daddf2f42690'
);


-- None 가곡 <Noch'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Noch''>', 'Noch'' (Night)', 'song', NULL, NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Noch''>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e26c1977-9b83-43bb-92a6-ecb167193979'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e26c1977-9b83-43bb-92a6-ecb167193979'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Noch''>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e26c1977-9b83-43bb-92a6-ecb167193979'
);


-- None 가곡 <Molitva>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Molitva>', 'Molitva (A Prayer)', 'song', NULL, NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Molitva>'
);


-- None 가곡 <Otverzhennaya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Otverzhennaya>', 'Otverzhennaya (The Outcast)', 'song', NULL, NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Otverzhennaya>'
);


-- None 가곡 <자장가> (오스트롭스키 시)

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30a84444-aa67-454e-ad37-f222b3590214'
FROM pieces p
WHERE p.id = 26045 AND p.composer_id = 43
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30a84444-aa67-454e-ad37-f222b3590214'
);


-- None 가곡 <Malyutka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Malyutka>', 'Malyutka (Little One)', 'song', NULL, NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Malyutka>'
);


-- None 가곡 <Zhelanie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Zhelanie>', 'Zhelanie (Desire)', 'song', NULL, NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Zhelanie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'baeede77-6ef1-4e52-b632-f8de1cb7484b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'baeede77-6ef1-4e52-b632-f8de1cb7484b'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Zhelanie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'baeede77-6ef1-4e52-b632-f8de1cb7484b'
);


-- None 가곡 <Iz slyoz moikh>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Iz slyoz moikh>', 'Iz slyoz moikh (From My Tears)', 'song', NULL, NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Iz slyoz moikh>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66f834e2-fd81-4bfc-bfaa-3788fbc1a7ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '66f834e2-fd81-4bfc-bfaa-3788fbc1a7ae'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Iz slyoz moikh>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66f834e2-fd81-4bfc-bfaa-3788fbc1a7ae'
);


-- None 가곡 <Svetik Savishna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Svetik Savishna>', 'Svetik Savishna (Darling Savishna)', 'song', NULL, NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Svetik Savishna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f87de07c-7fdb-481c-9dc3-8070f7190e25'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f87de07c-7fdb-481c-9dc3-8070f7190e25'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Svetik Savishna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f87de07c-7fdb-481c-9dc3-8070f7190e25'
);


-- None 가곡 <Akh ty, p'yanaya teterya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Akh ty, p''yanaya teterya>', 'Akh ty, p''yanaya teterya (Ah, You Drunken Sot)', 'song', NULL, NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Akh ty, p''yanaya teterya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64eeb2f4-f2e3-475b-905f-9589d5d3b1e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64eeb2f4-f2e3-475b-905f-9589d5d3b1e3'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Akh ty, p''yanaya teterya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64eeb2f4-f2e3-475b-905f-9589d5d3b1e3'
);


-- None 가곡 <Seminarist>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Seminarist>', 'Seminarist (The Seminarist)', 'song', NULL, NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Seminarist>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df601378-a391-46d8-b63d-227be39d3288'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df601378-a391-46d8-b63d-227be39d3288'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Seminarist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df601378-a391-46d8-b63d-227be39d3288'
);


-- None 가곡 <고파크>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <고파크>', 'Gopak', 'song', NULL, NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <고파크>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31e08f16-c63c-40e8-8a31-cdacd3a7e5f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31e08f16-c63c-40e8-8a31-cdacd3a7e5f6'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <고파크>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31e08f16-c63c-40e8-8a31-cdacd3a7e5f6'
);


-- None 가곡 <Na Dnepre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Na Dnepre>', 'Na Dnepre (On the Dnieper)', 'song', NULL, NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Na Dnepre>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08d093f0-8d05-4d36-a8ec-0a68e7fd49c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '08d093f0-8d05-4d36-a8ec-0a68e7fd49c4'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Na Dnepre>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '08d093f0-8d05-4d36-a8ec-0a68e7fd49c4'
);


-- None 가곡 <Yevreyskaya pesnya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Yevreyskaya pesnya>', 'Yevreyskaya pesnya (Hebrew Song)', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Yevreyskaya pesnya>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52f0e9d2-e4ec-4e59-b164-ac023a3156b5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '52f0e9d2-e4ec-4e59-b164-ac023a3156b5'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Yevreyskaya pesnya>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '52f0e9d2-e4ec-4e59-b164-ac023a3156b5'
);


-- None 가곡 <Strekotun'ya-beloboka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Strekotun''ya-beloboka>', 'Strekotun''ya-beloboka (Magpie Whitesides)', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Strekotun''ya-beloboka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7e02da6-2f6e-4fe0-871d-f5aa59431272'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7e02da6-2f6e-4fe0-871d-f5aa59431272'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Strekotun''ya-beloboka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7e02da6-2f6e-4fe0-871d-f5aa59431272'
);


-- None 가곡 <Po griby>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Po griby>', 'Po griby (Gathering Mushrooms)', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Po griby>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7853dcfd-416e-4b68-ae86-34d89e55df95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7853dcfd-416e-4b68-ae86-34d89e55df95'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Po griby>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7853dcfd-416e-4b68-ae86-34d89e55df95'
);


-- None 가곡 <Pirushka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pirushka>', 'Pirushka (The Banquet)', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pirushka>'
);


-- None 가곡 <Ozornik>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ozornik>', 'Ozornik (The Urchin)', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ozornik>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c0ff5cf-22b6-44cc-821e-4e1d23e4219d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c0ff5cf-22b6-44cc-821e-4e1d23e4219d'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Ozornik>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c0ff5cf-22b6-44cc-821e-4e1d23e4219d'
);


-- None 가곡 <Svetskaya skazochka (Kozyol)>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Svetskaya skazochka (Kozyol)>', 'Svetskaya skazochka (Kozyol) (A Society Tale (The Goat))', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Svetskaya skazochka (Kozyol)>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c813b135-4a8c-41ac-ad22-bd7983cc8e2f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c813b135-4a8c-41ac-ad22-bd7983cc8e2f'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Svetskaya skazochka (Kozyol)>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c813b135-4a8c-41ac-ad22-bd7983cc8e2f'
);


-- None 가곡 <Po-nad Donom sad tsvetyot>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Po-nad Donom sad tsvetyot>', 'Po-nad Donom sad tsvetyot (A Garden by the Don Blooms)', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Po-nad Donom sad tsvetyot>'
);


-- None 가곡 <Klassik>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Klassik>', 'Klassik (The Classicist)', 'song', NULL, NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Klassik>'
);


-- None 가곡 <Sirotka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sirotka>', 'Sirotka (The Orphan)', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sirotka>'
);


-- None 가곡 <Kolybel'naya Yeryomushki>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Kolybel''naya Yeryomushki>', 'Kolybel''naya Yeryomushki (Yeryomushka''s Lullaby)', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Kolybel''naya Yeryomushki>'
);


-- None 가곡 <Detskaya pesenka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Detskaya pesenka>', 'Detskaya pesenka (A Child''s Song)', 'song', NULL, NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Detskaya pesenka>'
);


-- None 연가곡집 <어린이 방>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <어린이 방>', 'The Nursery (Detskaya)', 'album', NULL, NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <어린이 방>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f49cc49-90b6-4a0a-8883-e56fa1890729'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f49cc49-90b6-4a0a-8883-e56fa1890729'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <어린이 방>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f49cc49-90b6-4a0a-8883-e56fa1890729'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66840173-238f-4dc1-a4df-9ebf17491b1a', 1, NULL, '유모와 함께 (S nyaney)', 'S nyaney', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <어린이 방>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66840173-238f-4dc1-a4df-9ebf17491b1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cbf4586a-9844-4185-898d-39a55d9d5598', 2, NULL, '구석에서 (V uglu)', 'V uglu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <어린이 방>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbf4586a-9844-4185-898d-39a55d9d5598'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c82a208-135d-477f-bebe-3e621f0e402a', 3, NULL, '풍뎅이 (Zhuk)', 'Zhuk', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <어린이 방>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c82a208-135d-477f-bebe-3e621f0e402a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:918328e0-68e0-4a8c-be15-de14d6f2ed5b', 4, NULL, '인형과 함께 (S kukloy)', 'S kukloy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <어린이 방>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:918328e0-68e0-4a8c-be15-de14d6f2ed5b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d13888af-604a-44a4-82b0-92c07795ace6', 5, NULL, '잠자리에서 (Na son gryadushchiy)', 'Na son gryadushchiy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <어린이 방>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d13888af-604a-44a4-82b0-92c07795ace6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8dfd69b-da2c-449a-abb6-4622303a5251', 6, NULL, '막대 말 타기 (Poekhal na palochke)', 'Poekhal na palochke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <어린이 방>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8dfd69b-da2c-449a-abb6-4622303a5251'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41ce8eab-1184-40af-846b-9449917e3630', 7, NULL, '고양이 마트로스 (Kot Matros)', 'Kot Matros', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <어린이 방>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41ce8eab-1184-40af-846b-9449917e3630'
);


-- None 가곡 <Rayok>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Rayok>', 'Rayok (The Peep-Show)', 'song', NULL, NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Rayok>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b480e1f-ee1d-4316-8f87-e05a4e95b46b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b480e1f-ee1d-4316-8f87-e05a4e95b46b'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Rayok>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b480e1f-ee1d-4316-8f87-e05a4e95b46b'
);


-- None 가곡 <Vechernyaya pesenka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Vechernyaya pesenka>', 'Vechernyaya pesenka (Evening Song)', 'song', NULL, NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Vechernyaya pesenka>'
);


-- None 연가곡집 <해 없이>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <해 없이>', 'Sunless (Bez solntsa)', 'album', NULL, NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <해 없이>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90c1226a-a24f-4b97-8b84-105e9b0efb0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90c1226a-a24f-4b97-8b84-105e9b0efb0b'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <해 없이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90c1226a-a24f-4b97-8b84-105e9b0efb0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cf4a2c2-405a-40d6-95ea-038f5ee34f3e', 1, NULL, 'V chetyryokh stenakh', 'V chetyryokh stenakh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <해 없이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cf4a2c2-405a-40d6-95ea-038f5ee34f3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1a456bb-6657-46d8-a917-22e05023d6ae', 2, NULL, 'Menya v tolpe ty ne uznala', 'Menya v tolpe ty ne uznala', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <해 없이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1a456bb-6657-46d8-a917-22e05023d6ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62c93ed6-66fa-4d4d-9009-9e6c6d817ed8', 3, NULL, 'Okonchen prazdnyy, shumnyy den''', 'Okonchen prazdnyy, shumnyy den''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <해 없이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62c93ed6-66fa-4d4d-9009-9e6c6d817ed8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80b737c9-dd9c-44f2-9cf6-0c1aad189098', 4, NULL, 'Skuchay', 'Skuchay', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <해 없이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80b737c9-dd9c-44f2-9cf6-0c1aad189098'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3f66827-93cd-4130-bf3d-52db8bb09b77', 5, NULL, 'Elegiya', 'Elegiya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <해 없이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3f66827-93cd-4130-bf3d-52db8bb09b77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2feb11f-5f58-4376-8c3b-f3b9e7ded996', 6, NULL, 'Nad rekoy', 'Nad rekoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <해 없이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2feb11f-5f58-4376-8c3b-f3b9e7ded996'
);


-- None 가곡 <Zabytyy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Zabytyy>', 'Zabytyy (Forgotten)', 'song', NULL, NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Zabytyy>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e191cf55-5e71-4db0-bf96-74d997e4dc91'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e191cf55-5e71-4db0-bf96-74d997e4dc91'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Zabytyy>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e191cf55-5e71-4db0-bf96-74d997e4dc91'
);


-- None 연가곡집 <죽음의 노래와 춤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <죽음의 노래와 춤>', 'Songs and Dances of Death', 'album', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <죽음의 노래와 춤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48be23ed-44f7-46fb-b703-e0e78447f460'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48be23ed-44f7-46fb-b703-e0e78447f460'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <죽음의 노래와 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48be23ed-44f7-46fb-b703-e0e78447f460'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0956ff3c-dc7f-4abb-912e-094698034c28', 1, NULL, '자장가 (Kolybel''naya)', 'Kolybel''naya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <죽음의 노래와 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0956ff3c-dc7f-4abb-912e-094698034c28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a2f2931-b089-41b5-b15d-580f3f58f1ca', 2, NULL, '세레나데 (Serenada)', 'Serenada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <죽음의 노래와 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a2f2931-b089-41b5-b15d-580f3f58f1ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d71c35de-74e1-4dca-9599-c7dba6f3e6f5', 3, NULL, '트레파크 (Trepak)', 'Trepak', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <죽음의 노래와 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d71c35de-74e1-4dca-9599-c7dba6f3e6f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b33301e-0232-45c3-8054-b37ff5de5489', 4, NULL, '사령관 (Polkovodets)', 'Polkovodets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '연가곡집 <죽음의 노래와 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b33301e-0232-45c3-8054-b37ff5de5489'
);


-- None 가곡 <Neponyatnaya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Neponyatnaya>', 'Neponyatnaya (The Misunderstood One)', 'song', NULL, NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Neponyatnaya>'
);


-- None 가곡 <Ne bozhiim gromom gore udarilo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ne bozhiim gromom gore udarilo>', 'Ne bozhiim gromom gore udarilo (Not Like Thunder from Heaven)', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ne bozhiim gromom gore udarilo>'
);


-- None 가곡 <Gornimi tikho letela dusha nebesami>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gornimi tikho letela dusha nebesami>', 'Gornimi tikho letela dusha nebesami (Softly the Spirit Flew up to Heaven)', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gornimi tikho letela dusha nebesami>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19fc82e9-8e58-460c-b4c5-d15fea60c704'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19fc82e9-8e58-460c-b4c5-d15fea60c704'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Gornimi tikho letela dusha nebesami>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19fc82e9-8e58-460c-b4c5-d15fea60c704'
);


-- None 가곡 <Oy, chest' li to molodtsu lyon pryasti>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Oy, chest'' li to molodtsu lyon pryasti>', 'Oy, chest'' li to molodtsu lyon pryasti (Is It an Honor for a Young Man to Weave Flax?)', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Oy, chest'' li to molodtsu lyon pryasti>'
);


-- None 가곡 <Rassevaetsya, rasstupaetsya>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Rassevaetsya, rasstupaetsya>', 'Rassevaetsya, rasstupaetsya (It Scatters and Breaks)', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Rassevaetsya, rasstupaetsya>'
);


-- None 가곡 <Videnie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Videnie>', 'Videnie (The Vision)', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Videnie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51188e2a-c16f-45d2-aaee-d335f6a432c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51188e2a-c16f-45d2-aaee-d335f6a432c3'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <Videnie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51188e2a-c16f-45d2-aaee-d335f6a432c3'
);


-- None 가곡 <Spes'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Spes''>', 'Spes'' (Pride)', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Spes''>'
);


-- None 가곡 <Strannik>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Strannik>', 'Strannik (The Wanderer)', 'song', NULL, NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Strannik>'
);


-- None 가곡 <벼룩의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <벼룩의 노래>', 'Pesnya Mefistofelya v pogrebke Auerbakha (Song of the Flea)', 'song', NULL, NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 43
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <벼룩의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed9ab2c1-2ed3-4c19-94cb-a72a5dc468d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed9ab2c1-2ed3-4c19-94cb-a72a5dc468d5'
FROM pieces p
WHERE p.composer_id = 43 AND p.title = '가곡 <벼룩의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed9ab2c1-2ed3-4c19-94cb-a72a5dc468d5'
);

