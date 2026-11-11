-- 홍난파(composer_id 89) 작품 목록. 지금은 「봉선화」·「고향의 봄」·바이올린 소품 하나뿐이다.
-- 작품 24개(가곡 9, 동요 10, 바이올린 소품 4, 관현악 조곡 1)를 더하고, 기존 「봉선화」(342)에는 MusicBrainz work 만 잇는다.
--
-- 근거는 한국민족문화대백과사전 곡·인물 항목, 위키문헌 『조선동요백곡집』 원본 전사(곡마다 작사·작곡 줄), 홍난파 가곡 논문(KCI).
-- 연도는 근거가 「작곡」으로 적은 것만 넣었다(「1932년경」은 1932). 발표·출판 연도이거나 근거끼리 엇갈리면 비웠다.
-- 「반달」(윤극영)·「나뭇잎 배」(윤용하)·「오빠 생각」(박태준) 같이 다른 사람 곡으로 널리 불리는 같은 제목 노래는 넣지 않았다.
-- 작품마다 근거 URL·작사: seed_pipeline/curation/korean-composers-catalog-2026-11-12/hong-nanpa/sources.jsonl
-- 기존 작품의 제목·설명·링크·카드는 그대로 둔다. 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- 가곡 <봉선화>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5980d2f3-fb0c-3275-a2d6-57e871874c00'
FROM pieces p
WHERE p.id = 342 AND p.composer_id = 89
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5980d2f3-fb0c-3275-a2d6-57e871874c00'
);


-- 가곡 <성불사의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <성불사의 밤>', 'Gagok <Night at Seongbulsa Temple (Seongbulsaui Bam)>', 'song', NULL, NULL, NULL, 1932, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <성불사의 밤>'
);


-- 가곡 <옛 동산에 올라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <옛 동산에 올라>', 'Gagok <Climbing the Old Hill (Yet Dongsane Olla)>', 'song', NULL, NULL, NULL, 1932, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <옛 동산에 올라>'
);


-- 가곡 <봄처녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <봄처녀>', 'Gagok <Spring Maiden (Bomcheonyeo)>', 'song', NULL, NULL, NULL, 1932, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <봄처녀>'
);


-- 가곡 <장안사>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <장안사>', 'Gagok <Jangansa Temple (Jangansa)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <장안사>'
);


-- 가곡 <금강에 살으리랏다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <금강에 살으리랏다>', 'Gagok <I Would Live in Geumgang (Geumgange Sareuriratda)>', 'song', NULL, NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <금강에 살으리랏다>'
);


-- 가곡 <사공의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <사공의 노래>', 'Gagok <The Boatman''s Song (Sagongui Norae)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <사공의 노래>'
);


-- 가곡 <그리움>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <그리움>', 'Gagok <Longing (Geurium)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <그리움>'
);


-- 가곡 <사랑>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <사랑>', 'Gagok <Love (Sarang)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <사랑>'
);


-- 가곡 <고향 생각>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <고향 생각>', 'Gagok <Thinking of Home (Gohyang Saenggak)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <고향 생각>'
);


-- 동요 <퐁당퐁당>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <퐁당퐁당>', 'Children''s Song <Plop, Plop (Pongdang Pongdang)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <퐁당퐁당>'
);


-- 동요 <낮에 나온 반달>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <낮에 나온 반달>', 'Children''s Song <Half Moon in the Daytime (Naje Naon Bandal)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <낮에 나온 반달>'
);


-- 동요 <달마중>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <달마중>', 'Children''s Song <Going Out to Meet the Moon (Dalmajung)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <달마중>'
);


-- 동요 <휘파람>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <휘파람>', 'Children''s Song <Whistle (Hwiparam)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <휘파람>'
);


-- 동요 <꿀돼지>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <꿀돼지>', 'Children''s Song <Greedy Piggy (Kkuldwaeji)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <꿀돼지>'
);


-- 동요 <종이배>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <종이배>', 'Children''s Song <Paper Boat (Jongibae)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <종이배>'
);


-- 동요 <나뭇잎>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <나뭇잎>', 'Children''s Song <Leaves (Namunnip)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <나뭇잎>'
);


-- 동요 <햇볕은 쨍쨍>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <햇볕은 쨍쨍>', 'Children''s Song <Bright Sunshine (Haetbyeoteun Jjaengjjaeng)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <햇볕은 쨍쨍>'
);


-- 동요 <개구리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <개구리>', 'Children''s Song <Frogs (Gaeguri)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <개구리>'
);


-- 동요 <무지개>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '동요 <무지개>', 'Children''s Song <Rainbow (Mujigae)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '동요 <무지개>'
);


-- 바이올린 소품 <애수의 조선>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소품 <애수의 조선>', 'Violin Piece <Melancholy of Joseon (Aesuui Joseon)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소품 <애수의 조선>'
);


-- 바이올린 소품 <로만스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소품 <로만스>', 'Violin Piece <Romance (Romanseu)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소품 <로만스>'
);


-- 바이올린 소품 <동양풍의 무곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소품 <동양풍의 무곡>', 'Violin Piece <Dance in Oriental Style (Dongyangpungui Mugok)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소품 <동양풍의 무곡>'
);


-- 바이올린 소품 <하야의 성군>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소품 <하야의 성군>', 'Violin Piece <Stars on a Summer Night (Hayaui Seonggun)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소품 <하야의 성군>'
);


-- 관현악 조곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악 조곡', 'Orchestral Suite', 'album', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 89
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악 조곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:hong-nanpa:hong-nanpa-orchestral-suite:1', 1, NULL, '즉흥곡', 'Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 89 AND p.title = '관현악 조곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:hong-nanpa:hong-nanpa-orchestral-suite:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:hong-nanpa:hong-nanpa-orchestral-suite:2', 2, NULL, '론도', 'Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 89 AND p.title = '관현악 조곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:hong-nanpa:hong-nanpa-orchestral-suite:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:hong-nanpa:hong-nanpa-orchestral-suite:3', 3, NULL, '동양풍의 무곡', 'Dance in Oriental Style', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 89 AND p.title = '관현악 조곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:hong-nanpa:hong-nanpa-orchestral-suite:3'
);


-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <성불사의 밤>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <옛 동산에 올라>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <봄처녀>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <장안사>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <금강에 살으리랏다>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <사공의 노래>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <그리움>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <사랑>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '가곡 <고향 생각>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <퐁당퐁당>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <낮에 나온 반달>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <달마중>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <휘파람>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <꿀돼지>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <종이배>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <나뭇잎>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <햇볕은 쨍쨍>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <개구리>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 89 AND title = '동요 <무지개>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 89 AND title = '바이올린 소품 <애수의 조선>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 89 AND title = '바이올린 소품 <로만스>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 89 AND title = '바이올린 소품 <동양풍의 무곡>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 89 AND title = '바이올린 소품 <하야의 성군>' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orch_suite'
WHERE composer_id = 89 AND title = '관현악 조곡' AND origin = 'manual' AND genre IS NULL AND form_key IS NULL;
