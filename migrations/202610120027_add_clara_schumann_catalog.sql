-- 클라라 슈만 작품을 출판 단위로 채운다(카탈로그: Op.). 작품 43개(묶음 14, 다악장 4, 낱곡 25),
-- 새 작품 40개, 기존 작품 3개, part 73개, 그 아래 6개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   Op. 1–23(미완성 Op. 18 제외)과 작품번호 없는 현존 곡. 178 「3개의 로망스」는 Op. 22 묶음 자체.
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

-- Op. 1 폴로네즈 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 Op. 1', '4 Polonaises, Op. 1', 'album', NULL, 'Op.', '1', 1830, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 Op. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70138afc-397a-46e6-b96b-512b9f4367a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70138afc-397a-46e6-b96b-512b9f4367a3'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '폴로네즈 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70138afc-397a-46e6-b96b-512b9f4367a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1d1a8d6-43b0-4c8e-9f17-819f828eb7c5', 1, NULL, 'E♭장조', 'No. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '폴로네즈 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1d1a8d6-43b0-4c8e-9f17-819f828eb7c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f21344f-89bf-43aa-8653-e3c9493d8911', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '폴로네즈 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f21344f-89bf-43aa-8653-e3c9493d8911'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd58361b-6fa6-40ff-a227-1bd162f4c902', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '폴로네즈 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd58361b-6fa6-40ff-a227-1bd162f4c902'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95dbcd03-b882-415f-8a59-c6d36b60d452', 4, NULL, 'C장조', 'No. 4 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '폴로네즈 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95dbcd03-b882-415f-8a59-c6d36b60d452'
);


-- Op. 2 왈츠풍 카프리스 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠풍 카프리스 Op. 2', '9 Caprices en forme de valse, Op. 2', 'album', NULL, 'Op.', '2', 1832, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠풍 카프리스 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75020956-e2e9-4cba-a530-991dd6a26ae1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75020956-e2e9-4cba-a530-991dd6a26ae1'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75020956-e2e9-4cba-a530-991dd6a26ae1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27cd858b-fc93-48a3-8494-71888fcb7684', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27cd858b-fc93-48a3-8494-71888fcb7684'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2616f464-ce4b-4783-b606-8cbb60812f9e', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2616f464-ce4b-4783-b606-8cbb60812f9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:608fbbb3-80ea-4ad0-aa45-10d133f064fe', 3, NULL, 'E♭장조', 'No. 3 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:608fbbb3-80ea-4ad0-aa45-10d133f064fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cc725cd-cd3a-4f10-85ff-46c0bf964584', 4, NULL, 'A♭장조', 'No. 4 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cc725cd-cd3a-4f10-85ff-46c0bf964584'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd32a817-3787-4e04-9b8a-1ea082bdd32c', 5, NULL, 'B♭장조', 'No. 5 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd32a817-3787-4e04-9b8a-1ea082bdd32c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4b5f1f3-4171-46fe-9ac2-dc132a4b4742', 6, NULL, 'C장조', 'No. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4b5f1f3-4171-46fe-9ac2-dc132a4b4742'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8071aacf-2c15-4f5c-a869-1d07b51749ea', 7, NULL, 'A♭장조', 'No. 7 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8071aacf-2c15-4f5c-a869-1d07b51749ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00fd2ab0-699e-45b7-8fec-0949f8022737', 8, NULL, 'E♭장조', 'No. 8 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00fd2ab0-699e-45b7-8fec-0949f8022737'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f2e273c-d06c-4d5d-afc4-296a3bcc2e65', 9, NULL, 'D♭장조', 'No. 9 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '왈츠풍 카프리스 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f2e273c-d06c-4d5d-afc4-296a3bcc2e65'
);


-- Op. 3 변주 로망스 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '변주 로망스 C장조', 'Romance variée in C major', 'song', 'Op. 3', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '변주 로망스 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a004887d-3787-4c65-bd48-e81a2dbeb694'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a004887d-3787-4c65-bd48-e81a2dbeb694'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '변주 로망스 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a004887d-3787-4c65-bd48-e81a2dbeb694'
);


-- Op. 4 낭만적 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '낭만적 왈츠', 'Valses romantiques', 'song', 'Op. 4', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '낭만적 왈츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b9363b9-2e3b-402e-810a-ce19dc5c3bde'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b9363b9-2e3b-402e-810a-ce19dc5c3bde'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '낭만적 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b9363b9-2e3b-402e-810a-ce19dc5c3bde'
);


-- Op. 5 성격 소품 Op. 5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성격 소품 Op. 5', '4 Pièces caractéristiques, Op. 5', 'album', NULL, 'Op.', '5', 1835, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성격 소품 Op. 5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8abb71c-37c5-4b3b-b286-403c0146cce0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8abb71c-37c5-4b3b-b286-403c0146cce0'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '성격 소품 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8abb71c-37c5-4b3b-b286-403c0146cce0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3dda02c5-daf6-40f2-8bb3-34363f568b98', 1, NULL, '즉흥곡 A단조 "마녀들의 집회"', 'Impromptu "Le Sabbat" in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '성격 소품 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dda02c5-daf6-40f2-8bb3-34363f568b98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb9148ca-a8ab-4c0f-8c7c-746d981cc033', 2, NULL, '볼레로풍 카프리스 E장조', 'Caprice à la Boléro in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '성격 소품 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb9148ca-a8ab-4c0f-8c7c-746d981cc033'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2ac7366-260b-4f3f-a756-a1fc27e8728a', 3, NULL, '로망스 B단조', 'Romance in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '성격 소품 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2ac7366-260b-4f3f-a756-a1fc27e8728a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce13b3fc-1870-4aa3-b208-84dd1de1e11e', 4, NULL, '환상적 장면 G장조 "유령들의 발레"', 'Scène fantastique "Le Ballet des Revenants" in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '성격 소품 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce13b3fc-1870-4aa3-b208-84dd1de1e11e'
);


-- Op. 6 피아노 모음곡 <음악의 밤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <음악의 밤>', 'Soirées musicales, Op. 6', 'album', 'Op. 6', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <음악의 밤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '806f3c17-f565-40ad-bc96-fbe467cdca99'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '806f3c17-f565-40ad-bc96-fbe467cdca99'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 모음곡 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '806f3c17-f565-40ad-bc96-fbe467cdca99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a88cefb-1046-4eb1-a80a-9db71a03550f', 1, NULL, '토카티나 A단조', 'Toccatina in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 모음곡 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a88cefb-1046-4eb1-a80a-9db71a03550f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8923b581-7ddb-4b95-b92f-b5bbbfeb1162', 2, NULL, '녹턴 F장조', 'Notturno in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 모음곡 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8923b581-7ddb-4b95-b92f-b5bbbfeb1162'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c78e0b49-e2f4-4614-9f8a-6311cf4ed882', 3, NULL, '마주르카 G단조', 'Mazurka in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 모음곡 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c78e0b49-e2f4-4614-9f8a-6311cf4ed882'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d472461a-ccec-47fe-9b3f-2440b5a20136', 4, NULL, '발라드 D단조', 'Ballade in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 모음곡 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d472461a-ccec-47fe-9b3f-2440b5a20136'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51f1fbb8-c822-4f30-8aac-48b8cf8d91a4', 5, NULL, '마주르카 G장조', 'Mazurka in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 모음곡 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51f1fbb8-c822-4f30-8aac-48b8cf8d91a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:011cabbd-df6b-45b8-9014-e5d096b3d4a4', 6, NULL, '폴로네즈 A단조', 'Polonaise in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 모음곡 <음악의 밤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:011cabbd-df6b-45b8-9014-e5d096b3d4a4'
);


-- Op. 7 피아노 협주곡 A단조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94d40e8a-81fc-3264-a2df-44c5225f2ab5', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 177 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94d40e8a-81fc-3264-a2df-44c5225f2ab5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1655036-4a54-37bb-873e-c792f123aa1a', 2, 'II', '로망스. Andante non troppo, con grazia', 'II. Romanze. Andante non troppo, con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 177 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1655036-4a54-37bb-873e-c792f123aa1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51e79aa1-0318-3bb3-8cce-b83bedfae260', 3, 'III', '피날레. Allegro non troppo', 'III. Finale. Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 177 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51e79aa1-0318-3bb3-8cce-b83bedfae260'
);


-- Op. 8 벨리니 <해적>의 카바티나에 의한 연주회용 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '벨리니 <해적>의 카바티나에 의한 연주회용 변주곡', 'Variations de concert sur la cavatine du Pirate de Bellini', 'song', 'Op. 8', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '벨리니 <해적>의 카바티나에 의한 연주회용 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5db156ba-f68d-4c77-a32a-7cb38e0ea68f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5db156ba-f68d-4c77-a32a-7cb38e0ea68f'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '벨리니 <해적>의 카바티나에 의한 연주회용 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5db156ba-f68d-4c77-a32a-7cb38e0ea68f'
);


-- Op. 9 즉흥곡 G단조 "빈의 추억"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 G단조 "빈의 추억"', 'Souvenir de Vienne, Impromptu in G minor', 'song', 'Op. 9', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 G단조 "빈의 추억"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2256cf94-03bd-48e8-acb6-f985b7a83646'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2256cf94-03bd-48e8-acb6-f985b7a83646'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '즉흥곡 G단조 "빈의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2256cf94-03bd-48e8-acb6-f985b7a83646'
);


-- Op. 10 스케르초 1번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 1번 D단조', 'Scherzo No. 1 in D minor', 'song', 'Op. 10', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 1번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '732bafea-8d56-47c2-9b89-435acc7fba0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '732bafea-8d56-47c2-9b89-435acc7fba0e'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '스케르초 1번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '732bafea-8d56-47c2-9b89-435acc7fba0e'
);


-- Op. 11 로망스 Op. 11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 Op. 11', '3 Romances, Op. 11', 'album', NULL, 'Op.', '11', 1839, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 Op. 11'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00550ecf-0272-43c4-9a0a-9c4af52a5c54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00550ecf-0272-43c4-9a0a-9c4af52a5c54'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00550ecf-0272-43c4-9a0a-9c4af52a5c54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:792c22d1-c16c-4de0-9a9d-eb6b2f0e3cd2', 1, NULL, 'E♭단조', 'No. 1 in E♭ minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792c22d1-c16c-4de0-9a9d-eb6b2f0e3cd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22ad98c0-c319-4b66-827e-9f0e4dc1607d', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22ad98c0-c319-4b66-827e-9f0e4dc1607d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:764b2d49-af68-4f5c-b767-828ecaba1078', 3, NULL, 'A♭장조', 'No. 3 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:764b2d49-af68-4f5c-b767-828ecaba1078'
);


-- Op. 12 뤼케르트 <사랑의 봄>에 의한 3개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '뤼케르트 <사랑의 봄>에 의한 3개의 가곡', '3 Songs from Rückert''s "Liebesfrühling", Op. 12', 'album', 'Op. 12', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '뤼케르트 <사랑의 봄>에 의한 3개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f98ff2ea-c901-4ee0-856d-df020fe94d8f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f98ff2ea-c901-4ee0-856d-df020fe94d8f'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '뤼케르트 <사랑의 봄>에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f98ff2ea-c901-4ee0-856d-df020fe94d8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a973bff-3062-47f1-a455-6bcbfa05defe', 1, NULL, 'Er ist gekommen in Sturm und Regen', 'Er ist gekommen in Sturm und Regen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '뤼케르트 <사랑의 봄>에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a973bff-3062-47f1-a455-6bcbfa05defe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23d17c15-b032-41e5-80f2-0bb67024763a', 2, NULL, 'Liebst du um Schönheit', 'Liebst du um Schönheit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '뤼케르트 <사랑의 봄>에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23d17c15-b032-41e5-80f2-0bb67024763a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cbcd73e-c3ec-4685-93a6-9d60d4a26746', 3, NULL, 'Warum willst du and''re fragen', 'Warum willst du and''re fragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '뤼케르트 <사랑의 봄>에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cbcd73e-c3ec-4685-93a6-9d60d4a26746'
);


-- Op. 13 가곡집 Op. 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 Op. 13', '6 Lieder, Op. 13', 'album', NULL, 'Op.', '13', 1843, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 Op. 13'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4ab20db-bf5f-4b0b-a900-a99c2d31414f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e4ab20db-bf5f-4b0b-a900-a99c2d31414f'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡집 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e4ab20db-bf5f-4b0b-a900-a99c2d31414f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6191b47b-f0e0-475b-9320-41975c80a47a', 1, NULL, 'Ich stand in dunklen Träumen', 'Ich stand in dunklen Träumen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡집 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6191b47b-f0e0-475b-9320-41975c80a47a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1900782d-8c3d-4bb7-952e-88c77d58a8e6', 2, NULL, 'Sie liebten sich beide', 'Sie liebten sich beide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡집 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1900782d-8c3d-4bb7-952e-88c77d58a8e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e4cb31b-6e23-4d90-b639-80d8dbd7e340', 3, NULL, 'Liebeszauber', 'Liebeszauber', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡집 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e4cb31b-6e23-4d90-b639-80d8dbd7e340'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6916a104-8693-4d3b-9e00-c757d54b5c62', 4, NULL, 'Der Mond kommt still gegangen', 'Der Mond kommt still gegangen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡집 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6916a104-8693-4d3b-9e00-c757d54b5c62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74125f0c-d415-496f-8f57-70af7e473add', 5, NULL, 'Ich hab'' in deinem Auge', 'Ich hab'' in deinem Auge', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡집 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74125f0c-d415-496f-8f57-70af7e473add'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ac06705-0692-49d1-956f-e71a9d2bffe8', 6, NULL, 'Die stille Lotosblume', 'Die stille Lotosblume', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡집 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ac06705-0692-49d1-956f-e71a9d2bffe8'
);


-- Op. 14 스케르초 2번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 2번 C단조', 'Scherzo No. 2 in C minor', 'song', 'Op. 14', NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 2번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '273807e9-5238-451d-b6d0-05115f24d73f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '273807e9-5238-451d-b6d0-05115f24d73f'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '스케르초 2번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '273807e9-5238-451d-b6d0-05115f24d73f'
);


-- Op. 15 덧없는 소품 Op. 15

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '덧없는 소품 Op. 15', '4 Pièces fugitives, Op. 15', 'album', NULL, 'Op.', '15', 1844, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '덧없는 소품 Op. 15'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07594c7f-9a62-4e4b-a0d5-ad0fd43fd388'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07594c7f-9a62-4e4b-a0d5-ad0fd43fd388'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '덧없는 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07594c7f-9a62-4e4b-a0d5-ad0fd43fd388'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5c4e10a-916f-44cb-b39a-137c0a358ed8', 1, NULL, 'F장조', 'No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '덧없는 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5c4e10a-916f-44cb-b39a-137c0a358ed8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a5e1ef6-b79d-4004-aae2-af386a66de64', 2, NULL, 'A단조', 'No. 2 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '덧없는 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a5e1ef6-b79d-4004-aae2-af386a66de64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72d82c21-b052-451a-922c-0fea209acddb', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '덧없는 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72d82c21-b052-451a-922c-0fea209acddb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2249c0d5-1fe4-4afb-97fb-281839212f14', 4, NULL, 'G장조', 'No. 4 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '덧없는 소품 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2249c0d5-1fe4-4afb-97fb-281839212f14'
);


-- Op. 16 전주곡과 푸가 Op. 16

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡과 푸가 Op. 16', '3 Preludes and Fugues, Op. 16', 'album', NULL, 'Op.', '16', 1845, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡과 푸가 Op. 16'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c0ff350-9cd1-4173-bca6-e7148a189f29'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c0ff350-9cd1-4173-bca6-e7148a189f29'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c0ff350-9cd1-4173-bca6-e7148a189f29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92633f48-6bef-4e04-97c7-14d1b55d0fdf', 1, NULL, '전주곡과 푸가 G단조', 'No. 1 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92633f48-6bef-4e04-97c7-14d1b55d0fdf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8846717-2f10-48bd-acb3-75aabb81c2af', 1, 'I', '전주곡. Andante', 'I. Prelude. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92633f48-6bef-4e04-97c7-14d1b55d0fdf'
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8846717-2f10-48bd-acb3-75aabb81c2af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97270fc1-6912-4faf-871f-c7796afd01a8', 2, 'II', '푸가. Allegro vivace', 'II. Fugue. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:92633f48-6bef-4e04-97c7-14d1b55d0fdf'
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97270fc1-6912-4faf-871f-c7796afd01a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f164ceee-74e8-46e1-8725-7f72d980e4d2', 2, NULL, '전주곡과 푸가 B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f164ceee-74e8-46e1-8725-7f72d980e4d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cfeca8ce-77bc-4c2b-82a7-b1b2d138ad98', 1, 'I', '전주곡. Allegretto', 'I. Prelude. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f164ceee-74e8-46e1-8725-7f72d980e4d2'
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfeca8ce-77bc-4c2b-82a7-b1b2d138ad98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae4bb44e-ad96-4b74-a8db-2e9b83d180ed', 2, 'II', '푸가. Andante', 'II. Fugue. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f164ceee-74e8-46e1-8725-7f72d980e4d2'
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae4bb44e-ad96-4b74-a8db-2e9b83d180ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13030aee-1d4c-4664-b284-f780b591a5b4', 3, NULL, '전주곡과 푸가 D단조', 'No. 3 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13030aee-1d4c-4664-b284-f780b591a5b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88a0f80e-1f95-44f5-bd6d-e94eeff12fca', 1, 'I', '전주곡. Andante', 'I. Prelude. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:13030aee-1d4c-4664-b284-f780b591a5b4'
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88a0f80e-1f95-44f5-bd6d-e94eeff12fca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3a7e6f3b-92f0-4845-9de0-ff4d17bd3637', 2, 'II', '푸가. Andantino con moto', 'II. Fugue. Andantino con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:13030aee-1d4c-4664-b284-f780b591a5b4'
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a7e6f3b-92f0-4845-9de0-ff4d17bd3637'
);


-- Op. 17 피아노 3중주 G단조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b5547cd-0705-46c6-b9d3-298f554faf8c', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 176 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b5547cd-0705-46c6-b9d3-298f554faf8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bd73393-3f05-48f8-afd2-32935b8653f2', 2, 'II', '스케르초. Tempo di menuetto', 'II. Scherzo. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 176 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bd73393-3f05-48f8-afd2-32935b8653f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ff0b98f-479c-4fad-8af9-89d7235c7d67', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 176 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ff0b98f-479c-4fad-8af9-89d7235c7d67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:662e4ea6-ad23-40f2-8dd2-d01a4286055a', 4, 'IV', 'Allegretto', 'IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 176 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:662e4ea6-ad23-40f2-8dd2-d01a4286055a'
);


-- Op. 19 혼성 합창곡 Op. 19

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '혼성 합창곡 Op. 19', '3 Gemischte Chöre, Op. 19', 'album', NULL, 'Op.', '19', 1848, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '혼성 합창곡 Op. 19'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4ad5873-33ca-4d3a-9463-b11d1c010dad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a4ad5873-33ca-4d3a-9463-b11d1c010dad'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '혼성 합창곡 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a4ad5873-33ca-4d3a-9463-b11d1c010dad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4474af5a-76b0-433b-983d-1fda382f9554', 1, NULL, 'Abendfeier in Venedig', 'Abendfeier in Venedig', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '혼성 합창곡 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4474af5a-76b0-433b-983d-1fda382f9554'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dddd0fe-dabc-4a9f-9a8f-83866edcc50b', 2, NULL, 'Vorwärts', 'Vorwärts', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '혼성 합창곡 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dddd0fe-dabc-4a9f-9a8f-83866edcc50b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd8c25be-a141-4ef7-b64a-a39fee351b7d', 3, NULL, 'Gondoliera', 'Gondoliera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '혼성 합창곡 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd8c25be-a141-4ef7-b64a-a39fee351b7d'
);


-- Op. 20 로베르트 슈만 주제에 의한 변주곡 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로베르트 슈만 주제에 의한 변주곡 F#단조', 'Variations on a Theme by Robert Schumann in F# minor', 'song', 'Op. 20', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로베르트 슈만 주제에 의한 변주곡 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d4d8528-3305-4df6-934d-1aad4e9fca66'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0d4d8528-3305-4df6-934d-1aad4e9fca66'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로베르트 슈만 주제에 의한 변주곡 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0d4d8528-3305-4df6-934d-1aad4e9fca66'
);


-- Op. 21 로망스 Op. 21

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 Op. 21', '3 Romances, Op. 21', 'album', NULL, 'Op.', '21', 1853, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 Op. 21'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ab4a0cc-3564-4030-afe5-3d0bc306f029'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ab4a0cc-3564-4030-afe5-3d0bc306f029'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ab4a0cc-3564-4030-afe5-3d0bc306f029'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e79673b-3176-4e19-9460-707790f530d7', 1, NULL, 'A단조', 'No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e79673b-3176-4e19-9460-707790f530d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1c403ab-7c6c-4c15-a758-5ac9e308e7ec', 2, NULL, 'F장조', 'No. 2 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1c403ab-7c6c-4c15-a758-5ac9e308e7ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d35af7bf-a17b-4b98-a72e-c003c57ac419', 3, NULL, 'G단조', 'No. 3 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 Op. 21' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d35af7bf-a17b-4b98-a72e-c003c57ac419'
);


-- Op. 22 3개의 로망스 (바이올린과 피아노를 위한)

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ff73cc3-d436-43f8-91fd-f7eb7c94e153', 1, NULL, 'D♭장조', 'No. 1 in D♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 178 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ff73cc3-d436-43f8-91fd-f7eb7c94e153'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1128ff3-5268-473c-8583-70b8172037c2', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 178 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1128ff3-5268-473c-8583-70b8172037c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd63498f-8e11-41e7-95fb-f1dfccc46571', 3, NULL, 'B♭장조', 'No. 3 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 178 AND p.composer_id = 39
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd63498f-8e11-41e7-95fb-f1dfccc46571'
);


-- Op. 23 롤레트 <유쿤데>에 의한 6개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '롤레트 <유쿤데>에 의한 6개의 가곡', '6 Lieder from Rollett''s "Jucunde", Op. 23', 'album', 'Op. 23', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '롤레트 <유쿤데>에 의한 6개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10cf97d3-7f7b-43c8-8d23-5880896a9cd5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '10cf97d3-7f7b-43c8-8d23-5880896a9cd5'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '롤레트 <유쿤데>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10cf97d3-7f7b-43c8-8d23-5880896a9cd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89c905db-3e4d-4aec-a366-66754bbeea10', 1, NULL, 'Was weinst du, Blümlein', 'Was weinst du, Blümlein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '롤레트 <유쿤데>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89c905db-3e4d-4aec-a366-66754bbeea10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2ea76f6-e65c-4ad6-9356-69da16d10b6b', 2, NULL, 'An einem lichten Morgen', 'An einem lichten Morgen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '롤레트 <유쿤데>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2ea76f6-e65c-4ad6-9356-69da16d10b6b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05e86d18-cf58-4f8f-91b9-760bbbdb6dc8', 3, NULL, 'Geheimes Flüstern hier und dort', 'Geheimes Flüstern hier und dort', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '롤레트 <유쿤데>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05e86d18-cf58-4f8f-91b9-760bbbdb6dc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79bbbe7d-4f93-4456-8f83-ab491b8cc607', 4, NULL, 'Auf einem grünen Hügel', 'Auf einem grünen Hügel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '롤레트 <유쿤데>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79bbbe7d-4f93-4456-8f83-ab491b8cc607'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edc5298a-7e55-4e5d-bd3a-854d59bca16a', 5, NULL, 'Das ist ein Tag, der klingen mag', 'Das ist ein Tag, der klingen mag', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '롤레트 <유쿤데>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edc5298a-7e55-4e5d-bd3a-854d59bca16a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17971c9f-d201-4564-98ba-4808699c8e94', 6, NULL, 'O Lust, o Lust', 'O Lust, o Lust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '롤레트 <유쿤데>에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17971c9f-d201-4564-98ba-4808699c8e94'
);


-- WoO 4 연습곡 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연습곡 A♭장조', 'Etude in A♭ major', 'song', 'WoO 4', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연습곡 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ec79ffa-d7bc-4bbf-932a-18f297a20746'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ec79ffa-d7bc-4bbf-932a-18f297a20746'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '연습곡 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ec79ffa-d7bc-4bbf-932a-18f297a20746'
);


-- None 피아노 소나타 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 G단조', 'Piano Sonata in G minor', 'album', NULL, NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3bdede6-a1e0-4d31-a21b-ed0f25ab44e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3bdede6-a1e0-4d31-a21b-ed0f25ab44e2'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3bdede6-a1e0-4d31-a21b-ed0f25ab44e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3913d290-e133-43b6-8f73-fad346d3c747', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3913d290-e133-43b6-8f73-fad346d3c747'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:455985d0-f760-46ac-a43b-a37ef999fa4c', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:455985d0-f760-46ac-a43b-a37ef999fa4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5df544f1-81b1-457f-b91d-0eb8c7a29940', 3, 'III', '스케르초', 'III. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5df544f1-81b1-457f-b91d-0eb8c7a29940'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f7be027-6e31-4f5d-98f9-a56b232ad0d2', 4, 'IV', '론도', 'IV. Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '피아노 소나타 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f7be027-6e31-4f5d-98f9-a56b232ad0d2'
);


-- None 즉흥곡 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '즉흥곡 E장조', 'Impromptu in E major', 'song', NULL, NULL, NULL, 1844, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '즉흥곡 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5d13785-61e2-4c58-a13f-2a56f6c9cef7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5d13785-61e2-4c58-a13f-2a56f6c9cef7'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '즉흥곡 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5d13785-61e2-4c58-a13f-2a56f6c9cef7'
);


-- None 전주곡과 푸가 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡과 푸가 F#단조', 'Prelude and Fugue in F# minor', 'album', NULL, NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡과 푸가 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd20642fd-efcb-4243-809b-56e9538d5ee0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd20642fd-efcb-4243-809b-56e9538d5ee0'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd20642fd-efcb-4243-809b-56e9538d5ee0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:824fc4a5-a5cc-4bbd-bcc6-79239fff26b4', 1, 'I', '전주곡', 'I. Präludium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:824fc4a5-a5cc-4bbd-bcc6-79239fff26b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bad6a09d-a173-44ab-832b-ba1087f07d98', 2, 'II', '4성 푸가', 'II. Fuga a 4 voci', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '전주곡과 푸가 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bad6a09d-a173-44ab-832b-ba1087f07d98'
);


-- None 전주곡 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 F단조', 'Praeludium in F minor', 'song', NULL, NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9824251-0749-4bbc-a65e-f113f023d8c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9824251-0749-4bbc-a65e-f113f023d8c1'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '전주곡 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9824251-0749-4bbc-a65e-f113f023d8c1'
);


-- None 바흐 주제에 의한 3개의 푸가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바흐 주제에 의한 3개의 푸가', '3 Fugues on Themes by J. S. Bach', 'album', NULL, NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바흐 주제에 의한 3개의 푸가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed145ec4-760a-426b-bd50-2d1f58bf4228'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed145ec4-760a-426b-bd50-2d1f58bf4228'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '바흐 주제에 의한 3개의 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed145ec4-760a-426b-bd50-2d1f58bf4228'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:356bd52d-c54f-4621-b6fc-9abc89f05379', 1, NULL, '4성 푸가 E♭장조', 'Fuga a 4 voci in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '바흐 주제에 의한 3개의 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:356bd52d-c54f-4621-b6fc-9abc89f05379'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e75efe6d-710c-4aee-8ecb-62eab6668844', 2, NULL, '4성 푸가 E장조', 'Fuga a 4 voci in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '바흐 주제에 의한 3개의 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e75efe6d-710c-4aee-8ecb-62eab6668844'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a74adb2-faab-4968-8701-9e67366cb449', 3, NULL, '4성 푸가 G단조', 'Fuga a 4 voci in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '바흐 주제에 의한 3개의 푸가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a74adb2-faab-4968-8701-9e67366cb449'
);


-- WoO 28 로망스 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 A단조', 'Romanze in A minor', 'song', 'WoO 28', NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58b37c68-b1df-4e27-84e9-7107259a564a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58b37c68-b1df-4e27-84e9-7107259a564a'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58b37c68-b1df-4e27-84e9-7107259a564a'
);


-- None 로망스 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '로망스 B단조', 'Romanze in B minor', 'song', NULL, NULL, NULL, 1855, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '로망스 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb6224f5-1fb3-40fc-8a05-a35e79a34710'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb6224f5-1fb3-40fc-8a05-a35e79a34710'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '로망스 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb6224f5-1fb3-40fc-8a05-a35e79a34710'
);


-- None 행진곡 E♭장조 (피아노 연탄)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 (피아노 연탄)', 'March in E♭ major for Piano Four Hands (Geburtstagsmarsch)', 'song', NULL, NULL, NULL, 1879, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 (피아노 연탄)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05fda05d-7baf-4bbb-a30e-71312b60f3df'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '05fda05d-7baf-4bbb-a30e-71312b60f3df'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '행진곡 E♭장조 (피아노 연탄)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '05fda05d-7baf-4bbb-a30e-71312b60f3df'
);


-- None 3성 카논 <Wenn ich ein Vöglein wär>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성 카논 <Wenn ich ein Vöglein wär>', 'Wenn ich ein Vöglein wär (canon for three voices)', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성 카논 <Wenn ich ein Vöglein wär>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '580dc796-69a7-4c75-be2c-c757d34bc81a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '580dc796-69a7-4c75-be2c-c757d34bc81a'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '3성 카논 <Wenn ich ein Vöglein wär>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '580dc796-69a7-4c75-be2c-c757d34bc81a'
);


-- None 가곡 <An Alexis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <An Alexis>', 'An Alexis', 'song', NULL, NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <An Alexis>'
);


-- None 가곡 <Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Walzer>', 'Walzer', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b27186ca-54c5-4f75-bec4-c5bffe7027d4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b27186ca-54c5-4f75-bec4-c5bffe7027d4'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b27186ca-54c5-4f75-bec4-c5bffe7027d4'
);


-- None 가곡 <Der Abendstern>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Abendstern>', 'Der Abendstern', 'song', NULL, NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Abendstern>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b1e87c6-cf5a-49da-880e-1e908bcc6453'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b1e87c6-cf5a-49da-880e-1e908bcc6453'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Der Abendstern>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b1e87c6-cf5a-49da-880e-1e908bcc6453'
);


-- None 가곡 <Am Strande>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Am Strande>', 'Am Strande', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Am Strande>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e209d19-a123-49b2-a5c0-06d75cd45656'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e209d19-a123-49b2-a5c0-06d75cd45656'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Am Strande>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e209d19-a123-49b2-a5c0-06d75cd45656'
);


-- None 가곡 <Volkslied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Volkslied>', 'Volkslied', 'song', NULL, NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Volkslied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c8ef8cb-ebd1-48e9-afc2-233e8418f09f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c8ef8cb-ebd1-48e9-afc2-233e8418f09f'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Volkslied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c8ef8cb-ebd1-48e9-afc2-233e8418f09f'
);


-- None 가곡 <Die gute Nacht, die ich dir sage>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die gute Nacht, die ich dir sage>', 'Die gute Nacht, die ich dir sage', 'song', NULL, NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die gute Nacht, die ich dir sage>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea14d13c-02b5-480c-95ba-1568d2294c0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea14d13c-02b5-480c-95ba-1568d2294c0e'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Die gute Nacht, die ich dir sage>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea14d13c-02b5-480c-95ba-1568d2294c0e'
);


-- None 가곡 <Lorelei>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lorelei>', 'Lorelei', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lorelei>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62d1f980-aa25-4bf5-b83d-0a2bae5c6d96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '62d1f980-aa25-4bf5-b83d-0a2bae5c6d96'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Lorelei>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '62d1f980-aa25-4bf5-b83d-0a2bae5c6d96'
);


-- None 가곡 <Oh weh des Scheidens, das er tat>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Oh weh des Scheidens, das er tat>', 'Oh weh des Scheidens, das er tat', 'song', NULL, NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Oh weh des Scheidens, das er tat>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7484e3ac-2bfe-4ee2-ab37-7f7d87c45b1c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7484e3ac-2bfe-4ee2-ab37-7f7d87c45b1c'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Oh weh des Scheidens, das er tat>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7484e3ac-2bfe-4ee2-ab37-7f7d87c45b1c'
);


-- None 가곡 <Mein Stern>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mein Stern>', 'Mein Stern', 'song', NULL, NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mein Stern>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdb658e0-a7b3-4eff-b978-daf6c6dbee4d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fdb658e0-a7b3-4eff-b978-daf6c6dbee4d'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Mein Stern>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdb658e0-a7b3-4eff-b978-daf6c6dbee4d'
);


-- None 가곡 <Beim Abschied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Beim Abschied>', 'Beim Abschied', 'song', NULL, NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Beim Abschied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48c9c3a7-674d-4cab-8334-d424e8a52f67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '48c9c3a7-674d-4cab-8334-d424e8a52f67'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Beim Abschied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '48c9c3a7-674d-4cab-8334-d424e8a52f67'
);


-- None 가곡 <Das Veilchen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Das Veilchen>', 'Das Veilchen', 'song', NULL, NULL, NULL, 1853, 'manual', 1
FROM composers c
WHERE c.id = 39
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Das Veilchen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0f52e5a-2dce-4e82-b281-1a61f16ede77'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b0f52e5a-2dce-4e82-b281-1a61f16ede77'
FROM pieces p
WHERE p.composer_id = 39 AND p.title = '가곡 <Das Veilchen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b0f52e5a-2dce-4e82-b281-1a61f16ede77'
);

