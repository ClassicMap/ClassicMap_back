-- 파가니니 작품을 출판 단위로 채운다(카탈로그: Op.·MS). 작품 121개(묶음 25, 다악장 39, 낱곡 57),
-- 새 작품 118개, 기존 작품 3개, part 372개, 그 아래 313개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   Op. 1–14 와 MS 표 작품. 협주곡 1~6번을 다 넣고(5·6번은 남이 관현악 복원), 변주곡은 낱곡.
--   164 「24개의 카프리스」는 24곡 묶음 자체.
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

-- Op. 1 24개의 카프리스

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ded18a4a-1fee-4d05-bfb4-57649f90e69f'
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ded18a4a-1fee-4d05-bfb4-57649f90e69f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:487ed36a-22e3-3d61-a9eb-0bde3d9fb522', 1, NULL, 'E장조', 'No. 1 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:487ed36a-22e3-3d61-a9eb-0bde3d9fb522'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25314eb9-5fcd-368f-87dd-bf820ef63b68', 2, NULL, 'B단조', 'No. 2 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25314eb9-5fcd-368f-87dd-bf820ef63b68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6a0e282-8e6d-3590-aeff-a419f56454f4', 3, NULL, 'E단조', 'No. 3 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6a0e282-8e6d-3590-aeff-a419f56454f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3858989a-73d2-3402-84c8-a40a02f0c94b', 4, NULL, 'C단조', 'No. 4 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3858989a-73d2-3402-84c8-a40a02f0c94b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15e2cc01-523d-38e3-a8b5-32687c73cbfc', 5, NULL, 'A단조', 'No. 5 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15e2cc01-523d-38e3-a8b5-32687c73cbfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6153049f-a32c-38b0-a791-d04ce8e55b88', 6, NULL, 'G단조', 'No. 6 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6153049f-a32c-38b0-a791-d04ce8e55b88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b1f60c1-fc1c-3fac-85bb-fda3f1acea36', 7, NULL, 'A단조', 'No. 7 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b1f60c1-fc1c-3fac-85bb-fda3f1acea36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2efa974-95ff-3972-a740-a10b29073426', 8, NULL, 'E♭장조', 'No. 8 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2efa974-95ff-3972-a740-a10b29073426'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5fd6fc0-3bad-3b27-9e46-2de9f2e09181', 9, NULL, 'E장조 "사냥"', 'No. 9 in E major "La Chasse"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5fd6fc0-3bad-3b27-9e46-2de9f2e09181'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bb75714-2edd-31df-b90a-87a5b65a0117', 10, NULL, 'G단조', 'No. 10 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bb75714-2edd-31df-b90a-87a5b65a0117'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df139ba9-7b12-3f71-99f2-ae91926fa06e', 11, NULL, 'C장조', 'No. 11 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df139ba9-7b12-3f71-99f2-ae91926fa06e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd465ae5-5b69-3a66-8896-35f667dd7fb8', 12, NULL, 'A♭장조', 'No. 12 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd465ae5-5b69-3a66-8896-35f667dd7fb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f90d56c5-0222-3e3d-abb1-3c2a1e0bb94a', 13, NULL, 'B♭장조 "악마의 웃음"', 'No. 13 in B♭ major "The Devil''s Laughter"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f90d56c5-0222-3e3d-abb1-3c2a1e0bb94a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:baba23cf-f3ba-34d6-8f75-110e3bb2d65d', 14, NULL, 'E♭장조', 'No. 14 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baba23cf-f3ba-34d6-8f75-110e3bb2d65d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:314d4301-4725-37e9-9483-11bf66ea5136', 15, NULL, 'E단조', 'No. 15 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:314d4301-4725-37e9-9483-11bf66ea5136'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c680f4d2-897a-3a9e-91e9-04c4f94c6298', 16, NULL, 'G단조', 'No. 16 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c680f4d2-897a-3a9e-91e9-04c4f94c6298'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5831e38e-6bfd-32ed-869f-6687aa345ff0', 17, NULL, 'E♭장조', 'No. 17 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5831e38e-6bfd-32ed-869f-6687aa345ff0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2aa04d9b-863b-3abe-b149-87542a7f9b31', 18, NULL, 'C장조', 'No. 18 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2aa04d9b-863b-3abe-b149-87542a7f9b31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8ded54a-d866-3094-aaa1-06a8918fa678', 19, NULL, 'E♭장조', 'No. 19 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8ded54a-d866-3094-aaa1-06a8918fa678'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dbaa677-a9a8-3d7a-84e6-a20c9d36dcd8', 20, NULL, 'D장조', 'No. 20 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dbaa677-a9a8-3d7a-84e6-a20c9d36dcd8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d26f618-a0b2-34f2-a9c5-e2ebe6c1a72f', 21, NULL, 'A장조', 'No. 21 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d26f618-a0b2-34f2-a9c5-e2ebe6c1a72f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25be083b-1c18-3d2e-951b-1ea7cb8a8c93', 22, NULL, 'F장조', 'No. 22 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25be083b-1c18-3d2e-951b-1ea7cb8a8c93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4afbe663-e6b4-37d5-aba7-7bf5674d2452', 23, NULL, 'E♭장조', 'No. 23 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4afbe663-e6b4-37d5-aba7-7bf5674d2452'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47fd6ff8-c237-34bd-8f75-3abf847fc6b3', 24, NULL, 'A단조', 'No. 24 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 164 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47fd6ff8-c237-34bd-8f75-3abf847fc6b3'
);


-- Op. 2 바이올린과 기타를 위한 소나타 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 Op. 2', '6 Sonatas for Violin and Guitar, Op. 2', 'album', NULL, 'Op.', '2', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ceecee0-b23b-40f1-a98f-37554b4fe1e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ceecee0-b23b-40f1-a98f-37554b4fe1e8'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ceecee0-b23b-40f1-a98f-37554b4fe1e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:535e3f57-c992-4199-a0a4-d98971b07252', 1, NULL, 'A장조', 'No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:535e3f57-c992-4199-a0a4-d98971b07252'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68eec576-f3f5-469b-bf36-7bd8ceb32c06', 1, 'I', '미뉴에트. Adagio', 'I. Minuetto - Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:535e3f57-c992-4199-a0a4-d98971b07252'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68eec576-f3f5-469b-bf36-7bd8ceb32c06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a432b287-7f88-49f7-b4a8-e8f86b9de49f', 2, 'II', '폴로네즈. Quasi allegro', 'II. Polonese - Quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:535e3f57-c992-4199-a0a4-d98971b07252'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a432b287-7f88-49f7-b4a8-e8f86b9de49f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af745ecd-433f-4508-9d50-3ff745ac002d', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af745ecd-433f-4508-9d50-3ff745ac002d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd7ec902-f43a-4e59-b330-12e3b007c2ce', 1, 'I', 'Larghetto espressivo', 'I. Larghetto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:af745ecd-433f-4508-9d50-3ff745ac002d'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd7ec902-f43a-4e59-b330-12e3b007c2ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2695c884-a2e9-4fad-89f5-a10deeed9040', 2, 'II', 'Allegro spiritoso', 'II. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:af745ecd-433f-4508-9d50-3ff745ac002d'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2695c884-a2e9-4fad-89f5-a10deeed9040'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a3f3c2-9a0c-4d55-a1c6-b3bb496f1fc5', 3, NULL, 'D단조', 'No. 3 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a3f3c2-9a0c-4d55-a1c6-b3bb496f1fc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11ae1bb8-698b-4fb9-b223-30a5e657174c', 1, 'I', 'Adagio - Maestoso', 'I. Adagio - Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9a3f3c2-9a0c-4d55-a1c6-b3bb496f1fc5'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ae1bb8-698b-4fb9-b223-30a5e657174c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c869030-2cfa-4397-9da6-1634ad8a248f', 2, 'II', 'Andantino - Galantemente', 'II. Andantino - Galantemente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9a3f3c2-9a0c-4d55-a1c6-b3bb496f1fc5'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c869030-2cfa-4397-9da6-1634ad8a248f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c853cd0-3156-4b46-9100-b9a25a340e69', 4, NULL, 'A장조', 'No. 4 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c853cd0-3156-4b46-9100-b9a25a340e69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a704c79a-45a3-404e-8d4c-7603890b9d7d', 1, 'I', 'La sinagoga - Andante calcando', 'I. La sinagoga - Andante calcando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c853cd0-3156-4b46-9100-b9a25a340e69'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a704c79a-45a3-404e-8d4c-7603890b9d7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2fe467a-3a1c-460a-8ece-800026406cc3', 2, 'II', 'Andantino con brio', 'II. Andantino con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c853cd0-3156-4b46-9100-b9a25a340e69'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2fe467a-3a1c-460a-8ece-800026406cc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d1f1d65-97d6-4c66-b334-43a636efe875', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d1f1d65-97d6-4c66-b334-43a636efe875'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6348337b-2079-482f-a453-1a5eca325477', 1, 'I', 'Andante - Moderato impostatamente', 'I. Andante - Moderato impostatamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d1f1d65-97d6-4c66-b334-43a636efe875'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6348337b-2079-482f-a453-1a5eca325477'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:707cf92d-8083-4ee3-9c71-314a78f256d6', 2, 'II', 'Allegro spiritoso', 'II. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d1f1d65-97d6-4c66-b334-43a636efe875'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:707cf92d-8083-4ee3-9c71-314a78f256d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:250c03c4-ab2f-4967-a8d7-525868d461cd', 6, NULL, 'A단조', 'No. 6 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:250c03c4-ab2f-4967-a8d7-525868d461cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a32a0bad-ce0e-47bd-a5b9-b2eaff44e196', 1, 'I', 'Largo, con precisione', 'I. Largo, con precisione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:250c03c4-ab2f-4967-a8d7-525868d461cd'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a32a0bad-ce0e-47bd-a5b9-b2eaff44e196'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:204936b4-faf5-47f6-9457-517cbe5b849b', 2, 'II', 'Tempo di Valtz', 'II. Tempo di Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:250c03c4-ab2f-4967-a8d7-525868d461cd'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:204936b4-faf5-47f6-9457-517cbe5b849b'
);


-- Op. 3 바이올린과 기타를 위한 소나타 Op. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 Op. 3', '6 Sonatas for Violin and Guitar, Op. 3', 'album', NULL, 'Op.', '3', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 Op. 3'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '617ead5a-6eaa-403e-b8cb-f7551a1ced14'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '617ead5a-6eaa-403e-b8cb-f7551a1ced14'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '617ead5a-6eaa-403e-b8cb-f7551a1ced14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f875d77-b9d0-4810-b336-d8d27bb7299a', 1, NULL, 'A장조', 'No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f875d77-b9d0-4810-b336-d8d27bb7299a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b871ea2-e91d-477c-8619-07e940dd70c6', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f875d77-b9d0-4810-b336-d8d27bb7299a'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b871ea2-e91d-477c-8619-07e940dd70c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8cfcc67a-707d-47b8-90f9-bf81c066b304', 2, 'II', 'Presto, Variato - Variazione', 'II. Presto, Variato - Variazione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8f875d77-b9d0-4810-b336-d8d27bb7299a'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cfcc67a-707d-47b8-90f9-bf81c066b304'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb0e131c-0b37-47e0-911c-6663baefc263', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb0e131c-0b37-47e0-911c-6663baefc263'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b94cb4fa-7d9c-42cb-93ba-12e8558425b9', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb0e131c-0b37-47e0-911c-6663baefc263'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b94cb4fa-7d9c-42cb-93ba-12e8558425b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e29deb59-a35c-4cfe-8cdb-aca373ba4ed6', 2, 'II', 'Andantino scherzoso', 'II. Andantino scherzoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb0e131c-0b37-47e0-911c-6663baefc263'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e29deb59-a35c-4cfe-8cdb-aca373ba4ed6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df6301ba-8f43-4e4a-862f-265992f8abe7', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df6301ba-8f43-4e4a-862f-265992f8abe7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e676199-3b28-41b9-9be6-2765015ccb4e', 1, 'I', 'Andante sostenuto', 'I. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df6301ba-8f43-4e4a-862f-265992f8abe7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e676199-3b28-41b9-9be6-2765015ccb4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d18da9ea-8096-42e7-b1af-9a1ba96bc42a', 2, 'II', '론도. Molto allegro', 'II. Rondò - Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:df6301ba-8f43-4e4a-862f-265992f8abe7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d18da9ea-8096-42e7-b1af-9a1ba96bc42a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d43d27a-36c5-4353-9b11-83403ff113f9', 4, NULL, 'A단조', 'No. 4 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d43d27a-36c5-4353-9b11-83403ff113f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22fc7470-dea2-4f5f-87a9-60b8c9163048', 1, 'I', 'Andante - Largo', 'I. Andante - Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d43d27a-36c5-4353-9b11-83403ff113f9'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22fc7470-dea2-4f5f-87a9-60b8c9163048'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9f638e4-12b8-4109-b4d1-583ad4b54e8d', 2, 'II', 'Allegretto - Motteggiando', 'II. Allegretto - Motteggiando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d43d27a-36c5-4353-9b11-83403ff113f9'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9f638e4-12b8-4109-b4d1-583ad4b54e8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6757812-cede-45c9-a955-5bcaa4300fed', 5, NULL, 'A장조', 'No. 5 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6757812-cede-45c9-a955-5bcaa4300fed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:feea82de-892e-4ff0-bf21-fddc99ac6b05', 1, 'I', 'Adagio amoroso', 'I. Adagio amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6757812-cede-45c9-a955-5bcaa4300fed'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feea82de-892e-4ff0-bf21-fddc99ac6b05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa514459-5366-42c2-bf13-550d1e37c818', 2, 'II', 'Allegretto - Energicamente', 'II. Allegretto - Energicamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6757812-cede-45c9-a955-5bcaa4300fed'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa514459-5366-42c2-bf13-550d1e37c818'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea3f8e3d-58a8-414b-9d0e-5347ba8528d5', 6, NULL, 'E단조', 'No. 6 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea3f8e3d-58a8-414b-9d0e-5347ba8528d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:824b2ef5-2748-43e6-8616-39469e5cc167', 1, 'I', 'Andante - Innocentemente', 'I. Andante - Innocentemente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea3f8e3d-58a8-414b-9d0e-5347ba8528d5'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:824b2ef5-2748-43e6-8616-39469e5cc167'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4406db00-0159-4080-8b24-20191e703f63', 2, 'II', 'Allegro vivo e spiritoso', 'II. Allegro vivo e spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea3f8e3d-58a8-414b-9d0e-5347ba8528d5'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4406db00-0159-4080-8b24-20191e703f63'
);


-- Op. 4 기타 4중주 Op. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 Op. 4', '3 Quartets for Violin, Viola, Guitar and Cello, Op. 4', 'album', NULL, 'Op.', '4', 1816, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 Op. 4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e14d4355-e87c-4835-a1c1-5468d03df998', 1, NULL, '기타 4중주 1번 A단조', 'Quartet No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e14d4355-e87c-4835-a1c1-5468d03df998'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03418a08-8141-3449-9681-9301b697ad64', 1, 'I', '서주. Andante marcato. Vivace', 'I. Introduzione - Andante marcato. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e14d4355-e87c-4835-a1c1-5468d03df998'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03418a08-8141-3449-9681-9301b697ad64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73be430e-6ae1-37be-9bdf-8e305785e7bb', 2, 'II', '마르세유풍 미뉴에트. Andantino', 'II. Minuetto alla marsigliese - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e14d4355-e87c-4835-a1c1-5468d03df998'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73be430e-6ae1-37be-9bdf-8e305785e7bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:259ed6bc-09d9-3bba-b2c8-feec303247e2', 3, 'III', '주제와 변주. Adagietto cantabile', 'III. Tema con variazioni - Adagietto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e14d4355-e87c-4835-a1c1-5468d03df998'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:259ed6bc-09d9-3bba-b2c8-feec303247e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb008459-9507-492c-b188-e0a4dfeef08a', 2, NULL, '기타 4중주 2번 C장조', 'Quartet No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb008459-9507-492c-b188-e0a4dfeef08a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e48ce189-0e49-4622-ab46-a88410306206', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb008459-9507-492c-b188-e0a4dfeef08a'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e48ce189-0e49-4622-ab46-a88410306206'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b785de13-30a0-4753-bf30-756b66d0c7c9', 2, 'II', '미뉴에트. Andante', 'II. Minuetto - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb008459-9507-492c-b188-e0a4dfeef08a'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b785de13-30a0-4753-bf30-756b66d0c7c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d52209f-c7ce-4c4c-a8b9-1fab290bac27', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb008459-9507-492c-b188-e0a4dfeef08a'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d52209f-c7ce-4c4c-a8b9-1fab290bac27'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:266bdb3b-17c2-473e-8e23-1ed3f08579a1', 4, 'IV', '론도. Allegretto', 'IV. Rondò - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cb008459-9507-492c-b188-e0a4dfeef08a'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:266bdb3b-17c2-473e-8e23-1ed3f08579a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e35d7ddc-d051-480c-93b9-bae4436d4793', 3, NULL, '기타 4중주 3번 A장조', 'Quartet No. 3 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e35d7ddc-d051-480c-93b9-bae4436d4793'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a88972d1-704e-3e93-a7a0-a17f83aa494e', 1, 'I', 'Por-pourri - Allegro', 'I. Por-pourri - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e35d7ddc-d051-480c-93b9-bae4436d4793'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a88972d1-704e-3e93-a7a0-a17f83aa494e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae3b8860-3cde-32fa-8e02-0b41315c61d2', 2, 'II', '미뉴에트 alla Spagnola. Andantino', 'II. Minuetto alla Spagnola - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e35d7ddc-d051-480c-93b9-bae4436d4793'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae3b8860-3cde-32fa-8e02-0b41315c61d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a8e508fe-b7c2-37b4-977d-0794f74f372c', 3, 'III', '로망스. Adagio non tanto', 'III. Romance - Adagio non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e35d7ddc-d051-480c-93b9-bae4436d4793'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8e508fe-b7c2-37b4-977d-0794f74f372c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:706b24d1-467a-3bf8-8f3c-67946e7c7b32', 4, 'IV', '론도. Allegretto', 'IV. Rondò - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e35d7ddc-d051-480c-93b9-bae4436d4793'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:706b24d1-467a-3bf8-8f3c-67946e7c7b32'
);


-- Op. 5 기타 4중주 Op. 5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 Op. 5', '3 Quartets for Violin, Viola, Guitar and Cello, Op. 5', 'album', NULL, 'Op.', '5', 1815, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 Op. 5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cc9b0c5-8514-4f23-92d5-a74325d47774', 1, NULL, '기타 4중주 4번 D장조', 'Quartet No. 4 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cc9b0c5-8514-4f23-92d5-a74325d47774'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9141ea18-b01b-4568-8d50-fe889029c8a4', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2cc9b0c5-8514-4f23-92d5-a74325d47774'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9141ea18-b01b-4568-8d50-fe889029c8a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1a0ab71-677a-4546-a106-f9adb4cf9109', 2, 'II', 'Andante sotto voce e staccato', 'II. Andante sotto voce e staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2cc9b0c5-8514-4f23-92d5-a74325d47774'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1a0ab71-677a-4546-a106-f9adb4cf9109'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fbff1c5c-3f45-4341-9d14-a146be854556', 3, 'III', '칸타빌레. Quasi larghetto', 'III. Cantabile - Quasi larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2cc9b0c5-8514-4f23-92d5-a74325d47774'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbff1c5c-3f45-4341-9d14-a146be854556'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35ffedde-d960-422b-be5a-673360ad97ef', 4, 'IV', '피날레. Prestissimo', 'IV. Finale - Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2cc9b0c5-8514-4f23-92d5-a74325d47774'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35ffedde-d960-422b-be5a-673360ad97ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c5e4fb0-6c4c-470b-a9de-661567e811ee', 2, NULL, '기타 4중주 5번 C장조', 'Quartet No. 5 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c5e4fb0-6c4c-470b-a9de-661567e811ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e9359330-65d4-4918-a185-440e793b79f1', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2c5e4fb0-6c4c-470b-a9de-661567e811ee'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9359330-65d4-4918-a185-440e793b79f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8be8217f-3e10-47dd-a06b-e6d90d26852d', 2, 'II', '미뉴에트. Allegretto', 'II. Minuetto - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2c5e4fb0-6c4c-470b-a9de-661567e811ee'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8be8217f-3e10-47dd-a06b-e6d90d26852d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:057f6cb8-7dba-4120-a279-33a17f535a11', 3, 'III', '칸타빌레. Larghetto', 'III. Cantabile - Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2c5e4fb0-6c4c-470b-a9de-661567e811ee'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:057f6cb8-7dba-4120-a279-33a17f535a11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4f7a398-7904-4f18-8fbb-129873e7e931', 4, 'IV', '폴로네즈. Quasi presto', 'IV. Polacca - Quasi presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2c5e4fb0-6c4c-470b-a9de-661567e811ee'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4f7a398-7904-4f18-8fbb-129873e7e931'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b43afde-8e99-46db-bc4f-32de85375987', 3, NULL, '기타 4중주 6번 D단조', 'Quartet No. 6 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b43afde-8e99-46db-bc4f-32de85375987'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e3c6037-896c-48cf-ba9c-46da7c6b50aa', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9b43afde-8e99-46db-bc4f-32de85375987'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e3c6037-896c-48cf-ba9c-46da7c6b50aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13144ca1-6746-4f0f-8291-e0d3de2b125c', 2, 'II', 'Canone a trè - Allegro moderato', 'II. Canone a trè - Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9b43afde-8e99-46db-bc4f-32de85375987'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13144ca1-6746-4f0f-8291-e0d3de2b125c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcac3c24-ea80-45d6-95a4-705416ac4577', 3, 'III', '주제 cantabile. Quasi adagio', 'III. Tema cantabile - Quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9b43afde-8e99-46db-bc4f-32de85375987'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcac3c24-ea80-45d6-95a4-705416ac4577'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07696003-eb50-459e-856e-2e061b0403e7', 4, 'IV', '폴라케타. Allegro con brio', 'IV. Polacchetta - Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9b43afde-8e99-46db-bc4f-32de85375987'
WHERE p.composer_id = 35 AND p.title = '기타 4중주 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07696003-eb50-459e-856e-2e061b0403e7'
);


-- Op. 6 바이올린 협주곡 1번 D장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:307150d7-6f5f-3235-883d-5d4bb61196ba', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 166 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:307150d7-6f5f-3235-883d-5d4bb61196ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a92d7c37-91fc-38c7-b059-a33ccbc3ed5c', 2, 'II', 'Adagio espressivo', 'II. Adagio espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 166 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a92d7c37-91fc-38c7-b059-a33ccbc3ed5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29db839e-810c-3836-affb-5a2cbbf1dc91', 3, 'III', '론도. Allegro spiritoso', 'III. Rondò - Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 166 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29db839e-810c-3836-affb-5a2cbbf1dc91'
);


-- Op. 7 바이올린 협주곡 2번 B단조 "라 캄파넬라"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b54685-bf0c-3315-ae68-3290c3226166', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 165 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b54685-bf0c-3315-ae68-3290c3226166'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d78c28d-fa4c-3550-8d3c-2bcc94311d44', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 165 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d78c28d-fa4c-3550-8d3c-2bcc94311d44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1c8993a-59d4-3c99-a83d-9b6c047b9f2f', 3, 'III', '론도 "라 캄파넬라"', 'III. Rondo à la clochette "La campanella"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 165 AND p.composer_id = 35
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1c8993a-59d4-3c99-a83d-9b6c047b9f2f'
);


-- Op. 8 <마녀들> 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<마녀들> 변주곡', 'Le streghe, Variations on a Theme by Süssmayr', 'song', 'Op. 8', NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<마녀들> 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdef1660-b9d1-4be6-83a7-4c8b7ec0abfa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdef1660-b9d1-4be6-83a7-4c8b7ec0abfa'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<마녀들> 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdef1660-b9d1-4be6-83a7-4c8b7ec0abfa'
);


-- Op. 9 "God Save the King" 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"God Save the King" 변주곡', 'Variations on "God Save the King"', 'song', 'Op. 9', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"God Save the King" 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35ae0d92-da96-4b99-b730-59e98bdc1b6b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35ae0d92-da96-4b99-b730-59e98bdc1b6b'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '"God Save the King" 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35ae0d92-da96-4b99-b730-59e98bdc1b6b'
);


-- Op. 10 <베네치아의 사육제> 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<베네치아의 사육제> 변주곡', 'Il carnevale di Venezia, Variations', 'song', 'Op. 10', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<베네치아의 사육제> 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37a185af-ccd6-4b24-a433-cd850782aa7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '37a185af-ccd6-4b24-a433-cd850782aa7f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<베네치아의 사육제> 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37a185af-ccd6-4b24-a433-cd850782aa7f'
);


-- Op. 11 무궁동 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무궁동 C장조', 'Moto perpetuo (Allegro vivace a movimento perpetuo) in C major', 'song', 'Op. 11', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무궁동 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d0ac225-7d78-3dd7-a841-7ec4549a133f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d0ac225-7d78-3dd7-a841-7ec4549a133f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '무궁동 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d0ac225-7d78-3dd7-a841-7ec4549a133f'
);


-- Op. 12 "Non più mesta" 주제에 의한 서주와 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"Non più mesta" 주제에 의한 서주와 변주곡', 'Introduction and Variations on "Non più mesta"', 'song', 'Op. 12', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"Non più mesta" 주제에 의한 서주와 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2cfc2748-26bf-430f-8f08-0f8480ddaf34'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2cfc2748-26bf-430f-8f08-0f8480ddaf34'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '"Non più mesta" 주제에 의한 서주와 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2cfc2748-26bf-430f-8f08-0f8480ddaf34'
);


-- Op. 13 <I palpiti> 서주와 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<I palpiti> 서주와 변주곡', 'I palpiti, Introduction and Variations on "Di tanti palpiti"', 'song', 'Op. 13', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<I palpiti> 서주와 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97f2c8ac-8f4e-4e6a-bef1-5da4ccc66b7e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97f2c8ac-8f4e-4e6a-bef1-5da4ccc66b7e'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<I palpiti> 서주와 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97f2c8ac-8f4e-4e6a-bef1-5da4ccc66b7e'
);


-- Op. 14 "바루카바" 주제에 의한 60개의 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"바루카바" 주제에 의한 60개의 변주곡', '60 Variations on "Barucabà"', 'song', 'Op. 14', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"바루카바" 주제에 의한 60개의 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43bc16e5-3535-4c22-b602-b4d6dd153be1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43bc16e5-3535-4c22-b602-b4d6dd153be1'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '"바루카바" 주제에 의한 60개의 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43bc16e5-3535-4c22-b602-b4d6dd153be1'
);


-- MS 1 <카르마뇰라> 변주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<카르마뇰라> 변주곡 A장조', 'Carmagnola con variazioni in A major', 'song', 'MS 1', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<카르마뇰라> 변주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd92915e1-2922-4047-b2cc-3c1b7d96f167'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd92915e1-2922-4047-b2cc-3c1b7d96f167'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<카르마뇰라> 변주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd92915e1-2922-4047-b2cc-3c1b7d96f167'
);


-- MS 2 소나타 콘체르타타 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타 콘체르타타 A장조', 'Sonata concertata in A major', 'album', 'MS 2', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타 콘체르타타 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60183ebf-6dfd-489a-9772-a2c483f0e9e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '60183ebf-6dfd-489a-9772-a2c483f0e9e8'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '소나타 콘체르타타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '60183ebf-6dfd-489a-9772-a2c483f0e9e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffe11097-8b28-4b62-a1b2-828968a658bf', 1, 'I', 'Allegro spiritoso', 'I. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '소나타 콘체르타타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffe11097-8b28-4b62-a1b2-828968a658bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:371b87e8-781e-3d59-9bab-a964cc7871d2', 2, 'II', 'Adagio, assai espressivo', 'II. Adagio, assai espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '소나타 콘체르타타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:371b87e8-781e-3d59-9bab-a964cc7871d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee219824-d415-33cb-ad54-ab8d467cffb2', 3, 'III', '론도. Allegretto con brio scherzando', 'III. Rondeau. Allegretto con brio scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '소나타 콘체르타타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee219824-d415-33cb-ad54-ab8d467cffb2'
);


-- MS 3 그랜드 소나타 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그랜드 소나타 A장조', 'Grand Sonata in A major', 'album', 'MS 3', NULL, NULL, 1804, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그랜드 소나타 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec725f36-9003-4935-95ff-48f187b03484'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec725f36-9003-4935-95ff-48f187b03484'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '그랜드 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec725f36-9003-4935-95ff-48f187b03484'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94d95707-ecec-4b3a-86ef-fa804b4bec76', 1, 'I', 'Allegro risoluto', 'I. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '그랜드 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94d95707-ecec-4b3a-86ef-fa804b4bec76'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80658a08-95cf-489f-a8ea-4fcdef7a32ed', 2, 'II', '로망스. Più tosto Largo, Amorosamente', 'II. Romance - Più tosto Largo, Amorosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '그랜드 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80658a08-95cf-489f-a8ea-4fcdef7a32ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53fdb45a-9322-48a8-b3f1-4519bc697b20', 3, 'III', 'Andantino variato, Scherzando con 6 variazioni', 'III. Andantino Variato, Scherzando con 6 variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '그랜드 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53fdb45a-9322-48a8-b3f1-4519bc697b20'
);


-- MS 4 <사육제 디베르티멘토>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<사육제 디베르티멘토>', 'Divertimenti carnevaleschi', 'album', 'MS 4', NULL, NULL, 1804, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<사육제 디베르티멘토>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec6c26e5-ab83-4dd3-969d-b097e239ac42'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec6c26e5-ab83-4dd3-969d-b097e239ac42'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec6c26e5-ab83-4dd3-969d-b097e239ac42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b0874a8-35f7-49a3-acc2-bdde0177d8d3', 1, NULL, '미뉴에트 E♭장조', 'Minuetto in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b0874a8-35f7-49a3-acc2-bdde0177d8d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51565eb6-4ee7-47fc-8596-98babb040bd3', 2, NULL, '알레산드리나 E♭장조', 'Alessandrina no. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51565eb6-4ee7-47fc-8596-98babb040bd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba4b1ca2-cea3-408b-91cf-75423c46a3f4', 3, NULL, '알레산드리나 A장조', 'Alessandrina no. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba4b1ca2-cea3-408b-91cf-75423c46a3f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a6e66de-9133-4b29-adcf-6b4dfe3c0047', 4, NULL, '알레산드리나 D장조', 'Alessandrina no. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a6e66de-9133-4b29-adcf-6b4dfe3c0047'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:508855a2-b8b3-4882-9d8c-ad2cb60f5435', 5, NULL, '알레산드리나 C장조', 'Alessandrina no. 4 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:508855a2-b8b3-4882-9d8c-ad2cb60f5435'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5abc5a00-adb2-49ea-b24d-b9b88d7c47c1', 6, NULL, '알레산드리나 B♭장조', 'Alessandrina no. 5 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5abc5a00-adb2-49ea-b24d-b9b88d7c47c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:082f2129-9775-4b79-be33-2f7739bf51c6', 7, NULL, '알레산드리나 E♭장조', 'Alessandrina no. 6 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:082f2129-9775-4b79-be33-2f7739bf51c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83f2ef73-bcdc-4a11-8b72-38293cdbc1d8', 8, NULL, '페리고르디노 B♭장조', 'Perigordino no. 1 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83f2ef73-bcdc-4a11-8b72-38293cdbc1d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a850053-dc92-48b2-a848-464e0faa08ff', 9, NULL, '페리고르디노 A장조', 'Perigordino no. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a850053-dc92-48b2-a848-464e0faa08ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d8d5a4d-b46e-455f-8002-c5eaa41038b2', 10, NULL, '왈츠 B♭장조', 'Valzer no. 1 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d8d5a4d-b46e-455f-8002-c5eaa41038b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66ecf264-9789-4534-b9f5-c01551b8bf57', 11, NULL, '왈츠 A장조', 'Valzer no. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66ecf264-9789-4534-b9f5-c01551b8bf57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dab219dc-986d-45d5-ac33-3130f0cc72bb', 12, NULL, '왈츠 C장조', 'Valzer no. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dab219dc-986d-45d5-ac33-3130f0cc72bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87777537-c485-43eb-81dc-8c0414b02566', 13, NULL, '왈츠 A장조', 'Valzer no. 4 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87777537-c485-43eb-81dc-8c0414b02566'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2664d633-6c46-4529-b027-6546d5f22b9d', 14, NULL, '스코체제 F장조', 'Scozzese in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2664d633-6c46-4529-b027-6546d5f22b9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1b31aba-5d0b-42ae-888a-d9271c473dd4', 15, NULL, '잉글레세 C장조', 'Inglese no. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1b31aba-5d0b-42ae-888a-d9271c473dd4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6b058d3-83f0-4c02-80af-5084e14dee17', 16, NULL, '잉글레세 C장조', 'Inglese no. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6b058d3-83f0-4c02-80af-5084e14dee17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33766adb-8f41-4d07-835a-faf22189e44c', 17, NULL, '잉글레세 A장조', 'Inglese no. 3 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33766adb-8f41-4d07-835a-faf22189e44c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23bde366-b740-4aa3-9ee5-70470536fae9', 18, NULL, '잉글레세 F장조', 'Inglese no. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23bde366-b740-4aa3-9ee5-70470536fae9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f0942f7-b641-48d2-a46c-a17d0d8ed25c', 19, NULL, '잉글레세 F장조', 'Inglese no. 5 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f0942f7-b641-48d2-a46c-a17d0d8ed25c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1851894-2740-495c-b1b8-1bd2c6babf95', 20, NULL, '잉글레세 C장조', 'Inglese no. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1851894-2740-495c-b1b8-1bd2c6babf95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:paganini:paganini-ms4:21', 21, NULL, '변주곡 C장조', 'Variazioni in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:paganini:paganini-ms4:21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:237e6521-7b0c-47ad-b4e4-5d7b79fa97fd', 1, 'I', '변주 1', 'I. Var. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:paganini:paganini-ms4:21'
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:237e6521-7b0c-47ad-b4e4-5d7b79fa97fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4ff8c06-6f87-4b81-a4ff-21c9d2153526', 2, 'II', '변주 2', 'II. Var. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:paganini:paganini-ms4:21'
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4ff8c06-6f87-4b81-a4ff-21c9d2153526'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c73556d5-d070-4c76-8c8b-79155f1ff86f', 3, 'III', '변주 3', 'III. Var. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'classicmap:paganini:paganini-ms4:21'
WHERE p.composer_id = 35 AND p.title = '<사육제 디베르티멘토>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c73556d5-d070-4c76-8c8b-79155f1ff86f'
);


-- MS 5 소나타 E♭장조 "나폴레옹"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타 E♭장조 "나폴레옹"', 'Sonata "Napoleone" in E♭ major', 'song', 'MS 5', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타 E♭장조 "나폴레옹"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b0541ef-6bad-40ea-8662-43fd7d4c8ffe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b0541ef-6bad-40ea-8662-43fd7d4c8ffe'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '소나타 E♭장조 "나폴레옹"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b0541ef-6bad-40ea-8662-43fd7d4c8ffe'
);


-- MS 6 무반주 바이올린 소나타 C장조 "뒤오 메르베유"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 바이올린 소나타 C장조 "뒤오 메르베유"', 'Duo merveille (Sonata for Solo Violin) in C major', 'album', 'MS 6', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 바이올린 소나타 C장조 "뒤오 메르베유"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa145221-1638-413b-8d59-aff2fccced0d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa145221-1638-413b-8d59-aff2fccced0d'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '무반주 바이올린 소나타 C장조 "뒤오 메르베유"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa145221-1638-413b-8d59-aff2fccced0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e22ece78-bbd7-4a38-82d5-dd08d19e4c8d', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '무반주 바이올린 소나타 C장조 "뒤오 메르베유"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e22ece78-bbd7-4a38-82d5-dd08d19e4c8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9969b60-3794-4382-8bf8-e44c7f930685', 2, 'II', 'Allegro molto', 'II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '무반주 바이올린 소나타 C장조 "뒤오 메르베유"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9969b60-3794-4382-8bf8-e44c7f930685'
);


-- MS 7 바이올린과 기타를 위한 소나타 MS 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 MS 7', '3 Sonatas for Violin and Guitar, MS 7', 'album', NULL, 'MS', '7', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 MS 7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21a00fb5-b1e1-4ede-925b-81cf6bc110de'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21a00fb5-b1e1-4ede-925b-81cf6bc110de'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21a00fb5-b1e1-4ede-925b-81cf6bc110de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75103db6-10a3-408f-956b-494df49358b7', 1, NULL, 'A단조', 'No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75103db6-10a3-408f-956b-494df49358b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95717e6d-8020-4b58-87a1-491f3e89a2d6', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:75103db6-10a3-408f-956b-494df49358b7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95717e6d-8020-4b58-87a1-491f3e89a2d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e959ef7-5a6c-4344-bc24-ca8c1646b09d', 2, 'II', 'Andantino scherzando', 'II. Andantino scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:75103db6-10a3-408f-956b-494df49358b7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e959ef7-5a6c-4344-bc24-ca8c1646b09d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7748f47-c0ac-4e90-b71d-8cff979373ba', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:75103db6-10a3-408f-956b-494df49358b7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7748f47-c0ac-4e90-b71d-8cff979373ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c68e395-a625-48a8-824c-e5523b6b8a5d', 4, 'IV', 'Primo tempo', 'IV. Primo tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:75103db6-10a3-408f-956b-494df49358b7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c68e395-a625-48a8-824c-e5523b6b8a5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:186fc4ce-75b9-46ab-96fd-eef52fa886ff', 2, NULL, 'D단조', 'No. 2 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:186fc4ce-75b9-46ab-96fd-eef52fa886ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:69e3c5f6-9626-492c-a9dc-c09bac91c22d', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:186fc4ce-75b9-46ab-96fd-eef52fa886ff'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69e3c5f6-9626-492c-a9dc-c09bac91c22d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12bc7f90-5a02-4511-b68a-3572c5c537ef', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:186fc4ce-75b9-46ab-96fd-eef52fa886ff'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12bc7f90-5a02-4511-b68a-3572c5c537ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc390b12-4ad3-4d29-945b-ea142851bc5a', 3, 'III', 'Cantabile', 'III. Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:186fc4ce-75b9-46ab-96fd-eef52fa886ff'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc390b12-4ad3-4d29-945b-ea142851bc5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:10937361-28f1-40ef-9e9d-2f07a948a698', 3, NULL, 'E단조', 'No. 3 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10937361-28f1-40ef-9e9d-2f07a948a698'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09f7c4dc-45b0-4804-b060-205f56ab9bab', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10937361-28f1-40ef-9e9d-2f07a948a698'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09f7c4dc-45b0-4804-b060-205f56ab9bab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:32f47160-3c99-4d7c-af2a-fc94754d2367', 2, 'II', 'Presto', 'II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:10937361-28f1-40ef-9e9d-2f07a948a698'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32f47160-3c99-4d7c-af2a-fc94754d2367'
);


-- MS 8 <Entrata d'Adone nella reggia di Venere>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Entrata d''Adone nella reggia di Venere>', 'Entrata d''Adone nella reggia di Venere', 'song', 'MS 8', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Entrata d''Adone nella reggia di Venere>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43d38ae9-69ca-40cd-bd44-7b09d077543d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43d38ae9-69ca-40cd-bd44-7b09d077543d'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<Entrata d''Adone nella reggia di Venere>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43d38ae9-69ca-40cd-bd44-7b09d077543d'
);


-- MS 9 바이올린과 기타를 위한 소나타 MS 9

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 MS 9', '6 Sonatas for Violin and Guitar, MS 9', 'album', NULL, 'MS', '9', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 MS 9'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b71d0fa-405b-415f-8d0c-53bb76bc4a10'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b71d0fa-405b-415f-8d0c-53bb76bc4a10'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b71d0fa-405b-415f-8d0c-53bb76bc4a10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e047b53-c588-4e7b-a4e3-bd2ce1b3f6b1', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e047b53-c588-4e7b-a4e3-bd2ce1b3f6b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc4e575d-20a4-4b4c-8080-712997e03ce3', 1, 'I', 'Amoroso', 'I. Amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e047b53-c588-4e7b-a4e3-bd2ce1b3f6b1'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc4e575d-20a4-4b4c-8080-712997e03ce3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7386c65-9295-4f96-953d-0dc4264ea219', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5e047b53-c588-4e7b-a4e3-bd2ce1b3f6b1'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7386c65-9295-4f96-953d-0dc4264ea219'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78ed1fa5-a65e-4062-81dd-b6adb33e1938', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78ed1fa5-a65e-4062-81dd-b6adb33e1938'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5c640a8-d089-4bbd-bc65-f47dea7df100', 1, 'I', 'Larghetto (legato e senza cantino)', 'I. Larghetto (legato e senza cantino)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78ed1fa5-a65e-4062-81dd-b6adb33e1938'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5c640a8-d089-4bbd-bc65-f47dea7df100'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ad78ad4-ddf5-4155-acf7-48f5db33de40', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78ed1fa5-a65e-4062-81dd-b6adb33e1938'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ad78ad4-ddf5-4155-acf7-48f5db33de40'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fbd5665-b86e-41a5-b1cd-456fabfe5fa4', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fbd5665-b86e-41a5-b1cd-456fabfe5fa4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a1d3f13-9256-4530-a5ff-784f63a6a8d2', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5fbd5665-b86e-41a5-b1cd-456fabfe5fa4'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a1d3f13-9256-4530-a5ff-784f63a6a8d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:663c7306-cd16-45d0-96f8-b20a6a2df6ce', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5fbd5665-b86e-41a5-b1cd-456fabfe5fa4'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:663c7306-cd16-45d0-96f8-b20a6a2df6ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e2db59a-6825-4963-bef9-399feefbb2f8', 4, NULL, 'C장조', 'No. 4 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e2db59a-6825-4963-bef9-399feefbb2f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52b10623-0e10-4328-be42-54ddd8118598', 1, 'I', '서주', 'I. Introduzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e2db59a-6825-4963-bef9-399feefbb2f8'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52b10623-0e10-4328-be42-54ddd8118598'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b5852e3e-eddb-472f-804b-2b3d97698e17', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7e2db59a-6825-4963-bef9-399feefbb2f8'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5852e3e-eddb-472f-804b-2b3d97698e17'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dceaba25-21f3-4bef-84b7-b504cfb7ba61', 5, NULL, 'A장조', 'No. 5 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dceaba25-21f3-4bef-84b7-b504cfb7ba61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b28532cd-3f56-4666-a4eb-e59d3bca2c99', 1, 'I', 'Quasi adagio', 'I. Quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dceaba25-21f3-4bef-84b7-b504cfb7ba61'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b28532cd-3f56-4666-a4eb-e59d3bca2c99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ded85935-abcb-4975-8ba3-cf7b6e7648cb', 2, 'II', '폴로네즈. Andantino', 'II. Polonese - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dceaba25-21f3-4bef-84b7-b504cfb7ba61'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ded85935-abcb-4975-8ba3-cf7b6e7648cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f21f3fe9-721e-46c3-8922-8b6ba8805388', 6, NULL, 'E장조', 'No. 6 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f21f3fe9-721e-46c3-8922-8b6ba8805388'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a7992d2-345a-4e1d-a914-971e4db0cd8d', 1, 'I', 'Maestoso', 'I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f21f3fe9-721e-46c3-8922-8b6ba8805388'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a7992d2-345a-4e1d-a914-971e4db0cd8d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40c16d35-4bce-4d3e-8fbf-0d5f9fa258ea', 2, 'II', '왈츠', 'II. Valzer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f21f3fe9-721e-46c3-8922-8b6ba8805388'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40c16d35-4bce-4d3e-8fbf-0d5f9fa258ea'
);


-- MS 10 바이올린과 기타를 위한 소나타 MS 10

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 MS 10', '6 Sonatas for Violin and Guitar, MS 10', 'album', NULL, 'MS', '10', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 MS 10'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83201d0b-7652-4eda-aab1-63d09ead722e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '83201d0b-7652-4eda-aab1-63d09ead722e'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83201d0b-7652-4eda-aab1-63d09ead722e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87d79da0-8eef-43ab-acd5-ccccf2491d0c', 1, NULL, 'A장조', 'No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87d79da0-8eef-43ab-acd5-ccccf2491d0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4151f7b1-8497-46ca-b779-e27c0f021b02', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87d79da0-8eef-43ab-acd5-ccccf2491d0c'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4151f7b1-8497-46ca-b779-e27c0f021b02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56aa2c0e-bcfd-4320-a83d-6af563bcb2b0', 2, 'II', 'Allegretto Perigordino con due variazioni', 'II. Allegretto Perigordino con due variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:87d79da0-8eef-43ab-acd5-ccccf2491d0c'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56aa2c0e-bcfd-4320-a83d-6af563bcb2b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe6d1c0a-34e8-4fe6-8b8b-aa195673a21e', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe6d1c0a-34e8-4fe6-8b8b-aa195673a21e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:48132a15-1255-423f-98b6-5ff7e04fc9fc', 1, 'I', '서주', 'I. Introduzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe6d1c0a-34e8-4fe6-8b8b-aa195673a21e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48132a15-1255-423f-98b6-5ff7e04fc9fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:947bcf9b-4f89-411e-b273-a881fe58a557', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fe6d1c0a-34e8-4fe6-8b8b-aa195673a21e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:947bcf9b-4f89-411e-b273-a881fe58a557'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6aaf6d6-2532-4523-9b67-635adbbb3689', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6aaf6d6-2532-4523-9b67-635adbbb3689'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13a078e5-f0e9-4f4e-8062-5d16ede82edb', 1, 'I', '칸타빌레 appassionatamente', 'I. Cantabile appassionatamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6aaf6d6-2532-4523-9b67-635adbbb3689'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13a078e5-f0e9-4f4e-8062-5d16ede82edb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c5053f1-8a3f-4a11-8d80-17c59e3a8c53', 2, 'II', 'Andantino scherzando', 'II. Andantino scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6aaf6d6-2532-4523-9b67-635adbbb3689'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c5053f1-8a3f-4a11-8d80-17c59e3a8c53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5afa735-e1ed-4d1f-bac1-9056526a7bc1', 4, NULL, 'A단조', 'No. 4 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5afa735-e1ed-4d1f-bac1-9056526a7bc1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a91c757-c1c9-4da6-a23b-cc218a6d7668', 1, 'I', 'Quasi adagio amorosamente', 'I. Quasi adagio amorosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5afa735-e1ed-4d1f-bac1-9056526a7bc1'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a91c757-c1c9-4da6-a23b-cc218a6d7668'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05b39863-53da-48bb-a19d-4708ec25a3b0', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e5afa735-e1ed-4d1f-bac1-9056526a7bc1'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05b39863-53da-48bb-a19d-4708ec25a3b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1c6d525-3081-4b34-84a1-4de339389cf1', 5, NULL, 'E단조', 'No. 5 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1c6d525-3081-4b34-84a1-4de339389cf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3af1ecc2-0bd4-44d9-a9df-98f446f7a6e2', 1, 'I', '서주. Adagio assai', 'I. Introduzione - Adagio assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1c6d525-3081-4b34-84a1-4de339389cf1'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af1ecc2-0bd4-44d9-a9df-98f446f7a6e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd902f04-1062-4a99-8467-9955decd8ac4', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1c6d525-3081-4b34-84a1-4de339389cf1'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd902f04-1062-4a99-8467-9955decd8ac4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf7e6647-9f61-40c4-bbe5-8d91ef9781f4', 6, NULL, 'E단조', 'No. 6 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf7e6647-9f61-40c4-bbe5-8d91ef9781f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:edd62b12-ebb2-47df-84f1-8cdcedeb29dd', 1, 'I', 'Adagio, con sentimento', 'I. Adagio, con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cf7e6647-9f61-40c4-bbe5-8d91ef9781f4'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edd62b12-ebb2-47df-84f1-8cdcedeb29dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e34a8dd-573e-4f5c-a556-f2cc4f3f1959', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cf7e6647-9f61-40c4-bbe5-8d91ef9781f4'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e34a8dd-573e-4f5c-a556-f2cc4f3f1959'
);


-- MS 11 바이올린과 기타를 위한 소나타 MS 11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 MS 11', '6 Sonatas for Violin and Guitar, MS 11', 'album', NULL, 'MS', '11', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 MS 11'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad5991e1-e916-412b-9897-26c0f02d7eb5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad5991e1-e916-412b-9897-26c0f02d7eb5'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad5991e1-e916-412b-9897-26c0f02d7eb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d012e9d-30e4-452d-a44f-cc7681147db8', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d012e9d-30e4-452d-a44f-cc7681147db8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:40bc9585-b3a9-4170-840c-f35a42dd1a72', 1, 'I', 'Adagio amorosamente', 'I. Adagio amorosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d012e9d-30e4-452d-a44f-cc7681147db8'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40bc9585-b3a9-4170-840c-f35a42dd1a72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca39b85d-a1ae-4f44-b5cc-cc9b8a42a3ae', 2, 'II', 'Quasi allegretto', 'II. Quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d012e9d-30e4-452d-a44f-cc7681147db8'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca39b85d-a1ae-4f44-b5cc-cc9b8a42a3ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4509cfe3-dae6-4da2-9018-57228b833df7', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4509cfe3-dae6-4da2-9018-57228b833df7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8156281-b648-43b7-a886-bcd18280d3d8', 1, 'I', 'Adagio espressivo', 'I. Adagio espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4509cfe3-dae6-4da2-9018-57228b833df7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8156281-b648-43b7-a886-bcd18280d3d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25bc969b-dacf-4cec-8bbd-37aa19eb9696', 2, 'II', 'Andantino innocentemente', 'II. Andantino innocentemente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4509cfe3-dae6-4da2-9018-57228b833df7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25bc969b-dacf-4cec-8bbd-37aa19eb9696'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f4bb7db-a8a5-49f8-8fe3-efbc46e6732f', 3, NULL, 'A단조', 'No. 3 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f4bb7db-a8a5-49f8-8fe3-efbc46e6732f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2086d26d-c478-49e6-a0bb-7914aa093372', 1, 'I', 'Adagio con zelo', 'I. Adagio con zelo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6f4bb7db-a8a5-49f8-8fe3-efbc46e6732f'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2086d26d-c478-49e6-a0bb-7914aa093372'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3435e022-3b0a-495b-867a-286ebd3b99bd', 2, 'II', 'Allegretto con moto', 'II. Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6f4bb7db-a8a5-49f8-8fe3-efbc46e6732f'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3435e022-3b0a-495b-867a-286ebd3b99bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b86ff4e2-7e8c-484d-b8e6-d55aafc8444e', 4, NULL, 'C장조', 'No. 4 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b86ff4e2-7e8c-484d-b8e6-d55aafc8444e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29510f0f-efa3-43f2-b5eb-35aa32b99ae8', 1, 'I', 'Adagio con grazia e trasporto', 'I. Adagio con grazia e trasporto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b86ff4e2-7e8c-484d-b8e6-d55aafc8444e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29510f0f-efa3-43f2-b5eb-35aa32b99ae8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b85eb31-8831-4d7c-bf34-de23ff30e105', 2, 'II', 'Andantino scherzando', 'II. Andantino scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b86ff4e2-7e8c-484d-b8e6-d55aafc8444e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b85eb31-8831-4d7c-bf34-de23ff30e105'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6a906be-e65c-4969-a4a2-4a1c7d490552', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6a906be-e65c-4969-a4a2-4a1c7d490552'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:521a7a3a-33f6-4b5f-8b2e-178b9caa7325', 1, 'I', 'Adagio con sentimento', 'I. Adagio con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e6a906be-e65c-4969-a4a2-4a1c7d490552'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:521a7a3a-33f6-4b5f-8b2e-178b9caa7325'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73dd0d4c-e7f1-41c3-aa2b-da07250a3335', 2, 'II', '론도 alla Turca. Andantemente', 'II. Rondò alla Turca - Andantemente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e6a906be-e65c-4969-a4a2-4a1c7d490552'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73dd0d4c-e7f1-41c3-aa2b-da07250a3335'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47408b37-98b8-42d4-8ad4-3e0b5637a026', 6, NULL, 'A단조', 'No. 6 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47408b37-98b8-42d4-8ad4-3e0b5637a026'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b245e48-f57f-4297-b7f6-0bfcf6495574', 1, 'I', 'Adagio appassionatissimamente', 'I. Adagio appassionatissimamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:47408b37-98b8-42d4-8ad4-3e0b5637a026'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b245e48-f57f-4297-b7f6-0bfcf6495574'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31e36276-f723-410e-a69c-8f0a1c0bada2', 2, 'II', 'Allegretto con piacere', 'II. Allegretto con piacere', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:47408b37-98b8-42d4-8ad4-3e0b5637a026'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31e36276-f723-410e-a69c-8f0a1c0bada2'
);


-- MS 12 바이올린과 기타를 위한 소나타 MS 12

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 MS 12', '6 Sonatas for Violin and Guitar, MS 12', 'album', NULL, 'MS', '12', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 MS 12'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '436dd14c-fde9-4c85-9e33-d6fad24e4da6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '436dd14c-fde9-4c85-9e33-d6fad24e4da6'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '436dd14c-fde9-4c85-9e33-d6fad24e4da6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8412c93c-552b-4e42-8a9b-db4f55b73297', 1, NULL, 'E단조', 'No. 1 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8412c93c-552b-4e42-8a9b-db4f55b73297'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2cb791e1-1f7c-41dd-972b-3d1ec3118af5', 1, 'I', 'Adagio con passione', 'I. Adagio con passione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8412c93c-552b-4e42-8a9b-db4f55b73297'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cb791e1-1f7c-41dd-972b-3d1ec3118af5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb1d2015-d427-4b1f-8646-28b3a6ab24d3', 2, 'II', 'Andante smorfiosamente', 'II. Andante smorfiosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8412c93c-552b-4e42-8a9b-db4f55b73297'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb1d2015-d427-4b1f-8646-28b3a6ab24d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0099d3c-07bf-4fe6-8fc7-747cf2698ef9', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0099d3c-07bf-4fe6-8fc7-747cf2698ef9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:349e7910-fd17-4c51-9b59-b9e27e6e999a', 1, 'I', 'Adagio con amore', 'I. Adagio con amore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0099d3c-07bf-4fe6-8fc7-747cf2698ef9'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:349e7910-fd17-4c51-9b59-b9e27e6e999a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9904a887-f89b-4043-801e-3b0fc9e48d79', 2, 'II', 'Andante con semplizità', 'II. Andante con semplizità', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e0099d3c-07bf-4fe6-8fc7-747cf2698ef9'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9904a887-f89b-4043-801e-3b0fc9e48d79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04e96199-d941-4f44-aa7b-347f9f7de091', 3, NULL, 'A단조', 'No. 3 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04e96199-d941-4f44-aa7b-347f9f7de091'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b5ff489-57f1-42d7-8020-50d2638c2709', 1, 'I', 'Adagio con anima', 'I. Adagio con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:04e96199-d941-4f44-aa7b-347f9f7de091'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b5ff489-57f1-42d7-8020-50d2638c2709'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f10edb33-0185-4ba0-b322-dfb87e764690', 2, 'II', 'Andantino galante', 'II. Andantino galante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:04e96199-d941-4f44-aa7b-347f9f7de091'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f10edb33-0185-4ba0-b322-dfb87e764690'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b60bfb44-dd66-455c-bd0b-23fad27ba30e', 4, NULL, 'D단조', 'No. 4 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60bfb44-dd66-455c-bd0b-23fad27ba30e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a594ac5-38aa-484d-a692-e93f5e353005', 1, 'I', 'Adagio con sentimento', 'I. Adagio con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b60bfb44-dd66-455c-bd0b-23fad27ba30e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a594ac5-38aa-484d-a692-e93f5e353005'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43af7ed9-5672-400e-a3c0-74e1b0e32f31', 2, 'II', '코렌테 con motteggio', 'II. Corrente con motteggio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b60bfb44-dd66-455c-bd0b-23fad27ba30e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43af7ed9-5672-400e-a3c0-74e1b0e32f31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea4ad756-ed24-4c05-bf61-fd1fd25a33ad', 5, NULL, 'A장조', 'No. 5 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea4ad756-ed24-4c05-bf61-fd1fd25a33ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f5986fbc-ff6a-41f2-8cc7-ea79757af44b', 1, 'I', 'Adagio con grazia', 'I. Adagio con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea4ad756-ed24-4c05-bf61-fd1fd25a33ad'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5986fbc-ff6a-41f2-8cc7-ea79757af44b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bdaa4277-1cab-49c0-9d85-3845ed9e4247', 2, 'II', 'Allegro con brio', 'II. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea4ad756-ed24-4c05-bf61-fd1fd25a33ad'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdaa4277-1cab-49c0-9d85-3845ed9e4247'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cd834ce-8694-4b88-bc0a-721f2e70294e', 6, NULL, 'G장조', 'No. 6 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cd834ce-8694-4b88-bc0a-721f2e70294e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:004e672c-ce37-46dd-bcc1-1b53a214a1d0', 1, 'I', 'Adagio con trasporto', 'I. Adagio con trasporto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8cd834ce-8694-4b88-bc0a-721f2e70294e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:004e672c-ce37-46dd-bcc1-1b53a214a1d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f33fa48-e609-4f4b-b7f3-d9931b7bad42', 2, 'II', 'Pollonese brillante', 'II. Pollonese brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8cd834ce-8694-4b88-bc0a-721f2e70294e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f33fa48-e609-4f4b-b7f3-d9931b7bad42'
);


-- MS 13 바이올린과 기타를 위한 소나타 MS 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 MS 13', '6 Sonatas for Violin and Guitar, MS 13', 'album', NULL, 'MS', '13', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 MS 13'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e924289b-4678-4e4a-9cc9-b521019df5a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e924289b-4678-4e4a-9cc9-b521019df5a2'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e924289b-4678-4e4a-9cc9-b521019df5a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b61953b8-81df-46ba-9643-b17e281de545', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61953b8-81df-46ba-9643-b17e281de545'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:718d6d70-32d6-41e3-9c49-4ff3e49f8d0b', 1, 'I', 'Adagio seducentemente', 'I. Adagio seducentemente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61953b8-81df-46ba-9643-b17e281de545'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:718d6d70-32d6-41e3-9c49-4ff3e49f8d0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d19d3446-78da-4190-99d7-9e03ba2ca00b', 2, 'II', 'Andantino con grazia', 'II. Andantino con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b61953b8-81df-46ba-9643-b17e281de545'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d19d3446-78da-4190-99d7-9e03ba2ca00b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57189540-a44a-4984-b5ed-644094781bb4', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57189540-a44a-4984-b5ed-644094781bb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:247a6908-9a3b-4023-8b60-371b92460ad9', 1, 'I', 'Adagio maestoso', 'I. Adagio maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:57189540-a44a-4984-b5ed-644094781bb4'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:247a6908-9a3b-4023-8b60-371b92460ad9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53302042-ee02-40e3-a810-c309c56140ec', 2, 'II', 'Allegretto con energia', 'II. Allegretto con energia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:57189540-a44a-4984-b5ed-644094781bb4'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53302042-ee02-40e3-a810-c309c56140ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ad65e58-005c-4596-b470-dea0f8867939', 3, NULL, 'A단조', 'No. 3 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ad65e58-005c-4596-b470-dea0f8867939'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bf9e110f-6dfc-485d-a408-78b50962e9d5', 1, 'I', 'Adagio con espressione', 'I. Adagio con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ad65e58-005c-4596-b470-dea0f8867939'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf9e110f-6dfc-485d-a408-78b50962e9d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f65e9656-3753-417e-b8e6-82065270b4fd', 2, 'II', '론도 alla napoletana. Andante', 'II. Rondò alla napoletana - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ad65e58-005c-4596-b470-dea0f8867939'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f65e9656-3753-417e-b8e6-82065270b4fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b920948-29f0-43fc-862b-ea9fb71e7f64', 4, NULL, 'F장조', 'No. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b920948-29f0-43fc-862b-ea9fb71e7f64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:72e44b4e-edbf-451d-97be-a73ff5eba9bf', 1, 'I', 'Adagio amorosamente', 'I. Adagio amorosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4b920948-29f0-43fc-862b-ea9fb71e7f64'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72e44b4e-edbf-451d-97be-a73ff5eba9bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7fcbed43-6cd8-49ef-a699-1004f00f2aa6', 2, 'II', 'Allegro con gentilezza', 'II. Allegro con gentilezza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4b920948-29f0-43fc-862b-ea9fb71e7f64'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fcbed43-6cd8-49ef-a699-1004f00f2aa6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fea9f84-3a98-4ded-8f8a-b8a0070dd52c', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fea9f84-3a98-4ded-8f8a-b8a0070dd52c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f621b4c0-2886-4e63-9677-7972c68a645a', 1, 'I', 'Adagio con trasporto', 'I. Adagio con trasporto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fea9f84-3a98-4ded-8f8a-b8a0070dd52c'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f621b4c0-2886-4e63-9677-7972c68a645a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f42f1c36-9b1b-4bc9-a524-5c31cd5e7101', 2, 'II', '론도. Andante alla Frassinet', 'II. Rondò Andante alla Frassinet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fea9f84-3a98-4ded-8f8a-b8a0070dd52c'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f42f1c36-9b1b-4bc9-a524-5c31cd5e7101'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f0a0ddd-a72f-4138-a525-57d46a204445', 6, NULL, 'E장조', 'No. 6 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f0a0ddd-a72f-4138-a525-57d46a204445'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e050df4-ea55-415d-855c-339bbe38a42b', 1, 'I', 'Adagio con afflizione', 'I. Adagio con afflizione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f0a0ddd-a72f-4138-a525-57d46a204445'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e050df4-ea55-415d-855c-339bbe38a42b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe429711-c9c2-4272-8075-5d4c15137847', 2, 'II', '왈츠 galante', 'II. Valtz galante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f0a0ddd-a72f-4138-a525-57d46a204445'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe429711-c9c2-4272-8075-5d4c15137847'
);


-- MS 14 세레나타 E단조 "로베네를 위한"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나타 E단조 "로베네를 위한"', 'Serenata per Rovene in E minor', 'album', 'MS 14', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나타 E단조 "로베네를 위한"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aeaa4eba-a3e1-4f4d-99f1-2c47f5be2599'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aeaa4eba-a3e1-4f4d-99f1-2c47f5be2599'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 E단조 "로베네를 위한"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aeaa4eba-a3e1-4f4d-99f1-2c47f5be2599'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bbf53667-aed2-4d87-8276-83c2f3ed9db8', 1, 'I', '아리에타. Introduzione - Largo', 'I. Arietta - Introduzione - Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 E단조 "로베네를 위한"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbf53667-aed2-4d87-8276-83c2f3ed9db8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a36ab595-b28c-43eb-aa14-2f289538150c', 2, 'II', 'Andante sostenuto', 'II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 E단조 "로베네를 위한"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a36ab595-b28c-43eb-aa14-2f289538150c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ee1e97b-0875-4df6-b7c9-9125763e5f8c', 3, 'III', 'Andantino brillante', 'III. Andantino brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 E단조 "로베네를 위한"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ee1e97b-0875-4df6-b7c9-9125763e5f8c'
);


-- MS 15 <4개의 4중주 녹턴>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<4개의 4중주 녹턴>', '4 Notturni a quartetto', 'album', 'MS 15', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<4개의 4중주 녹턴>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b29d133-83f2-458d-974d-4025794b8f49'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b29d133-83f2-458d-974d-4025794b8f49'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b29d133-83f2-458d-974d-4025794b8f49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f7eb5fc-7212-46f8-9917-45fa6d667f6e', 1, NULL, 'E장조', 'No. 1 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f7eb5fc-7212-46f8-9917-45fa6d667f6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9ee47d3f-401d-45d0-a08c-c27fb023f1f0', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6f7eb5fc-7212-46f8-9917-45fa6d667f6e'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ee47d3f-401d-45d0-a08c-c27fb023f1f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a2de93ad-94e9-4ed8-9461-b03acae84b99', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6f7eb5fc-7212-46f8-9917-45fa6d667f6e'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2de93ad-94e9-4ed8-9461-b03acae84b99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff40de16-bb1f-4dc7-882f-85000f968416', 2, NULL, 'D단조', 'No. 2 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff40de16-bb1f-4dc7-882f-85000f968416'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1891546f-0cfa-4aba-9a9c-0242565d580c', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff40de16-bb1f-4dc7-882f-85000f968416'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1891546f-0cfa-4aba-9a9c-0242565d580c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8b88a1c-3e61-4503-846e-cab708374c24', 2, 'II', '폴로네즈. Andante', 'II. Polonese - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff40de16-bb1f-4dc7-882f-85000f968416'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b88a1c-3e61-4503-846e-cab708374c24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d042a15e-5c53-421d-b725-020cfe25e760', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d042a15e-5c53-421d-b725-020cfe25e760'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1e39092-ca25-4c11-bfd2-f2df2ea7087f', 1, 'I', '칸타빌레. Andante', 'I. Cantabile - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d042a15e-5c53-421d-b725-020cfe25e760'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1e39092-ca25-4c11-bfd2-f2df2ea7087f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db167dcf-6a68-4064-a258-4f7cb844ce7f', 2, 'II', 'Andantino - Tempo di Valzer', 'II. Andantino - Tempo di Valzer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d042a15e-5c53-421d-b725-020cfe25e760'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db167dcf-6a68-4064-a258-4f7cb844ce7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee47ed99-7cbf-4903-b022-5e33561e5763', 4, NULL, 'E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee47ed99-7cbf-4903-b022-5e33561e5763'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b6a6abf-421f-4fc2-8947-4d5f1abb1102', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee47ed99-7cbf-4903-b022-5e33561e5763'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b6a6abf-421f-4fc2-8947-4d5f1abb1102'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7d18098-b056-465a-8daf-354f131de09e', 2, 'II', 'Andante sostenuto', 'II. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee47ed99-7cbf-4903-b022-5e33561e5763'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7d18098-b056-465a-8daf-354f131de09e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:843c456a-6d95-473a-8c32-ad6ee6b92e73', 3, 'III', 'Andante brillante', 'III. Andante brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee47ed99-7cbf-4903-b022-5e33561e5763'
WHERE p.composer_id = 35 AND p.title = '<4개의 4중주 녹턴>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:843c456a-6d95-473a-8c32-ad6ee6b92e73'
);


-- MS 16 세레나타 G장조 (만돌린과 기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나타 G장조 (만돌린과 기타)', 'Serenata in G major for Mandolin and Guitar', 'album', 'MS 16', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나타 G장조 (만돌린과 기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4165e8fa-da83-421c-a094-ceb9554cb2bb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4165e8fa-da83-421c-a094-ceb9554cb2bb'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 G장조 (만돌린과 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4165e8fa-da83-421c-a094-ceb9554cb2bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ae4fa9e-7893-4d7f-8379-e578c36ef046', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 G장조 (만돌린과 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ae4fa9e-7893-4d7f-8379-e578c36ef046'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e2cd1aa-425c-44e7-86a3-db53e2ebae61', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 G장조 (만돌린과 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e2cd1aa-425c-44e7-86a3-db53e2ebae61'
);


-- MS 17 세레나타 C장조 (비올라, 첼로, 기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나타 C장조 (비올라, 첼로, 기타)', 'Serenata in C major for Viola, Cello and Guitar', 'album', 'MS 17', NULL, NULL, 1808, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나타 C장조 (비올라, 첼로, 기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55641448-0aaf-4ac4-8410-a79b2412a2a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55641448-0aaf-4ac4-8410-a79b2412a2a6'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 C장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55641448-0aaf-4ac4-8410-a79b2412a2a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36f7ce5e-b4c9-4171-928d-a1633f304e8c', 1, 'I', 'Allegro spiritoso', 'I. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 C장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36f7ce5e-b4c9-4171-928d-a1633f304e8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13f5c7b9-8777-454b-8774-68ce3995abe6', 2, 'II', '미뉴에트. Andantino, amorosamente', 'II. Minuetto - Andantino, amorosamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 C장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13f5c7b9-8777-454b-8774-68ce3995abe6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c37d639-0381-45a1-ab93-560393ae893d', 3, 'III', 'Adagio non tanto - Unione e con anima', 'III. Adagio non tanto - Unione e con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 C장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c37d639-0381-45a1-ab93-560393ae893d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:860072a3-d788-4a0c-b4cb-2d0a7d45e86b', 4, 'IV', '론도. Con maestria e grazia, Canzonetta genovese', 'IV. Rondò - Con maestria e grazia, Canzonetta genovese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 C장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:860072a3-d788-4a0c-b4cb-2d0a7d45e86b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f1638a5-7e17-42af-9ee6-29d539784ab8', 5, 'V', '3중주풍 폴로네즈. Andantino', 'V. Polacca al Terzetto, Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 C장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1638a5-7e17-42af-9ee6-29d539784ab8'
);


-- MS 18 폴로네즈와 변주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈와 변주곡 A장조', 'Polacca con variazioni in A major', 'song', 'MS 18', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈와 변주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c8ee359-18a5-4774-85a0-762ea1ab1fb3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4c8ee359-18a5-4774-85a0-762ea1ab1fb3'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '폴로네즈와 변주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4c8ee359-18a5-4774-85a0-762ea1ab1fb3'
);


-- MS 20 현악 4중주 MS 20

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 MS 20', '3 String Quartets, MS 20', 'album', NULL, 'MS', '20', 1815, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 MS 20'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c16dfe96-eb98-4bfe-af4e-81a086721d9e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c16dfe96-eb98-4bfe-af4e-81a086721d9e'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c16dfe96-eb98-4bfe-af4e-81a086721d9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15366615-5a93-49fe-acab-0bb41b446f0c', 1, NULL, '현악 4중주 1번 D단조', 'Quartet No. 1 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15366615-5a93-49fe-acab-0bb41b446f0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d35099fb-9c4c-4d95-9e6a-6be9a3e56464', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15366615-5a93-49fe-acab-0bb41b446f0c'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d35099fb-9c4c-4d95-9e6a-6be9a3e56464'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88b23f03-f428-4a73-b973-540b590227fd', 2, 'II', '미뉴에트. Allegretto - Trio', 'II. Minuetto. Allegretto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15366615-5a93-49fe-acab-0bb41b446f0c'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88b23f03-f428-4a73-b973-540b590227fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f6e06b9e-829b-4727-b828-2590c13f5a68', 3, 'III', 'Adagio - Con Anima', 'III. Adagio - Con Anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15366615-5a93-49fe-acab-0bb41b446f0c'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6e06b9e-829b-4727-b828-2590c13f5a68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f60609e5-d8fe-474c-9ddf-3bba27c113a8', 4, 'IV', '론도. Allegretto con brio', 'IV. Rondeau - Allegretto con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15366615-5a93-49fe-acab-0bb41b446f0c'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f60609e5-d8fe-474c-9ddf-3bba27c113a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a80bedb-25e0-4354-90c3-40cb6a264690', 2, NULL, '현악 4중주 2번 E♭장조', 'Quartet No. 2 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a80bedb-25e0-4354-90c3-40cb6a264690'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b37fe79-ec66-4f3d-b2a2-38bd16f7b10f', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a80bedb-25e0-4354-90c3-40cb6a264690'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b37fe79-ec66-4f3d-b2a2-38bd16f7b10f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9883a15-f495-4ee7-a099-4c5c8add15e6', 2, 'II', '미뉴에트. Allegretto - Trio', 'II. Minuetto. Allegretto - Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a80bedb-25e0-4354-90c3-40cb6a264690'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9883a15-f495-4ee7-a099-4c5c8add15e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:23ca46b0-5df3-49e4-ad07-e47c6558d75e', 3, 'III', 'Adagio - Con trasporto', 'III. Adagio - Con trasporto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a80bedb-25e0-4354-90c3-40cb6a264690'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23ca46b0-5df3-49e4-ad07-e47c6558d75e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d60d9a9-16c6-4e79-985f-4820cc3a2c46', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0a80bedb-25e0-4354-90c3-40cb6a264690'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d60d9a9-16c6-4e79-985f-4820cc3a2c46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21a944f0-b4b0-49d4-bf38-5f8aa2e53a3f', 3, NULL, '현악 4중주 3번 A단조', 'Quartet No. 3 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21a944f0-b4b0-49d4-bf38-5f8aa2e53a3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e0f9879-3536-4cd0-9488-d5ae2045a109', 1, 'I', 'Largo – Allegro', 'I. Largo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21a944f0-b4b0-49d4-bf38-5f8aa2e53a3f'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e0f9879-3536-4cd0-9488-d5ae2045a109'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1aa8f28a-c377-43ea-a9c5-c7185a235baf', 2, 'II', '미뉴에트. Andantino – Trio', 'II. Minuetto. Andantino – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21a944f0-b4b0-49d4-bf38-5f8aa2e53a3f'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aa8f28a-c377-43ea-a9c5-c7185a235baf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a159e10f-61b1-450b-a555-8d113df464bf', 3, 'III', 'Andante con Variazioni', 'III. Andante con Variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21a944f0-b4b0-49d4-bf38-5f8aa2e53a3f'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a159e10f-61b1-450b-a555-8d113df464bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:928b05ce-835d-4d6f-aa1e-91ea48f95f76', 4, 'IV', '피날레. Presto', 'IV. Finale - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:21a944f0-b4b0-49d4-bf38-5f8aa2e53a3f'
WHERE p.composer_id = 35 AND p.title = '현악 4중주 MS 20' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:928b05ce-835d-4d6f-aa1e-91ea48f95f76'
);


-- MS 23 <모세> 환상곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<모세> 환상곡', 'Sonata "a Preghiera" (Moses Fantasy)', 'song', 'MS 23', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<모세> 환상곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fddc174d-87d8-3d94-9c86-859a07e71935'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fddc174d-87d8-3d94-9c86-859a07e71935'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<모세> 환상곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fddc174d-87d8-3d94-9c86-859a07e71935'
);


-- MS 34 기타 4중주 7번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 7번 E장조', 'Quartet for Violin, Viola, Guitar and Cello No. 7 in E major', 'album', 'MS 34', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 7번 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72335946-8f5c-4620-92b3-7d8b3b966d95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72335946-8f5c-4620-92b3-7d8b3b966d95'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 7번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72335946-8f5c-4620-92b3-7d8b3b966d95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:751d81fc-9297-3fe2-a8ba-b1e21bd45791', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 7번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:751d81fc-9297-3fe2-a8ba-b1e21bd45791'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53d7d795-f060-3003-9639-335e5c09e445', 2, 'II', '미뉴에트. Allegretto', 'II. Minuetto - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 7번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53d7d795-f060-3003-9639-335e5c09e445'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84a3faf3-e11f-39b3-a5eb-a4499bbf926f', 3, 'III', 'Adagio cantabile - Sostenuto con passione', 'III. Adagio cantabile - Sostenuto con passione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 7번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84a3faf3-e11f-39b3-a5eb-a4499bbf926f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac9c15ce-fbe3-3305-b3a3-cf856296598f', 4, 'IV', '론도 vivace', 'IV. Rondò vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 7번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac9c15ce-fbe3-3305-b3a3-cf856296598f'
);


-- MS 35 기타 4중주 8번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 8번 A장조', 'Quartet for Violin, Viola, Guitar and Cello No. 8 in A major', 'album', 'MS 35', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 8번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19c1f9b4-3b5a-4e4b-bae9-4007edc33ceb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19c1f9b4-3b5a-4e4b-bae9-4007edc33ceb'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 8번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19c1f9b4-3b5a-4e4b-bae9-4007edc33ceb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71b5e6e9-ae79-458f-9ef9-325ddba97b42', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 8번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71b5e6e9-ae79-458f-9ef9-325ddba97b42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43270e87-3a3c-4490-b953-5c725f9783e6', 2, 'II', '미뉴에트. Andantino', 'II. Minuetto - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 8번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43270e87-3a3c-4490-b953-5c725f9783e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b60fe45b-a303-48dc-8dcd-d0ad867fc48e', 3, 'III', '칸타빌레 molto adagio', 'III. Cantabile molto adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 8번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b60fe45b-a303-48dc-8dcd-d0ad867fc48e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:071f14b4-cda4-41af-a37d-93edb498e97c', 4, 'IV', '론도. Allegretto', 'IV. Rondò - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 8번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:071f14b4-cda4-41af-a37d-93edb498e97c'
);


-- MS 36 기타 4중주 9번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 9번 D장조', 'Quartet for Violin, Viola, Guitar and Cello No. 9 in D major', 'album', 'MS 36', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 9번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eddc88b3-3ac9-4523-bb9f-de9d4028d6bf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eddc88b3-3ac9-4523-bb9f-de9d4028d6bf'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 9번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eddc88b3-3ac9-4523-bb9f-de9d4028d6bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:382cb61a-0af5-3cbd-9d46-a8afae80e8d1', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 9번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:382cb61a-0af5-3cbd-9d46-a8afae80e8d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ba55940-c616-3f2a-8cc5-f740e2e38ff2', 2, 'II', '미뉴에트. Alla Valtz - Allegretto mosso', 'II. Minuetto, Alla Valtz - Allegretto mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 9번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ba55940-c616-3f2a-8cc5-f740e2e38ff2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea42c9a2-b8ad-3d30-b60d-b8e54d0843fe', 3, 'III', 'Adagio - Sostenuto, appassionatamente', 'III. Adagio - Sostenuto, appassionatamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 9번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea42c9a2-b8ad-3d30-b60d-b8e54d0843fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:515e08ce-d658-33f4-84bd-7895d5acf54a', 4, 'IV', '피날레. Allegro vivace', 'IV. Finale - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 9번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:515e08ce-d658-33f4-84bd-7895d5acf54a'
);


-- MS 37 기타 4중주 10번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 10번 A장조', 'Quartet for Violin, Viola, Guitar and Cello No. 10 in A major', 'album', 'MS 37', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 10번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1f19ba8-af9f-422f-89c7-51ae018e6966'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1f19ba8-af9f-422f-89c7-51ae018e6966'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 10번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1f19ba8-af9f-422f-89c7-51ae018e6966'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45fc7745-aa7d-3f58-9f3e-5ca392b50727', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 10번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45fc7745-aa7d-3f58-9f3e-5ca392b50727'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b39ecd4-6bda-318b-9454-9d1c8929cf8b', 2, 'II', '미뉴에트 스케르초. Allegretto [mosso]', 'II. Minuetto Scherzo - Allegretto [mosso]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 10번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b39ecd4-6bda-318b-9454-9d1c8929cf8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:945ad1ac-e267-3b92-bc78-29ae217008c2', 3, 'III', 'Adagio cantabile', 'III. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 10번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:945ad1ac-e267-3b92-bc78-29ae217008c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2735fcc8-ae7d-31d4-a28d-05c1c03be7af', 4, 'IV', '론도. Andantino con brio', 'IV. Rondò - Andantino con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 10번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2735fcc8-ae7d-31d4-a28d-05c1c03be7af'
);


-- MS 38 기타 4중주 11번 B장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 11번 B장조', 'Quartet for Violin, Viola, Guitar and Cello No. 11 in B major', 'album', 'MS 38', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 11번 B장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e5cfaa5-e0a3-4f57-939f-736371b0e850'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7e5cfaa5-e0a3-4f57-939f-736371b0e850'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 11번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e5cfaa5-e0a3-4f57-939f-736371b0e850'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79303813-4115-3edf-9f61-3a5da889f29e', 1, 'I', 'Allegretto moderato', 'I. Allegretto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 11번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79303813-4115-3edf-9f61-3a5da889f29e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:95372ec1-65e7-36af-beb1-2dc249bf15c2', 2, 'II', '미뉴에트. Allegretto', 'II. Minuetto - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 11번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95372ec1-65e7-36af-beb1-2dc249bf15c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3523fd42-770f-34ec-a2a4-c05ce3c1684e', 3, 'III', 'Larghetto, con passione', 'III. Larghetto, con passione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 11번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3523fd42-770f-34ec-a2a4-c05ce3c1684e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b45c51c-6f6c-31f6-ab33-660bec8df468', 4, 'IV', '폴로네즈. Andantino', 'IV. Polacca - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 11번 B장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b45c51c-6f6c-31f6-ab33-660bec8df468'
);


-- MS 39 기타 4중주 12번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 12번 A단조', 'Quartet for Violin, Viola, Guitar and Cello No. 12 in A minor', 'album', 'MS 39', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 12번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c28c984e-441c-40d7-b3e7-66816cf8f2b6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c28c984e-441c-40d7-b3e7-66816cf8f2b6'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 12번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c28c984e-441c-40d7-b3e7-66816cf8f2b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db9bc6f5-2aca-3864-8c2a-2e00e0743a6a', 1, 'I', 'Allegro giusto', 'I. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 12번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db9bc6f5-2aca-3864-8c2a-2e00e0743a6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de3e1234-2190-363d-972d-e1a71465e8a2', 2, 'II', 'Adagio tenuto - Con precisione', 'II. Adagio tenuto - Con precisione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 12번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de3e1234-2190-363d-972d-e1a71465e8a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c79e8281-3d30-35e8-b066-faf87d3bfcaf', 3, 'III', '미뉴에트. Allegretto mosso', 'III. Minuetto - Allegretto mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 12번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c79e8281-3d30-35e8-b066-faf87d3bfcaf'
);


-- MS 40 기타 4중주 13번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 13번 F장조', 'Quartet for Violin, Viola, Guitar and Cello No. 13 in F major', 'album', 'MS 40', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 13번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd2ecd61-8644-459c-82b1-044e6d4f94e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fd2ecd61-8644-459c-82b1-044e6d4f94e1'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 13번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fd2ecd61-8644-459c-82b1-044e6d4f94e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a8cbf64-805a-3e0f-bfcf-bb035e3d09c6', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 13번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a8cbf64-805a-3e0f-bfcf-bb035e3d09c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4dc1ce4-f6d1-37cc-b95d-56b433dc5611', 2, 'II', '미뉴에트. Allegretto', 'II. Minuetto - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 13번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4dc1ce4-f6d1-37cc-b95d-56b433dc5611'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf1760a0-da09-3337-a883-047ec81f82fd', 3, 'III', 'Larghetto, tenuto con anima', 'III. Larghetto, tenuto con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 13번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf1760a0-da09-3337-a883-047ec81f82fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a2b2a1b-bd0c-31f6-8f56-f3d7ff537b60', 4, 'IV', '피날레. Prestissimo', 'IV. Finale - Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 13번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a2b2a1b-bd0c-31f6-8f56-f3d7ff537b60'
);


-- MS 41 기타 4중주 14번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 14번 A장조', 'Quartet for Violin, Viola, Guitar and Cello No. 14 in A major', 'album', 'MS 41', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 14번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3f0fecd-7a9f-4c27-9946-543672b4e48b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a3f0fecd-7a9f-4c27-9946-543672b4e48b'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3f0fecd-7a9f-4c27-9946-543672b4e48b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f07405a9-f518-3f32-ad88-8903e08cb708', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f07405a9-f518-3f32-ad88-8903e08cb708'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b914e5cb-cf7f-3d70-95f2-1e424bed3b64', 2, 'II', '미뉴에트 스케르초. Allegretto', 'II. Minuetto Scherzo - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b914e5cb-cf7f-3d70-95f2-1e424bed3b64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e733518-1e1a-303f-b5e2-aad37a92edc8', 3, 'III', 'Largo con sentimento', 'III. Largo con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e733518-1e1a-303f-b5e2-aad37a92edc8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96d8dfa4-8558-3fd2-960c-a72b80ccc615', 4, 'IV', '피날레. Allegro vivace', 'IV. Finale - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 14번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96d8dfa4-8558-3fd2-960c-a72b80ccc615'
);


-- MS 42 기타 4중주 15번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 4중주 15번 A단조', 'Quartet for Violin, Viola, Guitar and Cello No. 15 in A minor', 'album', 'MS 42', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 4중주 15번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f49d449e-5241-4c8c-a5f8-1173d363b706'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f49d449e-5241-4c8c-a5f8-1173d363b706'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f49d449e-5241-4c8c-a5f8-1173d363b706'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5232ba84-1f9e-42b4-ac2b-b3c48a5f47c1', 1, 'I', 'Maestoso', 'I. Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5232ba84-1f9e-42b4-ac2b-b3c48a5f47c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68196f5c-8193-42b1-84bd-000d800fefb2', 2, 'II', '카논풍 미뉴에트. Andantino', 'II. Minuetto a canone - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68196f5c-8193-42b1-84bd-000d800fefb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd7a1fc2-947a-4074-b83c-22e244f6639d', 3, 'III', '레치타티보. Andante sostenuto, con sentimento', 'III. Recitativo - Andante sostenuto, con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd7a1fc2-947a-4074-b83c-22e244f6639d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03a17b7b-2a56-4a9e-9a3d-bdbc77c803d1', 4, 'IV', 'Adagio cantabile', 'IV. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a17b7b-2a56-4a9e-9a3d-bdbc77c803d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0e9bbac-136f-42b9-aba6-c5414068edc7', 5, 'V', '론도. Allegretto', 'V. Rondò - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0e9bbac-136f-42b9-aba6-c5414068edc7'
);


-- MS 43 <기리비치>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<기리비치>', '43 Ghiribizzi', 'album', 'MS 43', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<기리비치>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e272636-5850-4afb-84a0-b5ed1e7a5a26'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7e272636-5850-4afb-84a0-b5ed1e7a5a26'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7e272636-5850-4afb-84a0-b5ed1e7a5a26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ec4ca6c-cde2-4969-8547-1307981b1256', 1, NULL, 'Allegretto A장조', 'No. 1 Allegretto in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ec4ca6c-cde2-4969-8547-1307981b1256'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63113afd-b2e0-46ed-bf72-52d7dce68499', 2, NULL, 'Andantino C장조', 'No. 2 Andantino in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63113afd-b2e0-46ed-bf72-52d7dce68499'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a500ffc4-f3a7-45c3-808e-2b58039a543b', 3, NULL, '왈츠 C장조', 'No. 3 Valtz in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a500ffc4-f3a7-45c3-808e-2b58039a543b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20c1dc5f-0403-41ec-878c-ce7925fe64a2', 4, NULL, 'Allegretto A장조', 'No. 4 Allegretto in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20c1dc5f-0403-41ec-878c-ce7925fe64a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d75151d5-b214-441c-a670-bb9c6cc96df2', 5, NULL, 'Moderato D장조', 'No. 5 Moderato in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d75151d5-b214-441c-a670-bb9c6cc96df2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0afe3e34-09e7-4742-ba2b-e006043175fd', 6, NULL, 'Andantino G장조', 'No. 6 Andantino in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0afe3e34-09e7-4742-ba2b-e006043175fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c18f938f-4b5c-450b-8aba-084bd2fe9b70', 7, NULL, '왈츠 E장조', 'No. 7 Valtz in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c18f938f-4b5c-450b-8aba-084bd2fe9b70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb165333-ad21-4095-97da-50a9ada24586', 8, NULL, 'Andante C장조', 'No. 8 Andante in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb165333-ad21-4095-97da-50a9ada24586'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bca24f08-4c07-4a56-a344-ee75624f7097', 9, NULL, 'Andantino C장조', 'No. 9 Andantino in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bca24f08-4c07-4a56-a344-ee75624f7097'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:759da0c3-249f-4512-98d7-ff9c07b61eac', 10, NULL, 'C장조', 'No. 10 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:759da0c3-249f-4512-98d7-ff9c07b61eac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad8b2b93-64fd-47ac-be7e-1c490b6bcfd6', 11, NULL, 'Allegretto A장조', 'No. 11 Allegretto in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad8b2b93-64fd-47ac-be7e-1c490b6bcfd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05f20d1f-6ece-4361-8f40-b9c1308b9cfb', 12, NULL, 'Andante C장조', 'No. 12 Andante in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05f20d1f-6ece-4361-8f40-b9c1308b9cfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52a91ec8-99e3-45ae-a455-cb1548e84233', 13, NULL, 'Allegro C장조', 'No. 13 Allegro in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52a91ec8-99e3-45ae-a455-cb1548e84233'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df3f58a1-39b0-4602-97b2-4be81953aef0', 14, NULL, 'C장조', 'No. 14 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df3f58a1-39b0-4602-97b2-4be81953aef0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71f5cb2f-9815-4e39-8005-050cc0773924', 15, NULL, 'Allegro G장조', 'No. 15 Allegro in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71f5cb2f-9815-4e39-8005-050cc0773924'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f78d247-4e2d-47b0-ad26-a83d20e7d4dd', 16, NULL, 'Larghetto G장조', 'No. 16 Larghetto in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f78d247-4e2d-47b0-ad26-a83d20e7d4dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0db60011-49c2-4f83-8ca3-1715090943ff', 17, NULL, '"Le streghe" D장조', 'No. 17 "Le streghe" in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0db60011-49c2-4f83-8ca3-1715090943ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9dfe735-6fc0-4903-8ecb-8e58471e2335', 18, NULL, 'Andantino D단조', 'No. 18 Andantino in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9dfe735-6fc0-4903-8ecb-8e58471e2335'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4529119b-da00-4f35-ac7d-f50974b81e32', 19, NULL, '코렌테 G장조', 'No. 19 Corrente in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4529119b-da00-4f35-ac7d-f50974b81e32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f7624bc-9768-453d-8348-a23c97436408', 20, NULL, 'Andante C장조', 'No. 20 Andante in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f7624bc-9768-453d-8348-a23c97436408'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c953a173-6de5-4915-a202-96a963cb3259', 21, NULL, 'A장조', 'No. 21 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c953a173-6de5-4915-a202-96a963cb3259'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:618d7292-bf0d-4988-9698-366f26f070be', 22, NULL, 'Larghetto A장조', 'No. 22 Larghetto in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:618d7292-bf0d-4988-9698-366f26f070be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e1bd5b8-4dbe-4912-9a79-cf7179e22615', 23, NULL, 'A장조', 'No. 23 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e1bd5b8-4dbe-4912-9a79-cf7179e22615'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f6a9926-f5db-40b7-9b14-912542e7a571', 24, NULL, 'Andante A장조', 'No. 24 Andante in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f6a9926-f5db-40b7-9b14-912542e7a571'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba1ec984-6fbe-4ec7-a2b5-d53f438f5e3b', 25, NULL, 'Andante C장조', 'No. 25 Andante in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba1ec984-6fbe-4ec7-a2b5-d53f438f5e3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f77bfd47-821f-4156-8d39-9227b04a4748', 26, NULL, '아리에타 D장조', 'No. 26 Arietta in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f77bfd47-821f-4156-8d39-9227b04a4748'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:330ed716-c638-46c9-8a03-d171f16d2c5e', 27, NULL, 'Andantino D장조', 'No. 27 Andantino in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:330ed716-c638-46c9-8a03-d171f16d2c5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d43b24-3e9b-4541-91ad-6d2f68635157', 28, NULL, 'D장조', 'No. 28 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d43b24-3e9b-4541-91ad-6d2f68635157'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4d86df9-d609-446c-ab23-ed3e9e79665c', 29, NULL, '행진곡 D장조', 'No. 29 Marcia in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4d86df9-d609-446c-ab23-ed3e9e79665c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:574fefb6-cf56-4644-8db4-35b1f4d325a2', 30, NULL, 'Allegretto D장조', 'No. 30 Allegretto in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:574fefb6-cf56-4644-8db4-35b1f4d325a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fa68135-c8e5-4d19-813e-eb016f02ab36', 31, NULL, '미뉴에트. Andante A장조', 'No. 31 Minuetto - Andante in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fa68135-c8e5-4d19-813e-eb016f02ab36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:983c586c-6faf-4e08-aece-3fed2697e855', 32, NULL, 'Allegretto A장조', 'No. 32 Allegretto in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:983c586c-6faf-4e08-aece-3fed2697e855'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9d57bb4-4559-4d69-88c3-34acb24227bd', 33, NULL, 'Allegretto A장조', 'No. 33 Allegretto in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9d57bb4-4559-4d69-88c3-34acb24227bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ff869a7-d279-4b42-9132-3877766c6984', 34, NULL, '왈츠 A장조', 'No. 34 Valtz in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ff869a7-d279-4b42-9132-3877766c6984'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25ec5419-2481-4079-93a7-38ef699e8b09', 35, NULL, '왈츠 D장조', 'No. 35 Valtz in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25ec5419-2481-4079-93a7-38ef699e8b09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb570acf-f0cf-4169-b0e8-1b7e35a32f23', 36, NULL, 'C장조', 'No. 36 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb570acf-f0cf-4169-b0e8-1b7e35a32f23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d9625a0-d4ce-4c89-b71f-3b451966105b', 37, NULL, 'Adagetto con espressione A장조', 'No. 37 Adagetto con espressione (Rossini) in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d9625a0-d4ce-4c89-b71f-3b451966105b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f70746fc-1da3-4ffd-b643-0eb8c360c632', 38, NULL, 'Vivace A장조', 'No. 38 Vivace in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f70746fc-1da3-4ffd-b643-0eb8c360c632'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c719ad4-9916-4549-8f34-7901451a093f', 39, NULL, 'Allegretto D장조', 'No. 39 Allegretto in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c719ad4-9916-4549-8f34-7901451a093f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87d02f92-f5b6-4c02-848d-dc228f2b0ce9', 40, NULL, 'Andante A장조', 'No. 40 Andante in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87d02f92-f5b6-4c02-848d-dc228f2b0ce9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:137cbcae-463d-452a-939d-aaf4d21fb46a', 41, NULL, 'Allegro C장조', 'No. 41 Allegro in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:137cbcae-463d-452a-939d-aaf4d21fb46a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bb3c065-80ed-4e1a-bdbd-88949b9244cf', 42, NULL, 'A장조', 'No. 42 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb3c065-80ed-4e1a-bdbd-88949b9244cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a591179-96a5-432d-ab22-9efd3d5b3b4b', 43, NULL, 'A단조', 'No. 43 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<기리비치>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a591179-96a5-432d-ab22-9efd3d5b3b4b'
);


-- MS 44 "Nel cor più non mi sento" 서주와 변주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"Nel cor più non mi sento" 서주와 변주곡 G장조', 'Introduction and Variations on "Nel cor più non mi sento" in G major', 'song', 'MS 44', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"Nel cor più non mi sento" 서주와 변주곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '147f97bc-39a0-4755-9920-04c06fd28fcf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '147f97bc-39a0-4755-9920-04c06fd28fcf'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '"Nel cor più non mi sento" 서주와 변주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '147f97bc-39a0-4755-9920-04c06fd28fcf'
);


-- MS 45 칸타빌레와 왈츠 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타빌레와 왈츠 E장조', 'Cantabile e Valtz in E major', 'song', 'MS 45', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타빌레와 왈츠 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4e175f6-1980-4cdb-9c78-a2fe5369dca2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c4e175f6-1980-4cdb-9c78-a2fe5369dca2'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '칸타빌레와 왈츠 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c4e175f6-1980-4cdb-9c78-a2fe5369dca2'
);


-- MS 47 "Pria ch'io l'impegno" 변주 소나타 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"Pria ch''io l''impegno" 변주 소나타 E장조', 'Sonata con variazioni "Pria ch''io l''impegno" in E major', 'song', 'MS 47', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"Pria ch''io l''impegno" 변주 소나타 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '949d7e10-4c83-44af-9b82-aec0dca3ed9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '949d7e10-4c83-44af-9b82-aec0dca3ed9b'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '"Pria ch''io l''impegno" 변주 소나타 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '949d7e10-4c83-44af-9b82-aec0dca3ed9b'
);


-- MS 49 아다지오 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아다지오 E장조', 'Adagio in E major', 'song', 'MS 49', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아다지오 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd50e889d-c015-4e9f-8fb8-2b1f78ba57a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd50e889d-c015-4e9f-8fb8-2b1f78ba57a1'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '아다지오 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd50e889d-c015-4e9f-8fb8-2b1f78ba57a1'
);


-- MS 50 바이올린 협주곡 3번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 3번 E장조', 'Violin Concerto No. 3 in E major', 'album', 'MS 50', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 3번 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac563a06-ee0c-4cdd-a1ce-db0ddcc65816'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac563a06-ee0c-4cdd-a1ce-db0ddcc65816'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 3번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac563a06-ee0c-4cdd-a1ce-db0ddcc65816'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d37099a8-be11-31b5-80c2-aa89b342fd4d', 1, 'I', '서주. Andante. Allegro marziale', 'I. Introduzione - Andante. Allegro marziale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 3번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d37099a8-be11-31b5-80c2-aa89b342fd4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:510c485a-9f80-36bd-81ed-d0eb68ea3e67', 2, 'II', 'Adagio, cantabile spianato', 'II. Adagio, cantabile spianato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 3번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:510c485a-9f80-36bd-81ed-d0eb68ea3e67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4584ae6-a46b-397d-bb49-bef220ce028b', 3, 'III', '폴로네즈. Andantino', 'III. Polacca - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 3번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4584ae6-a46b-397d-bb49-bef220ce028b'
);


-- MS 51 <Maestosa sonata sentimentale>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Maestosa sonata sentimentale>', 'Maestosa sonata sentimentale', 'song', 'MS 51', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Maestosa sonata sentimentale>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcb59f06-d934-404c-ab29-7f3b3824eccd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bcb59f06-d934-404c-ab29-7f3b3824eccd'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<Maestosa sonata sentimentale>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcb59f06-d934-404c-ab29-7f3b3824eccd'
);


-- MS 53 가곡 <È pur amabile>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <È pur amabile>', 'È pur amabile', 'song', 'MS 53', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <È pur amabile>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c37281f-b5db-496e-abd0-c4b210413673'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c37281f-b5db-496e-abd0-c4b210413673'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '가곡 <È pur amabile>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c37281f-b5db-496e-abd0-c4b210413673'
);


-- MS 54 카프리치오 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카프리치오 G장조', 'Capriccio in G major', 'song', 'MS 54', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카프리치오 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '644bad7c-7eae-4c83-a128-a77053046690'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '644bad7c-7eae-4c83-a128-a77053046690'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '카프리치오 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '644bad7c-7eae-4c83-a128-a77053046690'
);


-- MS 57 <바르샤바 소나타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<바르샤바 소나타>', 'Sonata Varsavia', 'song', 'MS 57', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<바르샤바 소나타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a400c08a-cd9c-4274-96d9-77b9be23b367'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a400c08a-cd9c-4274-96d9-77b9be23b367'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<바르샤바 소나타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a400c08a-cd9c-4274-96d9-77b9be23b367'
);


-- MS 60 바이올린 협주곡 4번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 4번 D단조', 'Violin Concerto No. 4 in D minor', 'album', 'MS 60', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 4번 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e1ac10c-0b9d-49b1-ab8e-37c9b7a15d6f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e1ac10c-0b9d-49b1-ab8e-37c9b7a15d6f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e1ac10c-0b9d-49b1-ab8e-37c9b7a15d6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b1c81c3-c862-376f-bc72-d73da8550a48', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b1c81c3-c862-376f-bc72-d73da8550a48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:084cc417-7344-3e71-8bbf-1b9a599367f1', 2, 'II', 'Adagio flebile con sentimento', 'II. Adagio flebile con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:084cc417-7344-3e71-8bbf-1b9a599367f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca21764d-a21e-38d1-8daf-c47a2bba0aa9', 3, 'III', '론도. Andantino ameno', 'III. Rondò - Andantino ameno', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 4번 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca21764d-a21e-38d1-8daf-c47a2bba0aa9'
);


-- MS 62 <애국의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<애국의 노래>', 'Quel jour heureux (Chant patriotique)', 'song', 'MS 62', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<애국의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bba77c86-c277-452f-8c64-78ec2ec997cd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bba77c86-c277-452f-8c64-78ec2ec997cd'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<애국의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bba77c86-c277-452f-8c64-78ec2ec997cd'
);


-- MS 63 론도 A장조 (바이올린과 첼로)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 A장조 (바이올린과 첼로)', 'Rondo in A major for Violin and Cello', 'song', 'MS 63', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 A장조 (바이올린과 첼로)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a831393-0681-45ea-892c-cddbd3205b36'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a831393-0681-45ea-892c-cddbd3205b36'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '론도 A장조 (바이올린과 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a831393-0681-45ea-892c-cddbd3205b36'
);


-- MS 65 호른과 바순을 위한 콘체르티노 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른과 바순을 위한 콘체르티노 E장조', 'Concertino in E major for Horn and Bassoon "à Mr. Henry"', 'album', 'MS 65', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른과 바순을 위한 콘체르티노 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99ea5d2e-5d76-46ce-bb32-045d40a81ea6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99ea5d2e-5d76-46ce-bb32-045d40a81ea6'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '호른과 바순을 위한 콘체르티노 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99ea5d2e-5d76-46ce-bb32-045d40a81ea6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ed5503b-89a4-4ed6-9c01-741510480503', 1, 'I', 'Larghetto', 'I. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '호른과 바순을 위한 콘체르티노 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ed5503b-89a4-4ed6-9c01-741510480503'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:438ae79a-95bc-49f0-9141-b3e18abc6cb0', 2, 'II', 'Allegro moderato', 'II. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '호른과 바순을 위한 콘체르티노 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:438ae79a-95bc-49f0-9141-b3e18abc6cb0'
);


-- MS 67 <생베르나르 산의 수도원>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<생베르나르 산의 수도원>', 'Le Couvent du Mont Saint-Bernard', 'album', 'MS 67', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<생베르나르 산의 수도원>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bad6e64-52c9-4ae9-a169-7c8a30bbe880'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5bad6e64-52c9-4ae9-a169-7c8a30bbe880'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<생베르나르 산의 수도원>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5bad6e64-52c9-4ae9-a169-7c8a30bbe880'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59d92f26-f207-4afb-aab8-6380f9310360', 1, 'I', 'Andante sonnolento', 'I. Andante sonnolento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<생베르나르 산의 수도원>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59d92f26-f207-4afb-aab8-6380f9310360'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c3d533b-e9ce-4952-b4cf-eb8139462967', 2, 'II', 'Pendule. Lento', 'II. Pendule. Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<생베르나르 산의 수도원>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c3d533b-e9ce-4952-b4cf-eb8139462967'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97419f5a-57c8-4fb1-8942-9060efa51820', 3, 'III', '미뉴에트. Moderato', 'III. Minuetto. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<생베르나르 산의 수도원>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97419f5a-57c8-4fb1-8942-9060efa51820'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bb306fb-e70a-4e1b-9c1a-78e8b18a2c6e', 4, 'IV', 'L''aurora. Lento - Maestoso', 'IV. L''aurora. Lento - Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<생베르나르 산의 수도원>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bb306fb-e70a-4e1b-9c1a-78e8b18a2c6e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf5804d1-7cba-4ca7-a9d6-040473c0fd1e', 5, 'V', 'Rondò del campanello', 'V. Rondò del campanello', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<생베르나르 산의 수도원>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf5804d1-7cba-4ca7-a9d6-040473c0fd1e'
);


-- MS 68 <작별의 카프리스> E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<작별의 카프리스> E장조', 'Caprice d''adieu in E major', 'song', 'MS 68', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<작별의 카프리스> E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82e07098-c0b3-48e6-9eed-8184fda311de'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82e07098-c0b3-48e6-9eed-8184fda311de'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<작별의 카프리스> E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82e07098-c0b3-48e6-9eed-8184fda311de'
);


-- MS 69 3중주 D장조 (바이올린, 첼로, 기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중주 D장조 (바이올린, 첼로, 기타)', 'Terzetto in D major for Violin, Cello and Guitar', 'album', 'MS 69', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중주 D장조 (바이올린, 첼로, 기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a81c0708-ac91-4d20-96f3-fae7d1036c62'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a81c0708-ac91-4d20-96f3-fae7d1036c62'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 D장조 (바이올린, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a81c0708-ac91-4d20-96f3-fae7d1036c62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51e2fbd1-cb0e-47a5-9c8a-a34f816131d9', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 D장조 (바이올린, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51e2fbd1-cb0e-47a5-9c8a-a34f816131d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f368013-8089-423a-99c0-9b02d6e28745', 2, 'II', '미뉴에트. Allegro vivace', 'II. Minuetto - Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 D장조 (바이올린, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f368013-8089-423a-99c0-9b02d6e28745'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4467eeb2-a7ec-47a5-96ca-bef87a1b0fed', 3, 'III', 'Andante - Larghetto', 'III. Andante - Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 D장조 (바이올린, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4467eeb2-a7ec-47a5-96ca-bef87a1b0fed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a47d5d7-d676-4347-9214-82f639d73707', 4, 'IV', '론도. Allegretto', 'IV. Rondò - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 D장조 (바이올린, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a47d5d7-d676-4347-9214-82f639d73707'
);


-- MS 70 그랑 비올라 소나타 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그랑 비올라 소나타 C단조', 'Sonata per la Gran Viola in C minor', 'song', 'MS 70', NULL, NULL, 1834, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그랑 비올라 소나타 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34ff4e51-199f-454b-9f56-a8d34550383d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '34ff4e51-199f-454b-9f56-a8d34550383d'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '그랑 비올라 소나타 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34ff4e51-199f-454b-9f56-a8d34550383d'
);


-- MS 73 소나타 A장조 "봄"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타 A장조 "봄"', 'La primavera, Sonata in A major', 'song', 'MS 73', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타 A장조 "봄"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6cf461c0-bd04-3433-8171-624c02295652'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6cf461c0-bd04-3433-8171-624c02295652'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '소나타 A장조 "봄"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6cf461c0-bd04-3433-8171-624c02295652'
);


-- MS 74 <전원 발레> 변주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<전원 발레> 변주곡', 'Balletto campestre, Variations on a Comic Theme', 'song', 'MS 74', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<전원 발레> 변주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a281ddf-c27b-4808-8bcd-438b4ca9a6ae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5a281ddf-c27b-4808-8bcd-438b4ca9a6ae'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<전원 발레> 변주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5a281ddf-c27b-4808-8bcd-438b4ca9a6ae'
);


-- MS 75 바이올린 협주곡 6번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 6번 E단조', 'Violin Concerto No. 6 in E minor', 'album', 'MS 75', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 6번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86ca3139-f324-4863-b50a-1b9047e0771d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86ca3139-f324-4863-b50a-1b9047e0771d'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 6번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86ca3139-f324-4863-b50a-1b9047e0771d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9f3d6bf-1901-4f59-8795-38555d3d6539', 1, 'I', 'Risoluto', 'I. Risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 6번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9f3d6bf-1901-4f59-8795-38555d3d6539'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d65c9ffa-6977-4264-9213-5720dbbfcccb', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 6번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d65c9ffa-6977-4264-9213-5720dbbfcccb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de6222f0-848a-4c3f-88a2-2e78fc922889', 3, 'III', '론도 또는 폴로네즈', 'III. Rondò ossia Polonese', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 6번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de6222f0-848a-4c3f-88a2-2e78fc922889'
);


-- MS 76 타란텔라 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '타란텔라 A단조', 'Tarantella in A minor', 'song', 'MS 76', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '타란텔라 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e7af0e6-4c2e-4aad-a4b6-0f4078295f92'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e7af0e6-4c2e-4aad-a4b6-0f4078295f92'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '타란텔라 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e7af0e6-4c2e-4aad-a4b6-0f4078295f92'
);


-- MS 78 바이올린 협주곡 5번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 5번 A단조', 'Violin Concerto No. 5 in A minor', 'album', 'MS 78', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 5번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb540124-d928-4fa6-bc71-0a8a0b192784'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb540124-d928-4fa6-bc71-0a8a0b192784'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 5번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb540124-d928-4fa6-bc71-0a8a0b192784'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0e8adf7-0787-3d81-ad1d-972ba3cdc0d5', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 5번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0e8adf7-0787-3d81-ad1d-972ba3cdc0d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01e1fc7b-492e-3eb6-9871-b59c6d0913db', 2, 'II', 'Andante, un poco sostenuto', 'II. Andante, un poco sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 5번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01e1fc7b-492e-3eb6-9871-b59c6d0913db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7eecb263-756d-3e87-84bd-aa6b21e76957', 3, 'III', '론도. Andantino, allegretto', 'III. Rondò - Andantino, allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 5번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eecb263-756d-3e87-84bd-aa6b21e76957'
);


-- MS 79 소나타 E장조 "마리아 루이사"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소나타 E장조 "마리아 루이사"', 'Sonata "Maria Luisa" in E major', 'song', 'MS 79', NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소나타 E장조 "마리아 루이사"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49066154-e471-4af7-bc12-6de4b0568e08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '49066154-e471-4af7-bc12-6de4b0568e08'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '소나타 E장조 "마리아 루이사"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '49066154-e471-4af7-bc12-6de4b0568e08'
);


-- MS 80 왈츠 A장조 (바이올린)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 A장조 (바이올린)', 'Valtz in A major for Violin', 'song', 'MS 80', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 A장조 (바이올린)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac13ad37-c877-44a1-97ef-da32963e167b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac13ad37-c877-44a1-97ef-da32963e167b'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '왈츠 A장조 (바이올린)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac13ad37-c877-44a1-97ef-da32963e167b'
);


-- MS 81 <애국 찬가> 변주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<애국 찬가> 변주곡 A장조', 'Inno patriottico in A major', 'song', 'MS 81', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<애국 찬가> 변주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a935745a-fb7c-4117-b939-58e64895d86f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a935745a-fb7c-4117-b939-58e64895d86f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<애국 찬가> 변주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a935745a-fb7c-4117-b939-58e64895d86f'
);


-- MS 82 주제와 변주 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '주제와 변주 A장조', 'Tema variato in A major', 'song', 'MS 82', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '주제와 변주 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '459dce9f-cbe2-49f8-9f56-4e2a7fa6a80f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '459dce9f-cbe2-49f8-9f56-4e2a7fa6a80f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '주제와 변주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '459dce9f-cbe2-49f8-9f56-4e2a7fa6a80f'
);


-- MS 83 무반주 바이올린 소나타 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무반주 바이올린 소나타 A장조', 'Sonata for Solo Violin in A major', 'song', 'MS 83', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무반주 바이올린 소나타 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '813e7857-f392-4562-bccd-c839d73656ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '813e7857-f392-4562-bccd-c839d73656ab'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '무반주 바이올린 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '813e7857-f392-4562-bccd-c839d73656ab'
);


-- MS 84 기타 소나타 MS 84

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 소나타 MS 84', '37 Sonatas for Guitar, MS 84', 'album', NULL, 'MS', '84', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 소나타 MS 84'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ea55954-476d-4b1c-a4c8-5e90a9e5f32f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ea55954-476d-4b1c-a4c8-5e90a9e5f32f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ea55954-476d-4b1c-a4c8-5e90a9e5f32f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c1be48c-043b-4327-be64-2300131742b7', 1, NULL, 'A장조', 'No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c1be48c-043b-4327-be64-2300131742b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff7150bd-b92e-4690-991c-ca89be58325e', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c1be48c-043b-4327-be64-2300131742b7'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff7150bd-b92e-4690-991c-ca89be58325e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a80761e0-7728-4a2b-bee8-6d0f586e804d', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c1be48c-043b-4327-be64-2300131742b7'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a80761e0-7728-4a2b-bee8-6d0f586e804d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47f8b8fd-938f-4605-8ffc-78c457f6c158', 2, NULL, 'A장조', 'No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f8b8fd-938f-4605-8ffc-78c457f6c158'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3244984d-23b0-4746-b141-c0ac21274caf', 1, 'I', '(미뉴에트)', 'I. (Minuetto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:47f8b8fd-938f-4605-8ffc-78c457f6c158'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3244984d-23b0-4746-b141-c0ac21274caf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57e682f5-321b-4c5d-aa45-a3b2dfb28100', 2, 'II', 'Allegretto ossia Rondoncino', 'II. Allegretto ossia Rondoncino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:47f8b8fd-938f-4605-8ffc-78c457f6c158'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57e682f5-321b-4c5d-aa45-a3b2dfb28100'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14f1ec6f-ad10-4031-9331-6b5d25d36829', 3, NULL, 'C장조', 'No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14f1ec6f-ad10-4031-9331-6b5d25d36829'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3dd50a80-c3ea-42c7-8336-924797ae5377', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14f1ec6f-ad10-4031-9331-6b5d25d36829'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3dd50a80-c3ea-42c7-8336-924797ae5377'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5f546dd3-d7f7-4f54-898c-6da2a8290ae2', 2, 'II', '왈츠', 'II. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:14f1ec6f-ad10-4031-9331-6b5d25d36829'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f546dd3-d7f7-4f54-898c-6da2a8290ae2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8394da00-f615-466d-9bd6-a7db87281123', 4, NULL, 'D장조', 'No. 4 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8394da00-f615-466d-9bd6-a7db87281123'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc41850a-6c80-4d2e-ab39-eebfd8c817ca', 1, 'I', '(미뉴에트)', 'I. (Minuetto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8394da00-f615-466d-9bd6-a7db87281123'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc41850a-6c80-4d2e-ab39-eebfd8c817ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1595f5fe-d5b7-4e07-9b07-f76651053a57', 2, 'II', '론돈치노', 'II. Rondoncino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8394da00-f615-466d-9bd6-a7db87281123'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1595f5fe-d5b7-4e07-9b07-f76651053a57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2de1498d-5d39-4a9d-a09a-0f7684a7312f', 5, NULL, 'G장조', 'No. 5 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2de1498d-5d39-4a9d-a09a-0f7684a7312f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f4ec6db-1db2-4a20-a458-2645e84bc10e', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2de1498d-5d39-4a9d-a09a-0f7684a7312f'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f4ec6db-1db2-4a20-a458-2645e84bc10e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ba71c72-40de-4581-9519-f7a83e256cd7', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2de1498d-5d39-4a9d-a09a-0f7684a7312f'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ba71c72-40de-4581-9519-f7a83e256cd7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff2c279a-5fc4-47bc-b397-a69128b83a58', 6, NULL, 'F장조', 'No. 6 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff2c279a-5fc4-47bc-b397-a69128b83a58'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38c46459-c283-42b2-a119-2dfca5bc258f', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff2c279a-5fc4-47bc-b397-a69128b83a58'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38c46459-c283-42b2-a119-2dfca5bc258f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa03ca86-19d3-4d35-af3c-9f6e07681ae2', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff2c279a-5fc4-47bc-b397-a69128b83a58'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa03ca86-19d3-4d35-af3c-9f6e07681ae2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:486cbc6e-72e3-4759-9288-af00a5517d72', 7, NULL, 'F장조', 'No. 7 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:486cbc6e-72e3-4759-9288-af00a5517d72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dcf84c18-c530-4f56-b0a5-d8e006bd3644', 1, 'I', 'Altro Minuetto', 'I. Altro Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:486cbc6e-72e3-4759-9288-af00a5517d72'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf84c18-c530-4f56-b0a5-d8e006bd3644'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f66a0e86-c1b6-4e70-af12-51da5bb49007', 2, 'II', '왈츠', 'II. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:486cbc6e-72e3-4759-9288-af00a5517d72'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f66a0e86-c1b6-4e70-af12-51da5bb49007'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b420219d-be51-4cba-afe1-f09c961707e3', 8, NULL, 'G장조', 'No. 8 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b420219d-be51-4cba-afe1-f09c961707e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9fbebb5-8733-4cc1-84de-304b845408b7', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b420219d-be51-4cba-afe1-f09c961707e3'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9fbebb5-8733-4cc1-84de-304b845408b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c20e1f4b-e6bf-49d5-a952-e76708ef2ece', 2, 'II', 'Allegretto, scherzando', 'II. Allegretto, scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b420219d-be51-4cba-afe1-f09c961707e3'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c20e1f4b-e6bf-49d5-a952-e76708ef2ece'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec7657c8-fca4-4088-a6f7-b701b4c13942', 9, NULL, 'C장조', 'No. 9 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec7657c8-fca4-4088-a6f7-b701b4c13942'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3a703ab4-a98d-4430-96c0-c4c8c733ea68', 1, 'I', '(미뉴에트)', 'I. (Minuetto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec7657c8-fca4-4088-a6f7-b701b4c13942'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a703ab4-a98d-4430-96c0-c4c8c733ea68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:66b817f6-eb3a-474b-b786-2b0c199a8cab', 2, 'II', '왈츠', 'II. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ec7657c8-fca4-4088-a6f7-b701b4c13942'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66b817f6-eb3a-474b-b786-2b0c199a8cab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78472c3a-5051-42dd-9b31-ae036331ef83', 10, NULL, 'D장조', 'No. 10 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78472c3a-5051-42dd-9b31-ae036331ef83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:096731c4-cdd2-4088-bcd8-2fb71ee32960', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78472c3a-5051-42dd-9b31-ae036331ef83'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:096731c4-cdd2-4088-bcd8-2fb71ee32960'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f0cce7ca-0897-4b5c-9d5d-bc8bd9ff596b', 2, 'II', '왈츠', 'II. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:78472c3a-5051-42dd-9b31-ae036331ef83'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0cce7ca-0897-4b5c-9d5d-bc8bd9ff596b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:865a3697-b8e6-444e-86b0-e466fa2baacd', 11, NULL, 'A장조', 'No. 11 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:865a3697-b8e6-444e-86b0-e466fa2baacd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea5c5fee-8a87-4e48-969b-b54b90566c6a', 12, NULL, 'A장조', 'No. 12 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea5c5fee-8a87-4e48-969b-b54b90566c6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de239614-4668-4218-bd93-194289619e03', 1, 'I', '(미뉴에트)', 'I. (Minuetto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea5c5fee-8a87-4e48-969b-b54b90566c6a'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de239614-4668-4218-bd93-194289619e03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ace6174-3cc7-4d94-a489-6207a3a79608', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea5c5fee-8a87-4e48-969b-b54b90566c6a'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ace6174-3cc7-4d94-a489-6207a3a79608'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea2052f-98cb-453e-ad72-8c054bfc7167', 13, NULL, 'C장조', 'No. 13 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea2052f-98cb-453e-ad72-8c054bfc7167'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78a75523-1a61-44e9-87a7-8bd6de02d11c', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea2052f-98cb-453e-ad72-8c054bfc7167'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78a75523-1a61-44e9-87a7-8bd6de02d11c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:642f1b77-a6bd-4908-988b-b0e5144b1f3e', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dea2052f-98cb-453e-ad72-8c054bfc7167'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:642f1b77-a6bd-4908-988b-b0e5144b1f3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf9be417-14d9-4523-a48e-c3bd46f3b630', 14, NULL, 'F장조', 'No. 14 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf9be417-14d9-4523-a48e-c3bd46f3b630'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38f57482-fcc5-4868-805f-c9d0769ba6ad', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf9be417-14d9-4523-a48e-c3bd46f3b630'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38f57482-fcc5-4868-805f-c9d0769ba6ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:375f27d8-955a-4727-ae0c-64e2db6e801a', 2, 'II', 'Allegretto in Faffaut (ossia Valtz)', 'II. Allegretto in Faffaut (ossia Valtz)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bf9be417-14d9-4523-a48e-c3bd46f3b630'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:375f27d8-955a-4727-ae0c-64e2db6e801a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15b29bc2-14ea-40e1-a3ef-0c5e1d549229', 15, NULL, 'C장조', 'No. 15 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b29bc2-14ea-40e1-a3ef-0c5e1d549229'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:558edd3c-bddd-40f5-98b6-ea9f04b92189', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15b29bc2-14ea-40e1-a3ef-0c5e1d549229'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:558edd3c-bddd-40f5-98b6-ea9f04b92189'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a3b1727d-1920-44fd-9386-0bf5962e58eb', 2, 'II', 'Perligordino - Allegretto', 'II. Perligordino - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15b29bc2-14ea-40e1-a3ef-0c5e1d549229'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3b1727d-1920-44fd-9386-0bf5962e58eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b27b1d02-c194-4595-aa6f-0a25e40b34fc', 16, NULL, 'E장조', 'No. 16 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b27b1d02-c194-4595-aa6f-0a25e40b34fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e122273e-5221-465f-8a89-c40cfe2277b7', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b27b1d02-c194-4595-aa6f-0a25e40b34fc'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e122273e-5221-465f-8a89-c40cfe2277b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d3713ba-71e1-48b3-838c-2146b9b3bcc3', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b27b1d02-c194-4595-aa6f-0a25e40b34fc'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d3713ba-71e1-48b3-838c-2146b9b3bcc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59850b0a-8557-4498-9c9d-68d95ace5ecc', 17, NULL, 'A장조', 'No. 17 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59850b0a-8557-4498-9c9d-68d95ace5ecc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ec1404f-4552-4db3-b097-43c47c84dc14', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:59850b0a-8557-4498-9c9d-68d95ace5ecc'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ec1404f-4552-4db3-b097-43c47c84dc14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3bd7b3d-5de4-477d-8e7f-bdfa1e20ef5d', 2, 'II', 'Perligordino', 'II. Perligordino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:59850b0a-8557-4498-9c9d-68d95ace5ecc'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3bd7b3d-5de4-477d-8e7f-bdfa1e20ef5d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c27548a4-886f-4c3e-bf55-e8d02ef9aa3b', 18, NULL, 'A장조', 'No. 18 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c27548a4-886f-4c3e-bf55-e8d02ef9aa3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3597d7e3-2a29-4fbc-98c2-847e20424d55', 1, 'I', '(미뉴에트)', 'I. (Minuetto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c27548a4-886f-4c3e-bf55-e8d02ef9aa3b'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3597d7e3-2a29-4fbc-98c2-847e20424d55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:189279ff-adc7-4c6b-a2c6-db72672c2d8f', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c27548a4-886f-4c3e-bf55-e8d02ef9aa3b'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:189279ff-adc7-4c6b-a2c6-db72672c2d8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eef0a068-f994-4cce-abf2-3a8c34787d82', 19, NULL, 'C장조', 'No. 19 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eef0a068-f994-4cce-abf2-3a8c34787d82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f0f5673-a9ca-4e4d-a040-84c547a46556', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eef0a068-f994-4cce-abf2-3a8c34787d82'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f0f5673-a9ca-4e4d-a040-84c547a46556'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:231a41e4-7181-4e92-9c9e-7f7fa377272b', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eef0a068-f994-4cce-abf2-3a8c34787d82'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:231a41e4-7181-4e92-9c9e-7f7fa377272b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50279085-9bfb-47d1-86d2-74a644b68c20', 20, NULL, 'C장조', 'No. 20 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50279085-9bfb-47d1-86d2-74a644b68c20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a07fe60f-47ac-4cb1-8c69-c834f100c218', 1, 'I', '(미뉴에트)', 'I. (Minuetto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:50279085-9bfb-47d1-86d2-74a644b68c20'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a07fe60f-47ac-4cb1-8c69-c834f100c218'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:415abbcf-776e-4abb-97c6-620f038ae5c1', 2, 'II', '왈츠', 'II. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:50279085-9bfb-47d1-86d2-74a644b68c20'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:415abbcf-776e-4abb-97c6-620f038ae5c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff637448-ff01-4fe1-8a56-e40e085e6e02', 21, NULL, 'A장조', 'No. 21 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff637448-ff01-4fe1-8a56-e40e085e6e02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57abe94b-10d0-4bcd-ac48-4ae7311e6177', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff637448-ff01-4fe1-8a56-e40e085e6e02'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57abe94b-10d0-4bcd-ac48-4ae7311e6177'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1acc3934-7588-4355-943a-e52f47db4291', 2, 'II', '왈츠 in Allamire', 'II. Valtz in Allamire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ff637448-ff01-4fe1-8a56-e40e085e6e02'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1acc3934-7588-4355-943a-e52f47db4291'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f394c80-421a-4895-9147-5a6d21ad0ca6', 22, NULL, 'D장조', 'No. 22 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f394c80-421a-4895-9147-5a6d21ad0ca6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03b2ce02-86fc-4edc-8701-e0383c4da469', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7f394c80-421a-4895-9147-5a6d21ad0ca6'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03b2ce02-86fc-4edc-8701-e0383c4da469'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:876830bf-28c2-432c-82d7-f96b18e79a21', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7f394c80-421a-4895-9147-5a6d21ad0ca6'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:876830bf-28c2-432c-82d7-f96b18e79a21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c66f4383-8e92-4f57-82b1-e45c7e49764f', 23, NULL, 'A장조', 'No. 23 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c66f4383-8e92-4f57-82b1-e45c7e49764f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9c9c3861-d140-4044-b178-91d9090c86b8', 1, 'I', '미뉴에트 detto il Matto', 'I. Minuetto detto il Matto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c66f4383-8e92-4f57-82b1-e45c7e49764f'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c9c3861-d140-4044-b178-91d9090c86b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9febd175-c068-4564-a09a-83f5a21ff1dc', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c66f4383-8e92-4f57-82b1-e45c7e49764f'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9febd175-c068-4564-a09a-83f5a21ff1dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a79d7e42-fad1-433f-9021-6083536c4214', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c66f4383-8e92-4f57-82b1-e45c7e49764f'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a79d7e42-fad1-433f-9021-6083536c4214'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d608a0a9-80cb-4423-a41d-5b26e1804c13', 24, NULL, 'G장조', 'No. 24 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d608a0a9-80cb-4423-a41d-5b26e1804c13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6e8c9c7-3011-4055-a4cb-2afc8c34f34c', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d608a0a9-80cb-4423-a41d-5b26e1804c13'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6e8c9c7-3011-4055-a4cb-2afc8c34f34c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09c7a7bd-2783-4bce-b9a0-d8e753fd33bd', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d608a0a9-80cb-4423-a41d-5b26e1804c13'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09c7a7bd-2783-4bce-b9a0-d8e753fd33bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29a4d81d-79be-4022-bd58-03c9a42d5604', 25, NULL, 'E장조', 'No. 25 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29a4d81d-79be-4022-bd58-03c9a42d5604'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e5cda4aa-d8ae-4054-b803-43104d9b8748', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:29a4d81d-79be-4022-bd58-03c9a42d5604'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5cda4aa-d8ae-4054-b803-43104d9b8748'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e9e7abe-9708-4049-a9aa-d866c1db4d80', 2, 'II', '왈츠', 'II. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:29a4d81d-79be-4022-bd58-03c9a42d5604'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e9e7abe-9708-4049-a9aa-d866c1db4d80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83bcd0fa-1e12-4467-8976-8792e2ba31d6', 26, NULL, 'A장조', 'No. 26 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83bcd0fa-1e12-4467-8976-8792e2ba31d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4efc2a0b-13c2-4f98-8a1a-b08abccb1c35', 1, 'I', '미뉴에트 per la Signora Marina', 'I. Minuetto per la Signora Marina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83bcd0fa-1e12-4467-8976-8792e2ba31d6'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4efc2a0b-13c2-4f98-8a1a-b08abccb1c35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f5bda43-a29b-40b4-9ab8-48ea986c34eb', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:83bcd0fa-1e12-4467-8976-8792e2ba31d6'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f5bda43-a29b-40b4-9ab8-48ea986c34eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d855773-1516-4938-b696-a50fb433e2e5', 27, NULL, 'A장조', 'No. 27 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d855773-1516-4938-b696-a50fb433e2e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:654dd848-99ef-4cb3-8487-87beb43e0fbd', 1, 'I', '미뉴에트 per la Signora Marina', 'I. Minuetto per la Signora Marina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d855773-1516-4938-b696-a50fb433e2e5'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:654dd848-99ef-4cb3-8487-87beb43e0fbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6659788d-aa06-4d5e-84db-6d9164d6d826', 2, 'II', '왈츠', 'II. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2d855773-1516-4938-b696-a50fb433e2e5'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6659788d-aa06-4d5e-84db-6d9164d6d826'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e04eb35a-ebce-417d-b526-5bec79f7c99b', 28, NULL, 'G장조', 'No. 28 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e04eb35a-ebce-417d-b526-5bec79f7c99b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e5239ed-d8b7-47fc-a281-e2f6b2c5df0e', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e04eb35a-ebce-417d-b526-5bec79f7c99b'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e5239ed-d8b7-47fc-a281-e2f6b2c5df0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc86d920-7eee-42ad-86d6-91d88b5d790f', 2, 'II', 'Andantino amoroso', 'II. Andantino amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e04eb35a-ebce-417d-b526-5bec79f7c99b'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc86d920-7eee-42ad-86d6-91d88b5d790f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:916c49f4-e1c1-4ac5-9939-aa3465915b3e', 29, NULL, 'G장조', 'No. 29 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:916c49f4-e1c1-4ac5-9939-aa3465915b3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e83acac-1d5c-4df5-a03a-a5373c88744e', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:916c49f4-e1c1-4ac5-9939-aa3465915b3e'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e83acac-1d5c-4df5-a03a-a5373c88744e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:452da8f7-397b-4737-9bf3-0f25a41b8526', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:916c49f4-e1c1-4ac5-9939-aa3465915b3e'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:452da8f7-397b-4737-9bf3-0f25a41b8526'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ac7e8e9-c5eb-4f3d-bb42-43ccee1b38aa', 30, NULL, 'A장조', 'No. 30 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ac7e8e9-c5eb-4f3d-bb42-43ccee1b38aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab1f43c5-328b-4b36-b680-0d379bc04f2e', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ac7e8e9-c5eb-4f3d-bb42-43ccee1b38aa'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab1f43c5-328b-4b36-b680-0d379bc04f2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3b25712-c133-4eb3-81f8-7c2a72ed94a0', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8ac7e8e9-c5eb-4f3d-bb42-43ccee1b38aa'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3b25712-c133-4eb3-81f8-7c2a72ed94a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e0e6f27-6804-4400-bcb5-0eeaf7bed1e5', 31, NULL, 'C장조', 'No. 31 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e0e6f27-6804-4400-bcb5-0eeaf7bed1e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43d37099-7c02-4ed4-8e2f-ad830dbad6ab', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e0e6f27-6804-4400-bcb5-0eeaf7bed1e5'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43d37099-7c02-4ed4-8e2f-ad830dbad6ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:74432acc-2f44-4a70-bc47-10097055ef6f', 2, 'II', '론돈치노', 'II. Rondoncino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e0e6f27-6804-4400-bcb5-0eeaf7bed1e5'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74432acc-2f44-4a70-bc47-10097055ef6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88bb1003-d70b-467f-92b8-6c1d324cd90d', 3, 'III', '왈츠', 'III. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e0e6f27-6804-4400-bcb5-0eeaf7bed1e5'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88bb1003-d70b-467f-92b8-6c1d324cd90d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02c1c9c4-ac37-49d3-bc9a-17a6a08b019b', 32, NULL, 'E장조', 'No. 32 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02c1c9c4-ac37-49d3-bc9a-17a6a08b019b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:631b7a32-4faa-4c61-823a-bcb345641b0a', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02c1c9c4-ac37-49d3-bc9a-17a6a08b019b'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:631b7a32-4faa-4c61-823a-bcb345641b0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc23fc79-a004-472d-ad1d-f9248a5118ed', 2, 'II', '왈츠', 'II. Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:02c1c9c4-ac37-49d3-bc9a-17a6a08b019b'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc23fc79-a004-472d-ad1d-f9248a5118ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:842500de-ac7f-40fc-b864-66d17eb6ab64', 33, NULL, 'C단조', 'No. 33 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:842500de-ac7f-40fc-b864-66d17eb6ab64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fae103cc-9861-4a6f-820c-5a68c6223136', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:842500de-ac7f-40fc-b864-66d17eb6ab64'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fae103cc-9861-4a6f-820c-5a68c6223136'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4427fa39-c243-4b6c-81f1-7918d1bcfb0b', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:842500de-ac7f-40fc-b864-66d17eb6ab64'
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4427fa39-c243-4b6c-81f1-7918d1bcfb0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd4e9153-8558-4f1b-a562-7c176b1cab94', 34, NULL, 'A장조', 'No. 34 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd4e9153-8558-4f1b-a562-7c176b1cab94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6ffea4e-4257-48fb-a41a-30ad347f129c', 35, NULL, 'E장조', 'No. 35 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6ffea4e-4257-48fb-a41a-30ad347f129c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc959acd-dc2a-42ba-aad9-1fbd126b444b', 36, NULL, 'A장조', 'No. 36 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc959acd-dc2a-42ba-aad9-1fbd126b444b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da733cdc-9986-47c7-b01a-fa854e170e16', 37, NULL, 'A장조', 'No. 37 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 MS 84' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da733cdc-9986-47c7-b01a-fa854e170e16'
);


-- MS 85 기타 소나티나 MS 85

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 소나티나 MS 85', '5 Sonatinas for Guitar, MS 85', 'album', NULL, 'MS', '85', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 소나티나 MS 85'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7985404-1fab-47de-9cfe-425edb4684f7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7985404-1fab-47de-9cfe-425edb4684f7'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7985404-1fab-47de-9cfe-425edb4684f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05e4a05b-dfb2-4217-9cf1-86b4a4029430', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05e4a05b-dfb2-4217-9cf1-86b4a4029430'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:356a8cde-8ea6-4e86-8f98-3cca458d53a4', 2, NULL, 'A장조', 'No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:356a8cde-8ea6-4e86-8f98-3cca458d53a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b31484e3-429f-437e-8489-1248731d95e0', 1, 'I', '[without tempo indication]', 'I. [without tempo indication]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:356a8cde-8ea6-4e86-8f98-3cca458d53a4'
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b31484e3-429f-437e-8489-1248731d95e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d910d32c-5406-4407-ba69-ee1d4b8bd916', 2, 'II', '행진곡', 'II. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:356a8cde-8ea6-4e86-8f98-3cca458d53a4'
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d910d32c-5406-4407-ba69-ee1d4b8bd916'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d86e8ab8-08ce-40ed-9135-fb1678985280', 3, 'III', 'Passo Doppio - Corrente', 'III. Passo Doppio - Corrente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:356a8cde-8ea6-4e86-8f98-3cca458d53a4'
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d86e8ab8-08ce-40ed-9135-fb1678985280'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45965e34-d741-43ea-a99e-0123bbdb0bc7', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45965e34-d741-43ea-a99e-0123bbdb0bc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3aca97f-4431-42a6-b2da-6126e6c2b0a3', 4, NULL, 'C장조', 'No. 4 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3aca97f-4431-42a6-b2da-6126e6c2b0a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b179137b-efd9-458c-bb56-82f66f227759', 5, NULL, 'C장조', 'No. 5 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b179137b-efd9-458c-bb56-82f66f227759'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8a6e539-5bd0-4036-b1e1-defaa269bba2', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b179137b-efd9-458c-bb56-82f66f227759'
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8a6e539-5bd0-4036-b1e1-defaa269bba2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c8fb6803-d750-44fc-a73a-40674b92965e', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b179137b-efd9-458c-bb56-82f66f227759'
WHERE p.composer_id = 35 AND p.title = '기타 소나티나 MS 85' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8fb6803-d750-44fc-a73a-40674b92965e'
);


-- MS 86 알레그레토 A장조 MS 86

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 A장조 MS 86', 'Allegretto in A major, MS 86', 'song', NULL, 'MS', '86', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 A장조 MS 86'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b605ddd3-999e-47e5-bdef-6eb57cad175f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b605ddd3-999e-47e5-bdef-6eb57cad175f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '알레그레토 A장조 MS 86' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b605ddd3-999e-47e5-bdef-6eb57cad175f'
);


-- MS 87 기타 소나타 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 소나타 E장조', 'Guitar Sonata in E major', 'album', 'MS 87', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 소나타 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4daa829b-cb8e-4284-ace5-ca13123b5b9f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4daa829b-cb8e-4284-ace5-ca13123b5b9f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4daa829b-cb8e-4284-ace5-ca13123b5b9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6edba0bc-83da-488f-95bd-3b63f9eacd3e', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6edba0bc-83da-488f-95bd-3b63f9eacd3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3028dc86-4c16-4ee7-bdf1-7c38126a2505', 2, 'II', '론도. Allegro', 'II. Rondò - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3028dc86-4c16-4ee7-bdf1-7c38126a2505'
);


-- MS 88 안단티노 G장조 MS 88

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 G장조 MS 88', 'Andantino in G major, MS 88', 'song', NULL, 'MS', '88', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 G장조 MS 88'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3bef72f6-bcd7-43b0-b8e8-12601a636855'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3bef72f6-bcd7-43b0-b8e8-12601a636855'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '안단티노 G장조 MS 88' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3bef72f6-bcd7-43b0-b8e8-12601a636855'
);


-- MS 89 안단티노 C장조 MS 89

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 C장조 MS 89', 'Andantino in C major, MS 89', 'song', NULL, 'MS', '89', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 C장조 MS 89'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6e6d386-c0c2-46ef-ac16-e7af45d86d0a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6e6d386-c0c2-46ef-ac16-e7af45d86d0a'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '안단티노 C장조 MS 89' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6e6d386-c0c2-46ef-ac16-e7af45d86d0a'
);


-- MS 90 알레그레토 A장조 MS 90

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 A장조 MS 90', 'Allegretto in A major, MS 90', 'song', NULL, 'MS', '90', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 A장조 MS 90'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5062ff4f-2268-4aaa-8200-ffad69b7f681'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5062ff4f-2268-4aaa-8200-ffad69b7f681'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '알레그레토 A장조 MS 90' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5062ff4f-2268-4aaa-8200-ffad69b7f681'
);


-- MS 91 알레그레토 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 A단조', 'Allegretto in A minor', 'song', 'MS 91', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a51e066-4bb5-471a-9184-5108b4e25626'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a51e066-4bb5-471a-9184-5108b4e25626'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '알레그레토 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a51e066-4bb5-471a-9184-5108b4e25626'
);


-- MS 92 왈츠 C장조 MS 92

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 C장조 MS 92', 'Valtz in C major, MS 92', 'song', NULL, 'MS', '92', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 C장조 MS 92'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9547d77d-9878-46cf-a9a5-1c6ef9481806'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9547d77d-9878-46cf-a9a5-1c6ef9481806'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '왈츠 C장조 MS 92' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9547d77d-9878-46cf-a9a5-1c6ef9481806'
);


-- MS 93 론도 A단조 (기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 A단조 (기타)', 'Rondo in A minor for Guitar', 'song', 'MS 93', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 A단조 (기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd02e8f3d-2097-4859-96b5-cfda8404865e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd02e8f3d-2097-4859-96b5-cfda8404865e'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '론도 A단조 (기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd02e8f3d-2097-4859-96b5-cfda8404865e'
);


-- MS 94 론돈치노 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론돈치노 E장조', 'Rondoncino in E major', 'song', 'MS 94', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론돈치노 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d2fdc2b-509b-4bfc-b97b-ad73a2f40e9b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6d2fdc2b-509b-4bfc-b97b-ad73a2f40e9b'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '론돈치노 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6d2fdc2b-509b-4bfc-b97b-ad73a2f40e9b'
);


-- MS 95 알레그레토 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 C장조', 'Allegretto in C major', 'song', 'MS 95', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '974543a4-844e-4995-97da-ce7bde80f341'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '974543a4-844e-4995-97da-ce7bde80f341'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '알레그레토 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '974543a4-844e-4995-97da-ce7bde80f341'
);


-- MS 96 왈츠 E장조 (기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 E장조 (기타)', 'Valtz in E major for Guitar', 'song', 'MS 96', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 E장조 (기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1739b86-d38f-4dc7-9e94-77d15223167f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1739b86-d38f-4dc7-9e94-77d15223167f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '왈츠 E장조 (기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1739b86-d38f-4dc7-9e94-77d15223167f'
);


-- MS 97 안단티노 C장조 MS 97

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 C장조 MS 97', 'Andantino in C major, MS 97', 'song', NULL, 'MS', '97', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 C장조 MS 97'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21ce3e32-51c5-4a97-9860-7accfdf969cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21ce3e32-51c5-4a97-9860-7accfdf969cc'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '안단티노 C장조 MS 97' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21ce3e32-51c5-4a97-9860-7accfdf969cc'
);


-- MS 98 <로도비시아 교향곡> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<로도비시아 교향곡> D장조', 'Sinfonia della Lodovisia in D major', 'song', 'MS 98', NULL, NULL, 1800, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<로도비시아 교향곡> D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7291a84d-edbd-4166-9c69-68606ddd79da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7291a84d-edbd-4166-9c69-68606ddd79da'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<로도비시아 교향곡> D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7291a84d-edbd-4166-9c69-68606ddd79da'
);


-- MS 99 안단티노 G장조 MS 99

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 G장조 MS 99', 'Andantino in G major, MS 99', 'song', NULL, 'MS', '99', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 G장조 MS 99'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '957b9b82-3ade-426f-a8e7-31f73da5e31e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '957b9b82-3ade-426f-a8e7-31f73da5e31e'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '안단티노 G장조 MS 99' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '957b9b82-3ade-426f-a8e7-31f73da5e31e'
);


-- MS 100 왈츠 C장조 MS 100

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 C장조 MS 100', 'Valtz in C major, MS 100', 'song', NULL, 'MS', '100', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 C장조 MS 100'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ddb11662-d97b-4910-a104-0737ac8c3b11'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ddb11662-d97b-4910-a104-0737ac8c3b11'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '왈츠 C장조 MS 100' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ddb11662-d97b-4910-a104-0737ac8c3b11'
);


-- MS 101 트리오 F장조 (기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 F장조 (기타)', 'Trio in F major for Guitar', 'song', 'MS 101', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 F장조 (기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdebace5-b1a9-4e61-9bfe-c77ea25f2b34'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdebace5-b1a9-4e61-9bfe-c77ea25f2b34'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '트리오 F장조 (기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdebace5-b1a9-4e61-9bfe-c77ea25f2b34'
);


-- MS 102 안단티노 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단티노 F단조', 'Andantino in F minor', 'song', 'MS 102', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단티노 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74b43172-152f-407e-87e3-83b8226c6340'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '74b43172-152f-407e-87e3-83b8226c6340'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '안단티노 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '74b43172-152f-407e-87e3-83b8226c6340'
);


-- MS 103 행진곡 A장조 (기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 A장조 (기타)', 'Marcia in A major for Guitar', 'song', 'MS 103', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 A장조 (기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0003e5bf-de5d-4e15-ba91-329cc1c5dc9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0003e5bf-de5d-4e15-ba91-329cc1c5dc9c'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '행진곡 A장조 (기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0003e5bf-de5d-4e15-ba91-329cc1c5dc9c'
);


-- MS 104 기타 소나타 A장조 "Che va chiamando Dida"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '기타 소나타 A장조 "Che va chiamando Dida"', 'Sonata "Che va chiamando Dida" in A major', 'album', 'MS 104', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '기타 소나타 A장조 "Che va chiamando Dida"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31a1f947-3a85-45fb-aa27-3846a0367273'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31a1f947-3a85-45fb-aa27-3846a0367273'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 A장조 "Che va chiamando Dida"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31a1f947-3a85-45fb-aa27-3846a0367273'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c43fd0f-0a54-44f4-9355-1e62a4cf066f', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 A장조 "Che va chiamando Dida"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c43fd0f-0a54-44f4-9355-1e62a4cf066f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e550d99-0530-4147-952c-a0311c76eff6', 2, 'II', 'Perigordino con due variazioni', 'II. Perigordino con due variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '기타 소나타 A장조 "Che va chiamando Dida"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e550d99-0530-4147-952c-a0311c76eff6'
);


-- MS 105 마르치알레 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '마르치알레 E장조', 'Marziale in E major', 'song', 'MS 105', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '마르치알레 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b88562fa-d679-4108-ba5e-952a8a409b96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b88562fa-d679-4108-ba5e-952a8a409b96'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '마르치알레 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b88562fa-d679-4108-ba5e-952a8a409b96'
);


-- MS 106 만돌린을 위한 미뉴에트 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '만돌린을 위한 미뉴에트 E장조', 'Minuetto per l''amandorlino in E major', 'song', 'MS 106', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '만돌린을 위한 미뉴에트 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '612bac34-f5bc-44df-9533-4e610387dc8b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '612bac34-f5bc-44df-9533-4e610387dc8b'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '만돌린을 위한 미뉴에트 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '612bac34-f5bc-44df-9533-4e610387dc8b'
);


-- MS 107 바이올린과 첼로를 위한 2중주 MS 107

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 첼로를 위한 2중주 MS 107', '3 Concertante Duets for Violin and Cello, MS 107', 'album', NULL, 'MS', '107', 1802, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 첼로를 위한 2중주 MS 107'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f40df6f-feba-425c-b776-73e29675a40a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5f40df6f-feba-425c-b776-73e29675a40a'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5f40df6f-feba-425c-b776-73e29675a40a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb082b78-bbe2-4b6a-8621-021547b5edb1', 1, NULL, 'E♭장조', 'No. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb082b78-bbe2-4b6a-8621-021547b5edb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2888e4cc-1cb3-49d6-97d7-cbe2029f038c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb082b78-bbe2-4b6a-8621-021547b5edb1'
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2888e4cc-1cb3-49d6-97d7-cbe2029f038c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9032f67-7427-4978-afe4-ca9eb9da2ce9', 2, 'II', '론도. Allegretto', 'II. Rondò - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fb082b78-bbe2-4b6a-8621-021547b5edb1'
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9032f67-7427-4978-afe4-ca9eb9da2ce9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa43570a-b137-411d-936a-9abe85b1f9e5', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa43570a-b137-411d-936a-9abe85b1f9e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aad31227-3d5c-45ec-8c23-ab35ae3b21c4', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fa43570a-b137-411d-936a-9abe85b1f9e5'
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aad31227-3d5c-45ec-8c23-ab35ae3b21c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c87a1ca-46aa-4832-b1ea-9c091cb861ef', 2, 'II', '론도. Presto', 'II. Rondò - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fa43570a-b137-411d-936a-9abe85b1f9e5'
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c87a1ca-46aa-4832-b1ea-9c091cb861ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f6559ca-6d0d-4fd6-a6e3-a274a5dd554e', 3, NULL, 'A장조', 'No. 3 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f6559ca-6d0d-4fd6-a6e3-a274a5dd554e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad1a322e-0c13-45f2-bb0d-73d64307372f', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6f6559ca-6d0d-4fd6-a6e3-a274a5dd554e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad1a322e-0c13-45f2-bb0d-73d64307372f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3b111d78-6e35-4900-bfc5-270f93417876', 2, 'II', '폴로네즈. Andantino con brio', 'II. Polonese - Andantino con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6f6559ca-6d0d-4fd6-a6e3-a274a5dd554e'
WHERE p.composer_id = 35 AND p.title = '바이올린과 첼로를 위한 2중주 MS 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b111d78-6e35-4900-bfc5-270f93417876'
);


-- MS 108 바이올린과 비올라를 위한 소나타 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 비올라를 위한 소나타 C장조', 'Sonata for Violin and Viola in C major', 'album', 'MS 108', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 비올라를 위한 소나타 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd47b0db0-09cc-458b-83fa-20f9c33b06e3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd47b0db0-09cc-458b-83fa-20f9c33b06e3'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 비올라를 위한 소나타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd47b0db0-09cc-458b-83fa-20f9c33b06e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffdc1801-c52e-4006-9bad-1c2f6368217e', 1, 'I', 'Adagio non tanto', 'I. Adagio non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 비올라를 위한 소나타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffdc1801-c52e-4006-9bad-1c2f6368217e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f6457a3-7700-44ae-b5ec-0f691555e05c', 2, 'II', 'Andantino con moto', 'II. Andantino con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 비올라를 위한 소나타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f6457a3-7700-44ae-b5ec-0f691555e05c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:784e7e38-e63a-4f4e-8253-2e1630c8dc91', 3, 'III', 'Larghetto', 'III. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 비올라를 위한 소나타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:784e7e38-e63a-4f4e-8253-2e1630c8dc91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a8548fb-e594-44ca-93b4-87efeca6425a', 4, 'IV', 'Allegretto', 'IV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 비올라를 위한 소나타 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a8548fb-e594-44ca-93b4-87efeca6425a'
);


-- MS 109 칸타빌레 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타빌레 D장조', 'Cantabile in D major', 'song', 'MS 109', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타빌레 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1300f691-88cf-34e4-9a7c-9e4fd3119889'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1300f691-88cf-34e4-9a7c-9e4fd3119889'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '칸타빌레 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1300f691-88cf-34e4-9a7c-9e4fd3119889'
);


-- MS 110 바이올린과 기타를 위한 2중주 MS 110

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 2중주 MS 110', '6 Duets for Violin and Guitar, MS 110', 'album', NULL, 'MS', '110', NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 2중주 MS 110'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c23e940-19f7-4550-b979-d8e68e43264b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c23e940-19f7-4550-b979-d8e68e43264b'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c23e940-19f7-4550-b979-d8e68e43264b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c637499-0c2a-40fc-a810-71462ae7fbc9', 1, NULL, 'E단조', 'No. 1 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c637499-0c2a-40fc-a810-71462ae7fbc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96e6d9b5-fb98-42af-b441-f014fe012437', 1, 'I', 'Amoroso espressivo', 'I. Amoroso espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c637499-0c2a-40fc-a810-71462ae7fbc9'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96e6d9b5-fb98-42af-b441-f014fe012437'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05115e1c-bdc9-4fd9-bf4c-4f9ac9b696a8', 2, 'II', 'Andantino scherzando', 'II. Andantino scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c637499-0c2a-40fc-a810-71462ae7fbc9'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05115e1c-bdc9-4fd9-bf4c-4f9ac9b696a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c0b4c16-8112-4fc1-b56f-36f54cbb5045', 2, NULL, 'A장조', 'No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c0b4c16-8112-4fc1-b56f-36f54cbb5045'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96fc22e9-c56d-46f3-9b88-1d741befae0d', 1, 'I', '칸타빌레. Con anima', 'I. Cantabile, con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c0b4c16-8112-4fc1-b56f-36f54cbb5045'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96fc22e9-c56d-46f3-9b88-1d741befae0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c38ac11-5f74-4f04-98f1-511331bcf3db', 2, 'II', '론도 brillante', 'II. Rondò brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6c0b4c16-8112-4fc1-b56f-36f54cbb5045'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c38ac11-5f74-4f04-98f1-511331bcf3db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cb1376d-779f-41be-8446-085492c36043', 3, NULL, 'A단조', 'No. 3 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cb1376d-779f-41be-8446-085492c36043'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17928fac-73e9-45da-a75b-832993ca5187', 1, 'I', '로망스. Larghetto amabile', 'I. Romance - Larghetto amabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5cb1376d-779f-41be-8446-085492c36043'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17928fac-73e9-45da-a75b-832993ca5187'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b135fa6-004e-423d-8bd3-eefdfa3203fc', 2, 'II', '폴로네즈. Mosso', 'II. Polonese - Mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5cb1376d-779f-41be-8446-085492c36043'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b135fa6-004e-423d-8bd3-eefdfa3203fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae685bbe-687c-4b07-90fa-3e5caa447e46', 4, NULL, 'F장조', 'No. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae685bbe-687c-4b07-90fa-3e5caa447e46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71c9ca94-95f3-46cb-992f-80c7763206dd', 1, 'I', 'Placidamente, con grazia', 'I. Placidamente, con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae685bbe-687c-4b07-90fa-3e5caa447e46'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71c9ca94-95f3-46cb-992f-80c7763206dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:398c2da1-2e54-447e-81e9-5c10f0ad1b38', 2, 'II', 'Andantino trescando', 'II. Andantino trescando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ae685bbe-687c-4b07-90fa-3e5caa447e46'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398c2da1-2e54-447e-81e9-5c10f0ad1b38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08f75dee-8308-4310-ac99-87d06203e5c6', 5, NULL, 'D단조', 'No. 5 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08f75dee-8308-4310-ac99-87d06203e5c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0112a0f5-e372-4ea9-a0b0-2d689ef1fc96', 1, 'I', 'Andante sostenuto, con aspirazione', 'I. Andante sostenuto, con aspirazione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08f75dee-8308-4310-ac99-87d06203e5c6'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0112a0f5-e372-4ea9-a0b0-2d689ef1fc96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e19ba23b-e269-44ff-be28-fa206de4bb79', 2, 'II', 'Allegretto spiritoso, con energia', 'II. Allegretto spiritoso, con energia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:08f75dee-8308-4310-ac99-87d06203e5c6'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e19ba23b-e269-44ff-be28-fa206de4bb79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90a87b28-0c64-43ae-b955-78de3d26cb4c', 6, NULL, 'G장조', 'No. 6 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90a87b28-0c64-43ae-b955-78de3d26cb4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9cfe4d4f-f5d5-4293-a183-b62821b16865', 1, 'I', '칸타빌레 pacificamente', 'I. Cantabile pacificamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:90a87b28-0c64-43ae-b955-78de3d26cb4c'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cfe4d4f-f5d5-4293-a183-b62821b16865'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bdb8c99-81b0-4ae6-9df8-e5121203c89d', 2, 'II', '론도. Quasi allegro, placidamente', 'II. Rondò - Quasi allegro, placidamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:90a87b28-0c64-43ae-b955-78de3d26cb4c'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 2중주 MS 110' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bdb8c99-81b0-4ae6-9df8-e5121203c89d'
);


-- MS 111 <사랑의 2중주> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<사랑의 2중주> C장조', 'Duetto amoroso in C major', 'album', 'MS 111', NULL, NULL, 1807, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<사랑의 2중주> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fea37fbd-67af-477b-8d31-3889df2248f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fea37fbd-67af-477b-8d31-3889df2248f5'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fea37fbd-67af-477b-8d31-3889df2248f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8482585a-7db1-403b-b861-6a171833ccb6', 1, 'I', 'Principio - Allegretto', 'I. Principio - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8482585a-7db1-403b-b861-6a171833ccb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d77bd1e-9184-415d-b4b2-76703b670ff7', 2, 'II', 'Preghiera - Andante', 'II. Preghiera - Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d77bd1e-9184-415d-b4b2-76703b670ff7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a409414-054c-4ea8-90c2-b387f57546ac', 3, 'III', 'Acconsentito - Allegretto', 'III. Acconsentito - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a409414-054c-4ea8-90c2-b387f57546ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f0483a6-c68e-4af5-8e52-958b8d1caf3b', 4, 'IV', 'Timidezza - Allegro', 'IV. Timidezza - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f0483a6-c68e-4af5-8e52-958b8d1caf3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56554da1-ade1-49da-a9a1-298d027ea627', 5, 'V', 'Contentezza - Andantino', 'V. Contentezza - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56554da1-ade1-49da-a9a1-298d027ea627'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f705833a-0579-4439-bbc7-625cce8bebbb', 6, 'VI', 'Lite - Allegro assai', 'VI. Lite - Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f705833a-0579-4439-bbc7-625cce8bebbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:233a6167-e292-4da9-a3e0-426abe4f1784', 7, 'VII', 'Pace - Comodo', 'VII. Pace - Comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:233a6167-e292-4da9-a3e0-426abe4f1784'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45d4782c-47cd-4251-b1d7-f32b5afe18f3', 8, 'VIII', 'Segnali d''amore - Allegretto', 'VIII. Segnali d''amore - Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45d4782c-47cd-4251-b1d7-f32b5afe18f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:950db7c3-9d78-47b2-9baf-391099caa12f', 9, 'IX', 'Notizia della partenza - Allegro moderato', 'IX. Notizia della partenza - Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:950db7c3-9d78-47b2-9baf-391099caa12f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3aaeb356-c207-4963-a384-59582ae17f83', 10, 'X', 'Distacco - Allegro', 'X. Distacco - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<사랑의 2중주> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aaeb356-c207-4963-a384-59582ae17f83'
);


-- MS 112 <첸토네 디 소나테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<첸토네 디 소나테>', 'Centone di sonate, 18 Sonatas for Violin and Guitar', 'album', 'MS 112', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<첸토네 디 소나테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50a7a3bf-19e9-40c9-bf3d-f09b8943446d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50a7a3bf-19e9-40c9-bf3d-f09b8943446d'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50a7a3bf-19e9-40c9-bf3d-f09b8943446d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6d13e6b-5042-4610-9ea4-2c92b3e4fe33', 1, NULL, 'A단조', 'No. 1 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6d13e6b-5042-4610-9ea4-2c92b3e4fe33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dbb5de82-1f34-3707-a88c-99accd55104f', 1, 'I', '서주. Larghetto', 'I. Introduzione - Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6d13e6b-5042-4610-9ea4-2c92b3e4fe33'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbb5de82-1f34-3707-a88c-99accd55104f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67c60c9e-183c-478e-a35d-cbf4b51bcc56', 2, 'II', 'Allegro maestoso - Tempo di marcia', 'II. Allegro maestoso - Tempo di marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6d13e6b-5042-4610-9ea4-2c92b3e4fe33'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67c60c9e-183c-478e-a35d-cbf4b51bcc56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fdce5be9-8fe9-46d3-883e-af691db4aad2', 3, 'III', '론돈치노. Allegro. Trio', 'III. Rondoncino - Allegro. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6d13e6b-5042-4610-9ea4-2c92b3e4fe33'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdce5be9-8fe9-46d3-883e-af691db4aad2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f7b0d72-380f-41cf-bea2-13b2324e3082', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f7b0d72-380f-41cf-bea2-13b2324e3082'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b36b4f57-b18a-3bb8-b35c-4686b2c9457c', 1, 'I', 'Adagio cantabile', 'I. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f7b0d72-380f-41cf-bea2-13b2324e3082'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b36b4f57-b18a-3bb8-b35c-4686b2c9457c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38c348dc-7bf9-3212-9660-c6cd1db20a63', 2, 'II', '론돈치노. Andantino, Tempo di Polacca', 'II. Rondoncino - Andantino, Tempo di Polacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9f7b0d72-380f-41cf-bea2-13b2324e3082'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38c348dc-7bf9-3212-9660-c6cd1db20a63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc1ecf62-8c62-4b17-ac18-bab4b616ac2d', 3, NULL, 'C장조', 'No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc1ecf62-8c62-4b17-ac18-bab4b616ac2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7921760-4330-4c66-86ea-8d9278eb3cc2', 1, 'I', '서주. Prestissimo', 'I. Introduzione - Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1ecf62-8c62-4b17-ac18-bab4b616ac2d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7921760-4330-4c66-86ea-8d9278eb3cc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:193acc29-f544-4df7-baa0-dbb6c4a3ae9e', 2, 'II', 'Larghetto cantabile', 'II. Larghetto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc1ecf62-8c62-4b17-ac18-bab4b616ac2d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:193acc29-f544-4df7-baa0-dbb6c4a3ae9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f16c9aa-1fdb-460a-a566-1f9b6b50a7c5', 4, NULL, 'A장조', 'No. 4 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f16c9aa-1fdb-460a-a566-1f9b6b50a7c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a156c0c-3797-4b27-a1b4-65f0cff19286', 1, 'I', 'Adagio cantabile', 'I. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6f16c9aa-1fdb-460a-a566-1f9b6b50a7c5'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a156c0c-3797-4b27-a1b4-65f0cff19286'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3875e09e-1577-4264-89ff-03a302f72387', 2, 'II', '론도. Andantino, Allegretto', 'II. Rondò - Andantino, Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6f16c9aa-1fdb-460a-a566-1f9b6b50a7c5'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3875e09e-1577-4264-89ff-03a302f72387'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cd7562e-8f34-443d-a05a-cefb1fe52457', 5, NULL, 'E장조', 'No. 5 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cd7562e-8f34-443d-a05a-cefb1fe52457'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45cf3eda-d530-408a-a388-7a98851c9040', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1cd7562e-8f34-443d-a05a-cefb1fe52457'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45cf3eda-d530-408a-a388-7a98851c9040'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ddf7eec-43cc-4da3-af80-a93140d37591', 2, 'II', 'Andantino vivace con tre variazione', 'II. Andantino vivace con tre variazione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1cd7562e-8f34-443d-a05a-cefb1fe52457'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ddf7eec-43cc-4da3-af80-a93140d37591'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ca1b1ee-fa7e-425c-b618-ab3a4784db3a', 6, NULL, 'A장조', 'No. 6 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ca1b1ee-fa7e-425c-b618-ab3a4784db3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:97f076f6-0bb0-42cb-83da-8ecfbc60138e', 1, 'I', 'Larghetto cantabile', 'I. Larghetto cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ca1b1ee-fa7e-425c-b618-ab3a4784db3a'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97f076f6-0bb0-42cb-83da-8ecfbc60138e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe29959b-f353-45b6-a9e7-e70e3d470012', 2, 'II', '론도. Allegro assai. Trio', 'II. Rondò - Allegro assai. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9ca1b1ee-fa7e-425c-b618-ab3a4784db3a'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe29959b-f353-45b6-a9e7-e70e3d470012'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a244d01-821b-4970-b0f2-0abf4e58be1c', 7, NULL, 'F장조', 'No. 7 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a244d01-821b-4970-b0f2-0abf4e58be1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11e574ea-b726-44ba-a50d-5ab553a011fb', 1, 'I', 'Allegro giusto - Buonamente', 'I. Allegro giusto - Buonamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a244d01-821b-4970-b0f2-0abf4e58be1c'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11e574ea-b726-44ba-a50d-5ab553a011fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07026fb5-cf00-40d7-9268-aede53aec2a8', 2, 'II', '폴로네즈. Andantino, Allegretto. Trio', 'II. Polacca - Andantino, Allegretto. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a244d01-821b-4970-b0f2-0abf4e58be1c'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07026fb5-cf00-40d7-9268-aede53aec2a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2cae0a8-9174-4fe1-b6d8-e70712d962a2', 8, NULL, 'G장조', 'No. 8 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2cae0a8-9174-4fe1-b6d8-e70712d962a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:448fdba5-b7e6-4151-9965-d1a4ae948c62', 1, 'I', 'Andante cantabile', 'I. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2cae0a8-9174-4fe1-b6d8-e70712d962a2'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:448fdba5-b7e6-4151-9965-d1a4ae948c62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a5f5fb24-c73e-4272-ac08-9e61e529c513', 2, 'II', '론도. Allegretto. Trio', 'II. Rondò - Allegretto. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b2cae0a8-9174-4fe1-b6d8-e70712d962a2'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5f5fb24-c73e-4272-ac08-9e61e529c513'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72955a56-5417-406e-b03b-9ad2785d900f', 9, NULL, 'A장조', 'No. 9 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72955a56-5417-406e-b03b-9ad2785d900f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09935395-5696-4b01-8cbe-c234977b34c2', 1, 'I', 'Allegro maestoso - Tempo di marcia', 'I. Allegro maestoso - Tempo di marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72955a56-5417-406e-b03b-9ad2785d900f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09935395-5696-4b01-8cbe-c234977b34c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38f0b530-ade4-417e-8421-1ba5b9af67fc', 2, 'II', '주제. Andante placido', 'II. Tema - Andante placido', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72955a56-5417-406e-b03b-9ad2785d900f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38f0b530-ade4-417e-8421-1ba5b9af67fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7354dbc9-998b-478f-a92d-b6d6a8fca7b4', 3, 'III', '변주 I', 'III. Variazione I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72955a56-5417-406e-b03b-9ad2785d900f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7354dbc9-998b-478f-a92d-b6d6a8fca7b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f093c8fc-a4c0-4ea8-b846-0bf688374d39', 4, 'IV', '변주 II', 'IV. Variazione II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72955a56-5417-406e-b03b-9ad2785d900f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f093c8fc-a4c0-4ea8-b846-0bf688374d39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70ee9bfb-e579-4460-b23e-d75223132384', 5, 'V', '변주 III. Più mosso', 'V. Variazione III - Più mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:72955a56-5417-406e-b03b-9ad2785d900f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70ee9bfb-e579-4460-b23e-d75223132384'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2717fe52-f596-4138-abe6-9044dc95b2df', 10, NULL, 'C장조', 'No. 10 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2717fe52-f596-4138-abe6-9044dc95b2df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2711fc6c-1377-4410-b270-07632c91bfc3', 1, 'I', 'Allegro risoluto', 'I. Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2717fe52-f596-4138-abe6-9044dc95b2df'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2711fc6c-1377-4410-b270-07632c91bfc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49dbf709-9f23-4081-8504-c2233e92cda7', 2, 'II', '론도. Andantino vivace, Tempo di Pastorale. Trio', 'II. Rondò - Andantino vivace, Tempo di Pastorale. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2717fe52-f596-4138-abe6-9044dc95b2df'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49dbf709-9f23-4081-8504-c2233e92cda7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:749b0ba0-5722-4a91-8b45-c0b519ab6e0d', 11, NULL, 'A단조', 'No. 11 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:749b0ba0-5722-4a91-8b45-c0b519ab6e0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d4ee232-e6b7-4d80-a673-838c93acd895', 1, 'I', '칸타빌레. Andante appassionato, con flessibilità', 'I. Cantabile - Andante appassionato, con flessibilità', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:749b0ba0-5722-4a91-8b45-c0b519ab6e0d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d4ee232-e6b7-4d80-a673-838c93acd895'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:431cd876-3ded-47c6-82b9-27ab2e9e6ac4', 2, 'II', '주제. Allegro moderato', 'II. Tema - Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:749b0ba0-5722-4a91-8b45-c0b519ab6e0d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:431cd876-3ded-47c6-82b9-27ab2e9e6ac4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d5969ce1-38a0-4b2f-a5ec-a30500aad850', 3, 'III', '변주 I', 'III. Variazione I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:749b0ba0-5722-4a91-8b45-c0b519ab6e0d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5969ce1-38a0-4b2f-a5ec-a30500aad850'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a53085da-f12e-4958-b437-7007d1683d34', 4, 'IV', '변주 II. Minore', 'IV. Variazione II. Minore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:749b0ba0-5722-4a91-8b45-c0b519ab6e0d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a53085da-f12e-4958-b437-7007d1683d34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2347bb37-d550-4a8f-9786-6c663f44e82d', 5, 'V', '피날레. Tempo di Valtz', 'V. Finale - Tempo di Valtz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:749b0ba0-5722-4a91-8b45-c0b519ab6e0d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2347bb37-d550-4a8f-9786-6c663f44e82d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:315c77c6-cfdd-4173-9c6e-95b3cb255372', 12, NULL, 'D장조', 'No. 12 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:315c77c6-cfdd-4173-9c6e-95b3cb255372'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0f89a99-c0cd-4327-88fc-ad07b8a427d0', 1, 'I', 'Andante cantabile', 'I. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:315c77c6-cfdd-4173-9c6e-95b3cb255372'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0f89a99-c0cd-4327-88fc-ad07b8a427d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67e669be-a8ce-4906-9232-bbe62083750b', 2, 'II', '론도. Allegretto. Trio', 'II. Rondò - Allegretto. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:315c77c6-cfdd-4173-9c6e-95b3cb255372'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67e669be-a8ce-4906-9232-bbe62083750b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4790b368-ad0f-4b59-8466-e5927cd088c5', 13, NULL, 'E장조', 'No. 13 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4790b368-ad0f-4b59-8466-e5927cd088c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f6c520a-e91a-404d-9f51-41ff9a05f79b', 1, 'I', '서주. Maestoso', 'I. Introduzione - Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4790b368-ad0f-4b59-8466-e5927cd088c5'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f6c520a-e91a-404d-9f51-41ff9a05f79b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ffabf5d-5d02-4fa5-b23b-13c6159da619', 2, 'II', 'Larghetto - Cantabile', 'II. Larghetto - Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4790b368-ad0f-4b59-8466-e5927cd088c5'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ffabf5d-5d02-4fa5-b23b-13c6159da619'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b22e01a3-7f0f-498d-afff-01daca58fc2e', 3, 'III', '론도. Allegretto - Con Brio. Trio', 'III. Rondò Allegretto - Con Brio. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4790b368-ad0f-4b59-8466-e5927cd088c5'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b22e01a3-7f0f-498d-afff-01daca58fc2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45d32a6c-ce35-4f75-8595-a3d864e6b94f', 14, NULL, 'G장조', 'No. 14 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45d32a6c-ce35-4f75-8595-a3d864e6b94f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:02233546-b500-455c-8ab9-2672d2f8e2fa', 1, 'I', 'Andante Adagetto', 'I. Andante Adagetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:45d32a6c-ce35-4f75-8595-a3d864e6b94f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02233546-b500-455c-8ab9-2672d2f8e2fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37c8d1c0-0468-439b-a140-c57ef3c9257b', 2, 'II', '론도. Allegro molto vivace. Trio', 'II. Rondò - Allegro molto vivace. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:45d32a6c-ce35-4f75-8595-a3d864e6b94f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37c8d1c0-0468-439b-a140-c57ef3c9257b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2434ea2a-8653-44af-87e5-b24a3e80db6d', 15, NULL, 'A장조', 'No. 15 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2434ea2a-8653-44af-87e5-b24a3e80db6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:797a614b-29e7-4b8c-95c4-a8f3dab28699', 1, 'I', '서주. Maestoso', 'I. Introduzione - Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2434ea2a-8653-44af-87e5-b24a3e80db6d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:797a614b-29e7-4b8c-95c4-a8f3dab28699'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a0124e1-3cec-4efe-82c7-abb72b89e98a', 2, 'II', '주제. Andante moderato', 'II. Tema - Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2434ea2a-8653-44af-87e5-b24a3e80db6d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a0124e1-3cec-4efe-82c7-abb72b89e98a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aed3ad12-7007-4360-abdf-71ee389bc7d4', 3, 'III', '변주 I', 'III. Variazione I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2434ea2a-8653-44af-87e5-b24a3e80db6d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aed3ad12-7007-4360-abdf-71ee389bc7d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b09f50f5-e9e2-45a6-b534-8c949a569c1c', 4, 'IV', '변주 II. Minore', 'IV. Variazione II - Minore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2434ea2a-8653-44af-87e5-b24a3e80db6d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b09f50f5-e9e2-45a6-b534-8c949a569c1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e013fef9-60b6-4a75-8048-1de4c692a06d', 5, 'V', '변주 III. Maggiore', 'V. Variazione III - Maggiore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2434ea2a-8653-44af-87e5-b24a3e80db6d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e013fef9-60b6-4a75-8048-1de4c692a06d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:04654059-5beb-4604-a62b-1227fb074dee', 6, 'VI', '론도. Allegretto. Trio. Maggiore', 'VI. Rondò - Allegretto. Trio. Maggiore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2434ea2a-8653-44af-87e5-b24a3e80db6d'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04654059-5beb-4604-a62b-1227fb074dee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d78dc9e-7cae-422e-ae65-20663dcba8fc', 16, NULL, 'E장조', 'No. 16 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d78dc9e-7cae-422e-ae65-20663dcba8fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f76f5dcc-fa82-4165-8f08-7128365ed35c', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d78dc9e-7cae-422e-ae65-20663dcba8fc'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f76f5dcc-fa82-4165-8f08-7128365ed35c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:427f5956-e3cb-42b5-802a-7de5a54a6a7d', 2, 'II', '왈츠풍 미뉴에트. Allegro vivo. Trio', 'II. Minuetto a Valtz - Allegro vivo. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d78dc9e-7cae-422e-ae65-20663dcba8fc'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:427f5956-e3cb-42b5-802a-7de5a54a6a7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3da04f4-c6e3-4638-8c98-a9551c16754f', 17, NULL, 'A장조', 'No. 17 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3da04f4-c6e3-4638-8c98-a9551c16754f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee54a808-a284-4d08-a532-b178f3a5ec61', 1, 'I', '서주. Andante, Corrente', 'I. Introduzione - Andante, Corrente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b3da04f4-c6e3-4638-8c98-a9551c16754f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee54a808-a284-4d08-a532-b178f3a5ec61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:890f6a60-6c2d-4404-98bd-91e89724052e', 2, 'II', 'Andante - Cantabile', 'II. Andante - Cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b3da04f4-c6e3-4638-8c98-a9551c16754f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:890f6a60-6c2d-4404-98bd-91e89724052e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:af29b407-ab78-4e21-8331-6fd2e3e8d75a', 3, 'III', '론도. Allegro vivo. Trio', 'III. Rondò - Allegro vivo. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b3da04f4-c6e3-4638-8c98-a9551c16754f'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af29b407-ab78-4e21-8331-6fd2e3e8d75a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e11ab2ea-c0e5-4657-869f-e30aab81a424', 18, NULL, 'C장조', 'No. 18 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e11ab2ea-c0e5-4657-869f-e30aab81a424'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5deb82f3-7bf3-4ed3-8f4a-6bb2532f2b44', 1, 'I', 'Allegro - Presto', 'I. Allegro - Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e11ab2ea-c0e5-4657-869f-e30aab81a424'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5deb82f3-7bf3-4ed3-8f4a-6bb2532f2b44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60a1f151-2a30-4a74-b336-29bc2d60f9d2', 2, 'II', '론도. Balletto - Allegro vivissimo. Trio', 'II. Rondò, Balletto - Allegro vivissimo. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e11ab2ea-c0e5-4657-869f-e30aab81a424'
WHERE p.composer_id = 35 AND p.title = '<첸토네 디 소나테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60a1f151-2a30-4a74-b336-29bc2d60f9d2'
);


-- MS 113 <3개의 리토르넬로>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<3개의 리토르넬로>', '3 Ritornelli for Two Violins and Bass', 'album', 'MS 113', NULL, NULL, 1800, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<3개의 리토르넬로>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d48af0f-9e12-4c25-8dd3-69d3762749d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d48af0f-9e12-4c25-8dd3-69d3762749d2'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<3개의 리토르넬로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d48af0f-9e12-4c25-8dd3-69d3762749d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:138a3203-49ed-46dc-aa35-0ad291ae2150', 1, NULL, 'A장조', 'No. 1 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<3개의 리토르넬로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:138a3203-49ed-46dc-aa35-0ad291ae2150'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5574251b-7248-4eec-965f-8fc9f3ec1656', 2, NULL, 'C단조', 'No. 2 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<3개의 리토르넬로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5574251b-7248-4eec-965f-8fc9f3ec1656'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef7e3875-768a-4e25-88a2-17754ef1f751', 3, NULL, 'C장조', 'No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<3개의 리토르넬로>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef7e3875-768a-4e25-88a2-17754ef1f751'
);


-- MS 114 협주풍 3중주 D장조 (비올라, 첼로, 기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '협주풍 3중주 D장조 (비올라, 첼로, 기타)', 'Terzetto concertante in D major for Viola, Cello and Guitar', 'album', 'MS 114', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '협주풍 3중주 D장조 (비올라, 첼로, 기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '898a2722-c4a6-4b34-9681-052aa36abe75'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '898a2722-c4a6-4b34-9681-052aa36abe75'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '협주풍 3중주 D장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '898a2722-c4a6-4b34-9681-052aa36abe75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ace16ce6-c962-46c0-a1e1-8124ea5fbc9d', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '협주풍 3중주 D장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ace16ce6-c962-46c0-a1e1-8124ea5fbc9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d09f1122-714d-4d2c-8a87-e9f76a2d82ba', 2, 'II', '미뉴에트. Allegro vivo', 'II. Minuetto - Allegro vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '협주풍 3중주 D장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d09f1122-714d-4d2c-8a87-e9f76a2d82ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d3ff961-8bc2-413a-b611-90bf2bd55095', 3, 'III', 'Adagio - Cantabile con cavata', 'III. Adagio - Cantabile con cavata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '협주풍 3중주 D장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d3ff961-8bc2-413a-b611-90bf2bd55095'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff704ba3-beef-4ba2-88ca-da35d7397570', 4, 'IV', '론도풍 왈츠. Allegretto con energia', 'IV. Valtz a Rondò - Allegretto con energia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '협주풍 3중주 D장조 (비올라, 첼로, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff704ba3-beef-4ba2-88ca-da35d7397570'
);


-- MS 115 세레나타 F장조 (바이올린 2, 기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나타 F장조 (바이올린 2, 기타)', 'Serenata in F major for Two Violins and Guitar', 'album', 'MS 115', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나타 F장조 (바이올린 2, 기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd7fd4e5-c516-4e79-8db2-398cfdc25564'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd7fd4e5-c516-4e79-8db2-398cfdc25564'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 F장조 (바이올린 2, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd7fd4e5-c516-4e79-8db2-398cfdc25564'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:865b8470-fe78-46ff-b9a4-a6f4c5e59bc3', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 F장조 (바이올린 2, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:865b8470-fe78-46ff-b9a4-a6f4c5e59bc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59269108-f8bb-4576-a22b-775a940eb3a0', 2, 'II', '미뉴에트. Amoroso', 'II. Minuetto - Amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 F장조 (바이올린 2, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59269108-f8bb-4576-a22b-775a940eb3a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90e9b92c-ec60-49b3-a398-cbd920978179', 3, 'III', 'Andantino - Scherzando', 'III. Andantino - Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '세레나타 F장조 (바이올린 2, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90e9b92c-ec60-49b3-a398-cbd920978179'
);


-- MS 116 3중주 A단조 (바이올린 2, 기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중주 A단조 (바이올린 2, 기타)', 'Terzetto in A minor for Two Violins and Guitar', 'album', 'MS 116', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중주 A단조 (바이올린 2, 기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e342910-a3e7-4812-83c8-39b8760f9ff3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e342910-a3e7-4812-83c8-39b8760f9ff3'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 A단조 (바이올린 2, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e342910-a3e7-4812-83c8-39b8760f9ff3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab045771-6f1d-4120-8fdf-dc6bf5d27ac2', 1, 'I', 'Andante sostenuto', 'I. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 A단조 (바이올린 2, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab045771-6f1d-4120-8fdf-dc6bf5d27ac2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de6497f4-a14b-4e8f-a912-f7beb77820b8', 2, 'II', 'Tempo di minuetto', 'II. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 A단조 (바이올린 2, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de6497f4-a14b-4e8f-a912-f7beb77820b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96c5ad6d-548a-4b2a-80f7-14cd06c3bdfb', 3, 'III', 'Andantino - Allegro', 'III. Andantino - Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '3중주 A단조 (바이올린 2, 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96c5ad6d-548a-4b2a-80f7-14cd06c3bdfb'
);


-- MS 117 "Nel cor più non mi sento" 변주곡 A장조 (바이올린 2, 첼로)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"Nel cor più non mi sento" 변주곡 A장조 (바이올린 2, 첼로)', 'Variations on "Nel cor più non mi sento" in A major for Violin, Second Violin and Cello', 'song', 'MS 117', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"Nel cor più non mi sento" 변주곡 A장조 (바이올린 2, 첼로)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5caab94a-a457-477b-9b61-447a4efbad23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5caab94a-a457-477b-9b61-447a4efbad23'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '"Nel cor più non mi sento" 변주곡 A장조 (바이올린 2, 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5caab94a-a457-477b-9b61-447a4efbad23'
);


-- MS 118 스코르다투라 바이올린 소나타 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스코르다투라 바이올린 소나타 D장조', 'Sonata a violino scordato in D major', 'song', 'MS 118', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스코르다투라 바이올린 소나타 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3763a2c-02af-4090-b13b-a4cf4115a838'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3763a2c-02af-4090-b13b-a4cf4115a838'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '스코르다투라 바이올린 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3763a2c-02af-4090-b13b-a4cf4115a838'
);


-- MS 119 가곡 <Sul margine d'un rio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sul margine d''un rio>', 'Sul margine d''un rio', 'song', 'MS 119', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sul margine d''un rio>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7885cf6e-2931-450c-b3c8-f7f704798d41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7885cf6e-2931-450c-b3c8-f7f704798d41'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '가곡 <Sul margine d''un rio>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7885cf6e-2931-450c-b3c8-f7f704798d41'
);


-- MS 120 <Ghiribizzo vocale>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Ghiribizzo vocale>', 'Ghiribizzo vocale', 'song', 'MS 120', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Ghiribizzo vocale>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b65073b-8d9f-4d15-987c-0d1729064f06'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b65073b-8d9f-4d15-987c-0d1729064f06'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<Ghiribizzo vocale>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b65073b-8d9f-4d15-987c-0d1729064f06'
);


-- MS 122 2중주 C장조 (바이올린과 기타)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중주 C장조 (바이올린과 기타)', 'Duetto in C major for Violin and Guitar', 'album', 'MS 122', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중주 C장조 (바이올린과 기타)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97640242-4df7-4b33-aaff-9a1035ee2ed3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '97640242-4df7-4b33-aaff-9a1035ee2ed3'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '2중주 C장조 (바이올린과 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '97640242-4df7-4b33-aaff-9a1035ee2ed3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1aa1ec2-f944-4e26-b57b-7e71e5dcad82', 1, 'I', '미뉴에트', 'I. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '2중주 C장조 (바이올린과 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1aa1ec2-f944-4e26-b57b-7e71e5dcad82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c81f9027-9600-4ca1-a97a-34b9932042cd', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '2중주 C장조 (바이올린과 기타)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c81f9027-9600-4ca1-a97a-34b9932042cd'
);


-- MS 123 바이올린 협주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 D장조', 'Violin Concerto in D major', 'album', 'MS 123', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '644f2e8c-3b1a-444e-b8c0-d997a43b9b03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '644f2e8c-3b1a-444e-b8c0-d997a43b9b03'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '644f2e8c-3b1a-444e-b8c0-d997a43b9b03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ec916bf-2468-46e4-b6bf-8819fa5e4155', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ec916bf-2468-46e4-b6bf-8819fa5e4155'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c40371d-4e1b-4480-99c4-173c35f3eda4', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c40371d-4e1b-4480-99c4-173c35f3eda4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bdf2ac32-f2c2-40d2-af3d-0904bbac65d2', 3, 'III', '론도', 'III. Rondò', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bdf2ac32-f2c2-40d2-af3d-0904bbac65d2'
);


-- MS 124 바이올린과 기타를 위한 소나티나 1번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나티나 1번 A장조', 'Sonatina No. 1 in A major for Violin and Guitar', 'album', 'MS 124', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나티나 1번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd286ec6-dc21-4c37-a7ec-0862a3d5354d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bd286ec6-dc21-4c37-a7ec-0862a3d5354d'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bd286ec6-dc21-4c37-a7ec-0862a3d5354d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18f2b81d-3c51-421c-8b66-a1a1cc5e5cdd', 1, 'I', '미뉴에트. Andante cantabile', 'I. Minuetto - Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18f2b81d-3c51-421c-8b66-a1a1cc5e5cdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:813df625-3f18-4869-a2fb-93e376e71982', 2, 'II', '왈츠. Andantino', 'II. Valtz - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:813df625-3f18-4869-a2fb-93e376e71982'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:984ae22a-ea37-4010-a262-b5974a055fe6', 3, 'III', '트리오', 'III. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 1번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:984ae22a-ea37-4010-a262-b5974a055fe6'
);


-- MS 125 바이올린과 기타를 위한 소나티나 2번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나티나 2번 D장조', 'Sonatina No. 2 in D major for Violin and Guitar', 'album', 'MS 125', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나티나 2번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f03697cc-ae67-4e97-afbe-d2663b0d347f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f03697cc-ae67-4e97-afbe-d2663b0d347f'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f03697cc-ae67-4e97-afbe-d2663b0d347f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:049703fc-a80f-4900-b9de-5a3d5d0e1b47', 1, 'I', '미뉴에트. Cantabile andante un poco sostenuto', 'I. Minuetto - Cantabile andante un poco sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:049703fc-a80f-4900-b9de-5a3d5d0e1b47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:952f2c63-d2e3-4b38-b37d-38270d0863ab', 2, 'II', '왈츠. Andantino', 'II. Valtz - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:952f2c63-d2e3-4b38-b37d-38270d0863ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ba78953-4393-4000-b1c6-739effe5d00a', 3, 'III', '트리오', 'III. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ba78953-4393-4000-b1c6-739effe5d00a'
);


-- MS 126 바이올린과 기타를 위한 소나티나 3번 D장조 "칸타빌레, 미뉴에트와 왈츠"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나티나 3번 D장조 "칸타빌레, 미뉴에트와 왈츠"', 'Sonatina No. 3 in D major "Cantabile a Minuetto e Valtz"', 'album', 'MS 126', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나티나 3번 D장조 "칸타빌레, 미뉴에트와 왈츠"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3fc61c9-7dd8-4023-b528-efaad227e2cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b3fc61c9-7dd8-4023-b528-efaad227e2cf'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 3번 D장조 "칸타빌레, 미뉴에트와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b3fc61c9-7dd8-4023-b528-efaad227e2cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36be4e87-4ab8-40a4-bb6a-ef673ce20917', 1, 'I', '칸타빌레와 미뉴에트. Andante sostenuto', 'I. Cantabile e Minuetto - Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 3번 D장조 "칸타빌레, 미뉴에트와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36be4e87-4ab8-40a4-bb6a-ef673ce20917'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:359af387-62cd-437e-ad6f-9d795061169b', 2, 'II', '왈츠. Andantino', 'II. Valtz - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 3번 D장조 "칸타빌레, 미뉴에트와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:359af387-62cd-437e-ad6f-9d795061169b'
);


-- MS 127 바이올린과 기타를 위한 소나티나 4번 C장조 "칸타빌레와 왈츠"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나티나 4번 C장조 "칸타빌레와 왈츠"', 'Sonatina No. 4 in C major "Cantabile e Valtz"', 'album', 'MS 127', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나티나 4번 C장조 "칸타빌레와 왈츠"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f462f9c5-af65-47d5-94a1-5ec66acfdc38'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f462f9c5-af65-47d5-94a1-5ec66acfdc38'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 4번 C장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f462f9c5-af65-47d5-94a1-5ec66acfdc38'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:951050c3-d5dc-43dd-8521-d52ea878e574', 1, 'I', '칸타빌레. Andante moderato', 'I. Cantabile - Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 4번 C장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:951050c3-d5dc-43dd-8521-d52ea878e574'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30c58841-508d-4706-a109-2a596d2f8fea', 2, 'II', '왈츠. Andantino', 'II. Valtz - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 4번 C장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30c58841-508d-4706-a109-2a596d2f8fea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39af2941-7d37-41a8-834d-14691bb86ef5', 3, 'III', '트리오', 'III. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 4번 C장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39af2941-7d37-41a8-834d-14691bb86ef5'
);


-- MS 128 바이올린과 기타를 위한 소나티나 5번 G장조 "칸타빌레와 왈츠"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나티나 5번 G장조 "칸타빌레와 왈츠"', 'Sonatina No. 5 in G major "Cantabile e Valtz"', 'album', 'MS 128', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나티나 5번 G장조 "칸타빌레와 왈츠"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8596d2f9-742c-4fee-9da7-ab9e68ef1468'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8596d2f9-742c-4fee-9da7-ab9e68ef1468'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 5번 G장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8596d2f9-742c-4fee-9da7-ab9e68ef1468'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5308ffb-2018-4b1f-9bdf-ea57cf477659', 1, 'I', '칸타빌레. Andante sostenuto', 'I. Cantabile - Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 5번 G장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5308ffb-2018-4b1f-9bdf-ea57cf477659'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bf7afc0a-4189-472c-9d2d-bfab0d44c227', 2, 'II', '왈츠. Andantino', 'II. Valtz - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 5번 G장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bf7afc0a-4189-472c-9d2d-bfab0d44c227'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9a6a650-dfde-4c7f-a159-e7179e1799e7', 3, 'III', '트리오', 'III. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 5번 G장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9a6a650-dfde-4c7f-a159-e7179e1799e7'
);


-- MS 129 바이올린과 기타를 위한 소나티나 6번 E장조 "칸타빌레와 왈츠"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나티나 6번 E장조 "칸타빌레와 왈츠"', 'Sonatina No. 6 in E major "Cantabile e Valtz"', 'album', 'MS 129', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나티나 6번 E장조 "칸타빌레와 왈츠"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '420f9b3a-728b-42a1-ab71-5a1ba3cbe42c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '420f9b3a-728b-42a1-ab71-5a1ba3cbe42c'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 6번 E장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '420f9b3a-728b-42a1-ab71-5a1ba3cbe42c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ce62249-4ce8-4387-be31-d312a239171b', 1, 'I', 'Ombra adorata - Cantabile andante', 'I. Ombra adorata - Cantabile andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 6번 E장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ce62249-4ce8-4387-be31-d312a239171b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:138e3125-cf2b-4108-a412-4e33e9707a21', 2, 'II', '왈츠. Andantino', 'II. Valtz - Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 6번 E장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:138e3125-cf2b-4108-a412-4e33e9707a21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c524d8d6-808a-435e-b656-f86877840b05', 3, 'III', '트리오', 'III. Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나티나 6번 E장조 "칸타빌레와 왈츠"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c524d8d6-808a-435e-b656-f86877840b05'
);


-- MS 130 바이올린과 바순을 위한 2중주 MS 130

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 바순을 위한 2중주 MS 130', '3 Duets for Violin and Bassoon, MS 130', 'album', NULL, 'MS', '130', 1800, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 바순을 위한 2중주 MS 130'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5faaa7b-6e27-4a72-a1da-22cc267f387a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5faaa7b-6e27-4a72-a1da-22cc267f387a'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5faaa7b-6e27-4a72-a1da-22cc267f387a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d67d0682-f8fd-4f2f-bef1-5f5356cb11f0', 1, NULL, 'F장조', 'No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d67d0682-f8fd-4f2f-bef1-5f5356cb11f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17d03ef3-207d-4b6d-acbd-208374acb09d', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d67d0682-f8fd-4f2f-bef1-5f5356cb11f0'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17d03ef3-207d-4b6d-acbd-208374acb09d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7651061e-32b0-4ae7-9ce2-ad4e2ab0aae3', 2, 'II', '[Allegro moderato]', 'II. [Allegro moderato]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d67d0682-f8fd-4f2f-bef1-5f5356cb11f0'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7651061e-32b0-4ae7-9ce2-ad4e2ab0aae3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d924e538-a593-4c5a-afef-23b1eb1c2f4d', 3, 'III', '론도. Allegretto vivo', 'III. Rondò - Allegretto vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d67d0682-f8fd-4f2f-bef1-5f5356cb11f0'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d924e538-a593-4c5a-afef-23b1eb1c2f4d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28ca2961-7bd5-4a4b-b41e-4a9ac75663ee', 2, NULL, 'C단조', 'No. 2 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28ca2961-7bd5-4a4b-b41e-4a9ac75663ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c5c80926-9960-42b9-b640-b8f2924d7f68', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:28ca2961-7bd5-4a4b-b41e-4a9ac75663ee'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5c80926-9960-42b9-b640-b8f2924d7f68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8903fc77-bc98-46db-a2ce-93f95bcc614a', 2, 'II', 'Allegro moderato', 'II. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:28ca2961-7bd5-4a4b-b41e-4a9ac75663ee'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8903fc77-bc98-46db-a2ce-93f95bcc614a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:572525c6-b69a-4610-b061-fc1eca2c1bfb', 3, 'III', '론도', 'III. Rondò', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:28ca2961-7bd5-4a4b-b41e-4a9ac75663ee'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:572525c6-b69a-4610-b061-fc1eca2c1bfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4c745ae-be03-4cab-84c4-41be443cc9a0', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4c745ae-be03-4cab-84c4-41be443cc9a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa4dfec5-de2b-4345-8d8e-606b3507eb3d', 1, 'I', 'Allegro con brio poco scherzando', 'I. Allegro con brio poco scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a4c745ae-be03-4cab-84c4-41be443cc9a0'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa4dfec5-de2b-4345-8d8e-606b3507eb3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:477eb013-5e32-4710-96ae-afaf3ca6a4fb', 2, 'II', 'Petite Romance - Larghetto', 'II. Petite Romance - Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a4c745ae-be03-4cab-84c4-41be443cc9a0'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:477eb013-5e32-4710-96ae-afaf3ca6a4fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f33b74c9-dfc5-406c-bf85-ff0a5ad2f466', 3, 'III', 'Polacchina - Andantino con grazia', 'III. Polacchina - Andantino con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a4c745ae-be03-4cab-84c4-41be443cc9a0'
WHERE p.composer_id = 35 AND p.title = '바이올린과 바순을 위한 2중주 MS 130' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f33b74c9-dfc5-406c-bf85-ff0a5ad2f466'
);


-- MS 131 <6개의 새 알레산드리나>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<6개의 새 알레산드리나>', 'Sei nuovissime Alessandrine', 'album', 'MS 131', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<6개의 새 알레산드리나>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca023b4b-940c-4345-a5fe-3f77c22765f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca023b4b-940c-4345-a5fe-3f77c22765f6'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<6개의 새 알레산드리나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca023b4b-940c-4345-a5fe-3f77c22765f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b267353d-81ea-42ec-be66-038edc1224b2', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<6개의 새 알레산드리나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b267353d-81ea-42ec-be66-038edc1224b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40cf4243-e56f-4590-9115-50039d749375', 2, NULL, 'B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<6개의 새 알레산드리나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40cf4243-e56f-4590-9115-50039d749375'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4c6661c-5dbf-4566-a71b-5487424b8a88', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<6개의 새 알레산드리나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4c6661c-5dbf-4566-a71b-5487424b8a88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4735256b-ed00-4ef2-9e6b-1af895416192', 4, NULL, 'E♭장조', 'No. 4 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<6개의 새 알레산드리나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4735256b-ed00-4ef2-9e6b-1af895416192'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41c8497b-36a4-471d-a544-8006fc5700ab', 5, NULL, 'A장조', 'No. 5 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<6개의 새 알레산드리나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41c8497b-36a4-471d-a544-8006fc5700ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f1f65be-1a33-4fec-b945-1d4742249082', 6, NULL, 'F장조', 'No. 6 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '<6개의 새 알레산드리나>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f1f65be-1a33-4fec-b945-1d4742249082'
);


-- MS 132 변주 소나타 D장조 (바이올린, 비올라, 기타, 첼로)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '변주 소나타 D장조 (바이올린, 비올라, 기타, 첼로)', 'Sonata con variazioni in D major for Violin, Viola, Guitar and Cello', 'song', 'MS 132', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '변주 소나타 D장조 (바이올린, 비올라, 기타, 첼로)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac0ad102-2ceb-4c08-9581-a10739c7f0b5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac0ad102-2ceb-4c08-9581-a10739c7f0b5'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '변주 소나타 D장조 (바이올린, 비올라, 기타, 첼로)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac0ad102-2ceb-4c08-9581-a10739c7f0b5'
);


-- MS 133 바이올린과 기타를 위한 소나타 MS 133

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 MS 133', '6 Sonatas for Violin and Guitar, MS 133', 'album', NULL, 'MS', '133', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 MS 133'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8580db71-e1af-4559-9608-75e258eaa28c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8580db71-e1af-4559-9608-75e258eaa28c'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8580db71-e1af-4559-9608-75e258eaa28c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:27f858f5-6359-4e1e-9409-248179f9eb6d', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27f858f5-6359-4e1e-9409-248179f9eb6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dafab1a5-b3d9-48c7-92fa-f9b1bbdf4a1a', 1, 'I', 'Amoroso', 'I. Amoroso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:27f858f5-6359-4e1e-9409-248179f9eb6d'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dafab1a5-b3d9-48c7-92fa-f9b1bbdf4a1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d8047a8-3349-451a-85fe-edcb955ac04a', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:27f858f5-6359-4e1e-9409-248179f9eb6d'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d8047a8-3349-451a-85fe-edcb955ac04a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0006e8db-e72e-476f-b895-ff2bfc42bd52', 2, NULL, 'A장조', 'No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0006e8db-e72e-476f-b895-ff2bfc42bd52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6319dc8c-0786-42f8-a576-170e0700a11b', 1, 'I', 'Larghetto compassionevolmente', 'I. Larghetto compassionevolmente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0006e8db-e72e-476f-b895-ff2bfc42bd52'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6319dc8c-0786-42f8-a576-170e0700a11b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06e7f00e-8683-4e5a-8908-7c380e5f2a67', 2, 'II', 'Allegretto scherzando', 'II. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0006e8db-e72e-476f-b895-ff2bfc42bd52'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06e7f00e-8683-4e5a-8908-7c380e5f2a67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efa8fca8-eb41-442a-8b48-ae0092006e5c', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efa8fca8-eb41-442a-8b48-ae0092006e5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bb06d9c8-1fb2-4a5f-90c4-fac0ef0bfbb4', 1, 'I', 'Lento e con grazia', 'I. Lento e con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efa8fca8-eb41-442a-8b48-ae0092006e5c'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb06d9c8-1fb2-4a5f-90c4-fac0ef0bfbb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b51533c-b754-4993-88fd-fd310cafcebe', 2, 'II', 'Andantino brillante', 'II. Andantino brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:efa8fca8-eb41-442a-8b48-ae0092006e5c'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b51533c-b754-4993-88fd-fd310cafcebe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a89571d-2214-4c07-bf35-41a27eb958ce', 4, NULL, 'A장조', 'No. 4 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a89571d-2214-4c07-bf35-41a27eb958ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88f1dee6-314f-4e73-be58-1eb8673a3c6a', 1, 'I', 'Quasi andante con sentimento', 'I. Quasi andante con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9a89571d-2214-4c07-bf35-41a27eb958ce'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f1dee6-314f-4e73-be58-1eb8673a3c6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9a7791b6-59cd-482c-aa1b-104768564f71', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9a89571d-2214-4c07-bf35-41a27eb958ce'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a7791b6-59cd-482c-aa1b-104768564f71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f5d79a4-3043-49ac-b2d3-383907da1f4b', 5, NULL, 'G장조', 'No. 5 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f5d79a4-3043-49ac-b2d3-383907da1f4b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3468728-4eae-4311-bfd8-bc383065ce3d', 1, 'I', 'Con anima e trasporto', 'I. Con anima e trasporto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0f5d79a4-3043-49ac-b2d3-383907da1f4b'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3468728-4eae-4311-bfd8-bc383065ce3d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc1459c4-c93e-4b82-a0da-95ea8913f55b', 2, 'II', 'Andantino con brio', 'II. Andantino con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0f5d79a4-3043-49ac-b2d3-383907da1f4b'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc1459c4-c93e-4b82-a0da-95ea8913f55b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3306e783-8319-4a6a-a255-c46fa67c17e8', 6, NULL, 'D장조', 'No. 6 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3306e783-8319-4a6a-a255-c46fa67c17e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:baffbe98-7ad5-4322-a479-28b1003b98bd', 1, 'I', 'Quasi larghetto e con enfasi', 'I. Quasi larghetto e con enfasi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3306e783-8319-4a6a-a255-c46fa67c17e8'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baffbe98-7ad5-4322-a479-28b1003b98bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ace12942-d07c-4142-96ba-5ee38ee96e5a', 2, 'II', 'Andantino motteggiando', 'II. Andantino motteggiando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3306e783-8319-4a6a-a255-c46fa67c17e8'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 133' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ace12942-d07c-4142-96ba-5ee38ee96e5a'
);


-- MS 134 바이올린과 기타를 위한 소나타 MS 134

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 기타를 위한 소나타 MS 134', '6 Sonatas for Violin and Guitar, MS 134', 'album', NULL, 'MS', '134', 1809, 'manual', 1
FROM composers c
WHERE c.id = 35
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 기타를 위한 소나타 MS 134'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '610a89cf-8d10-4523-b570-1b9d473e0b0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '610a89cf-8d10-4523-b570-1b9d473e0b0b'
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '610a89cf-8d10-4523-b570-1b9d473e0b0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3337c73-23ca-41f2-b3d0-a287e1d7c34a', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3337c73-23ca-41f2-b3d0-a287e1d7c34a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5640f729-025a-4d5f-a147-fdbc5ffa6388', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e3337c73-23ca-41f2-b3d0-a287e1d7c34a'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5640f729-025a-4d5f-a147-fdbc5ffa6388'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6586ce8b-ce32-4f77-87ff-c117f54b7ba7', 2, 'II', 'Adagio con espressione', 'II. Adagio con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e3337c73-23ca-41f2-b3d0-a287e1d7c34a'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6586ce8b-ce32-4f77-87ff-c117f54b7ba7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a80850aa-18d3-434b-8d65-e93864535398', 3, 'III', 'Allegro con brio', 'III. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e3337c73-23ca-41f2-b3d0-a287e1d7c34a'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a80850aa-18d3-434b-8d65-e93864535398'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d278ed05-db37-4440-b727-35fcf08ae794', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d278ed05-db37-4440-b727-35fcf08ae794'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d890a6a5-203c-4c7b-99f1-867abd127ee9', 1, 'I', '서주. Largo', 'I. Introduzione - Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d278ed05-db37-4440-b727-35fcf08ae794'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d890a6a5-203c-4c7b-99f1-867abd127ee9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b873c080-7b25-496f-a285-2fef6f69e2f9', 2, 'II', 'Andante con grazia', 'II. Andante con grazia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d278ed05-db37-4440-b727-35fcf08ae794'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b873c080-7b25-496f-a285-2fef6f69e2f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd40526f-eae0-445a-aa3e-b90beaf96384', 3, 'III', 'Andantino scherzando', 'III. Andantino scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d278ed05-db37-4440-b727-35fcf08ae794'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd40526f-eae0-445a-aa3e-b90beaf96384'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:062ad453-ad2d-4a3a-939d-7a06c1942706', 3, NULL, 'A장조', 'No. 3 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:062ad453-ad2d-4a3a-939d-7a06c1942706'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0e336c6-6630-470a-a3cb-eba26afda3a8', 1, 'I', 'Larghetto sentimentalmente', 'I. Larghetto sentimentalmente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:062ad453-ad2d-4a3a-939d-7a06c1942706'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0e336c6-6630-470a-a3cb-eba26afda3a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3add5d50-6593-408e-a5b7-8c7e3f329377', 2, 'II', '폴로네즈. Andantino brillante', 'II. Polonese - Andantino brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:062ad453-ad2d-4a3a-939d-7a06c1942706'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3add5d50-6593-408e-a5b7-8c7e3f329377'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bcbe5f8-0bbc-4a8c-8d46-bbc4acf08ac8', 4, NULL, 'F장조', 'No. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bcbe5f8-0bbc-4a8c-8d46-bbc4acf08ac8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43207ea8-3f20-4ddc-957b-ba8cb25526b0', 1, 'I', 'Adagio non tanto con anima', 'I. Adagio non tanto con anima', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5bcbe5f8-0bbc-4a8c-8d46-bbc4acf08ac8'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43207ea8-3f20-4ddc-957b-ba8cb25526b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2161751-943b-49b6-a9c4-96f071267925', 2, 'II', 'Allegretto grazioso', 'II. Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5bcbe5f8-0bbc-4a8c-8d46-bbc4acf08ac8'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2161751-943b-49b6-a9c4-96f071267925'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64c48e11-4477-48b1-bdad-0c7e25c68ed7', 5, NULL, 'G장조', 'No. 5 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64c48e11-4477-48b1-bdad-0c7e25c68ed7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d0ff724-68d3-4487-b4ce-33588fb7c21d', 1, 'I', 'Adagio affettuoso', 'I. Adagio affettuoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:64c48e11-4477-48b1-bdad-0c7e25c68ed7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d0ff724-68d3-4487-b4ce-33588fb7c21d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a6162a4-c90b-41c3-a45c-4ae8f0f479a4', 2, 'II', 'Andantino corrente', 'II. Andantino corrente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:64c48e11-4477-48b1-bdad-0c7e25c68ed7'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a6162a4-c90b-41c3-a45c-4ae8f0f479a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6cb2561-d20e-49c5-af58-34c55a5d3ebe', 6, NULL, 'C장조', 'No. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6cb2561-d20e-49c5-af58-34c55a5d3ebe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7242cc69-0e31-4603-8e60-311516a28492', 1, 'I', 'Adagio con amore', 'I. Adagio con amore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6cb2561-d20e-49c5-af58-34c55a5d3ebe'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7242cc69-0e31-4603-8e60-311516a28492'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6c64e466-1e89-46c0-a8a3-008fc6f49dec', 2, 'II', '폴로네즈. Allegro con energia', 'II. Polonese - Allegro con energia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d6cb2561-d20e-49c5-af58-34c55a5d3ebe'
WHERE p.composer_id = 35 AND p.title = '바이올린과 기타를 위한 소나타 MS 134' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c64e466-1e89-46c0-a8a3-008fc6f49dec'
);

