-- 김동진(composer_id 103) 작품 목록. 지금은 「가고파」·「목련화」·「내 마음은」·신포니에타·「신아리랑」 다섯 곡뿐이다.
-- 작품 21개(가곡 6, 신창악 가극 2, 칸타타 7, 관현악 4, 협주곡 2)를 더한다. 기존 작품은 건드리지 않는다.
--
-- 근거는 한국민족문화대백과사전 곡 항목과 예술로(한국문화예술위원회) 김동진 소개 보관본의 약력·작품 목록, 언론 기사.
-- 연도는 근거가 작곡 연도로 적은 것만 넣었다. 영화 주제가가 된 해일 수 있거나 여러 곡을 묶어 적은 연도는 비웠다.
-- 근거가 약하거나 엇갈리는 곡(「뱃노래」·「조국찬가」·「신 밀양아리랑」), 군가·영화음악은 넣지 않았다.
-- 작품마다 근거 URL·작사: seed_pipeline/curation/korean-composers-catalog-2026-11-12/kim-dongjin/sources.jsonl
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- 가곡 <봄이 오면>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <봄이 오면>', 'Gagok <When Spring Comes (Bomi Omyeon)>', 'song', NULL, NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <봄이 오면>'
);


-- 가곡 <가고파 (후편)>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <가고파 (후편)>', 'Gagok <Gagopa, Part 2 (Gagopa Hupyeon)>', 'song', NULL, NULL, NULL, 1973, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <가고파 (후편)>'
);


-- 가곡 <수선화>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <수선화>', 'Gagok <Narcissus (Suseonhwa)>', 'song', NULL, NULL, NULL, 1941, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <수선화>'
);


-- 가곡 <진달래꽃>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <진달래꽃>', 'Gagok <Azaleas (Jindallaekkot)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <진달래꽃>'
);


-- 가곡 <못잊어>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <못잊어>', 'Gagok <Unforgettable (Monnijeo)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <못잊어>'
);


-- 가곡 <저 구름 흘러가는 곳>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <저 구름 흘러가는 곳>', 'Gagok <Where the Clouds Drift (Jeo Gureum Heulleoganeun Got)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <저 구름 흘러가는 곳>'
);


-- 오페라 <심청전>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <심청전>', 'Opera <Simcheongjeon>', 'song', NULL, NULL, NULL, 1977, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <심청전>'
);


-- 오페라 <춘향전>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <춘향전>', 'Opera <Chunhyangjeon>', 'song', NULL, NULL, NULL, 1993, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <춘향전>'
);


-- 칸타타 <국군은 죽어서 말한다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <국군은 죽어서 말한다>', 'Cantata <The Fallen Soldiers Speak (Gukguneun Jugeoseo Malhanda)>', 'song', NULL, NULL, NULL, 1958, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <국군은 죽어서 말한다>'
);


-- 칸타타 <승리의 길>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <승리의 길>', 'Cantata <The Road to Victory (Seungniui Gil)>', 'song', NULL, NULL, NULL, 1958, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <승리의 길>'
);


-- 칸타타 <조국>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <조국>', 'Cantata <Fatherland (Joguk)>', 'album', NULL, NULL, NULL, 1961, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <조국>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:kim-dongjin:kim-dongjin-joguk:1', 1, NULL, '조국광복', 'Liberation of the Fatherland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 103 AND p.title = '칸타타 <조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:kim-dongjin:kim-dongjin-joguk:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:kim-dongjin:kim-dongjin-joguk:2', 2, NULL, '조국수난', 'Ordeal of the Fatherland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 103 AND p.title = '칸타타 <조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:kim-dongjin:kim-dongjin-joguk:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:kim-dongjin:kim-dongjin-joguk:3', 3, NULL, '조국재건', 'Rebuilding of the Fatherland', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 103 AND p.title = '칸타타 <조국>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:kim-dongjin:kim-dongjin-joguk:3'
);


-- 칸타타 <민족의 축원>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <민족의 축원>', 'Cantata <A Nation''s Blessing (Minjogui Chugwon)>', 'song', NULL, NULL, NULL, 1967, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <민족의 축원>'
);


-- 칸타타 <대학찬가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <대학찬가>', 'Cantata <University Hymn (Daehak Changa)>', 'song', NULL, NULL, NULL, 1969, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <대학찬가>'
);


-- 칸타타 <민족의 행진>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <민족의 행진>', 'Cantata <March of the Nation (Minjogui Haengjin)>', 'song', NULL, NULL, NULL, 1971, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <민족의 행진>'
);


-- 칸타타 <대학송가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <대학송가>', 'Cantata <University Ode (Daehak Songga)>', 'song', NULL, NULL, NULL, 1974, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <대학송가>'
);


-- 양산도를 주제로 한 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '양산도를 주제로 한 바이올린 협주곡', 'Violin Concerto on "Yangsando"', 'song', NULL, NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '양산도를 주제로 한 바이올린 협주곡'
);


-- 교향시 <만가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <만가>', 'Symphonic Poem <Dirge (Manga)>', 'song', NULL, NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <만가>'
);


-- 관현악을 위한 <제례악>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <제례악>', 'Jeryeak for Orchestra', 'song', NULL, NULL, NULL, 1943, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <제례악>'
);


-- 서곡 <양산가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <양산가>', 'Overture <Yangsanga>', 'song', NULL, NULL, NULL, 1943, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <양산가>'
);


-- 관현악을 위한 <동양적 조곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <동양적 조곡>', 'Oriental Suite for Orchestra', 'song', NULL, NULL, NULL, 1957, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <동양적 조곡>'
);


-- 가야금 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가야금 협주곡', 'Gayageum Concerto', 'song', NULL, NULL, NULL, 1959, 'manual', 1
FROM composers c
WHERE c.id = 103
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가야금 협주곡'
);


-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 103 AND title = '가곡 <봄이 오면>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 103 AND title = '가곡 <가고파 (후편)>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 103 AND title = '가곡 <수선화>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 103 AND title = '가곡 <진달래꽃>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 103 AND title = '가곡 <못잊어>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 103 AND title = '가곡 <저 구름 흘러가는 곳>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 103 AND title = '오페라 <심청전>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 103 AND title = '오페라 <춘향전>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 103 AND title = '칸타타 <국군은 죽어서 말한다>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 103 AND title = '칸타타 <승리의 길>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 103 AND title = '칸타타 <조국>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 103 AND title = '칸타타 <민족의 축원>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 103 AND title = '칸타타 <대학찬가>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 103 AND title = '칸타타 <민족의 행진>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'cantata'
WHERE composer_id = 103 AND title = '칸타타 <대학송가>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 103 AND title = '양산도를 주제로 한 바이올린 협주곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'symphonic_poem'
WHERE composer_id = 103 AND title = '교향시 <만가>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 103 AND title = '관현악을 위한 <제례악>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'overture'
WHERE composer_id = 103 AND title = '서곡 <양산가>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 103 AND title = '관현악을 위한 <동양적 조곡>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 103 AND title = '가야금 협주곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
