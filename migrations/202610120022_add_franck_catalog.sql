-- 프랑크 작품을 출판 단위로 채운다(카탈로그: FWV). 작품 107개(묶음 5, 다악장 14, 낱곡 88),
-- 새 작품 105개, 기존 작품 2개, part 114개, 그 아래 63개, 기존 낱곡 연결 1개.
--
-- 정한 것
--   FWV 가 있거나 영어 목록에 있는 현존 원작만. 곡마다 FWV 가 따로면 같은 책이어도 낱개 작품.
--   181 「생명의 양식」은 <3성 미사> FWV 61 의 5악장과 같은 곡(MBID 같음)이라 그 part 로 잇는다.
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

-- FWV 1 피아노 3중주 1번 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 1번 F#단조', 'Piano Trio No. 1 in F# minor', 'album', 'FWV 1', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 1번 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e762a0ee-a78d-4f40-bdc2-0df95cfc6605'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e762a0ee-a78d-4f40-bdc2-0df95cfc6605'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e762a0ee-a78d-4f40-bdc2-0df95cfc6605'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bf27682-829e-4174-b54d-16b522eb895d', 1, 'I', 'Andante con moto', 'I. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bf27682-829e-4174-b54d-16b522eb895d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ccdeac1-92af-4755-a6df-f8d76ea77e18', 2, 'II', 'Allegro molto', 'II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ccdeac1-92af-4755-a6df-f8d76ea77e18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b45f90b-c47c-4875-9159-80cc7554604e', 3, 'III', '피날레. Allegro maestoso', 'III. Finale. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 1번 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b45f90b-c47c-4875-9159-80cc7554604e'
);


-- FWV 2 피아노 3중주 2번 B♭장조 "살롱 3중주"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 2번 B♭장조 "살롱 3중주"', 'Piano Trio No. 2 in B♭ major "Trio de salon"', 'album', 'FWV 2', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 2번 B♭장조 "살롱 3중주"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c54e4392-238e-4ccb-b983-c534530ffe53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c54e4392-238e-4ccb-b983-c534530ffe53'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 2번 B♭장조 "살롱 3중주"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c54e4392-238e-4ccb-b983-c534530ffe53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa08d6e6-434f-4eac-8680-064ecfc426be', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 2번 B♭장조 "살롱 3중주"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa08d6e6-434f-4eac-8680-064ecfc426be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c62f57b1-0bc5-45c6-b7ae-20f7be31ba66', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 2번 B♭장조 "살롱 3중주"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c62f57b1-0bc5-45c6-b7ae-20f7be31ba66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b3a5d37-21a8-4fc1-a215-12884fcf1671', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 2번 B♭장조 "살롱 3중주"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b3a5d37-21a8-4fc1-a215-12884fcf1671'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5678acb-82af-4653-8a71-f1e220c4ad15', 4, 'IV', '피날레. Allegro molto', 'IV. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 2번 B♭장조 "살롱 3중주"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5678acb-82af-4653-8a71-f1e220c4ad15'
);


-- FWV 3 피아노 3중주 3번 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 3번 B단조', 'Piano Trio No. 3 in B minor', 'album', 'FWV 3', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 3번 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '944649e6-9bed-48a3-aa73-790113fde3c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '944649e6-9bed-48a3-aa73-790113fde3c8'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 3번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '944649e6-9bed-48a3-aa73-790113fde3c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dbdd755-401a-47c9-8f86-283ed7974d99', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 3번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dbdd755-401a-47c9-8f86-283ed7974d99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad57554f-0b1a-4581-b872-815181375502', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 3번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad57554f-0b1a-4581-b872-815181375502'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64d8d280-6da7-40a2-a5d3-bb6b5a4d8aea', 3, 'III', '피날레. Poco lento', 'III. Finale. Poco lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 3번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64d8d280-6da7-40a2-a5d3-bb6b5a4d8aea'
);


-- FWV 4 피아노 3중주 4번 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 4번 B단조', 'Piano Trio No. 4 in B minor (Trio concertant)', 'song', 'FWV 4', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 4번 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b74c5021-17a4-48fb-944d-9fd8a120e4d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b74c5021-17a4-48fb-944d-9fd8a120e4d9'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 3중주 4번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b74c5021-17a4-48fb-944d-9fd8a120e4d9'
);


-- FWV 5 안단티노 콰이에토소 E♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 콰이에토소 E♭단조', 'Andantino quietoso in E♭ minor', 'song', 'FWV 5', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 콰이에토소 E♭단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '128de326-f75d-45a0-ac62-989618c9f1df'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '128de326-f75d-45a0-ac62-989618c9f1df'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '안단티노 콰이에토소 E♭단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '128de326-f75d-45a0-ac62-989618c9f1df'
);


-- FWV 6 <굴리스탄> 주제에 의한 바이올린과 피아노 2중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<굴리스탄> 주제에 의한 바이올린과 피아노 2중주', 'Duo for Violin and Piano on Themes from "Gulistan"', 'song', 'FWV 6', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<굴리스탄> 주제에 의한 바이올린과 피아노 2중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3abe1373-a07c-4b6f-aa93-70aae95d760f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3abe1373-a07c-4b6f-aa93-70aae95d760f'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<굴리스탄> 주제에 의한 바이올린과 피아노 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3abe1373-a07c-4b6f-aa93-70aae95d760f'
);


-- FWV 7 피아노 5중주 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 5중주 F단조', 'Piano Quintet in F minor', 'album', 'FWV 7', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 5중주 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84876be1-9c8a-4af0-a259-0231a7104b40'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84876be1-9c8a-4af0-a259-0231a7104b40'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84876be1-9c8a-4af0-a259-0231a7104b40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6307d46-db5c-439d-a4e7-932e5f2f5df4', 1, 'I', 'Molto moderato quasi lento', 'I. Molto moderato quasi lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6307d46-db5c-439d-a4e7-932e5f2f5df4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50b2ecfc-37f7-441d-9100-b1974314f150', 2, 'II', 'Lento, con molto sentimento', 'II. Lento, con molto sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b2ecfc-37f7-441d-9100-b1974314f150'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ff32a10-97d0-4c98-a191-cc8a2afdc26e', 3, 'III', 'Allegro non troppo, ma con fuoco', 'III. Allegro non troppo, ma con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 5중주 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ff32a10-97d0-4c98-a191-cc8a2afdc26e'
);


-- FWV 8 바이올린 소나타 A장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4d33c4b-6402-36b3-9e93-ae6353b6e505', 1, 'I', 'Allegretto ben moderato', 'I. Allegretto ben moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 179 AND p.composer_id = 40
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4d33c4b-6402-36b3-9e93-ae6353b6e505'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:670d6123-f424-3ca9-bc9e-7010fc8a0d4d', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 179 AND p.composer_id = 40
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:670d6123-f424-3ca9-bc9e-7010fc8a0d4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ad8a91c-d41c-3494-9a23-2b31f2f5b6eb', 3, 'III', '레치타티보 – 판타지아. Ben moderato', 'III. Recitativo – Fantasia. Ben moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 179 AND p.composer_id = 40
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ad8a91c-d41c-3494-9a23-2b31f2f5b6eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ae4d058-5cc8-3cde-8fdf-7fe57ccfd98a', 4, 'IV', 'Allegretto poco mosso', 'IV. Allegretto poco mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 179 AND p.composer_id = 40
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ae4d058-5cc8-3cde-8fdf-7fe57ccfd98a'
);


-- FWV 9 현악 4중주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 D장조', 'String Quartet in D major', 'album', 'FWV 9', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd970f387-cf69-4379-a9f9-724012d4d48c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd970f387-cf69-4379-a9f9-724012d4d48c'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd970f387-cf69-4379-a9f9-724012d4d48c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e2d3368-7665-3598-8f91-5beef981b355', 1, 'I', 'Poco lento - Allegro', 'I. Poco lento - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e2d3368-7665-3598-8f91-5beef981b355'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa96776b-958b-3aa2-9274-36d674a097c7', 2, 'II', '스케르초. Vivace', 'II. Scherzo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa96776b-958b-3aa2-9274-36d674a097c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9420342-25a9-3659-8718-fada8bab78e5', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9420342-25a9-3659-8718-fada8bab78e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d913573-1934-3131-863e-3d59cc0311bd', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '현악 4중주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d913573-1934-3131-863e-3d59cc0311bd'
);


-- FWV 11 <목가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<목가>', 'Églogue', 'song', 'FWV 11', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<목가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e02a0d4-fd62-4454-baf5-332cd539113f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e02a0d4-fd62-4454-baf5-332cd539113f'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<목가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e02a0d4-fd62-4454-baf5-332cd539113f'
);


-- FWV 12 "God Save the King" 주제에 의한 피아노 연탄 2중주 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"God Save the King" 주제에 의한 피아노 연탄 2중주 1번', 'Duo No. 1 for Piano Four Hands on "God Save the King"', 'song', 'FWV 12', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"God Save the King" 주제에 의한 피아노 연탄 2중주 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e9bba77-f541-43d2-9fa8-0693a240f457'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e9bba77-f541-43d2-9fa8-0693a240f457'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '"God Save the King" 주제에 의한 피아노 연탄 2중주 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e9bba77-f541-43d2-9fa8-0693a240f457'
);


-- FWV 13 대카프리스 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대카프리스 1번', 'Premier grand caprice', 'song', 'FWV 13', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대카프리스 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29f29551-ba08-430b-93f3-f5e912ea9d75'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29f29551-ba08-430b-93f3-f5e912ea9d75'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '대카프리스 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29f29551-ba08-430b-93f3-f5e912ea9d75'
);


-- FWV 14 <아헨의 추억>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아헨의 추억>', 'Souvenirs d''Aix-la-Chapelle', 'song', 'FWV 14', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아헨의 추억>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a29be710-c78e-4b74-8c13-fa12adad9db4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a29be710-c78e-4b74-8c13-fa12adad9db4'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<아헨의 추억>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a29be710-c78e-4b74-8c13-fa12adad9db4'
);


-- FWV 16 <굴리스탄> 주제에 의한 대환상곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<굴리스탄> 주제에 의한 대환상곡 1번', 'Grande fantaisie No. 1 on Themes from "Gulistan"', 'song', 'FWV 16', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<굴리스탄> 주제에 의한 대환상곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '493339cb-9f30-450c-9904-9b342636ad67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '493339cb-9f30-450c-9904-9b342636ad67'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<굴리스탄> 주제에 의한 대환상곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '493339cb-9f30-450c-9904-9b342636ad67'
);


-- FWV 17 <굴리스탄>의 "Le point du jour" 주제에 의한 환상곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<굴리스탄>의 "Le point du jour" 주제에 의한 환상곡 2번', 'Fantaisie No. 2 on "Le point du jour" from "Gulistan"', 'song', 'FWV 17', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<굴리스탄>의 "Le point du jour" 주제에 의한 환상곡 2번'
);


-- FWV 18 폴란드 노래 두 곡에 의한 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴란드 노래 두 곡에 의한 환상곡', 'Fantaisie sur deux airs polonais', 'song', 'FWV 18', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴란드 노래 두 곡에 의한 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d3fbbfb-1acf-4f04-a3b0-727213e8df8a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d3fbbfb-1acf-4f04-a3b0-727213e8df8a'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '폴란드 노래 두 곡에 의한 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d3fbbfb-1acf-4f04-a3b0-727213e8df8a'
);


-- FWV 19 그레트리 <뤼실> 주제에 의한 피아노 연탄 2중주 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그레트리 <뤼실> 주제에 의한 피아노 연탄 2중주 2번', 'Duo No. 2 for Piano Four Hands on Grétry''s "Lucile"', 'song', 'FWV 19', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그레트리 <뤼실> 주제에 의한 피아노 연탄 2중주 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a02ce034-cd31-4b17-bcbd-2839708eb864'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a02ce034-cd31-4b17-bcbd-2839708eb864'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '그레트리 <뤼실> 주제에 의한 피아노 연탄 2중주 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a02ce034-cd31-4b17-bcbd-2839708eb864'
);


-- FWV 20 <인형의 탄식>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<인형의 탄식>', 'Les plaintes d''une poupée', 'song', 'FWV 20', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<인형의 탄식>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e82447ed-9efe-480a-8dff-9daf3e597e61'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e82447ed-9efe-480a-8dff-9daf3e597e61'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<인형의 탄식>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e82447ed-9efe-480a-8dff-9daf3e597e61'
);


-- FWV 21 전주곡, 코랄과 푸가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡, 코랄과 푸가', 'Prélude, Choral et Fugue', 'album', 'FWV 21', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡, 코랄과 푸가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80c1bb41-5106-4b89-97db-8189619ca3e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80c1bb41-5106-4b89-97db-8189619ca3e3'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 코랄과 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80c1bb41-5106-4b89-97db-8189619ca3e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b668eb5f-c91a-4099-b29b-b3878803c44c', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 코랄과 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b668eb5f-c91a-4099-b29b-b3878803c44c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cb3b6d7-2377-463a-86b8-ee9be664810b', 2, 'II', '코랄', 'II. Choral', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 코랄과 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cb3b6d7-2377-463a-86b8-ee9be664810b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9b749b6-dd93-4f4f-8b2d-e6305b0fe145', 3, 'III', '푸가', 'III. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 코랄과 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9b749b6-dd93-4f4f-8b2d-e6305b0fe145'
);


-- FWV 22 <느린 춤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<느린 춤>', 'Danse lente', 'song', 'FWV 22', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<느린 춤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32cbf02f-ac1f-4ce5-906d-123c7181b37b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32cbf02f-ac1f-4ce5-906d-123c7181b37b'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<느린 춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32cbf02f-ac1f-4ce5-906d-123c7181b37b'
);


-- FWV 23 전주곡, 아리아와 피날레

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡, 아리아와 피날레', 'Prélude, Aria et Final', 'album', 'FWV 23', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡, 아리아와 피날레'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1c5c2bd-91b6-451d-bdb8-c031a94d3d54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1c5c2bd-91b6-451d-bdb8-c031a94d3d54'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 아리아와 피날레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1c5c2bd-91b6-451d-bdb8-c031a94d3d54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02765c49-df2d-4ef1-9be5-0c622b971ca1', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 아리아와 피날레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02765c49-df2d-4ef1-9be5-0c622b971ca1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b733e97-36ac-4660-9884-70145c465e8c', 2, 'II', '아리아', 'II. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 아리아와 피날레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b733e97-36ac-4660-9884-70145c465e8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4fd546e-10d4-4175-ad13-2d3f83839301', 3, 'III', '피날레', 'III. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 아리아와 피날레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4fd546e-10d4-4175-ad13-2d3f83839301'
);


-- FWV 24 하모늄·오르간 유작 소품집

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하모늄·오르간 유작 소품집', 'Pièces posthumes pour harmonium ou orgue à pédales', 'album', 'FWV 24', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하모늄·오르간 유작 소품집'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1ec78e7-0dc2-4b54-9d70-6de66b7d6990'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1ec78e7-0dc2-4b54-9d70-6de66b7d6990'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1ec78e7-0dc2-4b54-9d70-6de66b7d6990'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:741d9b44-7b82-4114-9f78-0acd5b74f650', 1, NULL, '봉헌송 F단조', 'Offertoire en fa mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:741d9b44-7b82-4114-9f78-0acd5b74f650'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:2', 2, NULL, '봉헌송 E♭장조', 'Offertoire en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:147cdb46-760b-4148-a82c-1a10bf06fc84', 3, NULL, '성체 거양 A장조', 'Élévation en la majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:147cdb46-760b-4148-a82c-1a10bf06fc84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3600f7a8-1b70-4193-bf94-ccd7ceb108b8', 4, NULL, '그랑 쾨르 D장조', 'Grand chœur en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3600f7a8-1b70-4193-bf94-ccd7ceb108b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f5349a-1bef-47fb-ac1c-dc2b3aca938d', 5, NULL, '안단티노 D장조', 'Andantino en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f5349a-1bef-47fb-ac1c-dc2b3aca938d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d09ced79-a4b9-4839-9bf7-e93952613f65', 6, NULL, '콰지 마르차 D단조', 'Quasi marcia en ré mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d09ced79-a4b9-4839-9bf7-e93952613f65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef39bfb1-dd15-4de2-8e96-56fc5089f44f', 7, NULL, '알레그레토 D장조', 'Allegretto en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef39bfb1-dd15-4de2-8e96-56fc5089f44f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:869d91c7-46e4-404a-91f3-7b9e2b9912fd', 8, NULL, '아멘 D장조', 'Amen en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:869d91c7-46e4-404a-91f3-7b9e2b9912fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edf197e1-7809-4fa4-91fc-5c8f961c7272', 9, NULL, '봉헌송 A장조', 'Offertoire en la majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf197e1-7809-4fa4-91fc-5c8f961c7272'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8634a488-8763-481c-9163-eae5bfe60ae2', 10, NULL, '콰지 렌토 F장조', 'Quasi lento en fa majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8634a488-8763-481c-9163-eae5bfe60ae2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc93334d-7bc9-45cc-945c-27fafd10c29d', 11, NULL, '알레그레토 C단조', 'Allegretto en ut mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc93334d-7bc9-45cc-945c-27fafd10c29d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51f368c7-68d6-4d4a-9f32-f83696db9242', 12, NULL, '알레그레토 논 트로포 D장조', 'Allegretto non troppo en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51f368c7-68d6-4d4a-9f32-f83696db9242'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d958a48-1eed-46f0-8087-684d427979ab', 13, NULL, '그랑 쾨르 E♭장조', 'Grand chœur en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d958a48-1eed-46f0-8087-684d427979ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df8b8527-ff19-4a86-b053-5562fbd61c84', 14, NULL, '모데라토 콘 모토 E♭장조', 'Moderato con moto en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df8b8527-ff19-4a86-b053-5562fbd61c84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59a47907-530e-4ab2-9591-6dc7a26db25b', 15, NULL, '안단티노 E♭장조', 'Andantino en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59a47907-530e-4ab2-9591-6dc7a26db25b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18119bf7-c54b-4331-9534-5f7896fdcf39', 16, NULL, '<아베 마리스 스텔라> 전주곡 D단조', 'Prélude pour l''Ave Maris Stella en ré mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18119bf7-c54b-4331-9534-5f7896fdcf39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d53048b-d119-49d9-a593-dafd8952c85b', 17, NULL, '<아베 마리스 스텔라> 전주곡 D장조', 'Prélude pour l''Ave Maris Stella en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d53048b-d119-49d9-a593-dafd8952c85b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0be7be13-5e01-4f19-ae92-fcc9da430688', 18, NULL, '<아베 마리스 스텔라> 전주곡 D단조', 'Prélude pour l''Ave Maris Stella en ré mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0be7be13-5e01-4f19-ae92-fcc9da430688'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6852de22-3087-434f-a0fb-c13571df62be', 19, NULL, '렌토 D단조', 'Lento en ré mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6852de22-3087-434f-a0fb-c13571df62be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:893bf35b-0616-4c2c-a963-c9fce7154c17', 20, NULL, '안단티노 A♭장조', 'Andantino en la bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:893bf35b-0616-4c2c-a963-c9fce7154c17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39b95af2-8b34-40e6-932d-21ab48610804', 21, NULL, '성탄 미사의 키리에 C단조', 'Kyrie de la Messe de Noël en ut mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39b95af2-8b34-40e6-932d-21ab48610804'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:22', 22, NULL, '모데라토 C단조', 'Moderato en ut mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:23', 23, NULL, '모데라토 C단조', 'Moderato en ut mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:398f5be2-cacf-42e5-b992-713299cc00cc', 24, NULL, '그랑 쾨르 C장조', 'Grand chœur en ut majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398f5be2-cacf-42e5-b992-713299cc00cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6641e8ce-1115-4d1e-ba83-4d639d0abc9e', 25, NULL, '자정 미사를 위한 봉헌송 D단조', 'Offertoire pour la Messe de minuit en ré mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6641e8ce-1115-4d1e-ba83-4d639d0abc9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f4e0ec5-03b4-4b35-9f77-edd7bc3a4dca', 26, NULL, '봉헌송 G단조', 'Offertoire en sol mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f4e0ec5-03b4-4b35-9f77-edd7bc3a4dca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d760a1a8-7a80-415b-9b78-157e7c056cf5', 27, NULL, '후주 D장조', 'Sortie en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d760a1a8-7a80-415b-9b78-157e7c056cf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c73d1034-e930-4e4d-9d03-0914d1ba6271', 28, NULL, '봉헌송 F#단조', 'Offertoire en fa dièse mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c73d1034-e930-4e4d-9d03-0914d1ba6271'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05e3691b-90cf-449c-9086-52644ac85099', 29, NULL, '알레그로 모데라토 D♭장조', 'Allegro moderato en ré bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05e3691b-90cf-449c-9086-52644ac85099'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ad289df-1ed0-45cf-850b-71563682325c', 30, NULL, '봉헌송 B장조', 'Offertoire en si majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ad289df-1ed0-45cf-850b-71563682325c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9061541-6295-406e-8aab-4fd0bdd4aa37', 31, NULL, '마니피카트 D장조', 'Magnificat en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9061541-6295-406e-8aab-4fd0bdd4aa37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:32', 32, NULL, '그랑 쾨르 D장조', 'Grand chœur en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6055602-fc73-42d6-963d-69d60b3aa984', 33, NULL, '글로리아 파트리 D장조', 'Gloria Patri en ré majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6055602-fc73-42d6-963d-69d60b3aa984'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea6db8ea-344f-42b8-8ee7-1622bba5e0d0', 34, NULL, '안단티노 C장조', 'Andantino en ut majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea6db8ea-344f-42b8-8ee7-1622bba5e0d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8273ef8b-28d3-454a-9fc4-a307805a7765', 35, NULL, '알레그레토 D단조', 'Allegretto en ré mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8273ef8b-28d3-454a-9fc4-a307805a7765'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:36', 36, NULL, '마니피카트 E♭장조', 'Magnificat en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:37', 37, NULL, '마니피카트 E♭장조', 'Magnificat en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:999901f8-bd2d-448e-96e6-e5dd899c27f7', 38, NULL, '알레그레토 논 트로포 E♭장조', 'Allegretto non troppo en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:999901f8-bd2d-448e-96e6-e5dd899c27f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:39', 39, NULL, '글로리아 파트리 E♭장조', 'Gloria Patri en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:40', 40, NULL, '글로리아 파트리 E♭장조', 'Gloria Patri en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b65df954-4a95-4d8a-b56a-2bdd450efbe3', 41, NULL, '아멘 E♭장조', 'Amen en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b65df954-4a95-4d8a-b56a-2bdd450efbe3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-fwv24:42', 42, NULL, '글로리아 파트리 E♭장조', 'Gloria Patri en mi bémol majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv24:42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de7a59e2-eccc-4223-865b-1316e9cd10c3', 43, NULL, '베네디카무스 C장조', 'Benedicamus en do majeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de7a59e2-eccc-4223-865b-1316e9cd10c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15d66345-ee3c-48a9-8e5e-5a58b7c49859', 44, NULL, '그랑 쾨르 C단조', 'Grand chœur en ut mineur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄·오르간 유작 소품집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15d66345-ee3c-48a9-8e5e-5a58b7c49859'
);


-- FWV 25 안단티노 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 G단조', 'Andantino in G minor', 'song', 'FWV 25', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '347c4c33-1b85-4e2d-9136-b5b3af6af314'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '347c4c33-1b85-4e2d-9136-b5b3af6af314'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '안단티노 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '347c4c33-1b85-4e2d-9136-b5b3af6af314'
);


-- FWV 26 하모늄을 위한 5개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하모늄을 위한 5개의 소품', '5 Pièces pour harmonium', 'album', 'FWV 26', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하모늄을 위한 5개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b0bc5b1-e2bc-4c68-95c1-d0fa557ca1ce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b0bc5b1-e2bc-4c68-95c1-d0fa557ca1ce'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b0bc5b1-e2bc-4c68-95c1-d0fa557ca1ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fb69954-5cf7-4e47-b098-dcf09c6a5345', 1, NULL, '봉헌송 B장조', 'Offertoire in B major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fb69954-5cf7-4e47-b098-dcf09c6a5345'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b2cdd48-cea0-416c-bea6-61c0a552b9ed', 2, NULL, '작은 봉헌송 E장조', 'Petit offertoire in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b2cdd48-cea0-416c-bea6-61c0a552b9ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfbb7d85-75fc-45b7-bea0-12a928e2693a', 3, NULL, '베르세 1 F단조', 'Verset I in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfbb7d85-75fc-45b7-bea0-12a928e2693a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32229a9f-f692-41bd-9706-79f5ddd4cee9', 4, NULL, '베르세 2 F단조', 'Verset II in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32229a9f-f692-41bd-9706-79f5ddd4cee9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:86f6d49a-32d1-4e0f-b9fc-96b3aa3ae613', 5, NULL, '영성체송 G장조', 'Communion in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '하모늄을 위한 5개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86f6d49a-32d1-4e0f-b9fc-96b3aa3ae613'
);


-- FWV 28 환상곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 C장조', 'Fantaisie in C major', 'song', 'FWV 28', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acf68e70-4e6f-446d-8310-00f043027805'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'acf68e70-4e6f-446d-8310-00f043027805'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '환상곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'acf68e70-4e6f-446d-8310-00f043027805'
);


-- FWV 29 교향적 대곡 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 대곡 F#단조', 'Grande pièce symphonique in F# minor', 'album', 'FWV 29', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 대곡 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62a2ac9f-f87d-482c-a0fe-b8cf290720a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62a2ac9f-f87d-482c-a0fe-b8cf290720a6'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향적 대곡 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62a2ac9f-f87d-482c-a0fe-b8cf290720a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:472a41de-9fbb-4eaa-88ad-6e3cade36545', 1, 'I', 'Andantino serioso – Allegro non troppo e maestoso', 'I. Andantino serioso – Allegro non troppo e maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향적 대곡 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:472a41de-9fbb-4eaa-88ad-6e3cade36545'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a104d113-0b7d-48cc-88c8-a36c1df0472c', 2, 'II', 'Andante – Allegro – Andante', 'II. Andante – Allegro – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향적 대곡 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a104d113-0b7d-48cc-88c8-a36c1df0472c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a10b959-364f-409f-b88e-e8e39435dd3c', 3, 'III', 'Allegro non troppo e maestoso – Beaucoup plus largement que précédemment', 'III. Allegro non troppo e maestoso – Beaucoup plus largement que précédemment', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향적 대곡 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a10b959-364f-409f-b88e-e8e39435dd3c'
);


-- FWV 30 전주곡, 푸가와 변주 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡, 푸가와 변주 B단조', 'Prélude, Fugue et Variation in B minor', 'album', 'FWV 30', NULL, NULL, 1862, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡, 푸가와 변주 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ef78bda-987e-438c-a5e1-ca410f7c83a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ef78bda-987e-438c-a5e1-ca410f7c83a0'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 푸가와 변주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ef78bda-987e-438c-a5e1-ca410f7c83a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc5446f0-309b-430d-b04e-a1adcca7df21', 1, 'I', '전주곡', 'I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 푸가와 변주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc5446f0-309b-430d-b04e-a1adcca7df21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ab2e9e8-9c75-4d8f-bbe0-181a4a411645', 2, 'II', '푸가', 'II. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 푸가와 변주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ab2e9e8-9c75-4d8f-bbe0-181a4a411645'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:462845e3-315b-488b-b6b3-8d54fb2141df', 3, 'III', '변주', 'III. Variation', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '전주곡, 푸가와 변주 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:462845e3-315b-488b-b6b3-8d54fb2141df'
);


-- FWV 31 파스토랄 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파스토랄 E장조', 'Pastorale in E major', 'song', 'FWV 31', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파스토랄 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5638c86d-c689-4161-a21b-f17ee5e47610'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5638c86d-c689-4161-a21b-f17ee5e47610'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '파스토랄 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5638c86d-c689-4161-a21b-f17ee5e47610'
);


-- FWV 32 기도 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기도 C#단조', 'Prière in C# minor', 'song', 'FWV 32', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기도 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ec3bd98-c9a0-4b00-bdc4-b074c832442d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ec3bd98-c9a0-4b00-bdc4-b074c832442d'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '기도 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ec3bd98-c9a0-4b00-bdc4-b074c832442d'
);


-- FWV 33 피날레 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피날레 B♭장조', 'Final in B♭ major', 'song', 'FWV 33', NULL, NULL, 1864, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피날레 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19adb541-6bf0-4fa6-9a2a-18b689e0a4eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19adb541-6bf0-4fa6-9a2a-18b689e0a4eb'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피날레 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19adb541-6bf0-4fa6-9a2a-18b689e0a4eb'
);


-- FWV 34 콰지 마르차 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콰지 마르차 F#단조', 'Quasi marcia in F# minor', 'song', 'FWV 34', NULL, NULL, 1865, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콰지 마르차 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38bd0e6b-72e9-4f94-8ce7-8d2a3a0bb6c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38bd0e6b-72e9-4f94-8ce7-8d2a3a0bb6c0'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '콰지 마르차 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38bd0e6b-72e9-4f94-8ce7-8d2a3a0bb6c0'
);


-- FWV 35 환상곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 A장조', 'Fantaisie in A major', 'song', 'FWV 35', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd9de959-acf5-4097-8a36-b3d2270040b5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd9de959-acf5-4097-8a36-b3d2270040b5'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '환상곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd9de959-acf5-4097-8a36-b3d2270040b5'
);


-- FWV 36 칸타빌레 B장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타빌레 B장조', 'Cantabile in B major', 'song', 'FWV 36', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타빌레 B장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7260cd98-532b-42b3-9a23-eace92fc4181'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7260cd98-532b-42b3-9a23-eace92fc4181'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '칸타빌레 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7260cd98-532b-42b3-9a23-eace92fc4181'
);


-- FWV 37 영웅적 소품 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '영웅적 소품 B단조', 'Pièce héroïque in B minor', 'song', 'FWV 37', NULL, NULL, 1878, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '영웅적 소품 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f7b866d-adb9-3ecc-8e44-bc542e36b1f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f7b866d-adb9-3ecc-8e44-bc542e36b1f2'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '영웅적 소품 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f7b866d-adb9-3ecc-8e44-bc542e36b1f2'
);


-- FWV 38 코랄 1번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코랄 1번 E장조', 'Choral No. 1 in E major', 'song', 'FWV 38', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코랄 1번 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d5ad61c-a720-43d6-80a4-72c9931fc294'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3d5ad61c-a720-43d6-80a4-72c9931fc294'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '코랄 1번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d5ad61c-a720-43d6-80a4-72c9931fc294'
);


-- FWV 39 코랄 2번 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코랄 2번 B단조', 'Choral No. 2 in B minor', 'song', 'FWV 39', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코랄 2번 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ee62b86-8977-3b98-9f75-290ac236e57b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ee62b86-8977-3b98-9f75-290ac236e57b'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '코랄 2번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ee62b86-8977-3b98-9f75-290ac236e57b'
);


-- FWV 40 코랄 3번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코랄 3번 A단조', 'Choral No. 3 in A minor', 'song', 'FWV 40', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코랄 3번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9eaf1e5b-d58f-451c-959e-b03b9e4febf8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9eaf1e5b-d58f-451c-959e-b03b9e4febf8'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '코랄 3번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9eaf1e5b-d58f-451c-959e-b03b9e4febf8'
);


-- FWV 41 <오르가니스트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<오르가니스트>', 'L''Organiste', 'album', 'FWV 41', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<오르가니스트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd1d5a0c-a80b-404f-9b7e-6ad7441b5d73'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd1d5a0c-a80b-404f-9b7e-6ad7441b5d73'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd1d5a0c-a80b-404f-9b7e-6ad7441b5d73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304', 1, NULL, 'C장조·C단조 7곡', '7 Pieces in C major and C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d14b35a8-0abc-4d17-ae92-b8c44d253556', 1, 'I', 'Poco Allegretto', 'I. Poco Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d14b35a8-0abc-4d17-ae92-b8c44d253556'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91eca295-e1a3-4587-bf2a-83ae9324a9c0', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91eca295-e1a3-4587-bf2a-83ae9324a9c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f42dffd9-3ac5-4810-bb44-427af79f8a05', 3, 'III', 'Poco Lento', 'III. Poco Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f42dffd9-3ac5-4810-bb44-427af79f8a05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5fbe2b99-b51c-4736-b38a-d863631615f0', 4, 'IV', 'Maestoso', 'IV. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fbe2b99-b51c-4736-b38a-d863631615f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6bc51dc1-f7ea-4488-b730-c5ccc33614cd', 5, 'V', 'Poco Lento', 'V. Poco Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bc51dc1-f7ea-4488-b730-c5ccc33614cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8e651790-4831-4327-a2cc-e01764fee060', 6, 'VI', 'Poco Allegro – Amen', 'VI. Poco Allegro – Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e651790-4831-4327-a2cc-e01764fee060'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b895c361-06d5-473e-bdbc-ca6bf8110621', 7, 'VII', '봉헌송. Andantino', 'VII. Offertoire - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7329e9e3-2038-4708-80d4-020d2eab7304'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b895c361-06d5-473e-bdbc-ca6bf8110621'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a', 2, NULL, 'D♭장조·C#단조 7곡', '7 Pieces in D♭ major and C# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05289941-6513-4f97-a686-e78267185668', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05289941-6513-4f97-a686-e78267185668'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4bad1e1-fc39-42ce-87f1-44d5651c8ecc', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4bad1e1-fc39-42ce-87f1-44d5651c8ecc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:226e821b-6f14-4272-a2ff-63f11e7124b4', 3, 'III', 'Poco Andantino', 'III. Poco Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:226e821b-6f14-4272-a2ff-63f11e7124b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6805ed27-42d5-4884-9482-fb0b18db03ef', 4, 'IV', 'Poco Allegro', 'IV. Poco Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6805ed27-42d5-4884-9482-fb0b18db03ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0408ca33-d2f4-48f8-a483-776aa9e8817e', 5, 'V', 'Lento', 'V. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0408ca33-d2f4-48f8-a483-776aa9e8817e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36a51820-2b70-46fb-ac86-42371f73400f', 6, 'VI', 'Andantino poco mosso – Amen', 'VI. Andantino poco mosso – Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36a51820-2b70-46fb-ac86-42371f73400f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04a75ad5-d63b-463b-bc92-01f4d6d6272f', 7, 'VII', 'Andante', 'VII. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ce145f6-696a-4e06-bc2a-ae56e5f5a34a'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04a75ad5-d63b-463b-bc92-01f4d6d6272f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be', 3, NULL, 'D장조·D단조 7곡 (성탄절을 위한)', '7 Pieces in D major and D minor (pour le temps de Noël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:498dea70-a010-4c7c-b043-30e79b980302', 1, 'I', 'Quasi Allegro', 'I. Quasi Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:498dea70-a010-4c7c-b043-30e79b980302'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e5764ddc-3ec0-4f80-a05b-40f596d1864e', 2, 'II', 'Très Lent "Chant de la Creuse"', 'II. Très Lent "Chant de la Creuse"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5764ddc-3ec0-4f80-a05b-40f596d1864e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f0500b0-75cb-4b57-8513-921905bb7759', 3, 'III', 'Quasi Andante', 'III. Quasi Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f0500b0-75cb-4b57-8513-921905bb7759'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f901e12-8701-49a5-bdcb-3d70e2da986f', 4, 'IV', 'Andantino "Vieux Noël"', 'IV. Andantino "Vieux Noël"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f901e12-8701-49a5-bdcb-3d70e2da986f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9154c02a-c2bf-4faa-b1b7-e6fe547c54d6', 5, 'V', 'Maestoso', 'V. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9154c02a-c2bf-4faa-b1b7-e6fe547c54d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9df68fb-6f3c-43b4-aba5-3ac7d6c182fc', 6, 'VI', 'Maestoso "Vieux Noël"', 'VI. Maestoso "Vieux Noël"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9df68fb-6f3c-43b4-aba5-3ac7d6c182fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f08405d-3c33-471f-a2aa-ab1d73d05eab', 7, 'VII', '후주 또는 봉헌송. Allegro – Amen', 'VII. Sortie ou Offertoire - Allegro – Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb380493-303d-4829-b2f8-16f65dff57be'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f08405d-3c33-471f-a2aa-ab1d73d05eab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288', 4, NULL, 'E♭장조·E♭단조 7곡', '7 Pieces in E♭ major and E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1983e48a-617e-4888-9654-4c711b7096c0', 1, 'I', 'Andantino poco Allegretto', 'I. Andantino poco Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1983e48a-617e-4888-9654-4c711b7096c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:753a414b-eb32-4e31-bdd1-2b6c8cf8cd86', 2, 'II', 'Quasi Lento', 'II. Quasi Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:753a414b-eb32-4e31-bdd1-2b6c8cf8cd86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:353ceaf2-6ca7-4dfd-9b9f-24c8126eba4f', 3, 'III', 'Molto Moderato', 'III. Molto Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:353ceaf2-6ca7-4dfd-9b9f-24c8126eba4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:150bdfa9-70bb-4a99-a258-e44eeaa4b548', 4, 'IV', 'Allegretto', 'IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:150bdfa9-70bb-4a99-a258-e44eeaa4b548'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ad9bbff-d329-49ef-8c4c-1cd3aa660164', 5, 'V', 'Poco Allegro', 'V. Poco Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ad9bbff-d329-49ef-8c4c-1cd3aa660164'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2271bc07-0604-490e-a386-e4957b3dcac1', 6, 'VI', 'Andantino – Amen', 'VI. Andantino – Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2271bc07-0604-490e-a386-e4957b3dcac1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:76e834b1-9672-447c-9815-a23f50a3707d', 7, 'VII', '봉헌송. Andantino poco Allegretto', 'VII. Offertoire - Andantino poco Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:528891c7-15fd-4483-a26c-a85091f0e288'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76e834b1-9672-447c-9815-a23f50a3707d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5', 5, NULL, 'E단조·E장조 7곡', '7 Pieces in E minor and E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2dd98d6-a9e6-4f98-9b4d-7921f4b25484', 1, 'I', 'Andantino quasi Allegretto', 'I. Andantino quasi Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2dd98d6-a9e6-4f98-9b4d-7921f4b25484'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:183b19f2-1f80-44eb-a7cd-540978189617', 2, 'II', 'Sans titre', 'II. Sans titre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:183b19f2-1f80-44eb-a7cd-540978189617'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1af3344-9088-4a88-8d24-5bb98b8621dd', 3, 'III', '기도. Quasi Lento', 'III. Prière - Quasi Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1af3344-9088-4a88-8d24-5bb98b8621dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:faa6ea27-c826-43ed-a501-c4e42f2d2326', 4, 'IV', 'Non troppo Lento', 'IV. Non troppo Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faa6ea27-c826-43ed-a501-c4e42f2d2326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee8a68a3-b050-4cf7-8e71-ab6e2f007c91', 5, 'V', 'Allegretto', 'V. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee8a68a3-b050-4cf7-8e71-ab6e2f007c91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b97b149c-56d6-430a-9fa4-8f41d1aa4be7', 6, 'VI', 'Poco Allegretto – Amen', 'VI. Poco Allegretto – Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b97b149c-56d6-430a-9fa4-8f41d1aa4be7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9d2c02d-81cd-47e6-a93c-9bb485f78175', 7, 'VII', '봉헌송 또는 영성체송. Poco Lento', 'VII. Offertoire ou Communion - Poco Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2e7ca84e-dae1-4427-9ccb-e444c1c57fb5'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9d2c02d-81cd-47e6-a93c-9bb485f78175'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9', 6, NULL, 'F장조·F단조 7곡', '7 Pieces in F major and F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:46ee734a-e090-47ef-b85a-d544564c766e', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46ee734a-e090-47ef-b85a-d544564c766e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2dba49a-5182-4738-8d95-5721b283b470', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2dba49a-5182-4738-8d95-5721b283b470'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69c97405-8189-43a6-839f-d4e1ed516d7e', 3, 'III', 'Lento', 'III. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69c97405-8189-43a6-839f-d4e1ed516d7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:483b91f7-69ae-4eed-b505-9ba3aa3644e6', 4, 'IV', 'Allegretto', 'IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:483b91f7-69ae-4eed-b505-9ba3aa3644e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2dc29066-8309-4a48-a579-a5dc9d789033', 5, 'V', 'Allegretto', 'V. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2dc29066-8309-4a48-a579-a5dc9d789033'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bad7b01-9d4a-4295-badb-d11aaf62e725', 6, 'VI', 'Poco Lento – Amen', 'VI. Poco Lento – Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bad7b01-9d4a-4295-badb-d11aaf62e725'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5dc5afe-ff6d-4c64-b66f-a86aed2dd24d', 7, 'VII', '후주. Molto Moderato', 'VII. Sortie - Molto Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65351db8-475d-4e16-99f6-adc7b51dc8d9'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5dc5afe-ff6d-4c64-b66f-a86aed2dd24d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af', 7, NULL, 'F#단조·G♭장조 7곡', '7 Pieces in F# minor and G♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3f975b5-9e45-4f82-be48-a8b066de6c23', 1, 'I', 'Andantino "Air Béarnais"', 'I. Andantino "Air Béarnais"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3f975b5-9e45-4f82-be48-a8b066de6c23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8432b49a-e1b2-4a58-962f-06aef3cc42bc', 2, 'II', 'Poco Allegretto Andantino "Chant Béarnais"', 'II. Poco Allegretto Andantino "Chant Béarnais"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8432b49a-e1b2-4a58-962f-06aef3cc42bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06e681fe-3a03-4bf9-8de7-04839d037a36', 3, 'III', 'Andantino', 'III. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06e681fe-3a03-4bf9-8de7-04839d037a36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a73809dc-ae2a-4600-8048-35e888987cfc', 4, 'IV', 'Poco Lento', 'IV. Poco Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a73809dc-ae2a-4600-8048-35e888987cfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a972aef-534d-4026-bf17-4893531d1b5c', 5, 'V', 'Poco Allegro', 'V. Poco Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a972aef-534d-4026-bf17-4893531d1b5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3dd04f0d-2ab4-4cdc-866e-0d2438595503', 6, 'VI', 'Poco Allegretto – Amen', 'VI. Poco Allegretto – Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dd04f0d-2ab4-4cdc-866e-0d2438595503'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:acc897a3-2643-4d09-937a-e7b5c1a44a0d', 7, 'VII', '장례 봉헌송. Poco Lento', 'VII. Offertoire funèbre - Poco Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f8b5218-ca17-4e4d-b54a-7c23183b28af'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acc897a3-2643-4d09-937a-e7b5c1a44a0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4', 8, NULL, 'G장조·G단조 7곡 (성탄절을 위한)', '7 Pieces in G major and G minor (pour le temps de Noël)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35840893-4e52-45d9-b9b1-d5c8dd29b334', 1, 'I', 'Poco Allegretto', 'I. Poco Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35840893-4e52-45d9-b9b1-d5c8dd29b334'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c0dc8c07-6341-437b-b852-887b8edce7ff', 2, 'II', 'Poco Lento "Vieux Noël"', 'II. Poco Lento "Vieux Noël"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0dc8c07-6341-437b-b852-887b8edce7ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:652fe153-0f67-4d59-baee-c96b57995be8', 3, 'III', 'Allegretto "Noël angevin"', 'III. Allegretto "Noël angevin"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:652fe153-0f67-4d59-baee-c96b57995be8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8028bb5-d513-48eb-8de6-8c35df2c3bb9', 4, 'IV', 'Quasi Lento', 'IV. Quasi Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8028bb5-d513-48eb-8de6-8c35df2c3bb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be3d6e0b-6d91-49a9-a17e-10b53ec5b336', 5, 'V', 'Quasi Allegro "Noël angevin"', 'V. Quasi Allegro "Noël angevin"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be3d6e0b-6d91-49a9-a17e-10b53ec5b336'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c190562-db8c-4d94-b8be-f2c0239b0192', 6, 'VI', 'Allegretto vivo – Amen', 'VI. Allegretto vivo – Amen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c190562-db8c-4d94-b8be-f2c0239b0192'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd36d362-400e-4ebd-a802-1f0443e52d70', 7, 'VII', '후주. Allegro', 'VII. Sortie - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5173dcc-9fd9-4010-b701-c2a833d751d4'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd36d362-400e-4ebd-a802-1f0443e52d70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d', 9, NULL, 'A♭장조·G#단조 7곡', '7 Pieces in A♭ major and G# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60001bd1-bba6-4f2c-a965-0f637d9a3c8f', 1, 'I', 'Poco maestoso', 'I. Poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60001bd1-bba6-4f2c-a965-0f637d9a3c8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9efb7968-82b0-4b1a-95e0-4fb6af28647c', 2, 'II', 'Allegretto amabile', 'II. Allegretto amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9efb7968-82b0-4b1a-95e0-4fb6af28647c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:caf4fad2-bf54-4c1f-8073-f873cbff84be', 3, 'III', 'Andantino', 'III. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf4fad2-bf54-4c1f-8073-f873cbff84be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:556fb22a-fc30-469b-b83a-8a68e795c8de', 4, 'IV', 'Andantino', 'IV. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:556fb22a-fc30-469b-b83a-8a68e795c8de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82bb12db-4006-450a-9bd2-af678672e7e6', 5, 'V', 'Lento', 'V. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82bb12db-4006-450a-9bd2-af678672e7e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'classicmap:franck:franck-fwv41:9-6', 6, 'VI', 'Andantino', 'VI. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv41:9-6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'classicmap:franck:franck-fwv41:9-7', 7, 'VII', '봉헌송. Poco maestoso', 'VII. Offertoire, poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bc4adbdc-606c-4200-9073-cfbc0082d50d'
WHERE p.composer_id = 40 AND p.title = '<오르가니스트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-fwv41:9-7'
);


-- FWV 43 교향시 <에올리드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <에올리드>', 'Les Éolides', 'song', 'FWV 43', NULL, NULL, 1876, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <에올리드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80e2dd72-72bd-454f-a53c-3d25a78b5c5b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80e2dd72-72bd-454f-a53c-3d25a78b5c5b'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향시 <에올리드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80e2dd72-72bd-454f-a53c-3d25a78b5c5b'
);


-- FWV 44 교향시 <저주받은 사냥꾼>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <저주받은 사냥꾼>', 'Le Chasseur maudit', 'song', 'FWV 44', NULL, NULL, 1882, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <저주받은 사냥꾼>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d174eb6-0240-4921-96e9-15651b4152a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d174eb6-0240-4921-96e9-15651b4152a0'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향시 <저주받은 사냥꾼>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d174eb6-0240-4921-96e9-15651b4152a0'
);


-- FWV 45 교향시 <정령들> (피아노와 관현악)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <정령들> (피아노와 관현악)', 'Les Djinns', 'song', 'FWV 45', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <정령들> (피아노와 관현악)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccb7f7bb-ac14-43f7-9eb6-16bed5cd8246'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ccb7f7bb-ac14-43f7-9eb6-16bed5cd8246'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향시 <정령들> (피아노와 관현악)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccb7f7bb-ac14-43f7-9eb6-16bed5cd8246'
);


-- FWV 46 교향적 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향적 변주곡', 'Variations symphoniques', 'song', 'FWV 46', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향적 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8611bed1-5fcf-351a-a414-ad4c1299fe7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8611bed1-5fcf-351a-a414-ad4c1299fe7d'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향적 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8611bed1-5fcf-351a-a414-ad4c1299fe7d'
);


-- FWV 47 교향시 <프시케>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <프시케>', 'Psyché', 'song', 'FWV 47', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <프시케>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19db437e-c051-4e0b-b36d-970a2c33b632'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19db437e-c051-4e0b-b36d-970a2c33b632'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향시 <프시케>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19db437e-c051-4e0b-b36d-970a2c33b632'
);


-- FWV 48 교향곡 D단조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df271c25-b052-3401-83d0-4c97682d2386', 1, 'I', 'Lento – Allegro non troppo', 'I. Lento – Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 180 AND p.composer_id = 40
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df271c25-b052-3401-83d0-4c97682d2386'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15e99233-1d36-34c5-ab34-b6967c5f4e26', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 180 AND p.composer_id = 40
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15e99233-1d36-34c5-ab34-b6967c5f4e26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfb0b483-da51-3c90-87c3-bce7436eda23', 3, 'III', 'Allegro non troppo', 'III. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 180 AND p.composer_id = 40
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfb0b483-da51-3c90-87c3-bce7436eda23'
);


-- FWV 49 오페라 <훌다>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <훌다>', 'Hulda', 'song', 'FWV 49', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <훌다>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca764b9e-ba10-4ff2-8042-c8d6966d09b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca764b9e-ba10-4ff2-8042-c8d6966d09b7'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '오페라 <훌다>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca764b9e-ba10-4ff2-8042-c8d6966d09b7'
);


-- FWV 50 오페라 <기젤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <기젤>', 'Ghiselle', 'song', 'FWV 50', NULL, NULL, 1890, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <기젤>'
);


-- FWV 51 오라토리오 <룻>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <룻>', 'Ruth', 'song', 'FWV 51', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <룻>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c09bbe2-c390-47fb-b3bb-3eb08c205397'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c09bbe2-c390-47fb-b3bb-3eb08c205397'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '오라토리오 <룻>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c09bbe2-c390-47fb-b3bb-3eb08c205397'
);


-- FWV 52 <속죄>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<속죄>', 'Rédemption', 'song', 'FWV 52', NULL, NULL, 1874, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<속죄>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14e5a03c-b168-4666-901b-e5bfc286ba24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '14e5a03c-b168-4666-901b-e5bfc286ba24'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<속죄>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '14e5a03c-b168-4666-901b-e5bfc286ba24'
);


-- FWV 53 오라토리오 <참행복>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <참행복>', 'Les Béatitudes', 'song', 'FWV 53', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <참행복>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69ea9f44-50b0-4f9b-b6db-948cf5279ff2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '69ea9f44-50b0-4f9b-b6db-948cf5279ff2'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '오라토리오 <참행복>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '69ea9f44-50b0-4f9b-b6db-948cf5279ff2'
);


-- FWV 54 성서 장면 <리브가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성서 장면 <리브가>', 'Rebecca', 'song', 'FWV 54', NULL, NULL, 1881, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성서 장면 <리브가>'
);


-- FWV 55 <O salutaris> (2성, 1858)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> (2성, 1858)', 'O salutaris for Two Voices', 'song', 'FWV 55', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> (2성, 1858)'
);


-- FWV 56 <O salutaris> E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> E장조', 'O salutaris in E major', 'song', 'FWV 56', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> E장조'
);


-- FWV 57 <아베 마리아> G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아베 마리아> G단조', 'Ave Maria in G minor', 'song', 'FWV 57', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아베 마리아> G단조'
);


-- FWV 58 <탄툼 에르고> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<탄툼 에르고> D장조', 'Tantum ergo in D major', 'song', 'FWV 58', NULL, NULL, 1858, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<탄툼 에르고> D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '176f450d-dd0f-4733-9644-147f4a03b7ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '176f450d-dd0f-4733-9644-147f4a03b7ae'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<탄툼 에르고> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '176f450d-dd0f-4733-9644-147f4a03b7ae'
);


-- FWV 60 성가 <Le garde d'honneur>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성가 <Le garde d''honneur>', 'Le garde d''honneur', 'song', 'FWV 60', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성가 <Le garde d''honneur>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7590b8f-ae6f-4197-88fb-f0839b54841e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7590b8f-ae6f-4197-88fb-f0839b54841e'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '성가 <Le garde d''honneur>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7590b8f-ae6f-4197-88fb-f0839b54841e'
);


-- FWV 61 3성 미사 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성 미사 A장조', 'Messe à trois voix in A major', 'album', 'FWV 61', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성 미사 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15649d4e-2dd2-4211-84bc-f5d2d316203a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '15649d4e-2dd2-4211-84bc-f5d2d316203a'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '3성 미사 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '15649d4e-2dd2-4211-84bc-f5d2d316203a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:938e40ed-eec9-434b-a19d-e8e8341344e4', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '3성 미사 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:938e40ed-eec9-434b-a19d-e8e8341344e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6cbf28f-f40d-4ce8-9578-923bf5c768f4', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '3성 미사 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6cbf28f-f40d-4ce8-9578-923bf5c768f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93076e2d-9d9c-4c7c-9e12-7668b8dc1465', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '3성 미사 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93076e2d-9d9c-4c7c-9e12-7668b8dc1465'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1950095-ce37-4bd8-93dc-c9b2d99145d3', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '3성 미사 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1950095-ce37-4bd8-93dc-c9b2d99145d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 181 AND linked.composer_id = 40), 'musicbrainz:5b979859-257c-4562-a5a3-8aeba2204241', 5, 'V', '생명의 양식 (Panis angelicus)', 'V. Panis angelicus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '3성 미사 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b979859-257c-4562-a5a3-8aeba2204241'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3bfa32e-577c-44f9-adc4-6c716cd5a66f', 6, 'VI', '아뉴스 데이', 'VI. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '3성 미사 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3bfa32e-577c-44f9-adc4-6c716cd5a66f'
);


-- FWV 62 <아베 마리아> (3성, 1863)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<아베 마리아> (3성, 1863)', 'Ave Maria for Three Voices', 'song', 'FWV 62', NULL, NULL, 1863, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<아베 마리아> (3성, 1863)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e6ef5ff-7077-49b0-87a9-88b5b0d1a7f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e6ef5ff-7077-49b0-87a9-88b5b0d1a7f7'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<아베 마리아> (3성, 1863)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e6ef5ff-7077-49b0-87a9-88b5b0d1a7f7'
);


-- FWV 63 봉헌송 <Quae est ista>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '봉헌송 <Quae est ista>', 'Quae est ista, Offertory', 'song', 'FWV 63', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '봉헌송 <Quae est ista>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c1e9f69-f6b6-4c4b-875d-346253aa3f63'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c1e9f69-f6b6-4c4b-875d-346253aa3f63'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '봉헌송 <Quae est ista>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c1e9f69-f6b6-4c4b-875d-346253aa3f63'
);


-- FWV 64 봉헌송 <Domine Deus in simplicitate>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '봉헌송 <Domine Deus in simplicitate>', 'Domine Deus in simplicitate, Offertory', 'song', 'FWV 64', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '봉헌송 <Domine Deus in simplicitate>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0501065-c8fa-456c-8225-53007bf49b41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e0501065-c8fa-456c-8225-53007bf49b41'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '봉헌송 <Domine Deus in simplicitate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0501065-c8fa-456c-8225-53007bf49b41'
);


-- FWV 65 봉헌송 <Dextera Domini>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '봉헌송 <Dextera Domini>', 'Dextera Domini, Offertory', 'song', 'FWV 65', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '봉헌송 <Dextera Domini>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c992b005-9fe2-4ffe-9c8e-203f20207a81'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c992b005-9fe2-4ffe-9c8e-203f20207a81'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '봉헌송 <Dextera Domini>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c992b005-9fe2-4ffe-9c8e-203f20207a81'
);


-- FWV 66 봉헌송 <Domine non secundum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '봉헌송 <Domine non secundum>', 'Domine non secundum, Offertory', 'song', 'FWV 66', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '봉헌송 <Domine non secundum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'adaa90de-3a60-49eb-a5f9-a38314c4f0da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'adaa90de-3a60-49eb-a5f9-a38314c4f0da'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '봉헌송 <Domine non secundum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'adaa90de-3a60-49eb-a5f9-a38314c4f0da'
);


-- FWV 67 봉헌송 <Quare fremuerunt gentes>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '봉헌송 <Quare fremuerunt gentes>', 'Quare fremuerunt gentes, Offertory', 'song', 'FWV 67', NULL, NULL, 1871, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '봉헌송 <Quare fremuerunt gentes>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c00106b9-37e4-40d8-b4c7-31fc9bc96edd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c00106b9-37e4-40d8-b4c7-31fc9bc96edd'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '봉헌송 <Quare fremuerunt gentes>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c00106b9-37e4-40d8-b4c7-31fc9bc96edd'
);


-- FWV 68 <Veni creator> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Veni creator> E♭장조', 'Veni creator in E♭ major', 'song', 'FWV 68', NULL, NULL, 1872, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Veni creator> E♭장조'
);


-- FWV 69 시편 150편

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '시편 150편', 'Psalm 150', 'song', 'FWV 69', NULL, NULL, 1884, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '시편 150편'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfe262d2-c93a-4465-914c-4014d355fb74'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dfe262d2-c93a-4465-914c-4014d355fb74'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '시편 150편' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dfe262d2-c93a-4465-914c-4014d355fb74'
);


-- FWV 70 가곡 <Souvenance>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Souvenance>', 'Souvenance', 'song', 'FWV 70', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Souvenance>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'beddfadf-c2e5-487c-aaca-77a48045d44d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'beddfadf-c2e5-487c-aaca-77a48045d44d'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Souvenance>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'beddfadf-c2e5-487c-aaca-77a48045d44d'
);


-- FWV 71 가곡 <Ninon>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ninon>', 'Ninon', 'song', 'FWV 71', NULL, NULL, 1851, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ninon>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0f19ba1-22be-4f0e-98a0-67b57adbff2b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0f19ba1-22be-4f0e-98a0-67b57adbff2b'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Ninon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0f19ba1-22be-4f0e-98a0-67b57adbff2b'
);


-- FWV 72 가곡 <L'émir de Bengador>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''émir de Bengador>', 'L''émir de Bengador', 'song', 'FWV 72', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''émir de Bengador>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d4cf13f-6305-4c81-9ec4-c7050732b21b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d4cf13f-6305-4c81-9ec4-c7050732b21b'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <L''émir de Bengador>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d4cf13f-6305-4c81-9ec4-c7050732b21b'
);


-- FWV 73 가곡 <Le sylphe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le sylphe>', 'Le sylphe', 'song', 'FWV 73', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le sylphe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd47a68a7-234a-47df-923e-9fa0ed93abff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd47a68a7-234a-47df-923e-9fa0ed93abff'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Le sylphe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd47a68a7-234a-47df-923e-9fa0ed93abff'
);


-- FWV 74 가곡 <Robin Gray>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Robin Gray>', 'Robin Gray', 'song', 'FWV 74', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Robin Gray>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5aa13c6-a114-4fc5-9f55-3f39a758824d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5aa13c6-a114-4fc5-9f55-3f39a758824d'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Robin Gray>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5aa13c6-a114-4fc5-9f55-3f39a758824d'
);


-- FWV 75 가곡 <L'ange et l'enfant>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''ange et l''enfant>', 'L''ange et l''enfant', 'song', 'FWV 75', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''ange et l''enfant>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '297ab036-a9d6-4011-8b37-235d732a60d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '297ab036-a9d6-4011-8b37-235d732a60d4'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <L''ange et l''enfant>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '297ab036-a9d6-4011-8b37-235d732a60d4'
);


-- FWV 76 가곡 <Aimer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Aimer>', 'Aimer', 'song', 'FWV 76', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Aimer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db45cccf-fece-451b-994e-59771c25feab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db45cccf-fece-451b-994e-59771c25feab'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Aimer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db45cccf-fece-451b-994e-59771c25feab'
);


-- FWV 77 가곡 <Les trois exilés>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Les trois exilés>', 'Les trois exilés', 'song', 'FWV 77', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Les trois exilés>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecdd2bc2-5675-40d2-a780-1cf6cec64343'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ecdd2bc2-5675-40d2-a780-1cf6cec64343'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Les trois exilés>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ecdd2bc2-5675-40d2-a780-1cf6cec64343'
);


-- FWV 78 가곡 <S'il est un charmant gazon>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <S''il est un charmant gazon>', 'S''il est un charmant gazon', 'song', 'FWV 78', NULL, NULL, 1857, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <S''il est un charmant gazon>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bbbb1c0-294a-4ca4-8eae-378936594e37'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4bbbb1c0-294a-4ca4-8eae-378936594e37'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <S''il est un charmant gazon>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bbbb1c0-294a-4ca4-8eae-378936594e37'
);


-- FWV 79 애국 송가 <파리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '애국 송가 <파리>', 'Paris, Ode patriotique', 'song', 'FWV 79', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '애국 송가 <파리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc512a0b-a03a-411a-932d-a082e1598dbf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc512a0b-a03a-411a-932d-a082e1598dbf'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '애국 송가 <파리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc512a0b-a03a-411a-932d-a082e1598dbf'
);


-- FWV 80 가곡 <Le mariage des roses>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le mariage des roses>', 'Le mariage des roses', 'song', 'FWV 80', NULL, NULL, 1870, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le mariage des roses>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8644c31f-73d4-4b0f-87f6-1d4f7343f6ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8644c31f-73d4-4b0f-87f6-1d4f7343f6ff'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Le mariage des roses>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8644c31f-73d4-4b0f-87f6-1d4f7343f6ff'
);


-- FWV 81 가곡 <Roses et papillons>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Roses et papillons>', 'Roses et papillons', 'song', 'FWV 81', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Roses et papillons>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41516159-55c4-4d2b-97b8-9f712c9e29ea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '41516159-55c4-4d2b-97b8-9f712c9e29ea'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Roses et papillons>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41516159-55c4-4d2b-97b8-9f712c9e29ea'
);


-- FWV 82 가곡 <Passez, passez toujours>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Passez, passez toujours>', 'Passez, passez toujours', 'song', 'FWV 82', NULL, NULL, 1860, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Passez, passez toujours>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e487d3c0-f8e3-410a-a49e-f75d49ccbd9f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e487d3c0-f8e3-410a-a49e-f75d49ccbd9f'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Passez, passez toujours>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e487d3c0-f8e3-410a-a49e-f75d49ccbd9f'
);


-- FWV 83 가곡 <Lied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lied>', 'Lied', 'song', 'FWV 83', NULL, NULL, 1873, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b2ddc1c-2878-4d22-a787-ace16ba5d5b1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b2ddc1c-2878-4d22-a787-ace16ba5d5b1'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Lied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b2ddc1c-2878-4d22-a787-ace16ba5d5b1'
);


-- FWV 84 가곡 <Le vase brisé>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Le vase brisé>', 'Le vase brisé', 'song', 'FWV 84', NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Le vase brisé>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6ae6eb8-29d8-4d8f-8c90-b572d143f5e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f6ae6eb8-29d8-4d8f-8c90-b572d143f5e8'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Le vase brisé>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f6ae6eb8-29d8-4d8f-8c90-b572d143f5e8'
);


-- FWV 85 가곡 <Nocturne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Nocturne>', 'Nocturne', 'song', 'FWV 85', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Nocturne>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4ece22c-264b-3317-9712-8d31ecb1eef7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4ece22c-264b-3317-9712-8d31ecb1eef7'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Nocturne>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4ece22c-264b-3317-9712-8d31ecb1eef7'
);


-- FWV 86 가곡 <Pour les victimes>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Pour les victimes>', 'Pour les victimes', 'song', 'FWV 86', NULL, NULL, 1887, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Pour les victimes>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '504e2469-985b-4d75-bcba-6b271425e38f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '504e2469-985b-4d75-bcba-6b271425e38f'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Pour les victimes>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '504e2469-985b-4d75-bcba-6b271425e38f'
);


-- FWV 87 가곡 <Les cloches du soir>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Les cloches du soir>', 'Les cloches du soir', 'song', 'FWV 87', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Les cloches du soir>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b717969-2080-4426-a266-b417a06d6d38'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b717969-2080-4426-a266-b417a06d6d38'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <Les cloches du soir>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b717969-2080-4426-a266-b417a06d6d38'
);


-- FWV 88 가곡 <La procession>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La procession>', 'La procession', 'song', 'FWV 88', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La procession>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a35f1d95-31e4-4b4b-9a0b-775e840bf421'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a35f1d95-31e4-4b4b-9a0b-775e840bf421'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '가곡 <La procession>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a35f1d95-31e4-4b4b-9a0b-775e840bf421'
);


-- FWV 89 6개의 2중창

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6개의 2중창', '6 Duos for Equal Voices', 'album', 'FWV 89', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6개의 2중창'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd7a4160-71a1-4ac9-9540-fa51bbebbb8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd7a4160-71a1-4ac9-9540-fa51bbebbb8b'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '6개의 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd7a4160-71a1-4ac9-9540-fa51bbebbb8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5e48567-e087-47dd-a867-80ed71b5f412', 1, NULL, 'L''ange gardien', 'L''ange gardien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '6개의 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5e48567-e087-47dd-a867-80ed71b5f412'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0015b9d2-633b-429f-abc7-de075daac8d6', 2, NULL, 'Aux petits enfants', 'Aux petits enfants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '6개의 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0015b9d2-633b-429f-abc7-de075daac8d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2d87b60-8264-4ff7-909f-2897b5c49df8', 3, NULL, 'La Vierge à la crèche', 'La Vierge à la crèche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '6개의 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2d87b60-8264-4ff7-909f-2897b5c49df8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d978076-c63f-4b8a-9736-d942236794c0', 4, NULL, 'Les danses de Lormont', 'Les danses de Lormont', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '6개의 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d978076-c63f-4b8a-9736-d942236794c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32b04f57-9f3a-4166-984c-c391f2c989a6', 5, NULL, 'Soleil', 'Soleil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '6개의 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b04f57-9f3a-4166-984c-c391f2c989a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac6cdfb1-9d5e-4e8d-b078-bbd7584b82f2', 6, NULL, 'La chanson du vannier', 'La chanson du vannier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '6개의 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac6cdfb1-9d5e-4e8d-b078-bbd7584b82f2'
);


-- FWV 90 여성 합창곡 <Premier sourire de mai>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '여성 합창곡 <Premier sourire de mai>', 'Premier sourire de mai', 'song', 'FWV 90', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '여성 합창곡 <Premier sourire de mai>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f12a6c00-ef24-4ba3-ad12-90096724df1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f12a6c00-ef24-4ba3-ad12-90096724df1f'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '여성 합창곡 <Premier sourire de mai>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f12a6c00-ef24-4ba3-ad12-90096724df1f'
);


-- FWV 91 남성 합창곡 <Hymne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창곡 <Hymne>', 'Hymne', 'song', 'FWV 91', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창곡 <Hymne>'
);


-- CFF 2 피아노 소나타 1번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 1번 D장조', 'Piano Sonata No. 1 in D major', 'album', 'CFF 2', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 1번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa8be45f-ac3f-4ba1-8d97-decdbc1f999c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aa8be45f-ac3f-4ba1-8d97-decdbc1f999c'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 소나타 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aa8be45f-ac3f-4ba1-8d97-decdbc1f999c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c80af0a8-9a98-4372-a9ab-5e82a3429c64', 1, 'I', 'Larghetto — Allegro moderato', 'I. Larghetto — Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 소나타 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c80af0a8-9a98-4372-a9ab-5e82a3429c64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05131675-ac82-4681-be4b-e580492fd6cd', 2, 'II', 'Adagio. Andante moderato', 'II. Adagio. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 소나타 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05131675-ac82-4681-be4b-e580492fd6cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc63f494-4f39-4087-b676-e7a232b5bf12', 3, 'III', '론도. Allegro vivace', 'III. Rondo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 소나타 1번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc63f494-4f39-4087-b676-e7a232b5bf12'
);


-- CFF 4 환상곡 2번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 2번 D장조', 'Fantaisie No. 2 in D major', 'song', 'CFF 4', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 2번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51d93508-e85b-4571-be57-0b1eeaf42398'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '51d93508-e85b-4571-be57-0b1eeaf42398'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '환상곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '51d93508-e85b-4571-be57-0b1eeaf42398'
);


-- CFF 5 2개의 선율

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2개의 선율', 'Deux mélodies', 'album', 'CFF 5', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2개의 선율'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-cff5:1', 1, NULL, '선율 1', 'No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '2개의 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-cff5:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:franck:franck-cff5:2', 2, NULL, '선율 2', 'No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '2개의 선율' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:franck:franck-cff5:2'
);


-- CFF 7 대환상곡 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대환상곡 3번', 'Troisième grande fantaisie', 'song', 'CFF 7', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대환상곡 3번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0ce4b05-6bf7-4974-9f30-4359c3f13f70'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0ce4b05-6bf7-4974-9f30-4359c3f13f70'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '대환상곡 3번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0ce4b05-6bf7-4974-9f30-4359c3f13f70'
);


-- CFF 108 그랑 트리오 (피아노 3중주)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그랑 트리오 (피아노 3중주)', 'Grand trio for Violin, Cello and Piano', 'song', 'CFF 108', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그랑 트리오 (피아노 3중주)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39f7b4d8-51c8-4cad-88fa-1640a02fad0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '39f7b4d8-51c8-4cad-88fa-1640a02fad0e'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '그랑 트리오 (피아노 3중주)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39f7b4d8-51c8-4cad-88fa-1640a02fad0e'
);


-- None 창작 주제에 의한 화려한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '창작 주제에 의한 화려한 변주곡', 'Variations brillantes sur un thème original', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '창작 주제에 의한 화려한 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7deb48f-b6f0-4e47-801d-03094aa43a35'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c7deb48f-b6f0-4e47-801d-03094aa43a35'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '창작 주제에 의한 화려한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c7deb48f-b6f0-4e47-801d-03094aa43a35'
);


-- None 에롤드 <르 프레 오 클레르> 주제에 의한 화려한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에롤드 <르 프레 오 클레르> 주제에 의한 화려한 변주곡', 'Variations brillantes sur un air du Pré aux clercs', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에롤드 <르 프레 오 클레르> 주제에 의한 화려한 변주곡'
);


-- CFF 133 오베르 <구스타브 3세>의 론도 주제에 의한 화려한 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오베르 <구스타브 3세>의 론도 주제에 의한 화려한 변주곡', 'Variations brillantes sur la ronde favorite de Gustave III', 'song', 'CFF 133', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오베르 <구스타브 3세>의 론도 주제에 의한 화려한 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f6e54ba-0904-47e7-8c16-eaa914f79c1e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f6e54ba-0904-47e7-8c16-eaa914f79c1e'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '오베르 <구스타브 3세>의 론도 주제에 의한 화려한 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f6e54ba-0904-47e7-8c16-eaa914f79c1e'
);


-- CFF 135 피아노 협주곡 2번 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번 B단조', 'Piano Concerto No. 2 in B minor', 'album', 'CFF 135', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8fba743-a65a-4214-a1b3-7c109d5146e0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8fba743-a65a-4214-a1b3-7c109d5146e0'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 협주곡 2번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8fba743-a65a-4214-a1b3-7c109d5146e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c2f0e89-b11d-480e-8c2d-125534adf488', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 협주곡 2번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c2f0e89-b11d-480e-8c2d-125534adf488'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f23c267-69bc-42a4-8b50-3e313967439d', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 협주곡 2번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f23c267-69bc-42a4-8b50-3e313967439d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9937848-04c0-4db0-96e0-dd72b4fb3999', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '피아노 협주곡 2번 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9937848-04c0-4db0-96e0-dd72b4fb3999'
);


-- CFF 188 <O salutaris> D장조 (1835)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<O salutaris> D장조 (1835)', 'O salutaris in D major (1835)', 'song', 'CFF 188', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<O salutaris> D장조 (1835)'
);


-- CFF 126 교향시 <산 위에서 들리는 것>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <산 위에서 들리는 것>', 'Ce qu''on entend sur la montagne', 'song', 'CFF 126', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <산 위에서 들리는 것>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9bf144d4-ca56-4e7e-a3b8-38e07340d523'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9bf144d4-ca56-4e7e-a3b8-38e07340d523'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '교향시 <산 위에서 들리는 것>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9bf144d4-ca56-4e7e-a3b8-38e07340d523'
);


-- CFF 180 <십자가 위의 일곱 말씀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<십자가 위의 일곱 말씀>', 'Les sept paroles du Christ en croix', 'song', 'CFF 180', NULL, NULL, 1859, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<십자가 위의 일곱 말씀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86e8ccca-2a6c-49e1-8b5b-550d22caf253'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86e8ccca-2a6c-49e1-8b5b-550d22caf253'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '<십자가 위의 일곱 말씀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86e8ccca-2a6c-49e1-8b5b-550d22caf253'
);


-- CFF 229 오페라 <스트라델라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <스트라델라>', 'Stradella', 'song', 'CFF 229', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <스트라델라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cac973ec-e055-4b35-972a-518280533618'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cac973ec-e055-4b35-972a-518280533618'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '오페라 <스트라델라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cac973ec-e055-4b35-972a-518280533618'
);


-- CFF 230 코믹 오페라 <농장 하인>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코믹 오페라 <농장 하인>', 'Le valet de ferme', 'song', 'CFF 230', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코믹 오페라 <농장 하인>'
);


-- CFF 49 그랑 쾨르 (1846)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그랑 쾨르 (1846)', 'Grand chœur (1846)', 'song', 'CFF 49', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그랑 쾨르 (1846)'
);


-- CFF 51 오르간 소품 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 소품 A장조', 'Pièce in A major', 'song', 'CFF 51', NULL, NULL, 1854, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 소품 A장조'
);


-- CFF 34 브르타뉴 노엘에 의한 봉헌송 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '브르타뉴 노엘에 의한 봉헌송 A단조', 'Offertoire sur un noël breton in A minor', 'song', 'CFF 34', NULL, NULL, 1867, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '브르타뉴 노엘에 의한 봉헌송 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd21d081e-8960-4eed-930f-b165414e4539'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd21d081e-8960-4eed-930f-b165414e4539'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '브르타뉴 노엘에 의한 봉헌송 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd21d081e-8960-4eed-930f-b165414e4539'
);


-- CFF 37 입당곡 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '입당곡 E장조', 'Entrée in E major', 'song', 'CFF 37', NULL, NULL, 1875, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '입당곡 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3425a8a5-dcc1-4636-a090-9af23d30a978'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3425a8a5-dcc1-4636-a090-9af23d30a978'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '입당곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3425a8a5-dcc1-4636-a090-9af23d30a978'
);


-- CFF 96b 작은 봉헌송 (1877)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 봉헌송 (1877)', 'Petit offertoire (1877)', 'song', 'CFF 96b', NULL, NULL, 1877, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 봉헌송 (1877)'
);


-- CFF 38 작은 봉헌송 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 봉헌송 C단조', 'Petit offertoire in C minor', 'song', 'CFF 38', NULL, NULL, 1885, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 봉헌송 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef993e24-8310-4a7f-8bc3-16a960a18342'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef993e24-8310-4a7f-8bc3-16a960a18342'
FROM pieces p
WHERE p.composer_id = 40 AND p.title = '작은 봉헌송 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef993e24-8310-4a7f-8bc3-16a960a18342'
);


-- CFF 39bis 안단테와 기도

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테와 기도', 'Andante et Prière', 'song', 'CFF 39bis', NULL, NULL, 1888, 'manual', 1
FROM composers c
WHERE c.id = 40
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테와 기도'
);

