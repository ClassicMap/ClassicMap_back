-- 윤이상(composer_id 90) 작품 목록. 지금은 「심청」·첼로 협주곡·「예악」·연습곡 네 곡뿐이다.
-- 작품 95개를 더하고(장르별 오페라 3, 성악 13, 관현악 15, 교향곡 7, 협주곡 9, 실내악·앙상블·독주 44, 피아노·오르간 4),
-- 기존 첼로 협주곡(346)에는 MusicBrainz work 만 잇는다. 세트·다악장 작품 9개에 곡 42개, 장르·형식.
--
-- 작품은 국제윤이상협회 작품 목록(yun-gesellschaft.de/isang-yun-de/werke/)에서 손으로 골랐다. 연도는 그 목록의 작곡 연도
-- (1967/68 같은 범위는 끝 해), 우리말 제목은 한국어 위키백과 「윤이상」에 있는 것만 쓰고 없으면 원제를 <> 안에 둔다.
-- 다른 사람의 편곡·다른 판(가곡 기타·하프판, 두 플루트판 인벤션, 바순 모놀로그 등)과 짧은 소편성 몇 곡은 뺐다.
-- MusicBrainz 에 있는 31곡만 MBID 를 잇고 나머지는 식별자 없이 넣는다. 자료와 생성기:
--   seed_pipeline/curation/korean-composers-catalog-2026-11-12/(build.py, isang-yun/) → catalog-wave4 gen_catalog.py
-- 기존 작품의 제목·설명·링크·카드는 그대로 둔다. 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- 첼로 협주곡

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a21ddfa-ace6-40c8-8f48-d4404805a201'
FROM pieces p
WHERE p.id = 346 AND p.composer_id = 90
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a21ddfa-ace6-40c8-8f48-d4404805a201'
);


-- 오페라 <류퉁의 꿈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <류퉁의 꿈>', 'Opera <Der Traum des Liu-Tung>', 'song', NULL, NULL, NULL, 1965, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <류퉁의 꿈>'
);


-- 오페라 <나비의 미망인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <나비의 미망인>', 'Opera <Die Witwe des Schmetterlings>', 'song', NULL, NULL, NULL, 1968, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <나비의 미망인>'
);


-- 오페라 <요정의 사랑>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <요정의 사랑>', 'Opera <Geisterliebe>', 'song', NULL, NULL, NULL, 1970, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <요정의 사랑>'
);


-- 독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>', 'Om mani padme hum', 'album', NULL, NULL, NULL, 1964, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:1', 1, 'I', 'Lotosblüte', 'Lotosblüte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:2', 2, 'II', 'Gotamo, befragt', 'Gotamo, befragt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:3', 3, 'III', 'Durst', 'Durst', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:4', 4, 'IV', 'Entwerden', 'Entwerden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:5', 5, 'V', 'Zum Nirvana', 'Zum Nirvana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-om-mani-padme-hum:5'
);


-- 혼성 합창과 타악기를 위한 <나비의 꿈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창과 타악기를 위한 <나비의 꿈>', 'Ein Schmetterlingstraum', 'song', NULL, NULL, NULL, 1969, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창과 타악기를 위한 <나비의 꿈>'
);


-- 혼성 합창, 오르간과 타악기를 위한 <도에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창, 오르간과 타악기를 위한 <도에서>', 'Vom Tao', 'song', NULL, NULL, NULL, 1982, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창, 오르간과 타악기를 위한 <도에서>'
);


-- 바리톤, 여성 합창, 오르간과 악기를 위한 <An der Schwelle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바리톤, 여성 합창, 오르간과 악기를 위한 <An der Schwelle>', 'An der Schwelle', 'song', NULL, NULL, NULL, 1975, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바리톤, 여성 합창, 오르간과 악기를 위한 <An der Schwelle>'
);


-- 칸타타 <Der weise Mann>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Der weise Mann>', 'Cantata <Der weise Mann>', 'song', NULL, NULL, NULL, 1977, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Der weise Mann>'
);


-- 합창, 바이올린과 타악기를 위한 <O Licht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창, 바이올린과 타악기를 위한 <O Licht>', 'O Licht', 'song', NULL, NULL, NULL, 1981, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창, 바이올린과 타악기를 위한 <O Licht>'
);


-- 합창과 트롬본을 위한 <Der Herr ist mein Hirte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창과 트롬본을 위한 <Der Herr ist mein Hirte>', 'Der Herr ist mein Hirte', 'song', NULL, NULL, NULL, 1981, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창과 트롬본을 위한 <Der Herr ist mein Hirte>'
);


-- 칸타타 <나의 땅, 나의 민족이여>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <나의 땅, 나의 민족이여>', 'Cantata <My Land, My People!>', 'album', NULL, NULL, NULL, 1987, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <나의 땅, 나의 민족이여>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9c465b8-c47b-43dc-b3b6-428ab7bee768'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9c465b8-c47b-43dc-b3b6-428ab7bee768'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '칸타타 <나의 땅, 나의 민족이여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9c465b8-c47b-43dc-b3b6-428ab7bee768'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e3a6df1-a070-43ea-be15-83a4b5bd387f', 1, 'I', '역사', 'My Land, My People!: I. History', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '칸타타 <나의 땅, 나의 민족이여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e3a6df1-a070-43ea-be15-83a4b5bd387f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b5a336e-2f1e-42f3-a80c-ee7b65f655d7', 2, 'II', '현실 I', 'My Land, My People!: II. Presence I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '칸타타 <나의 땅, 나의 민족이여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b5a336e-2f1e-42f3-a80c-ee7b65f655d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69ce609f-e82f-43ca-96fe-46ff81d612b2', 3, 'III', '현실 II', 'My Land, My People!: III. Presence II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '칸타타 <나의 땅, 나의 민족이여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69ce609f-e82f-43ca-96fe-46ff81d612b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e487e8c-cb76-4ffe-b826-339646beaad9', 4, 'IV', '미래', 'My Land, My People!: IV. Future', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '칸타타 <나의 땅, 나의 민족이여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e487e8c-cb76-4ffe-b826-339646beaad9'
);


-- 5개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 가곡', 'Five Songs for High Voice and Piano', 'album', NULL, NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 가곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-fuenf-lieder:1', 1, NULL, '고풍의상', 'Kop''ung ŭisang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-fuenf-lieder:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-fuenf-lieder:2', 2, NULL, '달무리', 'Talmuri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-fuenf-lieder:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-fuenf-lieder:3', 3, NULL, '그네', 'Kŭne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-fuenf-lieder:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-fuenf-lieder:4', 4, NULL, '편지', 'P''yŏnji', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-fuenf-lieder:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-fuenf-lieder:5', 5, NULL, '나그네', 'Nagune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-fuenf-lieder:5'
);


-- 세 명의 소프라노와 관현악을 위한 <나모>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세 명의 소프라노와 관현악을 위한 <나모>', 'Namo', 'song', NULL, NULL, NULL, 1971, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세 명의 소프라노와 관현악을 위한 <나모>'
);


-- 목소리, 기타와 타악기를 위한 <가곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목소리, 기타와 타악기를 위한 <가곡>', 'Gagok', 'song', NULL, NULL, NULL, 1972, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목소리, 기타와 타악기를 위한 <가곡>'
);


-- 세 목소리와 타악기를 위한 <추억>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세 목소리와 타악기를 위한 <추억>', 'Memory', 'song', NULL, NULL, NULL, 1974, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세 목소리와 타악기를 위한 <추억>'
);


-- 소프라노와 실내 앙상블을 위한 <Teile dich Nacht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소프라노와 실내 앙상블을 위한 <Teile dich Nacht>', 'Teile dich Nacht', 'song', NULL, NULL, NULL, 1980, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소프라노와 실내 앙상블을 위한 <Teile dich Nacht>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '406a613b-12f3-49f8-8b36-2e4ea9f79013'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '406a613b-12f3-49f8-8b36-2e4ea9f79013'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '소프라노와 실내 앙상블을 위한 <Teile dich Nacht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '406a613b-12f3-49f8-8b36-2e4ea9f79013'
);


-- 관현악을 위한 <바라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <바라>', 'Bara', 'song', NULL, NULL, NULL, 1960, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <바라>'
);


-- 대관현악을 위한 <교향악적 정경>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관현악을 위한 <교향악적 정경>', 'Symphonische Szene', 'song', NULL, NULL, NULL, 1961, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관현악을 위한 <교향악적 정경>'
);


-- 현악 합주를 위한 <교착적 음향>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 합주를 위한 <교착적 음향>', 'Colloïdes sonores', 'song', NULL, NULL, NULL, 1961, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 합주를 위한 <교착적 음향>'
);


-- 관현악을 위한 <유동>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <유동>', 'Fluktuationen', 'song', NULL, NULL, NULL, 1964, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <유동>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b3b9292-000d-47dc-b2df-ba27ee214e3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b3b9292-000d-47dc-b2df-ba27ee214e3f'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '관현악을 위한 <유동>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b3b9292-000d-47dc-b2df-ba27ee214e3f'
);


-- 대관현악과 오르간을 위한 <차원>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관현악과 오르간을 위한 <차원>', 'Dimensionen', 'song', NULL, NULL, NULL, 1971, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관현악과 오르간을 위한 <차원>'
);


-- 소관현악을 위한 <협주적 음형들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소관현악을 위한 <협주적 음형들>', 'Konzertante Figuren', 'song', NULL, NULL, NULL, 1972, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소관현악을 위한 <협주적 음형들>'
);


-- 대관현악을 위한 <서곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관현악을 위한 <서곡>', 'Ouverture', 'song', NULL, NULL, NULL, 1973, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관현악을 위한 <서곡>'
);


-- 관악기, 하프와 타악기를 위한 <조화>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악기, 하프와 타악기를 위한 <조화>', 'Harmonia', 'song', NULL, NULL, NULL, 1974, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악기, 하프와 타악기를 위한 <조화>'
);


-- 대관현악을 위한 <무악>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관현악을 위한 <무악>', 'Muak', 'song', NULL, NULL, NULL, 1978, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관현악을 위한 <무악>'
);


-- 관현악을 위한 <서주와 추상>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <서주와 추상>', 'Fanfare & Memorial', 'song', NULL, NULL, NULL, 1979, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <서주와 추상>'
);


-- 교향시 <광주여 영원히>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <광주여 영원히>', 'Exemplum in memoriam Kwangju', 'song', NULL, NULL, NULL, 1981, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <광주여 영원히>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38b69d1a-17da-4e0b-9fdd-7679f1f07c1d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38b69d1a-17da-4e0b-9fdd-7679f1f07c1d'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향시 <광주여 영원히>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38b69d1a-17da-4e0b-9fdd-7679f1f07c1d'
);


-- 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번', 'Symphony No. 1', 'song', NULL, NULL, NULL, 1983, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번'
);


-- 교향곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번', 'Symphony No. 2', 'song', NULL, NULL, NULL, 1984, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67f3fed5-2466-400c-95f2-bd76a88b0a3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '67f3fed5-2466-400c-95f2-bd76a88b0a3e'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67f3fed5-2466-400c-95f2-bd76a88b0a3e'
);


-- 교향곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번', 'Symphony No. 3', 'song', NULL, NULL, NULL, 1985, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번'
);


-- 교향곡 4번 "어둠 속에서 노래하다"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 "어둠 속에서 노래하다"', 'Symphony No. 4 "Im Dunkeln singen"', 'song', NULL, NULL, NULL, 1986, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 "어둠 속에서 노래하다"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8dda6ae4-a76d-4d04-a53d-db6202d0226b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8dda6ae4-a76d-4d04-a53d-db6202d0226b'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향곡 4번 "어둠 속에서 노래하다"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8dda6ae4-a76d-4d04-a53d-db6202d0226b'
);


-- 교향곡 5번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 5번', 'Symphony No. 5', 'album', NULL, NULL, NULL, 1987, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 5번'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-symphony-5:1', 1, 'I', 'Erinnerung', 'Erinnerung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향곡 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-symphony-5:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-symphony-5:2', 2, 'II', 'Wir Geretteten – Ihr Zuschauenden 1', 'Wir Geretteten – Ihr Zuschauenden 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향곡 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-symphony-5:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-symphony-5:3', 3, 'III', 'Aufruf', 'Aufruf', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향곡 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-symphony-5:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-symphony-5:4', 4, 'IV', 'Wir Geretteten – Ihr Zuschauenden 2', 'Wir Geretteten – Ihr Zuschauenden 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향곡 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-symphony-5:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:isang-yun:isang-yun-symphony-5:5', 5, 'V', 'Frieden', 'Frieden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '교향곡 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:isang-yun:isang-yun-symphony-5:5'
);


-- 관악기, 타악기와 콘트라베이스를 위한 <무궁동>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악기, 타악기와 콘트라베이스를 위한 <무궁동>', 'Mugung-Dong', 'song', NULL, NULL, NULL, 1986, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악기, 타악기와 콘트라베이스를 위한 <무궁동>'
);


-- 현을 위한 <Tapis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현을 위한 <Tapis>', 'Tapis pour cordes', 'song', NULL, NULL, NULL, 1987, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현을 위한 <Tapis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b847a230-65b2-4044-ba0d-109acd536151'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b847a230-65b2-4044-ba0d-109acd536151'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현을 위한 <Tapis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b847a230-65b2-4044-ba0d-109acd536151'
);


-- 실내 교향곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 교향곡 1번', 'Chamber Symphony No. 1', 'song', NULL, NULL, NULL, 1987, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 교향곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b97dc3e5-d3a2-494e-9293-291b137a11f3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b97dc3e5-d3a2-494e-9293-291b137a11f3'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '실내 교향곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b97dc3e5-d3a2-494e-9293-291b137a11f3'
);


-- 실내 교향곡 2번 "Den Opfern der Freiheit"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 교향곡 2번 "Den Opfern der Freiheit"', 'Chamber Symphony No. 2 "Den Opfern der Freiheit"', 'song', NULL, NULL, NULL, 1989, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 교향곡 2번 "Den Opfern der Freiheit"'
);


-- 대관현악을 위한 <윤곽>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대관현악을 위한 <윤곽>', 'Konturen', 'song', NULL, NULL, NULL, 1989, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대관현악을 위한 <윤곽>'
);


-- 관현악을 위한 전설 <신라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 전설 <신라>', 'Silla', 'song', NULL, NULL, NULL, 1992, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 전설 <신라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd780a73-880a-4819-b701-205c64746996'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd780a73-880a-4819-b701-205c64746996'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '관현악을 위한 전설 <신라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd780a73-880a-4819-b701-205c64746996'
);


-- 관현악을 위한 메멘토 <화염에 휩싸인 천사>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 메멘토 <화염에 휩싸인 천사>', 'Engel in Flammen', 'song', NULL, NULL, NULL, 1994, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 메멘토 <화염에 휩싸인 천사>'
);


-- 플루트 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 협주곡', 'Flute Concerto', 'song', NULL, NULL, NULL, 1977, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 협주곡'
);


-- 오보에와 하프를 위한 이중 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에와 하프를 위한 이중 협주곡', 'Double Concerto for Oboe and Harp', 'song', NULL, NULL, NULL, 1977, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에와 하프를 위한 이중 협주곡'
);


-- 바이올린 협주곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 1번', 'Violin Concerto No. 1', 'song', NULL, NULL, NULL, 1981, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 1번'
);


-- 클라리넷 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 협주곡', 'Clarinet Concerto', 'song', NULL, NULL, NULL, 1981, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 협주곡'
);


-- 하프와 현을 위한 <공후>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프와 현을 위한 <공후>', 'Gong-Hu', 'song', NULL, NULL, NULL, 1984, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프와 현을 위한 <공후>'
);


-- 바이올린 협주곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 2번', 'Violin Concerto No. 2', 'song', NULL, NULL, NULL, 1986, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 2번'
);


-- 오보에, 첼로와 현을 위한 <Duetto concertante>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에, 첼로와 현을 위한 <Duetto concertante>', 'Duetto concertante', 'song', NULL, NULL, NULL, 1987, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에, 첼로와 현을 위한 <Duetto concertante>'
);


-- 오보에 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡', 'Oboe Concerto', 'song', NULL, NULL, NULL, 1990, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡'
);


-- 바이올린 협주곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 3번', 'Violin Concerto No. 3', 'song', NULL, NULL, NULL, 1992, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7ea8bc8-cd50-472c-a9b2-099874fec56e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e7ea8bc8-cd50-472c-a9b2-099874fec56e'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '바이올린 협주곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e7ea8bc8-cd50-472c-a9b2-099874fec56e'
);


-- 일곱 개의 악기를 위한 음악

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '일곱 개의 악기를 위한 음악', 'Music for Seven Instruments', 'song', NULL, NULL, NULL, 1959, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '일곱 개의 악기를 위한 음악'
);


-- 실내 앙상블을 위한 <로양>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 앙상블을 위한 <로양>', 'Loyang', 'song', NULL, NULL, NULL, 1962, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 앙상블을 위한 <로양>'
);


-- 실내 앙상블을 위한 <협주적 단편>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 앙상블을 위한 <협주적 단편>', 'Pièce concertante', 'song', NULL, NULL, NULL, 1976, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 앙상블을 위한 <협주적 단편>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6eac0ab-71f4-41bd-95ee-096a1f6d1548'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6eac0ab-71f4-41bd-95ee-096a1f6d1548'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '실내 앙상블을 위한 <협주적 단편>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6eac0ab-71f4-41bd-95ee-096a1f6d1548'
);


-- 8중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8중주', 'Octet', 'song', NULL, NULL, NULL, 1978, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8중주'
);


-- 관악 5중주와 현악 5중주를 위한 <거리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 5중주와 현악 5중주를 위한 <거리>', 'Distanzen', 'song', NULL, NULL, NULL, 1988, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 5중주와 현악 5중주를 위한 <거리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05fe4ca4-6047-446d-8748-87d517768fb0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05fe4ca4-6047-446d-8748-87d517768fb0'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '관악 5중주와 현악 5중주를 위한 <거리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05fe4ca4-6047-446d-8748-87d517768fb0'
);


-- 실내 협주곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 협주곡 1번', 'Chamber Concerto No. 1', 'song', NULL, NULL, NULL, 1990, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 협주곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b3f4eb8-24fc-4174-8121-3a017efded3d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b3f4eb8-24fc-4174-8121-3a017efded3d'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '실내 협주곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b3f4eb8-24fc-4174-8121-3a017efded3d'
);


-- 실내 협주곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 협주곡 2번', 'Chamber Concerto No. 2', 'song', NULL, NULL, NULL, 1990, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 협주곡 2번'
);


-- 아코디언과 현악 4중주를 위한 콘체르티노

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아코디언과 현악 4중주를 위한 콘체르티노', 'Concertino for Accordion and String Quartet', 'song', NULL, NULL, NULL, 1983, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아코디언과 현악 4중주를 위한 콘체르티노'
);


-- 클라리넷 5중주 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 5중주 1번', 'Clarinet Quintet No. 1', 'song', NULL, NULL, NULL, 1984, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 5중주 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09cc9ce5-e51a-4a37-b424-95dac40a7337'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09cc9ce5-e51a-4a37-b424-95dac40a7337'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '클라리넷 5중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09cc9ce5-e51a-4a37-b424-95dac40a7337'
);


-- 플루트 5중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 5중주', 'Flute Quintet', 'song', NULL, NULL, NULL, 1986, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 5중주'
);


-- 클라리넷 5중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 5중주 2번', 'Clarinet Quintet No. 2', 'song', NULL, NULL, NULL, 1994, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 5중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f49fb4c-4e4e-430b-8e70-1e91adc6fc1b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f49fb4c-4e4e-430b-8e70-1e91adc6fc1b'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '클라리넷 5중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f49fb4c-4e4e-430b-8e70-1e91adc6fc1b'
);


-- 현악 4중주 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번', 'String Quartet No. 1', 'album', NULL, NULL, NULL, 1955, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df2dd3d3-b2ee-4392-baa5-99d98508faa6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df2dd3d3-b2ee-4392-baa5-99d98508faa6'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df2dd3d3-b2ee-4392-baa5-99d98508faa6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:908c411f-2d9a-4551-8a28-e5c161638f68', 1, 'I', 'Allegro moderato', 'String Quartet no. 1: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:908c411f-2d9a-4551-8a28-e5c161638f68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7f842f9-5be7-4351-b10a-ef5bc0705e7e', 2, 'II', 'Andante phantastique', 'String Quartet no. 1: II. Andante phantastique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7f842f9-5be7-4351-b10a-ef5bc0705e7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e977ecc7-f456-41ea-8ee7-757b7b586c76', 3, 'III', 'Allegro giocosamente', 'String Quartet no. 1: III. Allegro giocosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e977ecc7-f456-41ea-8ee7-757b7b586c76'
);


-- 현악 4중주 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 3번', 'String Quartet No. 3', 'song', NULL, NULL, NULL, 1961, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 3번'
);


-- 플루트, 오보에, 바이올린과 첼로를 위한 <영상>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 오보에, 바이올린과 첼로를 위한 <영상>', 'Images', 'song', NULL, NULL, NULL, 1968, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 오보에, 바이올린과 첼로를 위한 <영상>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21f28b1b-0682-46b1-9acb-3ae8f9fbe84e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21f28b1b-0682-46b1-9acb-3ae8f9fbe84e'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '플루트, 오보에, 바이올린과 첼로를 위한 <영상>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21f28b1b-0682-46b1-9acb-3ae8f9fbe84e'
);


-- 플루트와 하프를 위한 <Novellette>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 하프를 위한 <Novellette>', 'Novellette', 'song', NULL, NULL, NULL, 1980, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 하프를 위한 <Novellette>'
);


-- 플루트, 바이올린, 첼로와 피아노를 위한 4중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 바이올린, 첼로와 피아노를 위한 4중주', 'Quartet for Flute, Violin, Cello and Piano', 'song', NULL, NULL, NULL, 1988, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 바이올린, 첼로와 피아노를 위한 4중주'
);


-- 현악 4중주 4번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 4번', 'String Quartet No. 4', 'song', NULL, NULL, NULL, 1988, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 4번'
);


-- 현악 4중주 5번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 5번', 'String Quartet No. 5', 'song', NULL, NULL, NULL, 1990, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 5번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3d7f5dc-cd3a-44d0-a07f-b20e75fdae22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b3d7f5dc-cd3a-44d0-a07f-b20e75fdae22'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 5번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3d7f5dc-cd3a-44d0-a07f-b20e75fdae22'
);


-- 현악 4중주 6번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 6번', 'String Quartet No. 6', 'album', NULL, NULL, NULL, 1992, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 6번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '850f058e-b3ed-4681-ba70-be09445ff35d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '850f058e-b3ed-4681-ba70-be09445ff35d'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '850f058e-b3ed-4681-ba70-be09445ff35d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25c8fc97-365e-4b70-9705-b73bd5734c65', 1, 'I', 'Pesante', 'String Quartet no. 6: I. Pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c8fc97-365e-4b70-9705-b73bd5734c65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c074bf2f-a83e-4def-a1d0-0b54ea1791b6', 2, 'II', 'Giocoso', 'String Quartet no. 6: II. Giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c074bf2f-a83e-4def-a1d0-0b54ea1791b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84736279-42fa-4691-805b-01101019b7c2', 3, 'III', 'Lamentoso', 'String Quartet no. 6: III. Lamentoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84736279-42fa-4691-805b-01101019b7c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af522760-7cf9-41af-b57c-0148a9bb8e9b', 4, 'IV', 'Animato', 'String Quartet no. 6: IV. Animato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '현악 4중주 6번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af522760-7cf9-41af-b57c-0148a9bb8e9b'
);


-- 오보에 4중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 4중주', 'Oboe Quartet', 'song', NULL, NULL, NULL, 1994, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 4중주'
);


-- 플루트, 오보에와 바이올린을 위한 3중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 오보에와 바이올린을 위한 3중주', 'Trio for Flute, Oboe and Violin', 'song', NULL, NULL, NULL, 1973, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 오보에와 바이올린을 위한 3중주'
);


-- 피아노 3중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주', 'Piano Trio', 'song', NULL, NULL, NULL, 1975, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주'
);


-- 오보에, 클라리넷과 바순을 위한 <론델>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에, 클라리넷과 바순을 위한 <론델>', 'Rondell', 'song', NULL, NULL, NULL, 1975, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에, 클라리넷과 바순을 위한 <론델>'
);


-- 오보에, 하프와 비올라를 위한 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에, 하프와 비올라를 위한 소나타', 'Sonata for Oboe, Harp and Viola', 'song', NULL, NULL, NULL, 1979, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에, 하프와 비올라를 위한 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be9d2b5b-0eb6-4c60-afd9-900e9dcbf164'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be9d2b5b-0eb6-4c60-afd9-900e9dcbf164'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '오보에, 하프와 비올라를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be9d2b5b-0eb6-4c60-afd9-900e9dcbf164'
);


-- 클라리넷, 하프와 첼로를 위한 <Rencontre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷, 하프와 첼로를 위한 <Rencontre>', 'Rencontre', 'song', NULL, NULL, NULL, 1986, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷, 하프와 첼로를 위한 <Rencontre>'
);


-- 바이올린과 피아노를 위한 <가사>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 <가사>', 'Gasa for Violin and Piano', 'song', NULL, NULL, NULL, 1963, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 <가사>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9207062-be11-44b0-a6f5-c1296e162db1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9207062-be11-44b0-a6f5-c1296e162db1'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '바이올린과 피아노를 위한 <가사>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9207062-be11-44b0-a6f5-c1296e162db1'
);


-- 플루트와 피아노를 위한 <가락>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 피아노를 위한 <가락>', 'Garak for Flute and Piano', 'song', NULL, NULL, NULL, 1963, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 피아노를 위한 <가락>'
);


-- 첼로와 피아노를 위한 <노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 피아노를 위한 <노래>', 'Nore for Cello and Piano', 'song', NULL, NULL, NULL, 1964, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 피아노를 위한 <노래>'
);


-- 클라리넷과 피아노를 위한 <율>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷과 피아노를 위한 <율>', 'Riul for Clarinet and Piano', 'song', NULL, NULL, NULL, 1968, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷과 피아노를 위한 <율>'
);


-- 비올라와 피아노를 위한 이중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라와 피아노를 위한 이중주', 'Duo for Viola and Piano', 'song', NULL, NULL, NULL, 1976, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라와 피아노를 위한 이중주'
);


-- 두 대의 비올라를 위한 <Contemplation>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 비올라를 위한 <Contemplation>', 'Contemplation', 'song', NULL, NULL, NULL, 1988, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 비올라를 위한 <Contemplation>'
);


-- 바이올린 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타', 'Violin Sonata', 'song', NULL, NULL, NULL, 1991, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타'
);


-- 첼로와 피아노를 위한 <Espace I>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 피아노를 위한 <Espace I>', 'Espace I', 'song', NULL, NULL, NULL, 1992, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 피아노를 위한 <Espace I>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65f85a16-c0a2-4162-8311-bfb1975ad774'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65f85a16-c0a2-4162-8311-bfb1975ad774'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로와 피아노를 위한 <Espace I>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65f85a16-c0a2-4162-8311-bfb1975ad774'
);


-- 피아노를 위한 <다섯 개의 소품>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노를 위한 <다섯 개의 소품>', 'Five Pieces for Piano', 'album', NULL, NULL, NULL, 1958, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노를 위한 <다섯 개의 소품>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1efde39-0623-4666-bfe3-7dc0880b2298'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1efde39-0623-4666-bfe3-7dc0880b2298'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '피아노를 위한 <다섯 개의 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1efde39-0623-4666-bfe3-7dc0880b2298'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3605200-130c-42fc-9208-630427380a89', 1, NULL, 'Adagio, grazioso', '5 Piano Pieces: No. 1. Adagio, grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '피아노를 위한 <다섯 개의 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3605200-130c-42fc-9208-630427380a89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99c0437c-5be6-4ea1-9a6a-d3ad887eedce', 2, NULL, 'Andantino, espressivo', '5 Piano Pieces: No. 2. Andantino, espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '피아노를 위한 <다섯 개의 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99c0437c-5be6-4ea1-9a6a-d3ad887eedce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e8d81d3-9d9b-4597-b03d-ae3e6d15b2f5', 3, NULL, 'Allegro moderato', '5 Piano Pieces: No. 3. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '피아노를 위한 <다섯 개의 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e8d81d3-9d9b-4597-b03d-ae3e6d15b2f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb44117c-29d4-41fd-871e-eb4f0003bbf0', 4, NULL, 'Allegro', '5 Piano Pieces: No. 4. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '피아노를 위한 <다섯 개의 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb44117c-29d4-41fd-871e-eb4f0003bbf0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51cd8e08-ac2d-495c-93b1-4361e8a03528', 5, NULL, 'Allegretto', '5 Piano Pieces: No. 5. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '피아노를 위한 <다섯 개의 소품>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51cd8e08-ac2d-495c-93b1-4361e8a03528'
);


-- 쳄발로를 위한 <소양음>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쳄발로를 위한 <소양음>', 'Shao Yang Yin', 'song', NULL, NULL, NULL, 1966, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쳄발로를 위한 <소양음>'
);


-- 오르간을 위한 <음관들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 <음관들>', 'Tuyaux sonores', 'song', NULL, NULL, NULL, 1967, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 <음관들>'
);


-- 첼로를 위한 <활주>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로를 위한 <활주>', 'Glissées', 'song', NULL, NULL, NULL, 1970, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로를 위한 <활주>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae7cc57d-b68d-4cf8-905c-ef15e77cdbb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae7cc57d-b68d-4cf8-905c-ef15e77cdbb7'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 <활주>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae7cc57d-b68d-4cf8-905c-ef15e77cdbb7'
);


-- 오보에를 위한 <피리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에를 위한 <피리>', 'Piri', 'song', NULL, NULL, NULL, 1971, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에를 위한 <피리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a082117-c391-48bf-994b-61b5f2634cad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a082117-c391-48bf-994b-61b5f2634cad'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '오보에를 위한 <피리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a082117-c391-48bf-994b-61b5f2634cad'
);


-- 바이올린을 위한 <대왕의 주제>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린을 위한 <대왕의 주제>', 'Königliches Thema', 'song', NULL, NULL, NULL, 1976, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린을 위한 <대왕의 주제>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b11a282b-256a-4211-b46e-6afc9671764e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b11a282b-256a-4211-b46e-6afc9671764e'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '바이올린을 위한 <대왕의 주제>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b11a282b-256a-4211-b46e-6afc9671764e'
);


-- 플루트를 위한 <살로모>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트를 위한 <살로모>', 'Salomo', 'song', NULL, NULL, NULL, 1978, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트를 위한 <살로모>'
);


-- 피아노를 위한 <Interludium A>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노를 위한 <Interludium A>', 'Interludium A', 'song', NULL, NULL, NULL, 1982, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노를 위한 <Interludium A>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8de2ce60-0c4a-4464-8f78-a35e0b0092eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8de2ce60-0c4a-4464-8f78-a35e0b0092eb'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '피아노를 위한 <Interludium A>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8de2ce60-0c4a-4464-8f78-a35e0b0092eb'
);


-- 바이올린을 위한 <Li-Na im Garten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린을 위한 <Li-Na im Garten>', 'Li-Na im Garten', 'song', NULL, NULL, NULL, 1985, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린을 위한 <Li-Na im Garten>'
);


-- 하프를 위한 <균형을 위하여>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프를 위한 <균형을 위하여>', 'In Balance', 'song', NULL, NULL, NULL, 1987, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프를 위한 <균형을 위하여>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dd1c3c2-63d0-41f5-8421-f39e48a806b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dd1c3c2-63d0-41f5-8421-f39e48a806b7'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '하프를 위한 <균형을 위하여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dd1c3c2-63d0-41f5-8421-f39e48a806b7'
);


-- 바이올린을 위한 <Kontraste>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린을 위한 <Kontraste>', 'Kontraste', 'song', NULL, NULL, NULL, 1987, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린을 위한 <Kontraste>'
);


-- 플루트를 위한 <소리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트를 위한 <소리>', 'Sori', 'song', NULL, NULL, NULL, 1988, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트를 위한 <소리>'
);


-- 첼로를 위한 7개의 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로를 위한 7개의 연습곡', 'Seven Etudes for Cello', 'album', NULL, NULL, NULL, 1993, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로를 위한 7개의 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4c07c49-cd8f-4139-bca8-eb95d42a9fc4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4c07c49-cd8f-4139-bca8-eb95d42a9fc4'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 7개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4c07c49-cd8f-4139-bca8-eb95d42a9fc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40262f76-9bcd-41b8-b0d5-9cbee2840223', 1, 'I', 'Legato', '7 Etüden: I. Legato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 7개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40262f76-9bcd-41b8-b0d5-9cbee2840223'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffc9995c-3b31-4327-ab39-e524f8680108', 2, 'II', 'Leggiero', '7 Etüden: II. Leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 7개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffc9995c-3b31-4327-ab39-e524f8680108'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b235223-964e-4d6d-9288-57796b4377d0', 3, 'III', 'Parlando', '7 Etüden: III. Parlando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 7개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b235223-964e-4d6d-9288-57796b4377d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab5279c4-9395-4946-b7ef-02a6c073c682', 4, 'IV', 'Burlesque', '7 Etüden: IV. Burlesque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 7개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab5279c4-9395-4946-b7ef-02a6c073c682'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf93a177-8680-4b2e-844f-3fd994be4ec9', 5, 'V', 'Dolce', '7 Etüden: V. Dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 7개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf93a177-8680-4b2e-844f-3fd994be4ec9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:effc6691-c2fb-4534-90b0-56ba4df26fbf', 6, 'VI', 'Triller', '7 Etüden: VI. Triller', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 7개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:effc6691-c2fb-4534-90b0-56ba4df26fbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e482addf-6f5a-4411-b35e-dc55ad875fc1', 7, 'VII', 'Doppelgriffe', '7 Etüden: VII. Doppelgriffe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '첼로를 위한 7개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e482addf-6f5a-4411-b35e-dc55ad875fc1'
);


-- 리코더를 위한 <중국의 그림>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리코더를 위한 <중국의 그림>', 'Chinesische Bilder', 'album', NULL, NULL, NULL, 1993, 'manual', 1
FROM composers c
WHERE c.id = 90
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리코더를 위한 <중국의 그림>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b2819fc-5e3f-4dc3-9e45-dca11c1292cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b2819fc-5e3f-4dc3-9e45-dca11c1292cb'
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '리코더를 위한 <중국의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b2819fc-5e3f-4dc3-9e45-dca11c1292cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41a83c78-a951-4a24-a126-3d32e3d26899', 1, 'I', 'The Visitor of the Idyll', 'Chinesische Bilder: I. The Visitor of the Idyll', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '리코더를 위한 <중국의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41a83c78-a951-4a24-a126-3d32e3d26899'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f293305-bb06-4144-a1ac-ada0f0ed6670', 2, 'II', 'The Hermit at the Water', 'Chinesische Bilder: II. The Hermit at the Water', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '리코더를 위한 <중국의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f293305-bb06-4144-a1ac-ada0f0ed6670'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77c08b79-dc8b-4055-8fdb-15034a512826', 3, 'III', 'The Actor with the Monkey', 'Chinesische Bilder: III. The Actor with the Monkey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '리코더를 위한 <중국의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77c08b79-dc8b-4055-8fdb-15034a512826'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1444ae29-a9a3-4080-a29a-86fbecc878b6', 4, 'IV', 'The Shepherd''s Flute', 'Chinesische Bilder: IV. The Shepherd''s Flute', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 90 AND p.title = '리코더를 위한 <중국의 그림>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1444ae29-a9a3-4080-a29a-86fbecc878b6'
);


-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 90 AND title = '오페라 <류퉁의 꿈>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 90 AND title = '오페라 <나비의 미망인>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 90 AND title = '오페라 <요정의 사랑>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 90 AND title = '독창, 합창과 관현악을 위한 <오 연꽃 속의 진주여>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 90 AND title = '혼성 합창과 타악기를 위한 <나비의 꿈>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 90 AND title = '혼성 합창, 오르간과 타악기를 위한 <도에서>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 90 AND title = '바리톤, 여성 합창, 오르간과 악기를 위한 <An der Schwelle>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 90 AND title = '칸타타 <Der weise Mann>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 90 AND title = '합창, 바이올린과 타악기를 위한 <O Licht>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'sacred'
WHERE composer_id = 90 AND title = '합창과 트롬본을 위한 <Der Herr ist mein Hirte>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 90 AND title = '칸타타 <나의 땅, 나의 민족이여>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 90 AND title = '5개의 가곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE composer_id = 90 AND title = '세 명의 소프라노와 관현악을 위한 <나모>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE composer_id = 90 AND title = '목소리, 기타와 타악기를 위한 <가곡>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE composer_id = 90 AND title = '세 목소리와 타악기를 위한 <추억>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 90 AND title = '소프라노와 실내 앙상블을 위한 <Teile dich Nacht>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '관현악을 위한 <바라>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '대관현악을 위한 <교향악적 정경>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '현악 합주를 위한 <교착적 음향>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '관현악을 위한 <유동>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '대관현악과 오르간을 위한 <차원>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '소관현악을 위한 <협주적 음형들>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'overture'
WHERE composer_id = 90 AND title = '대관현악을 위한 <서곡>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '관악기, 하프와 타악기를 위한 <조화>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '대관현악을 위한 <무악>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '관현악을 위한 <서주와 추상>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 90 AND title = '교향시 <광주여 영원히>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 90 AND title = '교향곡 1번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 90 AND title = '교향곡 2번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 90 AND title = '교향곡 3번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 90 AND title = '교향곡 4번 "어둠 속에서 노래하다"' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 90 AND title = '교향곡 5번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '관악기, 타악기와 콘트라베이스를 위한 <무궁동>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_ensemble'
WHERE composer_id = 90 AND title = '현을 위한 <Tapis>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 90 AND title = '실내 교향곡 1번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'symphony', form_key = 'symphony'
WHERE composer_id = 90 AND title = '실내 교향곡 2번 "Den Opfern der Freiheit"' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '대관현악을 위한 <윤곽>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 90 AND title = '관현악을 위한 전설 <신라>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 90 AND title = '관현악을 위한 메멘토 <화염에 휩싸인 천사>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 90 AND title = '플루트 협주곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 90 AND title = '오보에와 하프를 위한 이중 협주곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 90 AND title = '바이올린 협주곡 1번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 90 AND title = '클라리넷 협주곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'concertante'
WHERE composer_id = 90 AND title = '하프와 현을 위한 <공후>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 90 AND title = '바이올린 협주곡 2번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 90 AND title = '오보에, 첼로와 현을 위한 <Duetto concertante>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 90 AND title = '오보에 협주곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 90 AND title = '바이올린 협주곡 3번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '일곱 개의 악기를 위한 음악' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '실내 앙상블을 위한 <로양>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '실내 앙상블을 위한 <협주적 단편>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '8중주' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '관악 5중주와 현악 5중주를 위한 <거리>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '실내 협주곡 1번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '실내 협주곡 2번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '아코디언과 현악 4중주를 위한 콘체르티노' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE composer_id = 90 AND title = '클라리넷 5중주 1번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE composer_id = 90 AND title = '플루트 5중주' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE composer_id = 90 AND title = '클라리넷 5중주 2번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 90 AND title = '현악 4중주 1번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 90 AND title = '현악 4중주 3번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '플루트, 오보에, 바이올린과 첼로를 위한 <영상>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '플루트와 하프를 위한 <Novellette>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '플루트, 바이올린, 첼로와 피아노를 위한 4중주' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 90 AND title = '현악 4중주 4번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 90 AND title = '현악 4중주 5번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 90 AND title = '현악 4중주 6번' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '오보에 4중주' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '플루트, 오보에와 바이올린을 위한 3중주' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'piano_chamber'
WHERE composer_id = 90 AND title = '피아노 3중주' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE composer_id = 90 AND title = '오보에, 클라리넷과 바순을 위한 <론델>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '오보에, 하프와 비올라를 위한 소나타' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '클라리넷, 하프와 첼로를 위한 <Rencontre>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '바이올린과 피아노를 위한 <가사>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '플루트와 피아노를 위한 <가락>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '첼로와 피아노를 위한 <노래>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '클라리넷과 피아노를 위한 <율>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '비올라와 피아노를 위한 이중주' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '두 대의 비올라를 위한 <Contemplation>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'duo_sonata'
WHERE composer_id = 90 AND title = '바이올린 소나타' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 90 AND title = '첼로와 피아노를 위한 <Espace I>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE composer_id = 90 AND title = '피아노를 위한 <다섯 개의 소품>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE composer_id = 90 AND title = '쳄발로를 위한 <소양음>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE composer_id = 90 AND title = '오르간을 위한 <음관들>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '첼로를 위한 <활주>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '오보에를 위한 <피리>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '바이올린을 위한 <대왕의 주제>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '플루트를 위한 <살로모>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE composer_id = 90 AND title = '피아노를 위한 <Interludium A>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '바이올린을 위한 <Li-Na im Garten>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '하프를 위한 <균형을 위하여>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '바이올린을 위한 <Kontraste>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '플루트를 위한 <소리>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '첼로를 위한 7개의 연습곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 90 AND title = '리코더를 위한 <중국의 그림>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
