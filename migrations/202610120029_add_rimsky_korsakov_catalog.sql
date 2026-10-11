-- 림스키코르사코프 작품을 출판 단위로 채운다(카탈로그: Op.). 작품 95개(묶음 31, 다악장 13, 낱곡 51),
-- 새 작품 92개, 기존 작품 3개, part 165개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   작품번호 없는 오페라 발췌 모음곡과 합작 기고곡은 뺀다. 가곡·합창 곡 이름은 이탈리아어 위키백과로 채운다.
--   203 「왕벌의 비행」은 그대로 두고 오페라는 따로 넣는다.
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

-- None 오페라 <프스코프의 처녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <프스코프의 처녀>', 'The Maid of Pskov', 'song', NULL, NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <프스코프의 처녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3544a7c5-693a-4fe1-855b-acf23870d4d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3544a7c5-693a-4fe1-855b-acf23870d4d5'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <프스코프의 처녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3544a7c5-693a-4fe1-855b-acf23870d4d5'
);


-- None 오페라 <5월의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <5월의 밤>', 'May Night', 'song', NULL, NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <5월의 밤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b81a07e-8c67-4b35-94fa-625d6474f2f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b81a07e-8c67-4b35-94fa-625d6474f2f5'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <5월의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b81a07e-8c67-4b35-94fa-625d6474f2f5'
);


-- None 오페라 <눈 아가씨>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <눈 아가씨>', 'The Snow Maiden (Snegurochka)', 'song', NULL, NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <눈 아가씨>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4912294f-f827-4b1b-8097-65af3939dd77'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4912294f-f827-4b1b-8097-65af3939dd77'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <눈 아가씨>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4912294f-f827-4b1b-8097-65af3939dd77'
);


-- None 오페라-발레 <믈라다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라-발레 <믈라다>', 'Mlada', 'song', NULL, NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라-발레 <믈라다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc1de53b-fb02-4f74-8cd9-7236a0114e38'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc1de53b-fb02-4f74-8cd9-7236a0114e38'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라-발레 <믈라다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc1de53b-fb02-4f74-8cd9-7236a0114e38'
);


-- None 오페라 <크리스마스 이브>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <크리스마스 이브>', 'Christmas Eve', 'song', NULL, NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <크리스마스 이브>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de055d05-c7e0-42db-b18b-189909d796b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de055d05-c7e0-42db-b18b-189909d796b2'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <크리스마스 이브>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de055d05-c7e0-42db-b18b-189909d796b2'
);


-- None 오페라 <사드코>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <사드코>', 'Sadko', 'song', NULL, NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <사드코>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9288ebd0-8fd8-4412-b67e-40268805d30e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9288ebd0-8fd8-4412-b67e-40268805d30e'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <사드코>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9288ebd0-8fd8-4412-b67e-40268805d30e'
);


-- Op. 48 오페라 <모차르트와 살리에리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <모차르트와 살리에리>', 'Mozart and Salieri', 'song', 'Op. 48', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <모차르트와 살리에리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2819dba7-d742-4dbf-b919-45098c1e6fb1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2819dba7-d742-4dbf-b919-45098c1e6fb1'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <모차르트와 살리에리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2819dba7-d742-4dbf-b919-45098c1e6fb1'
);


-- Op. 54 오페라 <귀족 부인 베라 셸로가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <귀족 부인 베라 셸로가>', 'The Noblewoman Vera Sheloga', 'song', 'Op. 54', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <귀족 부인 베라 셸로가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfd79e39-cd09-41f4-9ccc-47711e40c2c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cfd79e39-cd09-41f4-9ccc-47711e40c2c2'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <귀족 부인 베라 셸로가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cfd79e39-cd09-41f4-9ccc-47711e40c2c2'
);


-- None 오페라 <차르의 신부>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <차르의 신부>', 'The Tsar''s Bride', 'song', NULL, NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <차르의 신부>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72ba4133-9e8f-46b5-8337-9f3ba2b76dbc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72ba4133-9e8f-46b5-8337-9f3ba2b76dbc'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <차르의 신부>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72ba4133-9e8f-46b5-8337-9f3ba2b76dbc'
);


-- None 오페라 <술탄 황제의 이야기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <술탄 황제의 이야기>', 'The Tale of Tsar Saltan', 'song', NULL, NULL, NULL, 1900, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <술탄 황제의 이야기>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82d6a244-b1a1-4074-9eb2-14a61a441d95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82d6a244-b1a1-4074-9eb2-14a61a441d95'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <술탄 황제의 이야기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82d6a244-b1a1-4074-9eb2-14a61a441d95'
);


-- None 오페라 <세르빌리아>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <세르빌리아>', 'Servilia', 'song', NULL, NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <세르빌리아>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb36fa4a-89ab-4cde-b463-39b54321eb88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb36fa4a-89ab-4cde-b463-39b54321eb88'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <세르빌리아>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb36fa4a-89ab-4cde-b463-39b54321eb88'
);


-- None 오페라 <불사신 카셰이>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <불사신 카셰이>', 'Kashchey the Immortal', 'song', NULL, NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <불사신 카셰이>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8cd47a0-e687-4504-bd40-e73f625b9513'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8cd47a0-e687-4504-bd40-e73f625b9513'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <불사신 카셰이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8cd47a0-e687-4504-bd40-e73f625b9513'
);


-- None 오페라 <판 보예보다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <판 보예보다>', 'Pan Voyevoda', 'song', NULL, NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <판 보예보다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3766078e-e8bb-4ae7-bfd4-c599215630aa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3766078e-e8bb-4ae7-bfd4-c599215630aa'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <판 보예보다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3766078e-e8bb-4ae7-bfd4-c599215630aa'
);


-- None 오페라 <보이지 않는 도시 키테즈와 처녀 페브로니야의 전설>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <보이지 않는 도시 키테즈와 처녀 페브로니야의 전설>', 'The Legend of the Invisible City of Kitezh and the Maiden Fevroniya', 'song', NULL, NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <보이지 않는 도시 키테즈와 처녀 페브로니야의 전설>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5596c757-c555-41e7-939e-1632fab668a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5596c757-c555-41e7-939e-1632fab668a3'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <보이지 않는 도시 키테즈와 처녀 페브로니야의 전설>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5596c757-c555-41e7-939e-1632fab668a3'
);


-- None 오페라 <금계>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <금계>', 'The Golden Cockerel', 'song', NULL, NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <금계>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbb8db0e-2ba8-455c-aebe-630f9d39f5cb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dbb8db0e-2ba8-455c-aebe-630f9d39f5cb'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '오페라 <금계>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbb8db0e-2ba8-455c-aebe-630f9d39f5cb'
);


-- None 합창곡 <Tebe Boga khvalim>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Tebe Boga khvalim>', 'Tebe Boga khvalim (Thee, O God, We Praise)', 'song', NULL, NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Tebe Boga khvalim>'
);


-- Op. 22 성 요한 크리소스토모스 전례 성가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성 요한 크리소스토모스 전례 성가', 'Four-Voice Compositions from the Liturgy of St. John Chrysostom', 'song', 'Op. 22', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성 요한 크리소스토모스 전례 성가'
);


-- Op. 13 2개의 합창곡 Op. 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 합창곡 Op. 13', '2 Choruses, Op. 13', 'album', NULL, 'Op.', '13', 1874, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 합창곡 Op. 13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op13:1', 1, NULL, 'Tuchki nebesnye', 'Tuchki nebesnye', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 합창곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op13:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op13:2', 2, NULL, 'Nochevala tuchka zolotaya', 'Nochevala tuchka zolotaya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 합창곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op13:2'
);


-- Op. 14 러시아 민요 "Nadoeli nochi" 주제에 의한 4개의 변주와 푸게타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '러시아 민요 "Nadoeli nochi" 주제에 의한 4개의 변주와 푸게타', 'Four Variations and a Fughetta on a Russian Folksong "Nadoeli nochi"', 'song', 'Op. 14', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '러시아 민요 "Nadoeli nochi" 주제에 의한 4개의 변주와 푸게타'
);


-- Op. 16 6개의 합창곡 Op. 16

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 합창곡 Op. 16', '6 Choruses, Op. 16', 'album', NULL, 'Op.', '16', 1876, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 합창곡 Op. 16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:1', 1, NULL, 'Na severe dikom', 'Na severe dikom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 합창곡 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:2', 2, NULL, 'Vakkhicheskaya pesn''', 'Vakkhicheskaya pesn''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 합창곡 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:3', 3, NULL, 'Staraya pesn''', 'Staraya pesn''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 합창곡 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:4', 4, NULL, 'Mesyats plyvyot i tikh i spokoen', 'Mesyats plyvyot i tikh i spokoen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 합창곡 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:5', 5, NULL, 'Poslednyaya tucha rasseyannoy buri', 'Poslednyaya tucha rasseyannoy buri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 합창곡 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:6', 6, NULL, 'Molitva', 'Molitva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 합창곡 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op16:6'
);


-- Op. 18 2개의 합창곡 Op. 18

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 합창곡 Op. 18', '2 Choruses, Op. 18', 'album', NULL, 'Op.', '18', 1876, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 합창곡 Op. 18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op18:1', 1, NULL, 'Pred raspyat''em (믹솔리디아 선법 푸가)', 'Pred raspyat''em', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op18:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op18:2', 2, NULL, 'Tatarskiy polon (믹솔리디아 선법 러시아 주제 변주)', 'Tatarskiy polon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 합창곡 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op18:2'
);


-- Op. 23 4개의 합창곡 Op. 23

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 합창곡 Op. 23', '4 Choruses, Op. 23', 'album', NULL, 'Op.', '23', 1876, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 합창곡 Op. 23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op23:1', 1, NULL, 'Krest''yanskaya pirushka', 'Krest''yanskaya pirushka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op23:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op23:2', 2, NULL, 'Voron k voronu letit', 'Voron k voronu letit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op23:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op23:3', 3, NULL, 'Plenivshis'' rozoy, solovey', 'Plenivshis'' rozoy, solovey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op23:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op23:4', 4, NULL, 'Dayte bokaly', 'Dayte bokaly', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 합창곡 Op. 23' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op23:4'
);


-- Op. 20 <하느님의 사람 알렉세이에 관한 시>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<하느님의 사람 알렉세이에 관한 시>', 'Poem about Alexei, Man of God', 'song', 'Op. 20', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<하느님의 사람 알렉세이에 관한 시>'
);


-- Op. 21 합창곡 <Slava>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창곡 <Slava>', 'Slava (Glory)', 'song', 'Op. 21', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창곡 <Slava>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a23a8ba7-3f2f-4aca-bba3-6dcf6328b78b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a23a8ba7-3f2f-4aca-bba3-6dcf6328b78b'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '합창곡 <Slava>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a23a8ba7-3f2f-4aca-bba3-6dcf6328b78b'
);


-- Op. 44 칸타타 <스비테지안카>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <스비테지안카>', 'Switezianka', 'song', 'Op. 44', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <스비테지안카>'
);


-- Op. 58 칸타타 <현자 올레그의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <현자 올레그의 노래>', 'Song of Oleg the Wise', 'song', 'Op. 58', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <현자 올레그의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '975e0aa3-5362-44d8-a6e5-29f578c9686a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '975e0aa3-5362-44d8-a6e5-29f578c9686a'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '칸타타 <현자 올레그의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '975e0aa3-5362-44d8-a6e5-29f578c9686a'
);


-- Op. 60 전주곡-칸타타 <호메로스에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡-칸타타 <호메로스에서>', 'From Homer, Prelude-Cantata', 'song', 'Op. 60', NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡-칸타타 <호메로스에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6b0d9da-4af0-4823-90e5-bd32605b28c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b6b0d9da-4af0-4823-90e5-bd32605b28c2'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '전주곡-칸타타 <호메로스에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6b0d9da-4af0-4823-90e5-bd32605b28c2'
);


-- Op. 1 교향곡 1번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 E단조', 'Symphony No. 1 in E minor', 'album', 'Op. 1', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f90e694-abd2-4b55-8939-91a56d51c34a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f90e694-abd2-4b55-8939-91a56d51c34a'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f90e694-abd2-4b55-8939-91a56d51c34a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd33dd03-cf84-3213-8474-fc781a8229d7', 1, 'I', 'Largo assai – Allegro', 'I. Largo assai – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd33dd03-cf84-3213-8474-fc781a8229d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:851823b7-2989-3588-ab78-3a592933cf83', 2, 'II', 'Andante tranquillo', 'II. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:851823b7-2989-3588-ab78-3a592933cf83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b7f2ef4-3258-3f47-81b1-68250fa7b5f5', 3, 'III', '스케르초. Vivace', 'III. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b7f2ef4-3258-3f47-81b1-68250fa7b5f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bc76658-c14e-3366-b114-6dcd1df8058f', 4, 'IV', 'Allegro assai', 'IV. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 1번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bc76658-c14e-3366-b114-6dcd1df8058f'
);


-- Op. 28 3개의 러시아 주제에 의한 서곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 러시아 주제에 의한 서곡 D장조', 'Overture on Three Russian Themes in D major', 'song', 'Op. 28', NULL, NULL, 1866, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 러시아 주제에 의한 서곡 D장조'
);


-- Op. 6 세르비아 주제에 의한 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세르비아 주제에 의한 환상곡', 'Fantasy on Serbian Themes', 'song', 'Op. 6', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세르비아 주제에 의한 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7bbc3b6-e54e-4224-91f5-90dda14e490a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7bbc3b6-e54e-4224-91f5-90dda14e490a'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '세르비아 주제에 의한 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7bbc3b6-e54e-4224-91f5-90dda14e490a'
);


-- Op. 5 교향적 그림 <사드코>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 그림 <사드코>', 'Sadko, Musical Tableau', 'song', 'Op. 5', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 그림 <사드코>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8911d02b-b51e-3c43-86d2-cff2ad712cf9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8911d02b-b51e-3c43-86d2-cff2ad712cf9'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향적 그림 <사드코>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8911d02b-b51e-3c43-86d2-cff2ad712cf9'
);


-- Op. 9 교향 모음곡 <안타르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향 모음곡 <안타르>', 'Antar, Symphonic Suite', 'album', 'Op. 9', NULL, NULL, 1868, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향 모음곡 <안타르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8d81677-e331-4cbb-a7c2-2afb9f367881'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8d81677-e331-4cbb-a7c2-2afb9f367881'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향 모음곡 <안타르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8d81677-e331-4cbb-a7c2-2afb9f367881'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd2387f0-52ce-39d3-9df1-571fa1fd8e60', 1, 'I', 'Largo – Allegro giocoso', 'I. Largo – Allegro giocoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향 모음곡 <안타르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd2387f0-52ce-39d3-9df1-571fa1fd8e60'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75e95f20-06e4-3ac6-9fed-6f4c0a11d21e', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향 모음곡 <안타르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75e95f20-06e4-3ac6-9fed-6f4c0a11d21e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66d44f88-dd55-39ed-9217-79319ecd8603', 3, 'III', 'Allegro risoluto alla marcia', 'III. Allegro risoluto alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향 모음곡 <안타르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66d44f88-dd55-39ed-9217-79319ecd8603'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f63ed548-2e47-38d8-8f66-eabdff214e12', 4, 'IV', 'Allegretto vivace – Andante amoroso', 'IV. Allegretto vivace – Andante amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향 모음곡 <안타르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f63ed548-2e47-38d8-8f66-eabdff214e12'
);


-- Op. 32 교향곡 3번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 3번 C장조', 'Symphony No. 3 in C major', 'album', 'Op. 32', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 3번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9b9dcf5-6934-4d44-b172-4808c32f1570'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b9b9dcf5-6934-4d44-b172-4808c32f1570'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9b9dcf5-6934-4d44-b172-4808c32f1570'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cbd3588-c7b3-4ce0-847a-2a9c88075363', 1, 'I', 'Moderato assai – Allegro', 'I. Moderato assai – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cbd3588-c7b3-4ce0-847a-2a9c88075363'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecf48108-6918-490a-a095-cd63e67120ca', 2, 'II', '스케르초. Vivo', 'II. Scherzo. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecf48108-6918-490a-a095-cd63e67120ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:781c1b3e-2458-4f89-b50d-4723aee3c427', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:781c1b3e-2458-4f89-b50d-4723aee3c427'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:138ac54b-31d8-4f57-8aca-3834b5792d92', 4, 'IV', 'Allegro con spirito', 'IV. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:138ac54b-31d8-4f57-8aca-3834b5792d92'
);


-- None 부수음악 <프스코프의 처녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <프스코프의 처녀>', 'The Maid of Pskov, Overture and Entr''actes for Mei''s Drama', 'song', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <프스코프의 처녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b12ebce-13ea-4339-9134-ce9c06a067de'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b12ebce-13ea-4339-9134-ce9c06a067de'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '부수음악 <프스코프의 처녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b12ebce-13ea-4339-9134-ce9c06a067de'
);


-- Op. 29 교향시 <동화>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <동화>', 'Fairy Tale (Skazka)', 'song', 'Op. 29', NULL, NULL, 1880, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <동화>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6de7da62-eb08-31a8-b8d4-44b81d2a2f2a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6de7da62-eb08-31a8-b8d4-44b81d2a2f2a'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '교향시 <동화>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6de7da62-eb08-31a8-b8d4-44b81d2a2f2a'
);


-- Op. 31 러시아 주제에 의한 신포니에타 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '러시아 주제에 의한 신포니에타 A단조', 'Sinfonietta on Russian Themes in A minor', 'album', 'Op. 31', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '러시아 주제에 의한 신포니에타 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61e00b12-91bb-4af8-b180-750523f57951'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61e00b12-91bb-4af8-b180-750523f57951'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '러시아 주제에 의한 신포니에타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61e00b12-91bb-4af8-b180-750523f57951'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1be8cf66-657f-4fb7-a0a9-3b1040b8bff3', 1, 'I', 'Allegretto pastorale', 'I. Allegretto pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '러시아 주제에 의한 신포니에타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1be8cf66-657f-4fb7-a0a9-3b1040b8bff3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:204d5c2a-13a0-4b31-8ca8-78798f7bae7b', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '러시아 주제에 의한 신포니에타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:204d5c2a-13a0-4b31-8ca8-78798f7bae7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e694f32-9579-4920-8c94-c5aceb35c844', 3, 'III', '스케르초-피날레', 'III. Scherzo-Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '러시아 주제에 의한 신포니에타 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e694f32-9579-4920-8c94-c5aceb35c844'
);


-- Op. 34 스페인 기상곡

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:247529fc-66fb-38f1-bfcb-61ddc68db52f', 1, 'I', 'Alborada', 'I. Alborada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 204 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:247529fc-66fb-38f1-bfcb-61ddc68db52f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6034832-e2e4-3f68-ae13-9518b3c38196', 2, 'II', '변주곡 (Variazioni)', 'II. Variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 204 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6034832-e2e4-3f68-ae13-9518b3c38196'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d6bb846-947d-37e0-8bbb-4246a8963485', 3, 'III', 'Alborada', 'III. Alborada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 204 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d6bb846-947d-37e0-8bbb-4246a8963485'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b75caa4-a914-3c01-b6ad-119bc002939c', 4, 'IV', 'Scena e canto gitano', 'IV. Scena e canto gitano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 204 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b75caa4-a914-3c01-b6ad-119bc002939c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8973b8f5-f673-3b3a-9129-d1df1960cbdd', 5, 'V', 'Fandango asturiano', 'V. Fandango asturiano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 204 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8973b8f5-f673-3b3a-9129-d1df1960cbdd'
);


-- Op. 35 교향시 <셰헤라자데>

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b276317a-8b7c-3254-beed-0727860d5d1f', 1, 'I', '바다와 신드바드의 배', 'I. The Sea and Sinbad''s Ship', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 202 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b276317a-8b7c-3254-beed-0727860d5d1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:826226e0-2404-302e-8127-fee79c95be50', 2, 'II', '칼렌다르 왕자 이야기', 'II. The Story of the Kalendar Prince', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 202 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:826226e0-2404-302e-8127-fee79c95be50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d87afcfe-781b-357e-8224-ebafcba2d335', 3, 'III', '젊은 왕자와 젊은 공주', 'III. The Young Prince and the Young Princess', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 202 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d87afcfe-781b-357e-8224-ebafcba2d335'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd179d26-fbcf-4071-97f9-3eb34ade198d', 4, 'IV', '바그다드의 축제 – 바다 – 청동 기사상이 선 바위에 부딪쳐 부서지는 배', 'IV. Festival at Baghdad – The Sea – The Ship Breaks against a Cliff Surmounted by a Bronze Warrior', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 202 AND p.composer_id = 46
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd179d26-fbcf-4071-97f9-3eb34ade198d'
);


-- Op. 61 전주곡 <무덤 앞에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 <무덤 앞에서>', 'On the Tomb, Prelude', 'song', 'Op. 61', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 <무덤 앞에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce447573-2fc3-47ab-ba10-cd1fe91f2d89'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ce447573-2fc3-47ab-ba10-cd1fe91f2d89'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '전주곡 <무덤 앞에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ce447573-2fc3-47ab-ba10-cd1fe91f2d89'
);


-- Op. 62 <두비누시카>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<두비누시카>', 'Dubinushka', 'song', 'Op. 62', NULL, NULL, 1905, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<두비누시카>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c434926-7e49-4174-99e3-2009d39229e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c434926-7e49-4174-99e3-2009d39229e5'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<두비누시카>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c434926-7e49-4174-99e3-2009d39229e5'
);


-- None <건배의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<건배의 노래>', 'Zdravitsa (Greeting)', 'song', NULL, NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<건배의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c6828d7-0841-46c4-ad33-6ef638bb9bf7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c6828d7-0841-46c4-ad33-6ef638bb9bf7'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<건배의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c6828d7-0841-46c4-ad33-6ef638bb9bf7'
);


-- Op. 57 <술탄 황제의 이야기> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<술탄 황제의 이야기> 모음곡', 'The Tale of Tsar Saltan, Suite (Three Musical Pictures)', 'album', 'Op. 57', NULL, NULL, 1903, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<술탄 황제의 이야기> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6986a33-bc9e-48b9-a85a-2278dc6bad30'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b6986a33-bc9e-48b9-a85a-2278dc6bad30'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<술탄 황제의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b6986a33-bc9e-48b9-a85a-2278dc6bad30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caf70ced-4496-38b1-87b0-0c45264208ce', 1, 'I', '황제의 이별과 출정', 'I. The Tsar''s Farewell and Departure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<술탄 황제의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf70ced-4496-38b1-87b0-0c45264208ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c00a7e7b-ba49-38d7-a3b0-cc371a24ce04', 2, 'II', '통 속의 황후, 바다 위에서', 'II. The Tsaritsa in a Barrel at Sea', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<술탄 황제의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c00a7e7b-ba49-38d7-a3b0-cc371a24ce04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:285c8611-407f-3aa7-ba22-942782508efc', 3, 'III', '세 가지 기적', 'III. The Three Wonders', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<술탄 황제의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:285c8611-407f-3aa7-ba22-942782508efc'
);


-- Op. 59 <판 보예보다> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<판 보예보다> 모음곡', 'Pan Voyevoda, Suite', 'album', 'Op. 59', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<판 보예보다> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7c34a0a-05f9-4295-a040-4e2ec212dd0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7c34a0a-05f9-4295-a040-4e2ec212dd0e'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<판 보예보다> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7c34a0a-05f9-4295-a040-4e2ec212dd0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4741511-340e-4dd0-85ad-dea0f7ede567', 1, 'I', '서주. Allegretto', 'I. Introduction. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<판 보예보다> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4741511-340e-4dd0-85ad-dea0f7ede567'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98fc791a-1f1d-4bfd-83ec-488819801fa7', 2, 'II', '크라코비아크. Allegro', 'II. Krakowiak. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<판 보예보다> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98fc791a-1f1d-4bfd-83ec-488819801fa7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69c682fd-183b-417e-9620-027d4362d025', 3, 'III', '녹턴 "달빛". Lento', 'III. Nocturne "Clair de lune". Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<판 보예보다> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69c682fd-183b-417e-9620-027d4362d025'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21f8816a-69a7-4adf-a01e-e91a3b41ac54', 4, 'IV', '마주르카. Tempo di mazurka – Scherzando', 'IV. Mazurka. Tempo di mazurka – Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<판 보예보다> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21f8816a-69a7-4adf-a01e-e91a3b41ac54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2670cbb2-5304-45d6-9712-552fd39ee88b', 5, 'V', '폴로네즈. Allegretto', 'V. Polonaise. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<판 보예보다> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2670cbb2-5304-45d6-9712-552fd39ee88b'
);


-- None 트롬본 협주곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트롬본 협주곡 B♭장조', 'Trombone Concerto in B♭ major', 'album', NULL, NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트롬본 협주곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2252ac0e-ae48-47b6-a5b3-98a60636d24a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2252ac0e-ae48-47b6-a5b3-98a60636d24a'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '트롬본 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2252ac0e-ae48-47b6-a5b3-98a60636d24a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67822a12-aeb3-4e4d-886e-992bd3e4202b', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '트롬본 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67822a12-aeb3-4e4d-886e-992bd3e4202b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21a1538e-5a74-46ad-970e-6d743c40a125', 2, 'II', 'Andante cantabile', 'II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '트롬본 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21a1538e-5a74-46ad-970e-6d743c40a125'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3362c27-9cfe-44d4-a554-99c32edb6ec0', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '트롬본 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3362c27-9cfe-44d4-a554-99c32edb6ec0'
);


-- None 글린카 주제에 의한 변주곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '글린카 주제에 의한 변주곡 G단조', 'Variations on a Theme by Glinka in G minor', 'song', NULL, NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '글린카 주제에 의한 변주곡 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c3ed399-fbe3-45a5-9bd8-4d67689a476c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c3ed399-fbe3-45a5-9bd8-4d67689a476c'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '글린카 주제에 의한 변주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c3ed399-fbe3-45a5-9bd8-4d67689a476c'
);


-- None 클라리넷 콘체르트슈튀크 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 콘체르트슈튀크 E♭장조', 'Konzertstück for Clarinet in E♭ major', 'song', NULL, NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 콘체르트슈튀크 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '362203da-fca5-4ac9-b557-7e9df6d08edc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '362203da-fca5-4ac9-b557-7e9df6d08edc'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '클라리넷 콘체르트슈튀크 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '362203da-fca5-4ac9-b557-7e9df6d08edc'
);


-- Op. 30 피아노 협주곡 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 C#단조', 'Piano Concerto in C# minor', 'song', 'Op. 30', NULL, NULL, 1883, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1b884db-e304-47fe-8769-cf33af650603'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1b884db-e304-47fe-8769-cf33af650603'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노 협주곡 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1b884db-e304-47fe-8769-cf33af650603'
);


-- Op. 33 바이올린과 관현악을 위한 러시아 주제에 의한 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 러시아 주제에 의한 환상곡', 'Fantasy on Russian Themes for Violin and Orchestra', 'song', 'Op. 33', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 러시아 주제에 의한 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2cd900c-1d31-4cf4-83cf-64a29153b915'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2cd900c-1d31-4cf4-83cf-64a29153b915'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '바이올린과 관현악을 위한 러시아 주제에 의한 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2cd900c-1d31-4cf4-83cf-64a29153b915'
);


-- None 바이올린과 관현악을 위한 폴란드 민요 주제에 의한 마주르카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 관현악을 위한 폴란드 민요 주제에 의한 마주르카', 'Mazurka on Polish Folk Themes for Violin and Orchestra (Souvenir de trois chants polonais)', 'song', NULL, NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 관현악을 위한 폴란드 민요 주제에 의한 마주르카'
);


-- Op. 37 첼로를 위한 세레나데

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로를 위한 세레나데', 'Serenade for Cello and Orchestra', 'song', 'Op. 37', NULL, NULL, 1893, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로를 위한 세레나데'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac6c194e-643d-45e0-b706-69bc391b1493'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac6c194e-643d-45e0-b706-69bc391b1493'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '첼로를 위한 세레나데' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac6c194e-643d-45e0-b706-69bc391b1493'
);


-- None 2중창 <Babochka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Babochka>', 'Babochka (Butterfly)', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Babochka>'
);


-- None 가곡 <Vykhodi ko mne, sin'ora>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Vykhodi ko mne, sin''ora>', 'Vykhodi ko mne, sin''ora (Come Out to Me, Signora)', 'song', NULL, NULL, NULL, 1861, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Vykhodi ko mne, sin''ora>'
);


-- Op. 2 4개의 로망스 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 2', '4 Romances, Op. 2', 'album', NULL, 'Op.', '2', 1866, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46ece493-bc7f-47ca-8de6-7b5b58070cf1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46ece493-bc7f-47ca-8de6-7b5b58070cf1'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46ece493-bc7f-47ca-8de6-7b5b58070cf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op2:1', 1, NULL, 'Shchekoyu k shcheke ty moey prilozhis''', 'Shchekoyu k shcheke ty moey prilozhis''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op2:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ffe40be-3312-438d-bb58-be6992321f8a', 2, NULL, 'Vostochnyy romans (Plenivshis'' rozoy, solovey)', 'Vostochnyy romans (Plenivshis'' rozoy, solovey)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ffe40be-3312-438d-bb58-be6992321f8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op2:3', 3, NULL, 'Kolybel''naya pesnya', 'Kolybel''naya pesnya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op2:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op2:4', 4, NULL, 'Iz slyoz moikh', 'Iz slyoz moikh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op2:4'
);


-- Op. 3 4개의 로망스 Op. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 3', '4 Romances, Op. 3', 'album', NULL, 'Op.', '3', 1866, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcee9c22-513f-4e9c-81a9-29ee9f305348'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fcee9c22-513f-4e9c-81a9-29ee9f305348'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcee9c22-513f-4e9c-81a9-29ee9f305348'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op3:1', 1, NULL, 'Yel'' i pal''ma', 'Yel'' i pal''ma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op3:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op3:2', 2, NULL, 'Yuzhnaya noch''', 'Yuzhnaya noch''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op3:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op3:3', 3, NULL, 'Nochevala tuchka zolotaya', 'Nochevala tuchka zolotaya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op3:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9e457fe-1ff5-369b-a9fe-2ae9030fd6cf', 4, NULL, 'Na kholmakh Gruzii', 'Na kholmakh Gruzii', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9e457fe-1ff5-369b-a9fe-2ae9030fd6cf'
);


-- Op. 4 4개의 로망스 Op. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 4', '4 Romances, Op. 4', 'album', NULL, 'Op.', '4', 1866, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ed48561-0716-4bb0-bf68-3be631b6c52c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ed48561-0716-4bb0-bf68-3be631b6c52c'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ed48561-0716-4bb0-bf68-3be631b6c52c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f62e17ac-19af-482a-93de-c7cad11559c2', 1, NULL, 'Chto v imeni tebe moem?', 'Chto v imeni tebe moem?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f62e17ac-19af-482a-93de-c7cad11559c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op4:2', 2, NULL, 'Gonets', 'Gonets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op4:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op4:3', 3, NULL, 'V tyomnoy roshche zamolk solovey', 'V tyomnoy roshche zamolk solovey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op4:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op4:4', 4, NULL, 'Tikho vecher dogoraet', 'Tikho vecher dogoraet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op4:4'
);


-- Op. 7 4개의 로망스 Op. 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 7', '4 Romances, Op. 7', 'album', NULL, 'Op.', '7', 1867, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cee6163-452b-4ef6-b18c-8edc5e27fd38'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9cee6163-452b-4ef6-b18c-8edc5e27fd38'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9cee6163-452b-4ef6-b18c-8edc5e27fd38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c32c0ed4-af03-4429-8768-f2eaa196759d', 1, NULL, 'Moy golos dlya tebya i laskovyy, i tomnyy', 'Moy golos dlya tebya i laskovyy, i tomnyy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c32c0ed4-af03-4429-8768-f2eaa196759d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op7:2', 2, NULL, 'Yevreyskaya pesnya', 'Yevreyskaya pesnya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op7:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op7:3', 3, NULL, 'Svitezyanka', 'Svitezyanka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op7:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op7:4', 4, NULL, 'Kak nebesa, tvoy vzor blistaet', 'Kak nebesa, tvoy vzor blistaet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op7:4'
);


-- Op. 8 6개의 로망스 Op. 8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 로망스 Op. 8', '6 Romances, Op. 8', 'album', NULL, 'Op.', '8', 1870, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 로망스 Op. 8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:1', 1, NULL, 'Gde ty, tam mysl'' moya letaet', 'Gde ty, tam mysl'' moya letaet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:2', 2, NULL, 'Noch''', 'Noch''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:3', 3, NULL, 'Tayna', 'Tayna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:4', 4, NULL, 'Vstan'', soydi!', 'Vstan'', soydi!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:5', 5, NULL, 'V tsarstve rozy i vina', 'V tsarstve rozy i vina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:6', 6, NULL, 'Ya veryu, ya lyubim', 'Ya veryu, ya lyubim', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '6개의 로망스 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op8:6'
);


-- Op. 25 2개의 로망스 Op. 25

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 로망스 Op. 25', '2 Romances, Op. 25', 'album', NULL, 'Op.', '25', 1876, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 로망스 Op. 25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op25:1', 1, NULL, 'K moey pesne', 'K moey pesne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op25:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op25:2', 2, NULL, 'Kogda glyazhu tebe v glaza', 'Kogda glyazhu tebe v glaza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 로망스 Op. 25' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op25:2'
);


-- Op. 26 4개의 로망스 Op. 26

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 26', '4 Romances, Op. 26', 'album', NULL, 'Op.', '26', 1882, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op26:1', 1, NULL, 'V poryve nezhnosti serdechnoy', 'V poryve nezhnosti serdechnoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op26:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op26:2', 2, NULL, 'Zaklinanie', 'Zaklinanie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op26:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op26:3', 3, NULL, 'Dlya beregov otchizny dal''noy', 'Dlya beregov otchizny dal''noy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op26:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op26:4', 4, NULL, 'Pesnya Zyuleyki', 'Pesnya Zyuleyki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 26' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op26:4'
);


-- Op. 27 4개의 로망스 Op. 27

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 27', '4 Romances, Op. 27', 'album', NULL, 'Op.', '27', 1883, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 27'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50ef825e-02bb-42b6-8fc2-317e2f59ada9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50ef825e-02bb-42b6-8fc2-317e2f59ada9'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50ef825e-02bb-42b6-8fc2-317e2f59ada9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op27:1', 1, NULL, 'Gornimi tikho letela dusha nebesami', 'Gornimi tikho letela dusha nebesami', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op27:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op27:2', 2, NULL, 'Ekho', 'Ekho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op27:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fc1c04d-279e-417b-b846-14c3bb744b69', 3, NULL, 'Ty i vy', 'Ty i vy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fc1c04d-279e-417b-b846-14c3bb744b69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3e39a7e-886c-452f-af03-3edfa3e84f05', 4, NULL, 'Prosti! Ne pomni dney paden''ya', 'Prosti! Ne pomni dney paden''ya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3e39a7e-886c-452f-af03-3edfa3e84f05'
);


-- Op. 39 4개의 로망스 Op. 39

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 39', '4 Romances, Op. 39', 'album', NULL, 'Op.', '39', 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op39:1', 1, NULL, 'O, yesli b ty mogla', 'O, yesli b ty mogla', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op39:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op39:2', 2, NULL, 'Zapad gasnet v dali bledno-rozovoy', 'Zapad gasnet v dali bledno-rozovoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op39:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op39:3', 3, NULL, 'Na nivy zheltye niskhodit tishina', 'Na nivy zheltye niskhodit tishina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op39:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op39:4', 4, NULL, 'Usni, pechal''nyy drug', 'Usni, pechal''nyy drug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 39' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op39:4'
);


-- Op. 40 4개의 로망스 Op. 40

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 40', '4 Romances, Op. 40', 'album', NULL, 'Op.', '40', 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 40'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4b0fe2d-21d9-4a77-b108-43f1efe404a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c4b0fe2d-21d9-4a77-b108-43f1efe404a5'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4b0fe2d-21d9-4a77-b108-43f1efe404a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bb348ed-866a-4284-9939-87d20e230abb', 1, NULL, 'Kogda volnuetsya zhelteyushchaya niva', 'Kogda volnuetsya zhelteyushchaya niva', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bb348ed-866a-4284-9939-87d20e230abb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb8a46eb-4cb7-4f5a-85aa-023982174256', 2, NULL, 'Po nebu polunochi', 'Po nebu polunochi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb8a46eb-4cb7-4f5a-85aa-023982174256'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d0cb6ca-5f16-4047-98c7-0609527b1b72', 3, NULL, 'O chyom v tishi nochey', 'O chyom v tishi nochey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d0cb6ca-5f16-4047-98c7-0609527b1b72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0f6c238-3569-4fea-9aed-36c3ee036dc9', 4, NULL, 'Ya v grote zhdal tebya v urochnyy chas', 'Ya v grote zhdal tebya v urochnyy chas', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 40' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0f6c238-3569-4fea-9aed-36c3ee036dc9'
);


-- Op. 41 4개의 로망스 Op. 41

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 41', '4 Romances, Op. 41', 'album', NULL, 'Op.', '41', 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op41:1', 1, NULL, 'Nespyashchikh solntse', 'Nespyashchikh solntse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op41:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op41:2', 2, NULL, 'Mne grustno', 'Mne grustno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op41:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op41:3', 3, NULL, 'Lyublyu tebya, mesyats: Melodiya s beregov Ganga', 'Lyublyu tebya, mesyats: Melodiya s beregov Ganga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op41:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op41:4', 4, NULL, 'Posmotri v svoy vertograd', 'Posmotri v svoy vertograd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 41' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op41:4'
);


-- Op. 42 4개의 로망스 Op. 42

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 42', '4 Romances, Op. 42', 'album', NULL, 'Op.', '42', 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 42'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '469df4cd-406c-4353-8380-46ea0df2f950'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '469df4cd-406c-4353-8380-46ea0df2f950'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '469df4cd-406c-4353-8380-46ea0df2f950'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op42:1', 1, NULL, 'Shyopot, robkoe dykhan''e', 'Shyopot, robkoe dykhan''e', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op42:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op42:2', 2, NULL, 'Ya prishyol k tebe s privetom', 'Ya prishyol k tebe s privetom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op42:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebfcf515-62e5-4154-9ab7-4f19fb6d0b4d', 3, NULL, 'Redeet oblakov letuchaya gryada (Elegiya)', 'Redeet oblakov letuchaya gryada (Elegiya)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebfcf515-62e5-4154-9ab7-4f19fb6d0b4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op42:4', 4, NULL, 'Moya balovnitsa', 'Moya balovnitsa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op42:4'
);


-- Op. 43 연가곡집 <봄에>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <봄에>', 'In Spring, Op. 43', 'album', 'Op. 43', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <봄에>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e028d64-4bcd-453c-9f15-38d594476e5f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0e028d64-4bcd-453c-9f15-38d594476e5f'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <봄에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0e028d64-4bcd-453c-9f15-38d594476e5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op43:1', 1, NULL, 'Zvonche zhavoronka pen''e', 'Zvonche zhavoronka pen''e', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <봄에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op43:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6753ca3f-eabd-4b0b-b439-43f491ac6385', 2, NULL, 'Ne veter veya s vysoty', 'Ne veter veya s vysoty', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <봄에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6753ca3f-eabd-4b0b-b439-43f491ac6385'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op43:3', 3, NULL, 'Svezh i dushist tvoy roskoshnyy venok', 'Svezh i dushist tvoy roskoshnyy venok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <봄에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op43:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op43:4', 4, NULL, 'To bylo ranneyu vesnoy', 'To bylo ranneyu vesnoy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <봄에>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op43:4'
);


-- Op. 45 연가곡집 <시인에게>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <시인에게>', 'To the Poet, Op. 45', 'album', 'Op. 45', NULL, NULL, 1899, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <시인에게>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4555846e-f2e5-463a-a052-ea1458e9610a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4555846e-f2e5-463a-a052-ea1458e9610a'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <시인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4555846e-f2e5-463a-a052-ea1458e9610a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8952d9ec-ab78-436b-a8b4-754d74af92ba', 1, NULL, 'Ekho', 'Ekho', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <시인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8952d9ec-ab78-436b-a8b4-754d74af92ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op45:2', 2, NULL, 'Iskusstvo', 'Iskusstvo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <시인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op45:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d44943ac-9116-4b7a-8dd3-c419b43b3eaa', 3, NULL, 'Oktava', 'Oktava', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <시인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d44943ac-9116-4b7a-8dd3-c419b43b3eaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op45:4', 4, NULL, 'Somnenie', 'Somnenie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <시인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op45:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op45:5', 5, NULL, 'Poet', 'Poet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <시인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op45:5'
);


-- Op. 46 연가곡집 <바닷가에서>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <바닷가에서>', 'By the Sea, Op. 46', 'album', 'Op. 46', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <바닷가에서>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f50f568e-b25e-4b84-bdaa-a4736093b512'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f50f568e-b25e-4b84-bdaa-a4736093b512'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <바닷가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f50f568e-b25e-4b84-bdaa-a4736093b512'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73dc3f10-236c-43ee-8ac9-7148dd218cfa', 1, NULL, 'Drobitsya, i pleshchet, i bryzzhet volna', 'Drobitsya, i pleshchet, i bryzzhet volna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <바닷가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73dc3f10-236c-43ee-8ac9-7148dd218cfa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d44809e-2334-49ab-9827-5dce6453484f', 2, NULL, 'Ne penitsya more, ne pleshchet volna', 'Ne penitsya more, ne pleshchet volna', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <바닷가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d44809e-2334-49ab-9827-5dce6453484f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9e590d7-e488-49a0-bf38-74860fc5da6b', 3, NULL, 'Kolyshetsya more', 'Kolyshetsya more', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <바닷가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9e590d7-e488-49a0-bf38-74860fc5da6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7265112d-2d40-4ce2-ada8-6ef9e377bee7', 4, NULL, 'Ne ver'' mne, drug', 'Ne ver'' mne, drug', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <바닷가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7265112d-2d40-4ce2-ada8-6ef9e377bee7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fee56e26-3c79-4659-831e-7383ce4919ee', 5, NULL, 'Vzdymayutsya volny', 'Vzdymayutsya volny', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '연가곡집 <바닷가에서>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fee56e26-3c79-4659-831e-7383ce4919ee'
);


-- Op. 47 2개의 2중창 Op. 47

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 2중창 Op. 47', '2 Duets, Op. 47', 'album', NULL, 'Op.', '47', 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 2중창 Op. 47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op47:1', 1, NULL, 'Pan', 'Pan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 2중창 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op47:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op47:2', 2, NULL, 'Pesnya pesen', 'Pesnya pesen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 2중창 Op. 47' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op47:2'
);


-- Op. 49 베이스를 위한 2개의 로망스 Op. 49

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베이스를 위한 2개의 로망스 Op. 49', '2 Romances for Bass, Op. 49', 'album', NULL, 'Op.', '49', 1882, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베이스를 위한 2개의 로망스 Op. 49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op49:1', 1, NULL, 'Anchar', 'Anchar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '베이스를 위한 2개의 로망스 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op49:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op49:2', 2, NULL, 'Prorok', 'Prorok', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '베이스를 위한 2개의 로망스 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op49:2'
);


-- Op. 50 4개의 로망스 Op. 50

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 로망스 Op. 50', '4 Romances, Op. 50', 'album', NULL, 'Op.', '50', 1898, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 로망스 Op. 50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op50:1', 1, NULL, 'Deva i solntse', 'Deva i solntse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op50:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op50:2', 2, NULL, 'Pevets', 'Pevets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op50:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op50:3', 3, NULL, 'Tikho more goluboe', 'Tikho more goluboe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op50:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op50:4', 4, NULL, 'Yeshchyo ya poln, o drug moy milyy', 'Yeshchyo ya poln, o drug moy milyy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 로망스 Op. 50' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op50:4'
);


-- Op. 51 5개의 로망스 Op. 51

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5개의 로망스 Op. 51', '5 Romances, Op. 51', 'album', NULL, 'Op.', '51', 1898, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5개의 로망스 Op. 51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op51:1', 1, NULL, 'Medlitel''no vlekutsya dni moi', 'Medlitel''no vlekutsya dni moi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '5개의 로망스 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op51:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eed503c8-9a4c-4c81-9c43-d50304ba72d4', 2, NULL, 'Ne poy, krasavitsa, pri mne', 'Ne poy, krasavitsa, pri mne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '5개의 로망스 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eed503c8-9a4c-4c81-9c43-d50304ba72d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op51:3', 3, NULL, 'Tsvetok zasokhshiy', 'Tsvetok zasokhshiy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '5개의 로망스 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op51:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op51:4', 4, NULL, 'Krasavitsa', 'Krasavitsa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '5개의 로망스 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op51:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op51:5', 5, NULL, 'Nenastnyy den'' potukh', 'Nenastnyy den'' potukh', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '5개의 로망스 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op51:5'
);


-- Op. 52 2개의 2중창 Op. 52

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 2중창 Op. 52', '2 Duets, Op. 52', 'album', NULL, 'Op.', '52', 1898, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 2중창 Op. 52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op52:1', 1, NULL, 'Gornyy klyuch', 'Gornyy klyuch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 2중창 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op52:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op52:2', 2, NULL, 'Angel i demon', 'Angel i demon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 2중창 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op52:2'
);


-- Op. 53 3중창 <Strekozy>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중창 <Strekozy>', 'Strekozy (Dragonflies)', 'song', 'Op. 53', NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중창 <Strekozy>'
);


-- Op. 55 테너를 위한 4개의 로망스 Op. 55

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '테너를 위한 4개의 로망스 Op. 55', '4 Romances for Tenor, Op. 55', 'album', NULL, 'Op.', '55', 1898, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '테너를 위한 4개의 로망스 Op. 55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op55:1', 1, NULL, 'Probuzhden''e', 'Probuzhden''e', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '테너를 위한 4개의 로망스 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op55:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op55:2', 2, NULL, 'Grechanke', 'Grechanke', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '테너를 위한 4개의 로망스 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op55:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op55:3', 3, NULL, 'Snovidenie', 'Snovidenie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '테너를 위한 4개의 로망스 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op55:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op55:4', 4, NULL, 'Ya umer ot schast''ya', 'Ya umer ot schast''ya', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '테너를 위한 4개의 로망스 Op. 55' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op55:4'
);


-- Op. 56 소프라노를 위한 2개의 로망스 Op. 56

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소프라노를 위한 2개의 로망스 Op. 56', '2 Romances for Soprano, Op. 56', 'album', NULL, 'Op.', '56', 1898, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소프라노를 위한 2개의 로망스 Op. 56'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf3479cd-d63e-4c25-aec6-4a8cd2b3d909'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf3479cd-d63e-4c25-aec6-4a8cd2b3d909'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '소프라노를 위한 2개의 로망스 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf3479cd-d63e-4c25-aec6-4a8cd2b3d909'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be155050-bbee-3bb9-bc8d-09c15d5bdb86', 1, NULL, 'Nimfa', 'Nimfa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '소프라노를 위한 2개의 로망스 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be155050-bbee-3bb9-bc8d-09c15d5bdb86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:85822e7c-afa4-3253-93d4-6b45a5ced8e6', 2, NULL, 'Son v letnyuyu noch''', 'Son v letnyuyu noch''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '소프라노를 위한 2개의 로망스 Op. 56' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85822e7c-afa4-3253-93d4-6b45a5ced8e6'
);


-- Op. 12 현악 4중주 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 F장조', 'String Quartet in F major', 'album', 'Op. 12', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7811daa8-f6f9-4976-9b12-99268085ae1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7811daa8-f6f9-4976-9b12-99268085ae1f'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7811daa8-f6f9-4976-9b12-99268085ae1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6f3a49e-cffc-4219-8f40-c8ffe7195f71', 1, 'I', 'Moderato alla breve', 'I. Moderato alla breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6f3a49e-cffc-4219-8f40-c8ffe7195f71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cefa737-5e55-4a16-bb79-1df7a6843d4d', 2, 'II', 'Andante moderato', 'II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cefa737-5e55-4a16-bb79-1df7a6843d4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a4ffb7b-e455-4424-9ddd-b2d1e23cecbb', 3, 'III', '스케르초. Allegro vivace', 'III. Scherzo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a4ffb7b-e455-4424-9ddd-b2d1e23cecbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3429bcf8-6fe5-4ed3-b6a1-433c413ffec9', 4, 'IV', '피날레. Allegro con spirito', 'IV. Finale. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 4중주 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3429bcf8-6fe5-4ed3-b6a1-433c413ffec9'
);


-- None 현악 6중주 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 6중주 A장조', 'String Sextet in A major', 'album', NULL, NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 6중주 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ab6e2e4-62ed-4e8a-ae12-be414e115d1d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ab6e2e4-62ed-4e8a-ae12-be414e115d1d'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ab6e2e4-62ed-4e8a-ae12-be414e115d1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c58fcbd7-fa70-4a3b-a3ce-0764290b6c25', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c58fcbd7-fa70-4a3b-a3ce-0764290b6c25'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c686aac9-19a7-4a68-8e55-7e10584916ca', 2, 'II', '론도 푸가토', 'II. Rondo fugato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c686aac9-19a7-4a68-8e55-7e10584916ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58f182b9-4db7-48d5-9370-1c25b712e1ec', 3, 'III', '스케르초. Vivace alla saltarello', 'III. Scherzo. Vivace alla saltarello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58f182b9-4db7-48d5-9370-1c25b712e1ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7541925c-81ff-4432-81b2-43e28589f8eb', 4, 'IV', 'Andante espressivo', 'IV. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7541925c-81ff-4432-81b2-43e28589f8eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76c0b7a2-84af-4196-8e55-8dadcdd8a8d7', 5, 'V', '피날레. Allegro molto', 'V. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 6중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76c0b7a2-84af-4196-8e55-8dadcdd8a8d7'
);


-- None 피아노와 관악을 위한 5중주 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관악을 위한 5중주 B♭장조', 'Quintet in B♭ major for Flute, Clarinet, Horn, Bassoon and Piano', 'album', NULL, NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관악을 위한 5중주 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63a0fed5-1747-43a5-9a70-c66de84f6724'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '63a0fed5-1747-43a5-9a70-c66de84f6724'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노와 관악을 위한 5중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63a0fed5-1747-43a5-9a70-c66de84f6724'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b714fee1-b3e9-4bc7-8a29-7b22e175a700', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노와 관악을 위한 5중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b714fee1-b3e9-4bc7-8a29-7b22e175a700'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9092804-9080-4873-b7d9-fe89def0e68d', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노와 관악을 위한 5중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9092804-9080-4873-b7d9-fe89def0e68d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:871bdcbb-b2d4-405b-aa7f-734ba20f8348', 3, 'III', '론도. Allegretto', 'III. Rondo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노와 관악을 위한 5중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:871bdcbb-b2d4-405b-aa7f-734ba20f8348'
);


-- None 현악 4중주를 위한 코랄 변주곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 코랄 변주곡 G단조', 'Four Variations on a Chorale in G minor for String Quartet', 'song', NULL, NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 코랄 변주곡 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '605c01a0-caa5-4da0-8b8e-05771b3ad90b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '605c01a0-caa5-4da0-8b8e-05771b3ad90b'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '현악 4중주를 위한 코랄 변주곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '605c01a0-caa5-4da0-8b8e-05771b3ad90b'
);


-- None 네 호른을 위한 녹턴 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 호른을 위한 녹턴 F장조', 'Nocturne in F major for Four Horns', 'song', NULL, NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 호른을 위한 녹턴 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fb37d91-2ade-405f-918c-251f38cc118b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7fb37d91-2ade-405f-918c-251f38cc118b'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '네 호른을 위한 녹턴 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fb37d91-2ade-405f-918c-251f38cc118b'
);


-- None 두 호른을 위한 2개의 2중주 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 호른을 위한 2개의 2중주 F장조', 'Two Duets in F major for Two Horns', 'song', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 호른을 위한 2개의 2중주 F장조'
);


-- None 두 클라리넷을 위한 칸초네타와 타란텔라

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 클라리넷을 위한 칸초네타와 타란텔라', 'Canzonetta and Tarantella for Two Clarinets', 'album', NULL, NULL, NULL, 1894, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 클라리넷을 위한 칸초네타와 타란텔라'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-canzonetta-tarantella:1', 1, NULL, '칸초네타', 'Canzonetta', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '두 클라리넷을 위한 칸초네타와 타란텔라' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-canzonetta-tarantella:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-canzonetta-tarantella:2', 2, NULL, '타란텔라', 'Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '두 클라리넷을 위한 칸초네타와 타란텔라' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-canzonetta-tarantella:2'
);


-- None 현악 4중주 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 G장조', 'String Quartet in G major', 'song', NULL, NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 G장조'
);


-- None 피아노 3중주 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 C단조', 'Piano Trio in C minor', 'album', NULL, NULL, NULL, 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '965dbde9-108d-4329-ba6c-301e81cd25ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '965dbde9-108d-4329-ba6c-301e81cd25ba'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노 3중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '965dbde9-108d-4329-ba6c-301e81cd25ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f54e32d2-9f2c-44a1-acb1-a0898f67568a', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노 3중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f54e32d2-9f2c-44a1-acb1-a0898f67568a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77317dd6-6e61-4d2b-acc5-61547a675bed', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노 3중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77317dd6-6e61-4d2b-acc5-61547a675bed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:069c7a63-52c7-43a3-917e-6cc110e7a2be', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노 3중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:069c7a63-52c7-43a3-917e-6cc110e7a2be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bbb47b1-6612-4ac7-9cf6-ecdfcbb3b9a0', 4, 'IV', 'Adagio – Allegro assai', 'IV. Adagio – Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '피아노 3중주 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bbb47b1-6612-4ac7-9cf6-ecdfcbb3b9a0'
);


-- Op. 10 B-A-C-H 주제에 의한 6개의 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'B-A-C-H 주제에 의한 6개의 변주곡', 'Six Variations on the Theme B-A-C-H, Op. 10', 'album', 'Op. 10', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'B-A-C-H 주제에 의한 6개의 변주곡'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:1', 1, NULL, '왈츠', 'Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = 'B-A-C-H 주제에 의한 6개의 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:2', 2, NULL, '인테르메초', 'Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = 'B-A-C-H 주제에 의한 6개의 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:3', 3, NULL, '스케르초', 'Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = 'B-A-C-H 주제에 의한 6개의 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:4', 4, NULL, '녹턴', 'Nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = 'B-A-C-H 주제에 의한 6개의 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:5', 5, NULL, '전주곡', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = 'B-A-C-H 주제에 의한 6개의 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:6', 6, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = 'B-A-C-H 주제에 의한 6개의 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op10:6'
);


-- Op. 11 4개의 소품 Op. 11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 소품 Op. 11', '4 Pieces, Op. 11', 'album', NULL, 'Op.', '11', 1877, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 소품 Op. 11'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e157a61-5125-4091-a1e0-a324c8f1e8a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7e157a61-5125-4091-a1e0-a324c8f1e8a9'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e157a61-5125-4091-a1e0-a324c8f1e8a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39b17dbb-9264-4b88-8580-935acc78b585', 1, NULL, '즉흥곡', 'Impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39b17dbb-9264-4b88-8580-935acc78b585'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:304fdb36-88e9-4b51-b777-724672d16e15', 2, NULL, '노벨레테', 'Novelette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304fdb36-88e9-4b51-b777-724672d16e15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db0acc3c-49d3-4e83-b344-e99e83e324a8', 3, NULL, '스케르치노', 'Scherzino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db0acc3c-49d3-4e83-b344-e99e83e324a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:345d7233-31d8-42e5-8110-d9ad33c0f07e', 4, NULL, '연습곡', 'Étude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '4개의 소품 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:345d7233-31d8-42e5-8110-d9ad33c0f07e'
);


-- Op. 15 3개의 소품 Op. 15

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 소품 Op. 15', '3 Pieces, Op. 15', 'album', NULL, 'Op.', '15', 1876, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 소품 Op. 15'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '834227d4-0f41-4aeb-a62f-745b41cc6d49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '834227d4-0f41-4aeb-a62f-745b41cc6d49'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '3개의 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '834227d4-0f41-4aeb-a62f-745b41cc6d49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e33caac0-c9b3-48d6-b0aa-959eef80c7ab', 1, NULL, '왈츠', 'Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '3개의 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e33caac0-c9b3-48d6-b0aa-959eef80c7ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25a0520d-a599-435d-af1b-d1bef942231f', 2, NULL, '로망스', 'Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '3개의 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25a0520d-a599-435d-af1b-d1bef942231f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a94a7420-ac93-4bb7-b4ad-7820e8ead50d', 3, NULL, '푸가', 'Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '3개의 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a94a7420-ac93-4bb7-b4ad-7820e8ead50d'
);


-- Op. 17 6개의 푸가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 푸가', '6 Fugues', 'song', 'Op. 17', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 푸가'
);


-- Op. 38 2개의 소품 Op. 38

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 소품 Op. 38', '2 Pieces, Op. 38', 'album', NULL, 'Op.', '38', 1897, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 소품 Op. 38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op38:1', 1, NULL, '전주곡-즉흥곡', 'Prélude-impromptu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 소품 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op38:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:rimsky-korsakov:rimsky-korsakov-op38:2', 2, NULL, '마주르카', 'Mazurka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '2개의 소품 Op. 38' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rimsky-korsakov:rimsky-korsakov-op38:2'
);


-- None 알레그레토 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 C장조', 'Allegretto in C major', 'song', NULL, NULL, NULL, 1895, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 C장조'
);


-- None 전주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 G장조', 'Prelude in G major', 'song', NULL, NULL, NULL, 1896, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 G장조'
);


-- None 네 손을 위한 푸가 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 푸가 C장조', 'Fugue in C major for Piano Four Hands', 'song', NULL, NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 푸가 C장조'
);


-- None 미샤의 주제에 의한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미샤의 주제에 의한 변주곡', 'Variations on a Theme by Misha', 'song', NULL, NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미샤의 주제에 의한 변주곡'
);


-- None <작은 노래> (Andantino)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<작은 노래> (Andantino)', 'Pesenka (Andantino)', 'song', NULL, NULL, NULL, 1901, 'manual', 1
FROM composers c
WHERE c.id = 46
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<작은 노래> (Andantino)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84279752-7d5c-4de0-a3d1-b1c6aa63901b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84279752-7d5c-4de0-a3d1-b1c6aa63901b'
FROM pieces p
WHERE p.composer_id = 46 AND p.title = '<작은 노래> (Andantino)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84279752-7d5c-4de0-a3d1-b1c6aa63901b'
);

