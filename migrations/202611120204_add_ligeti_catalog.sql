-- 죄르지 리게티(composer_id 499) 작품 목록. 지금은 「레퀴엠」·「룩스 에테르나」·「아트모스페르」 세 곡뿐이다.
-- 새 작품 42개(피아노 연습곡 1~3권, 「무지카 리체르카타」, 현악 4중주 1·2번, 첼로·피아노·바이올린 협주곡, 「함부르크 협주곡」,
-- 「론타노」 등 관현악, 「르 그랑 마카브르」, 실내악·합창곡), 곡·악장 142개, 장르·형식.
--
-- 작품은 손으로 고르고(전자 음악·민요 편곡·남이 엮은 발췌는 뺌) 곡은 MusicBrainz parts 순서대로 붙였다. 자료와 생성기:
--   seed_pipeline/curation/composer-catalog-2026-11-12/(build.py, ligeti/works.tsv) → catalog-wave4 gen_catalog.py
-- 「레퀴엠」(비교 구간·영화 <2001> 큐 있음)은 제목·설명·링크를 두고 네 악장만 잇는다. 「룩스 에테르나」·「아트모스페르」는 손대지 않는다.
-- 장르·형식은 비어 있을 때만 채운다. 두 번 돌려도 같다.

-- None 레퀴엠

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = '입당송', part.name_en = 'I. Introitus. Sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26026 AND p.composer_id = 499 AND part.part_key = 'musicbrainz:0a398315-c652-42c6-889e-92501a04571a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a398315-c652-42c6-889e-92501a04571a', 1, 'I', '입당송', 'I. Introitus. Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26026 AND p.composer_id = 499
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a398315-c652-42c6-889e-92501a04571a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = '키리에', part.name_en = 'II. Kyrie. Molto espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26026 AND p.composer_id = 499 AND part.part_key = 'musicbrainz:bbb03f2a-0e95-4232-aa54-6909a08d14b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbb03f2a-0e95-4232-aa54-6909a08d14b6', 2, 'II', '키리에', 'II. Kyrie. Molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26026 AND p.composer_id = 499
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbb03f2a-0e95-4232-aa54-6909a08d14b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = '부속가 (De die judicii sequentia)', part.name_en = 'III. De die judicii sequentia. Subito - Agitato molto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26026 AND p.composer_id = 499 AND part.part_key = 'musicbrainz:8d721272-5466-447e-97d3-204fe91c95a9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d721272-5466-447e-97d3-204fe91c95a9', 3, 'III', '부속가 (De die judicii sequentia)', 'III. De die judicii sequentia. Subito - Agitato molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26026 AND p.composer_id = 499
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d721272-5466-447e-97d3-204fe91c95a9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = '라크리모사', part.name_en = 'IV. Lacrimosa. Molto lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26026 AND p.composer_id = 499 AND part.part_key = 'musicbrainz:b1f94f9f-d595-4a05-aec0-8da5aab8f641' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f94f9f-d595-4a05-aec0-8da5aab8f641', 4, 'IV', '라크리모사', 'IV. Lacrimosa. Molto lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26026 AND p.composer_id = 499
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f94f9f-d595-4a05-aec0-8da5aab8f641'
);


-- None 관현악을 위한 <루마니아 협주곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <루마니아 협주곡>', 'Concert românesc', 'album', NULL, NULL, NULL, 1951, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <루마니아 협주곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a55a1b3-7f4e-470e-8a46-40a8272f5180'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0a55a1b3-7f4e-470e-8a46-40a8272f5180'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <루마니아 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0a55a1b3-7f4e-470e-8a46-40a8272f5180'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cb94a01-8b6f-46e3-87e9-6811bd9880ec', 1, 'I', 'Andantino', 'I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <루마니아 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cb94a01-8b6f-46e3-87e9-6811bd9880ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:999baf07-94b3-4370-a47c-76243460a286', 2, 'II', 'Allegro vivace', 'II. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <루마니아 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:999baf07-94b3-4370-a47c-76243460a286'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80744c24-6a2b-4d52-9edc-f227b0f57d7a', 3, 'III', 'Adagio ma non troppo', 'III. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <루마니아 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80744c24-6a2b-4d52-9edc-f227b0f57d7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31872ab3-3a2a-4361-9b75-245a78ea6553', 4, 'IV', 'Molto vivace', 'IV. Molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <루마니아 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31872ab3-3a2a-4361-9b75-245a78ea6553'
);


-- None 피아노 연탄을 위한 소나티나

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄을 위한 소나티나', 'Sonatina for Piano Four Hands', 'album', NULL, NULL, NULL, 1950, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄을 위한 소나티나'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3661760e-c17c-4970-ad2d-96b100448540'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3661760e-c17c-4970-ad2d-96b100448540'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연탄을 위한 소나티나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3661760e-c17c-4970-ad2d-96b100448540'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca7b64ae-fdf1-4951-9423-ebd50beea475', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연탄을 위한 소나티나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca7b64ae-fdf1-4951-9423-ebd50beea475'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b8d0185-9acd-488e-b365-cb8303cf4cad', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연탄을 위한 소나티나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b8d0185-9acd-488e-b365-cb8303cf4cad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb1654d7-9ce7-481e-8124-91332a542200', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연탄을 위한 소나티나' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb1654d7-9ce7-481e-8124-91332a542200'
);


-- None 베외레스의 시에 의한 3개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베외레스의 시에 의한 3개의 가곡', 'Három Weöres-dal', 'album', NULL, NULL, NULL, 1947, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베외레스의 시에 의한 3개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e61c482-0e23-49d6-9f40-11fa7628f3f8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6e61c482-0e23-49d6-9f40-11fa7628f3f8'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '베외레스의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6e61c482-0e23-49d6-9f40-11fa7628f3f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48b15ec0-a8cf-4ad2-9f92-280bf6de57b6', 1, 'I', 'Tancol a Hold feher ingben', 'I. Tancol a Hold feher ingben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '베외레스의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48b15ec0-a8cf-4ad2-9f92-280bf6de57b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92e7224d-cb02-4ae5-b3f7-027fffd3d8d7', 2, 'II', 'Gyumolcs-furt', 'II. Gyumolcs-furt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '베외레스의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92e7224d-cb02-4ae5-b3f7-027fffd3d8d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68740883-79ab-482f-9ee5-0131e449f23b', 3, 'III', 'Kalmarjottnagy madarakkal', 'III. Kalmarjottnagy madarakkal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '베외레스의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68740883-79ab-482f-9ee5-0131e449f23b'
);


-- None 아라니의 시에 의한 5개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아라니의 시에 의한 5개의 가곡', 'Öt Arany-dal', 'album', NULL, NULL, NULL, 1952, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아라니의 시에 의한 5개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f8e9604-14fa-44b2-9387-a400d0fa75a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f8e9604-14fa-44b2-9387-a400d0fa75a2'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '아라니의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f8e9604-14fa-44b2-9387-a400d0fa75a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:265639f7-eace-4ec4-b902-db3be73a9676', 1, 'I', 'Csalfa sugár', 'I. Csalfa sugár', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '아라니의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:265639f7-eace-4ec4-b902-db3be73a9676'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3163c287-ed83-40de-abf4-40a92f9c4b17', 2, 'II', 'A legszebb virág', 'II. A legszebb virág', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '아라니의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3163c287-ed83-40de-abf4-40a92f9c4b17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:061f69bc-975b-4ce1-ae03-66e2ffd86635', 3, 'III', 'A csendes dalokból', 'III. A csendes dalokból', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '아라니의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:061f69bc-975b-4ce1-ae03-66e2ffd86635'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80b28661-0f94-4e93-b06f-fe1bbe4aa163', 4, 'IV', 'A bujdosó', 'IV. A bujdosó', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '아라니의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80b28661-0f94-4e93-b06f-fe1bbe4aa163'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b1aa049-7f24-4f1c-baa0-bd4a263da9c7', 5, 'V', 'Az ördög elvitte a fináncot', 'V. Az ördög elvitte a fináncot', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '아라니의 시에 의한 5개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b1aa049-7f24-4f1c-baa0-bd4a263da9c7'
);


-- None 무지카 리체르카타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무지카 리체르카타', 'Musica ricercata', 'album', NULL, NULL, NULL, 1953, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무지카 리체르카타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5a4d92c-ac14-4a01-a043-8fdebb0a7b88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5a4d92c-ac14-4a01-a043-8fdebb0a7b88'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5a4d92c-ac14-4a01-a043-8fdebb0a7b88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e78ce6-b593-48ff-a9e5-3012bb70baf3', 1, 'I', 'Sostenuto - Misurato - Prestissimo', 'I. Sostenuto - Misurato - Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e78ce6-b593-48ff-a9e5-3012bb70baf3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e7415d-6f94-4fd4-8b5a-60d70c961d8c', 2, 'II', 'Mesto, rigido e cerimoniale', 'II. Mesto, rigido e cerimoniale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e7415d-6f94-4fd4-8b5a-60d70c961d8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:066f0ff3-2506-4e18-b35f-c00641e09cca', 3, 'III', 'Allegro con spirito', 'III. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:066f0ff3-2506-4e18-b35f-c00641e09cca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f34544c0-76df-41a7-b513-048ed41fcb84', 4, 'IV', 'Tempo di valse (Poco vivace - à l''orgue de Barbarie)', 'IV. Tempo di valse (Poco vivace - à l''orgue de Barbarie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f34544c0-76df-41a7-b513-048ed41fcb84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07ca2594-c854-4eee-afcc-b630e1459c6a', 5, 'V', 'Rubato. Lamentoso', 'V. Rubato. Lamentoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07ca2594-c854-4eee-afcc-b630e1459c6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8e8d699-324c-4342-9eb5-c13dd4ddc1f9', 6, 'VI', 'Allegro molto capriccioso', 'VI. Allegro molto capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8e8d699-324c-4342-9eb5-c13dd4ddc1f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02a8ca8c-8619-4eb5-97f7-a979395a53d5', 7, 'VII', 'Cantabile, molto legato', 'VII. Cantabile, molto legato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02a8ca8c-8619-4eb5-97f7-a979395a53d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a9bccd0-fb2e-410b-a5bd-aeed333ec46c', 8, 'VIII', 'Vivace. Energico', 'VIII. Vivace. Energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a9bccd0-fb2e-410b-a5bd-aeed333ec46c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb4a2e49-ee5f-45ae-b41f-ddf5901558dc', 9, 'IX', 'Adagio. Mesto - Allegro maestoso', 'IX. Adagio. Mesto - Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb4a2e49-ee5f-45ae-b41f-ddf5901558dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24a26b9d-4969-401e-b292-e2fd026bdcb8', 10, 'X', 'Vivace. Capriccioso', 'X. Vivace. Capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24a26b9d-4969-401e-b292-e2fd026bdcb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17d26685-e0bc-49f1-917d-187d6369fe93', 11, 'XI', 'Andante misurato e tranquillo', 'XI. Andante misurato e tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무지카 리체르카타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17d26685-e0bc-49f1-917d-187d6369fe93'
);


-- None 목관 5중주를 위한 6개의 바가텔

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목관 5중주를 위한 6개의 바가텔', 'Six Bagatelles for Wind Quintet', 'album', NULL, NULL, NULL, 1953, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목관 5중주를 위한 6개의 바가텔'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb1e2cfc-bea9-4f68-bde9-c4b1ae1f6fda'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb1e2cfc-bea9-4f68-bde9-c4b1ae1f6fda'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 6개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb1e2cfc-bea9-4f68-bde9-c4b1ae1f6fda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6fe1b32-3911-4c8c-b801-bba09b367f31', 1, NULL, 'Allegro con spirito', 'No. 1. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 6개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6fe1b32-3911-4c8c-b801-bba09b367f31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e287e60d-298d-4e61-91b1-10e1e597d8a6', 2, NULL, 'Rubato. Lamentoso', 'No. 2. Rubato. Lamentoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 6개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e287e60d-298d-4e61-91b1-10e1e597d8a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f422bdb8-c1e3-4a09-ac38-03c454873ece', 3, NULL, 'Allegro grazioso', 'No. 3. Allegro grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 6개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f422bdb8-c1e3-4a09-ac38-03c454873ece'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab58d689-cf00-4c37-9405-4f1a89d9a49b', 4, NULL, 'Presto ruvido', 'No. 4. Presto ruvido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 6개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab58d689-cf00-4c37-9405-4f1a89d9a49b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0713ad15-4fdc-43af-8dba-44010d376b1d', 5, NULL, 'Adagio. Mesto', 'No. 5. Adagio. Mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 6개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0713ad15-4fdc-43af-8dba-44010d376b1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d5c8ae1-9a62-44da-a285-a0bc8c849fc7', 6, NULL, 'Molto vivace. Capriccioso', 'No. 6. Molto vivace. Capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 6개의 바가텔' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d5c8ae1-9a62-44da-a285-a0bc8c849fc7'
);


-- None 무반주 첼로 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 첼로 소나타', 'Sonata for Cello Solo', 'album', NULL, NULL, NULL, 1953, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 첼로 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a90a8d5-48bb-4e54-9de5-430cc848214c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7a90a8d5-48bb-4e54-9de5-430cc848214c'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 첼로 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a90a8d5-48bb-4e54-9de5-430cc848214c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dfe9c04-148a-4353-b7cf-9d58248447a7', 1, 'I', 'Dialogo', 'I. Dialogo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 첼로 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dfe9c04-148a-4353-b7cf-9d58248447a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f67bdd99-03b4-41c4-a874-8fad95aef57c', 2, 'II', 'Capriccio', 'II. Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 첼로 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f67bdd99-03b4-41c4-a874-8fad95aef57c'
);


-- None 현악 4중주 1번 "밤의 변용"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 1번 "밤의 변용"', 'String Quartet no. 1 “Métamorphoses nocturnes”', 'album', NULL, NULL, NULL, 1954, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 1번 "밤의 변용"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e55d68f-ed32-4e77-921b-7b430e6cb463'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e55d68f-ed32-4e77-921b-7b430e6cb463'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e55d68f-ed32-4e77-921b-7b430e6cb463'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30f4cfc3-8320-4046-a975-ae04ba14c894', 1, 'I', 'Allegro grazioso', 'I. Allegro grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30f4cfc3-8320-4046-a975-ae04ba14c894'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bf7bdae-181f-4644-ab0b-c761f0de29e3', 2, 'II', 'Vivace, capriccioso', 'II. Vivace, capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bf7bdae-181f-4644-ab0b-c761f0de29e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4418e49f-6af1-497c-b12c-ba196585f88c', 3, 'III', 'Adagio, mesto', 'III. Adagio, mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4418e49f-6af1-497c-b12c-ba196585f88c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8334863e-f686-4268-b1c1-7daf1227cc20', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8334863e-f686-4268-b1c1-7daf1227cc20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd4ceaf7-9eba-48d0-84b1-908211f72a8d', 5, 'V', 'Andante tranquillo', 'V. Andante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd4ceaf7-9eba-48d0-84b1-908211f72a8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91827dc7-f8b1-46d4-9cc4-be25269ef351', 6, 'VI', 'Tempo di valse, moderato, con eleganza, un poco capriccioso', 'VI. Tempo di valse, moderato, con eleganza, un poco capriccioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91827dc7-f8b1-46d4-9cc4-be25269ef351'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0883e16d-b573-41f7-9e45-f18baabe2b84', 7, 'VII', 'Allegretto, un poco gioviale', 'VII. Allegretto, un poco gioviale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0883e16d-b573-41f7-9e45-f18baabe2b84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59489719-1976-441d-ba4f-344bbb9a07fe', 8, 'VIII', 'Prestissimo', 'VIII. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 1번 "밤의 변용"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59489719-1976-441d-ba4f-344bbb9a07fe'
);


-- None 혼성 합창을 위한 <밤과 아침>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창을 위한 <밤과 아침>', 'Éjszaka és Reggel', 'album', NULL, NULL, NULL, 1955, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창을 위한 <밤과 아침>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd8f19be-0a81-43bf-9cb1-7164a87a896e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd8f19be-0a81-43bf-9cb1-7164a87a896e'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '혼성 합창을 위한 <밤과 아침>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd8f19be-0a81-43bf-9cb1-7164a87a896e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8327d72-3c70-4164-8611-416e1dc315cc', 1, NULL, 'Éjszaka', 'Éjszaka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '혼성 합창을 위한 <밤과 아침>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8327d72-3c70-4164-8611-416e1dc315cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fe42815-2032-4c1f-bf48-f7ddb2011f61', 2, NULL, 'Reggel', 'Reggel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '혼성 합창을 위한 <밤과 아침>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fe42815-2032-4c1f-bf48-f7ddb2011f61'
);


-- None 관현악을 위한 <아파리시옹>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <아파리시옹>', 'Apparitions', 'album', NULL, NULL, NULL, 1959, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <아파리시옹>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dc327b7-263f-4052-90d1-81cc1d4369fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1dc327b7-263f-4052-90d1-81cc1d4369fd'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <아파리시옹>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1dc327b7-263f-4052-90d1-81cc1d4369fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8720d09-f242-4a83-b545-087d73f2e17e', 1, 'I', 'Lento', 'I. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <아파리시옹>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8720d09-f242-4a83-b545-087d73f2e17e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a8aedbe-6093-4d0f-926c-0a56659a1827', 2, 'II', 'Agitato', 'II. Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <아파리시옹>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a8aedbe-6093-4d0f-926c-0a56659a1827'
);


-- None 오르간을 위한 <볼루미나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 <볼루미나>', 'Volumina', 'song', NULL, NULL, NULL, 1962, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 <볼루미나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b9127a8-e742-40b1-a641-318b275b0f78'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b9127a8-e742-40b1-a641-318b275b0f78'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '오르간을 위한 <볼루미나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b9127a8-e742-40b1-a641-318b275b0f78'
);


-- None 100대의 메트로놈을 위한 <교향시>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '100대의 메트로놈을 위한 <교향시>', 'Poème symphonique for 100 metronomes', 'song', NULL, NULL, NULL, 1962, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '100대의 메트로놈을 위한 <교향시>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9022aa9a-4b59-405b-af7a-62edf32e7b78'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9022aa9a-4b59-405b-af7a-62edf32e7b78'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '100대의 메트로놈을 위한 <교향시>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9022aa9a-4b59-405b-af7a-62edf32e7b78'
);


-- None <아방튀르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아방튀르>', 'Aventures', 'song', NULL, NULL, NULL, 1962, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아방튀르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b56b4a12-68db-380f-992a-720146b13c23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b56b4a12-68db-380f-992a-720146b13c23'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<아방튀르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b56b4a12-68db-380f-992a-720146b13c23'
);


-- None <누벨 아방튀르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<누벨 아방튀르>', 'Nouvelles aventures', 'album', NULL, NULL, NULL, 1965, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<누벨 아방튀르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c179b97-269d-4c5e-a0dd-4a1296bee682'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c179b97-269d-4c5e-a0dd-4a1296bee682'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<누벨 아방튀르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c179b97-269d-4c5e-a0dd-4a1296bee682'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cfd73fa-6234-4612-ac0d-b0163ecb4084', 1, 'I', 'Sostenuto', 'I. Sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<누벨 아방튀르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cfd73fa-6234-4612-ac0d-b0163ecb4084'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9884cdaa-4cc7-4286-96ce-e31e6226206c', 2, 'II', 'Agitato molto', 'II. Agitato molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<누벨 아방튀르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9884cdaa-4cc7-4286-96ce-e31e6226206c'
);


-- None 첼로 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 협주곡', 'Concerto for Violoncello and Orchestra', 'song', NULL, NULL, NULL, 1966, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e70301ec-98df-4436-a784-220020edb78d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e70301ec-98df-4436-a784-220020edb78d'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '첼로 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e70301ec-98df-4436-a784-220020edb78d'
);


-- None 관현악을 위한 <론타노>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <론타노>', 'Lontano', 'song', NULL, NULL, NULL, 1967, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <론타노>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc138d50-6106-41d9-9775-8401d7046356'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc138d50-6106-41d9-9775-8401d7046356'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <론타노>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc138d50-6106-41d9-9775-8401d7046356'
);


-- None 하프시코드를 위한 <콘티누움>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드를 위한 <콘티누움>', 'Continuum', 'song', NULL, NULL, NULL, 1968, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드를 위한 <콘티누움>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b73cb9fc-1217-4326-a005-3ef4ae4e235c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b73cb9fc-1217-4326-a005-3ef4ae4e235c'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '하프시코드를 위한 <콘티누움>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b73cb9fc-1217-4326-a005-3ef4ae4e235c'
);


-- None 목관 5중주를 위한 10개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '목관 5중주를 위한 10개의 소품', 'Ten Pieces for Wind Quintet', 'album', NULL, NULL, NULL, 1968, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '목관 5중주를 위한 10개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5e7b409-e50d-4d2f-ae45-30fc474512e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5e7b409-e50d-4d2f-ae45-30fc474512e2'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5e7b409-e50d-4d2f-ae45-30fc474512e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e0da601-1ae7-44ea-a6ea-a661b714173a', 1, 'I', 'Molto sostenuto e calmo', 'I. Molto sostenuto e calmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e0da601-1ae7-44ea-a6ea-a661b714173a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d227347f-8248-4bbc-93a5-d505e0391e4e', 2, 'II', 'Prestissimo minaccioso e burlesco', 'II. Prestissimo minaccioso e burlesco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d227347f-8248-4bbc-93a5-d505e0391e4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4a0a7f7-a792-4cf3-8fd7-0104314dc54d', 3, 'III', 'Lento', 'III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4a0a7f7-a792-4cf3-8fd7-0104314dc54d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d06edcb-0e49-4759-94d4-46be54895684', 4, 'IV', 'Prestissimo leggiero e virtuoso', 'IV. Prestissimo leggiero e virtuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d06edcb-0e49-4759-94d4-46be54895684'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb6b1901-aedc-40f2-9663-cdc8237af30b', 5, 'V', 'Prestissimo staccatissimo e leggiero', 'V. Prestissimo staccatissimo e leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb6b1901-aedc-40f2-9663-cdc8237af30b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d66f74d7-affd-4831-a2b1-91321dc27469', 6, 'VI', 'Prestissimo staccatissimo e leggiero', 'VI. Prestissimo staccatissimo e leggiero', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d66f74d7-affd-4831-a2b1-91321dc27469'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c331c4ef-939e-40e8-b1fe-0f7350cdd3b1', 7, 'VII', 'Vivo, energico', 'VII. Vivo, energico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c331c4ef-939e-40e8-b1fe-0f7350cdd3b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d90d2045-4106-4841-81db-56165c208872', 8, 'VIII', 'Allegro con delicatezza', 'VIII. Allegro con delicatezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d90d2045-4106-4841-81db-56165c208872'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9002d2b-8cc1-4d7e-8a9e-7fba6c346d42', 9, 'IX', 'Sostenuto, stridente', 'IX. Sostenuto, stridente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9002d2b-8cc1-4d7e-8a9e-7fba6c346d42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfb149da-bff8-466a-8892-3dc9e48f5852', 10, 'X', 'Presto bizzarro e rubato', 'X. Presto bizzarro e rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '목관 5중주를 위한 10개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfb149da-bff8-466a-8892-3dc9e48f5852'
);


-- None 현악 4중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 2번', 'String Quartet no. 2', 'album', NULL, NULL, NULL, 1968, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2b2083b-28ba-4194-ad95-6bd2077f5402'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2b2083b-28ba-4194-ad95-6bd2077f5402'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2b2083b-28ba-4194-ad95-6bd2077f5402'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c0ffb50-bfc2-40b3-b784-f23ecd17d11a', 1, 'I', 'Allegro nervoso', 'I. Allegro nervoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c0ffb50-bfc2-40b3-b784-f23ecd17d11a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55072069-7741-447d-9d8e-0959300a2453', 2, 'II', 'Sostenuto, molto calmo', 'II. Sostenuto, molto calmo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55072069-7741-447d-9d8e-0959300a2453'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec718c31-f44c-42e1-a470-32f8c90a5786', 3, 'III', 'Come un meccanismo di precisione', 'III. Come un meccanismo di precisione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec718c31-f44c-42e1-a470-32f8c90a5786'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:128bca22-e191-4e17-94e1-5f738c4bf402', 4, 'IV', 'Presto furioso, brutale, tumultuoso', 'IV. Presto furioso, brutale, tumultuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:128bca22-e191-4e17-94e1-5f738c4bf402'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2698c941-67f7-4fcb-a5c1-369e17c7bccc', 5, 'V', 'Allegro con delicatezza – stets sehr mild', 'V. Allegro con delicatezza – stets sehr mild', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 4중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2698c941-67f7-4fcb-a5c1-369e17c7bccc'
);


-- None 오르간을 위한 2개의 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간을 위한 2개의 연습곡', 'Two Studies for Organ', 'album', NULL, NULL, NULL, 1969, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간을 위한 2개의 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30c001a8-a81b-4410-8089-51b7621316a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '30c001a8-a81b-4410-8089-51b7621316a8'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '오르간을 위한 2개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '30c001a8-a81b-4410-8089-51b7621316a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be70f16e-5531-472d-bcf1-9015681e7df8', 1, 'I', 'Harmonies', 'I. Harmonies', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '오르간을 위한 2개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be70f16e-5531-472d-bcf1-9015681e7df8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:749071db-4250-44ff-9fa4-62f02fd1f80a', 2, 'II', 'Coulée', 'II. Coulée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '오르간을 위한 2개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:749071db-4250-44ff-9fa4-62f02fd1f80a'
);


-- None 현악 합주를 위한 <라미피카시옹>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 합주를 위한 <라미피카시옹>', 'Ramifications', 'song', NULL, NULL, NULL, 1969, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 합주를 위한 <라미피카시옹>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9374517f-7972-4991-a964-6499d3a318bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9374517f-7972-4991-a964-6499d3a318bf'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '현악 합주를 위한 <라미피카시옹>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9374517f-7972-4991-a964-6499d3a318bf'
);


-- None 실내 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '실내 협주곡', 'Chamber Concerto', 'album', NULL, NULL, NULL, 1970, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '실내 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09df6db9-5178-4ee3-ad20-c0a3cb311dd2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09df6db9-5178-4ee3-ad20-c0a3cb311dd2'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '실내 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09df6db9-5178-4ee3-ad20-c0a3cb311dd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fde51d3-40b0-4217-ae6a-91216e1a555c', 1, 'I', 'Corrente (Fliessend)', 'I. Corrente (Fliessend)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '실내 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fde51d3-40b0-4217-ae6a-91216e1a555c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:955909f0-d8fb-4213-8ff4-56cf34a7c1c5', 2, 'II', 'Calmo, sostenuto', 'II. Calmo, sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '실내 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:955909f0-d8fb-4213-8ff4-56cf34a7c1c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bde4029-84ea-44d1-bebc-5f8e9df9af66', 3, 'III', 'Movimento preciso e meccanico', 'III. Movimento preciso e meccanico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '실내 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bde4029-84ea-44d1-bebc-5f8e9df9af66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ea91b68-7635-4f70-b8f9-cec44ef3829c', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '실내 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ea91b68-7635-4f70-b8f9-cec44ef3829c'
);


-- None 관현악을 위한 <멜로디엔>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <멜로디엔>', 'Melodien', 'song', NULL, NULL, NULL, 1971, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <멜로디엔>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0bd4ea1-3ce1-426a-ad0b-44287ad4d2a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0bd4ea1-3ce1-426a-ad0b-44287ad4d2a4'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <멜로디엔>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0bd4ea1-3ce1-426a-ad0b-44287ad4d2a4'
);


-- None 플루트와 오보에를 위한 이중 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 오보에를 위한 이중 협주곡', 'Double Concerto for Flute and Oboe', 'album', NULL, NULL, NULL, 1972, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 오보에를 위한 이중 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd7829ce-a01f-424b-8ef1-5457d7dda2e7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd7829ce-a01f-424b-8ef1-5457d7dda2e7'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '플루트와 오보에를 위한 이중 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd7829ce-a01f-424b-8ef1-5457d7dda2e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8db5af70-4ef6-4bf0-9b89-b3fff2e44e74', 1, 'I', 'Calmo, con tenerezza', 'I. Calmo, con tenerezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '플루트와 오보에를 위한 이중 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8db5af70-4ef6-4bf0-9b89-b3fff2e44e74'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b09bf84f-5ba7-4856-ac25-f75ad99e6491', 2, 'II', 'Allegro corrente', 'II. Allegro corrente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '플루트와 오보에를 위한 이중 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b09bf84f-5ba7-4856-ac25-f75ad99e6491'
);


-- None 여성 합창과 관현악을 위한 <시계와 구름>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 합창과 관현악을 위한 <시계와 구름>', 'Clocks and Clouds', 'song', NULL, NULL, NULL, 1973, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 합창과 관현악을 위한 <시계와 구름>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef3c6a7b-0d7f-4c40-9ed2-7ff5fc66c26d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef3c6a7b-0d7f-4c40-9ed2-7ff5fc66c26d'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '여성 합창과 관현악을 위한 <시계와 구름>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef3c6a7b-0d7f-4c40-9ed2-7ff5fc66c26d'
);


-- None 관현악을 위한 <샌프란시스코 폴리포니>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 <샌프란시스코 폴리포니>', 'San Francisco Polyphony', 'song', NULL, NULL, NULL, 1974, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 <샌프란시스코 폴리포니>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05665fce-4f85-4df8-9438-5dcc233868c3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05665fce-4f85-4df8-9438-5dcc233868c3'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '관현악을 위한 <샌프란시스코 폴리포니>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05665fce-4f85-4df8-9438-5dcc233868c3'
);


-- None 두 대의 피아노를 위한 3개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 3개의 소품', 'Three Pieces', 'album', NULL, NULL, NULL, 1976, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 3개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9774fe6-1a03-414a-b7ed-88bb17af17b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9774fe6-1a03-414a-b7ed-88bb17af17b8'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '두 대의 피아노를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9774fe6-1a03-414a-b7ed-88bb17af17b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:61189e66-ce2e-4117-a04e-d205940e49c0', 1, 'I', 'Monument', 'I. Monument', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '두 대의 피아노를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:61189e66-ce2e-4117-a04e-d205940e49c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfe7e61d-b289-4239-9f29-3f103b91d804', 2, 'II', 'Selbstportrait mit Reich und Riley (und Chopin ist auch dabei)', 'II. Selbstportrait mit Reich und Riley (und Chopin ist auch dabei)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '두 대의 피아노를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfe7e61d-b289-4239-9f29-3f103b91d804'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fef95a85-7627-491d-aeea-5f25b45c3d78', 3, 'III', 'Bewegung', 'III. Bewegung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '두 대의 피아노를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fef95a85-7627-491d-aeea-5f25b45c3d78'
);


-- None 오페라 <르 그랑 마카브르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <르 그랑 마카브르>', 'Le Grand Macabre', 'song', NULL, NULL, NULL, 1977, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <르 그랑 마카브르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06919bf3-46d3-487b-8e33-e386c2b03d5d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06919bf3-46d3-487b-8e33-e386c2b03d5d'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '오페라 <르 그랑 마카브르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06919bf3-46d3-487b-8e33-e386c2b03d5d'
);


-- None 하프시코드를 위한 <파사칼리아 웅게레세>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드를 위한 <파사칼리아 웅게레세>', 'Passacaglia ungherese', 'song', NULL, NULL, NULL, 1978, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드를 위한 <파사칼리아 웅게레세>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98414f7b-693b-417f-b4c0-80e03a4e2af1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '98414f7b-693b-417f-b4c0-80e03a4e2af1'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '하프시코드를 위한 <파사칼리아 웅게레세>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '98414f7b-693b-417f-b4c0-80e03a4e2af1'
);


-- None 하프시코드를 위한 <헝가리안 록>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하프시코드를 위한 <헝가리안 록>', 'Hungarian Rock', 'song', NULL, NULL, NULL, 1978, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하프시코드를 위한 <헝가리안 록>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f40d9e66-a05b-41f2-89c0-78442fbebc22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f40d9e66-a05b-41f2-89c0-78442fbebc22'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '하프시코드를 위한 <헝가리안 록>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f40d9e66-a05b-41f2-89c0-78442fbebc22'
);


-- None 바이올린, 호른, 피아노를 위한 3중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린, 호른, 피아노를 위한 3중주', 'Trio for Violin, Horn, and Piano', 'album', NULL, NULL, NULL, 1982, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린, 호른, 피아노를 위한 3중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dc21b20-6789-4e49-9a15-e7c86c51d6c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4dc21b20-6789-4e49-9a15-e7c86c51d6c4'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린, 호른, 피아노를 위한 3중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4dc21b20-6789-4e49-9a15-e7c86c51d6c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12dcb081-9770-4158-8117-1b4aebf562c2', 1, 'I', 'Andantino con tenerezza', 'I. Andantino con tenerezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린, 호른, 피아노를 위한 3중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12dcb081-9770-4158-8117-1b4aebf562c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39637a8f-afbc-46f7-82f6-6a6b68344379', 2, 'II', 'Vivacissimo molto ritmico', 'II. Vivacissimo molto ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린, 호른, 피아노를 위한 3중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39637a8f-afbc-46f7-82f6-6a6b68344379'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc4b6ece-b4b9-4dcc-905a-301fc1640d85', 3, 'III', 'Alla marcia', 'III. Alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린, 호른, 피아노를 위한 3중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc4b6ece-b4b9-4dcc-905a-301fc1640d85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44aceee4-0bc4-4662-8580-e97748d17b8a', 4, 'IV', 'Lamento. Adagio', 'IV. Lamento. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린, 호른, 피아노를 위한 3중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44aceee4-0bc4-4662-8580-e97748d17b8a'
);


-- None 횔덜린에 의한 3개의 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '횔덜린에 의한 3개의 환상곡', 'Drei Phantasien nach Friedrich Hölderlin', 'album', NULL, NULL, NULL, 1982, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '횔덜린에 의한 3개의 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '768e3353-5ec6-4d9c-a2bb-1aee101c5c22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '768e3353-5ec6-4d9c-a2bb-1aee101c5c22'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '횔덜린에 의한 3개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '768e3353-5ec6-4d9c-a2bb-1aee101c5c22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7afd348-7451-4c7a-92ed-60d06f75f66b', 1, 'I', 'Hälfte des Lebens', 'I. Hälfte des Lebens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '횔덜린에 의한 3개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7afd348-7451-4c7a-92ed-60d06f75f66b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57d4939a-d721-43d9-bc74-caa2e8f4fffe', 2, 'II', 'Wenn aus der Ferne', 'II. Wenn aus der Ferne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '횔덜린에 의한 3개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57d4939a-d721-43d9-bc74-caa2e8f4fffe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c44f72fe-214c-4e43-9094-9b7340b8e910', 3, 'III', 'Abendphantasie', 'III. Abendphantasie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '횔덜린에 의한 3개의 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c44f72fe-214c-4e43-9094-9b7340b8e910'
);


-- None <헝가리 연습곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헝가리 연습곡>', 'Magyar etűdök', 'album', NULL, NULL, NULL, 1983, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<헝가리 연습곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73729b98-4051-4980-a600-55bfc65bf162'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '73729b98-4051-4980-a600-55bfc65bf162'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<헝가리 연습곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '73729b98-4051-4980-a600-55bfc65bf162'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94c286d5-5aba-4dc6-b436-dcafc9c191d6', 1, 'I', '9. etüd (Spiegelkanon)', 'I. 9. etüd (Spiegelkanon)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<헝가리 연습곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94c286d5-5aba-4dc6-b436-dcafc9c191d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59716773-f226-4aa7-bb7d-0e082ed3130c', 2, 'II', '49. etüd / 40. etüd', 'II. 49. etüd / 40. etüd', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<헝가리 연습곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59716773-f226-4aa7-bb7d-0e082ed3130c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fc43363-279a-4658-935d-a4f18210a4ee', 3, 'III', '90. etüd (Vásár)', 'III. 90. etüd (Vásár)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<헝가리 연습곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fc43363-279a-4658-935d-a4f18210a4ee'
);


-- None 피아노 연습곡 1권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연습곡 1권', 'Études pour piano, Book 1', 'album', NULL, NULL, NULL, 1985, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연습곡 1권'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4d58021-01fd-49af-b8a5-f723eb29129f', 1, NULL, 'Désordre', 'No. 1. Désordre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4d58021-01fd-49af-b8a5-f723eb29129f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e48a5e9a-dca2-4b34-9b9d-99aab70a725e', 2, NULL, 'Cordes vides', 'No. 2. Cordes vides', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48a5e9a-dca2-4b34-9b9d-99aab70a725e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b532519-b70b-4263-8f38-e6139fb1b93a', 3, NULL, 'Touches bloquées', 'No. 3. Touches bloquées', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b532519-b70b-4263-8f38-e6139fb1b93a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff9e3df6-491f-3ac5-a92c-a96b25475985', 4, NULL, 'Fanfares', 'No. 4. Fanfares', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff9e3df6-491f-3ac5-a92c-a96b25475985'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0be331d3-3e13-4920-ad07-7d57b7e9a235', 5, NULL, 'Arc-en-ciel', 'No. 5. Arc-en-ciel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0be331d3-3e13-4920-ad07-7d57b7e9a235'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd0413e7-1896-4c5a-b7ee-346d73c4b4ed', 6, NULL, 'Automne à Varsovie', 'No. 6. Automne à Varsovie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd0413e7-1896-4c5a-b7ee-346d73c4b4ed'
);


-- None 피아노 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡', 'Concerto for Piano and Orchestra', 'album', NULL, NULL, NULL, 1988, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09b11afd-a9a4-4fa0-b27a-efc51dc77bce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '09b11afd-a9a4-4fa0-b27a-efc51dc77bce'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '09b11afd-a9a4-4fa0-b27a-efc51dc77bce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91a0a1c6-196d-4c25-91af-15030198361b', 1, 'I', 'Vivace molto ritmico e preciso - attacca subito', 'I. Vivace molto ritmico e preciso - attacca subito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91a0a1c6-196d-4c25-91af-15030198361b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55f2cb7c-066f-4ef1-9f1a-26c4bc8d975f', 2, 'II', 'Lento e deserto', 'II. Lento e deserto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55f2cb7c-066f-4ef1-9f1a-26c4bc8d975f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c4ceebd-9ee2-464f-9847-b4fe24b693d8', 3, 'III', 'Vivace cantabile', 'III. Vivace cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c4ceebd-9ee2-464f-9847-b4fe24b693d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b320585-3334-46f9-9d24-0ee7b0bdd2d8', 4, 'IV', 'Allegro, risoluto, colto ritmico - attacca subito', 'IV. Allegro, risoluto, colto ritmico - attacca subito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b320585-3334-46f9-9d24-0ee7b0bdd2d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06cb0d6f-0a83-4c95-9119-df8ea6cc2cec', 5, 'V', 'Presto luminoso: fluido, constate, sempre molto ritmico', 'V. Presto luminoso: fluido, constate, sempre molto ritmico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06cb0d6f-0a83-4c95-9119-df8ea6cc2cec'
);


-- None 바이올린 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡', 'Violin Concerto', 'album', NULL, NULL, NULL, 1993, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f748e07c-c2e6-4e0c-9e8e-37e865e235ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f748e07c-c2e6-4e0c-9e8e-37e865e235ea'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f748e07c-c2e6-4e0c-9e8e-37e865e235ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21b2a698-04b9-4254-b49e-ad36126ea4f3', 1, 'I', 'Vivacissimo luminoso', 'I. Vivacissimo luminoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21b2a698-04b9-4254-b49e-ad36126ea4f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e8fcbff-d036-4d4f-b56d-f3ef93513748', 2, 'II', 'Aria, Hoquetus, Choral. Andante con moto', 'II. Aria, Hoquetus, Choral. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e8fcbff-d036-4d4f-b56d-f3ef93513748'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60aa7d51-4aa9-4372-912d-e826d2f0ed97', 3, 'III', '인테르메초. Presto fluido', 'III. Intermezzo. Presto fluido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60aa7d51-4aa9-4372-912d-e826d2f0ed97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:110f2c97-57e7-48f5-a8f7-35c650f63c47', 4, 'IV', '파사칼리아. Lento intenso', 'IV. Passacaglia. Lento intenso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:110f2c97-57e7-48f5-a8f7-35c650f63c47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bda0f1d-a224-455d-8bc6-511094d82045', 5, 'V', 'Appassionato. Agitato molto', 'V. Appassionato. Agitato molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '바이올린 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bda0f1d-a224-455d-8bc6-511094d82045'
);


-- None <난센스 마드리갈>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<난센스 마드리갈>', 'Nonsense Madrigals', 'album', NULL, NULL, NULL, 1993, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<난센스 마드리갈>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f7deb6d-c410-4de3-a068-332df37a38f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f7deb6d-c410-4de3-a068-332df37a38f0'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<난센스 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f7deb6d-c410-4de3-a068-332df37a38f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8866d266-ca56-46fa-a91d-79aa228ee5d5', 1, 'I', 'Two Dreams and Little Bat', 'I. Two Dreams and Little Bat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<난센스 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8866d266-ca56-46fa-a91d-79aa228ee5d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f5d9505-5fa0-4bcf-aaa3-d9c84c6d5d2f', 2, 'II', 'Cuckoo in the Pear-Tree', 'II. Cuckoo in the Pear-Tree', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<난센스 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f5d9505-5fa0-4bcf-aaa3-d9c84c6d5d2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d55f24ff-5bce-4f69-90ab-478b866e10b2', 3, 'III', 'The Alphabet', 'III. The Alphabet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<난센스 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d55f24ff-5bce-4f69-90ab-478b866e10b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:452f6708-fa12-4c95-b949-97030abd7867', 4, 'IV', 'Flying Robert', 'IV. Flying Robert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<난센스 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:452f6708-fa12-4c95-b949-97030abd7867'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d435f0f8-26a1-4db0-893d-0aae63906df2', 5, 'V', 'The Lobster Quadrille', 'V. The Lobster Quadrille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<난센스 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d435f0f8-26a1-4db0-893d-0aae63906df2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c82d507-6de8-4454-bd38-6c84353424fd', 6, 'VI', 'A Long, Sad Tale', 'VI. A Long, Sad Tale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '<난센스 마드리갈>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c82d507-6de8-4454-bd38-6c84353424fd'
);


-- None 피아노 연습곡 2권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연습곡 2권', 'Études pour piano, Book 2', 'album', NULL, NULL, NULL, 1994, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연습곡 2권'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92a48ed7-a717-4788-b83f-93b57b4e5e73', 7, NULL, 'Galamb borong', 'No. 7. Galamb borong', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92a48ed7-a717-4788-b83f-93b57b4e5e73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99fd25ea-16b9-3551-8353-b963db6c8277', 8, NULL, 'Fém', 'No. 8. Fém', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99fd25ea-16b9-3551-8353-b963db6c8277'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2dc2a436-2720-417e-a552-831fafe440e3', 9, NULL, 'Vertige', 'No. 9. Vertige', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dc2a436-2720-417e-a552-831fafe440e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ebf19aa-3c97-41ae-b9ae-14aa47924e2b', 10, NULL, 'Der Zauberlehrling', 'No. 10. Der Zauberlehrling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ebf19aa-3c97-41ae-b9ae-14aa47924e2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ea7f3f6-399a-4558-86a5-88fea6bd14d6', 11, NULL, 'En suspens', 'No. 11. En suspens', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ea7f3f6-399a-4558-86a5-88fea6bd14d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7783d85-74df-3523-bdc5-4d9e1cf1ffa9', 12, NULL, 'Entrelacs', 'No. 12. Entrelacs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7783d85-74df-3523-bdc5-4d9e1cf1ffa9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:622d4b0d-d145-406f-a4d5-22ff2ba4d982', 13, NULL, 'L’Escalier du Diable', 'No. 13. L’Escalier du Diable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:622d4b0d-d145-406f-a4d5-22ff2ba4d982'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30b75ec6-0798-414e-98ce-51a77361add9', 14, NULL, 'Coloana infinită', 'No. 14. Coloana infinită', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b75ec6-0798-414e-98ce-51a77361add9'
);


-- None 무반주 비올라 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 비올라 소나타', 'Sonata for Solo Viola', 'album', NULL, NULL, NULL, 1994, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 비올라 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9c04559-a472-4a22-9d2e-3f31840fcb83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9c04559-a472-4a22-9d2e-3f31840fcb83'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9c04559-a472-4a22-9d2e-3f31840fcb83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:131b240e-2d75-475c-84f8-649b5ef82285', 1, 'I', 'Hora lungă', 'I. Hora lungă', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:131b240e-2d75-475c-84f8-649b5ef82285'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17f464a2-db2e-45c8-b40a-b596c05691d3', 2, 'II', 'Loop', 'II. Loop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17f464a2-db2e-45c8-b40a-b596c05691d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fab5dba2-4ef5-40e8-a49e-4dbe08b43720', 3, 'III', 'Facsar', 'III. Facsar', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fab5dba2-4ef5-40e8-a49e-4dbe08b43720'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22f0c187-78fb-4789-b200-9c8967fbac3f', 4, 'IV', 'Prestissimo con sordino', 'IV. Prestissimo con sordino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22f0c187-78fb-4789-b200-9c8967fbac3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4f3cd27-d20f-4069-9819-104988099957', 5, 'V', 'Lamento', 'V. Lamento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4f3cd27-d20f-4069-9819-104988099957'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64196fbd-8fe7-48ee-9aaf-9b7f930225d0', 6, 'VI', 'Chaconne chromatique', 'VI. Chaconne chromatique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '무반주 비올라 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64196fbd-8fe7-48ee-9aaf-9b7f930225d0'
);


-- None 호른과 실내 관현악을 위한 <함부르크 협주곡>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른과 실내 관현악을 위한 <함부르크 협주곡>', 'Hamburg Concerto', 'album', NULL, NULL, NULL, 1999, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51339cc0-2077-4552-a06d-2d6e123e7abd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51339cc0-2077-4552-a06d-2d6e123e7abd'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51339cc0-2077-4552-a06d-2d6e123e7abd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c4fbe2d-3c7f-4b68-afc5-67524a6d9ed7', 1, 'I', '전주곡', 'I. Praeludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c4fbe2d-3c7f-4b68-afc5-67524a6d9ed7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c0eeee2-604f-4c9a-b043-52ff86cef4b2', 2, 'II', 'Signale, Tanz, Choral', 'II. Signale, Tanz, Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c0eeee2-604f-4c9a-b043-52ff86cef4b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:300d50c5-9ec7-4541-aa91-8254166fa4a7', 3, 'III', 'Aria, Aksak, Hoketus', 'III. Aria, Aksak, Hoketus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:300d50c5-9ec7-4541-aa91-8254166fa4a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb8d94c9-218c-406f-b3e9-94c7d37436ef', 4, 'IV', 'Soto, Intermezzo, Mictur, Kanon', 'IV. Soto, Intermezzo, Mictur, Kanon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb8d94c9-218c-406f-b3e9-94c7d37436ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46745147-b46e-4923-bbbf-fb04c3623b27', 5, 'V', 'Spectra', 'V. Spectra', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46745147-b46e-4923-bbbf-fb04c3623b27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6997cb18-9f0e-4703-ab37-0d7669856184', 6, 'VI', 'Capriccio', 'VI. Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6997cb18-9f0e-4703-ab37-0d7669856184'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acb9c6a0-b3c9-4812-aa90-32846ecc4fac', 7, 'VII', 'Hymnus', 'VII. Hymnus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acb9c6a0-b3c9-4812-aa90-32846ecc4fac'
);


-- None 연가곡 <Síppal, dobbal, nádihegedűvel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡 <Síppal, dobbal, nádihegedűvel>', 'Síppal, dobbal, nádihegedűvel', 'album', NULL, NULL, NULL, 2000, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡 <Síppal, dobbal, nádihegedűvel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de03ac64-f7d2-4541-9566-81afdce46399'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de03ac64-f7d2-4541-9566-81afdce46399'
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de03ac64-f7d2-4541-9566-81afdce46399'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31b91a7f-083a-49ac-ba88-c6f94310fde1', 1, 'I', 'Fabula', 'I. Fabula', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31b91a7f-083a-49ac-ba88-c6f94310fde1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d663d88-65ef-456f-a95e-26cd27f54977', 2, 'II', 'Táncdal', 'II. Táncdal', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d663d88-65ef-456f-a95e-26cd27f54977'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7276075-8c58-41b6-9d32-e82ce9c901c3', 3, 'III', 'Kínai templom', 'III. Kínai templom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7276075-8c58-41b6-9d32-e82ce9c901c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:175cd4bd-d26a-4321-9fc3-b4733bc2c110', 4, 'IV', 'Kuli', 'IV. Kuli', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:175cd4bd-d26a-4321-9fc3-b4733bc2c110'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4d24a54-5ca1-4b14-8fbd-b7e66a0934c2', 5, 'V', 'Alma álma', 'V. Alma álma', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4d24a54-5ca1-4b14-8fbd-b7e66a0934c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27b99bd4-2d45-4b5d-a5fc-6eead6f5627a', 6, 'VI', 'Keserédes', 'VI. Keserédes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27b99bd4-2d45-4b5d-a5fc-6eead6f5627a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9551ba2-746f-4c83-8e47-6566580fcfa3', 7, 'VII', 'Szajkó', 'VII. Szajkó', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9551ba2-746f-4c83-8e47-6566580fcfa3'
);


-- None 피아노 연습곡 3권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연습곡 3권', 'Études pour piano, Book 3', 'album', NULL, NULL, NULL, 2001, 'manual', 1
FROM composers c
WHERE c.id = 499
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연습곡 3권'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b8b125c-f8b8-4a5e-a5ca-5916e8b88c45', 15, NULL, 'White on White', 'No. 15. White on White', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b8b125c-f8b8-4a5e-a5ca-5916e8b88c45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02d1ce3b-84de-3752-b1b1-6bf2359f8a53', 16, NULL, 'Pour Irina', 'No. 16. Pour Irina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02d1ce3b-84de-3752-b1b1-6bf2359f8a53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69596c9e-9443-343f-9602-7a5ee5a9c861', 17, NULL, 'À bout de souffle', 'No. 17. À bout de souffle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69596c9e-9443-343f-9602-7a5ee5a9c861'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c49dda6-5996-3261-a7f0-0eeae99cb422', 18, NULL, 'Canon', 'No. 18. Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 499 AND p.title = '피아노 연습곡 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c49dda6-5996-3261-a7f0-0eeae99cb422'
);


-- 장르·형식(works.tsv). 비어 있을 때만 채운다.
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 499 AND title = '관현악을 위한 <루마니아 협주곡>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE composer_id = 499 AND title = '피아노 연탄을 위한 소나티나' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 499 AND title = '베외레스의 시에 의한 3개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 499 AND title = '아라니의 시에 의한 5개의 가곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'character'
WHERE composer_id = 499 AND title = '무지카 리체르카타' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE composer_id = 499 AND title = '목관 5중주를 위한 6개의 바가텔' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 499 AND title = '무반주 첼로 소나타' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 499 AND title = '현악 4중주 1번 "밤의 변용"' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 499 AND title = '혼성 합창을 위한 <밤과 아침>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 499 AND title = '관현악을 위한 <아파리시옹>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE composer_id = 499 AND title = '오르간을 위한 <볼루미나>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'chamber_other'
WHERE composer_id = 499 AND title = '100대의 메트로놈을 위한 <교향시>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE composer_id = 499 AND title = '<아방튀르>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'vocal_other'
WHERE composer_id = 499 AND title = '<누벨 아방튀르>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'cello_concerto'
WHERE composer_id = 499 AND title = '첼로 협주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 499 AND title = '관현악을 위한 <론타노>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE composer_id = 499 AND title = '하프시코드를 위한 <콘티누움>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'wind_chamber'
WHERE composer_id = 499 AND title = '목관 5중주를 위한 10개의 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'string_quartet'
WHERE composer_id = 499 AND title = '현악 4중주 2번' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'organ'
WHERE composer_id = 499 AND title = '오르간을 위한 2개의 연습곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 499 AND title = '현악 합주를 위한 <라미피카시옹>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'other_concerto'
WHERE composer_id = 499 AND title = '실내 협주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 499 AND title = '관현악을 위한 <멜로디엔>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 499 AND title = '플루트와 오보에를 위한 이중 협주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 499 AND title = '여성 합창과 관현악을 위한 <시계와 구름>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'orchestral', form_key = 'orchestral_other'
WHERE composer_id = 499 AND title = '관현악을 위한 <샌프란시스코 폴리포니>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'four_hands'
WHERE composer_id = 499 AND title = '두 대의 피아노를 위한 3개의 소품' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'stage', form_key = 'opera'
WHERE composer_id = 499 AND title = '오페라 <르 그랑 마카브르>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE composer_id = 499 AND title = '하프시코드를 위한 <파사칼리아 웅게레세>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'piano_other'
WHERE composer_id = 499 AND title = '하프시코드를 위한 <헝가리안 록>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'piano_chamber'
WHERE composer_id = 499 AND title = '바이올린, 호른, 피아노를 위한 3중주' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 499 AND title = '횔덜린에 의한 3개의 환상곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 499 AND title = '<헝가리 연습곡>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'etude'
WHERE composer_id = 499 AND title = '피아노 연습곡 1권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'piano_concerto'
WHERE composer_id = 499 AND title = '피아노 협주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'violin_concerto'
WHERE composer_id = 499 AND title = '바이올린 협주곡' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'choral'
WHERE composer_id = 499 AND title = '<난센스 마드리갈>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'etude'
WHERE composer_id = 499 AND title = '피아노 연습곡 2권' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'chamber', form_key = 'solo'
WHERE composer_id = 499 AND title = '무반주 비올라 소나타' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'concerto', form_key = 'wind_concerto'
WHERE composer_id = 499 AND title = '호른과 실내 관현악을 위한 <함부르크 협주곡>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'vocal', form_key = 'song'
WHERE composer_id = 499 AND title = '연가곡 <Síppal, dobbal, nádihegedűvel>' AND genre IS NULL AND form_key IS NULL;
UPDATE pieces SET genre = 'piano', form_key = 'etude'
WHERE composer_id = 499 AND title = '피아노 연습곡 3권' AND genre IS NULL AND form_key IS NULL;
