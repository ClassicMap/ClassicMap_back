-- 라모 작품을 출판 단위로 채운다(카탈로그: RCT). 작품 54개(묶음 4, 다악장 0, 낱곡 50),
-- 새 작품 51개, 기존 작품 3개, part 19개, 그 아래 50개, 기존 낱곡 연결 3개.
--
-- 정한 것
--   클라브생 곡집(1706·1724·1726/27, 합주곡집 1741)은 묶음, 모음곡·합주곡 아래 곡을 둔다. 무대 작품은 part 없이 둔다.
--   47 「탕부랭」·48 「가보트와 6개의 변주」·49 「암탉」은 곡집 안 곡으로 잇는다. 47 의 작품번호는 맨 끝에서 RCT 3 → RCT 2 로 고친다.
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

-- RCT 1 클라브생 곡집 1권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라브생 곡집 1권', 'Premier livre de pièces de clavecin', 'album', 'RCT 1', NULL, NULL, 1706, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라브생 곡집 1권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64925404-ec92-4bb5-8428-23b960711a1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64925404-ec92-4bb5-8428-23b960711a1f'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64925404-ec92-4bb5-8428-23b960711a1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:766f0112-1a83-377e-bcfc-bd8f096bef05', 1, NULL, '프렐류드', 'Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:766f0112-1a83-377e-bcfc-bd8f096bef05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e341720e-6765-3dbc-bcea-672229631ab8', 2, NULL, '알르망드 I', 'Allemande I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e341720e-6765-3dbc-bcea-672229631ab8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09986ebd-422e-427f-889b-b871b7cab18c', 3, NULL, '알르망드 II', 'Allemande II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09986ebd-422e-427f-889b-b871b7cab18c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c37cdaf7-c0a6-48fd-b83a-1d053541931b', 4, NULL, '쿠랑트', 'Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c37cdaf7-c0a6-48fd-b83a-1d053541931b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06fef192-7038-47ef-a822-99849d543fa3', 5, NULL, '지그', 'Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06fef192-7038-47ef-a822-99849d543fa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3c74a83-dc2f-3ac6-abcf-d8fed91e1d62', 6, NULL, '사라방드 I – 사라방드 II', 'Sarabande I – Sarabande II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3c74a83-dc2f-3ac6-abcf-d8fed91e1d62'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:602174f2-185f-4f54-8ea2-0527bc5cc04c', 7, NULL, 'Vénitienne', 'Vénitienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:602174f2-185f-4f54-8ea2-0527bc5cc04c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15b652b8-e195-35d5-bebf-a845f9ac2df0', 8, NULL, '가보트', 'Gavotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15b652b8-e195-35d5-bebf-a845f9ac2df0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a202216-d488-4bd9-8ff1-93dc33cadcae', 9, NULL, '미뉴에트', 'Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 1권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a202216-d488-4bd9-8ff1-93dc33cadcae'
);


-- RCT 2–4 클라브생 곡집 2권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라브생 곡집 2권', 'Pièces de clavessin (1724)', 'album', 'RCT 2–4', NULL, NULL, 1724, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라브생 곡집 2권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f4b070b-3573-4f6c-a409-cf3bf786486d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8f4b070b-3573-4f6c-a409-cf3bf786486d'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8f4b070b-3573-4f6c-a409-cf3bf786486d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55', 1, NULL, '모음곡 E단조', 'Suite in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:322a7e94-ce16-4c7d-ae31-6c44579440e6', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:322a7e94-ce16-4c7d-ae31-6c44579440e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:653d0fd5-e6de-4f15-a4dd-12c6d4ca891a', 2, 'II', '쿠랑트', 'II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:653d0fd5-e6de-4f15-a4dd-12c6d4ca891a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a668af77-b6d7-3489-99b1-18880b08fdde', 3, 'III', 'Gigue en rondeau I', 'III. Gigue en rondeau I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a668af77-b6d7-3489-99b1-18880b08fdde'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:220d2516-6198-38d9-a066-7dd8bc6fa779', 4, 'IV', 'Gigue en rondeau II', 'IV. Gigue en rondeau II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:220d2516-6198-38d9-a066-7dd8bc6fa779'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5e3c5987-eced-3bdf-b3ff-406d57fddc24', 5, 'V', 'Le Rappel des oiseaux', 'V. Le Rappel des oiseaux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e3c5987-eced-3bdf-b3ff-406d57fddc24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'classicmap:rameau:rameau-rct2-4:1-6', 6, 'VI', '리고동 I – 리고동 II와 두블', 'VI. Rigaudon I – Rigaudon II et Double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rameau:rameau-rct2-4:1-6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:320c6643-be8b-3787-ad9d-eb7edb798e7d', 7, 'VII', 'Musette en rondeau. Tendrement', 'VII. Musette en rondeau. Tendrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:320c6643-be8b-3787-ad9d-eb7edb798e7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 47 AND linked.composer_id = 10), 'musicbrainz:fc35bfba-5e0d-3de4-bbeb-93af627aa8b6', 8, 'VIII', '탕부랭', 'VIII. Tambourin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc35bfba-5e0d-3de4-bbeb-93af627aa8b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:58cbb661-7990-322b-bbfe-8927bd1a30ba', 9, 'IX', 'La Villageoise. Rondeau', 'IX. La Villageoise. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8c972348-8404-4945-ae75-b8588a6a9c55'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58cbb661-7990-322b-bbfe-8927bd1a30ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100', 2, NULL, '모음곡 D장조', 'Suite in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b17a2f7f-6c37-3212-93b8-9d8417d8d163', 1, 'I', 'Les Tendres Plaintes. Rondeau', 'I. Les Tendres Plaintes. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17a2f7f-6c37-3212-93b8-9d8417d8d163'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2bafd7d8-257e-3bb8-892a-8a1f128af71a', 2, 'II', 'Les Niais de Sologne – Premier double – Deuxième double', 'II. Les Niais de Sologne – Premier double – Deuxième double', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bafd7d8-257e-3bb8-892a-8a1f128af71a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:47ce9ac5-19e5-3f16-9d99-db85592941ce', 3, 'III', 'Les Soupirs. Tendrement', 'III. Les Soupirs. Tendrement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47ce9ac5-19e5-3f16-9d99-db85592941ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0aa6a7a-43bb-3c5b-adf0-db74f6d243dc', 4, 'IV', 'La Joyeuse. Rondeau', 'IV. La Joyeuse. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0aa6a7a-43bb-3c5b-adf0-db74f6d243dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:222a9c0e-a253-4510-a121-52bdf97867c2', 5, 'V', 'La Follette. Rondeau', 'V. La Follette. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:222a9c0e-a253-4510-a121-52bdf97867c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8ec7e92-d690-497c-9255-f27ef4ef3d3e', 6, 'VI', 'L''Entretien des Muses', 'VI. L''Entretien des Muses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8ec7e92-d690-497c-9255-f27ef4ef3d3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13ec0931-652f-4937-8ad1-f73153a33183', 7, 'VII', 'Les Tourbillons. Rondeau', 'VII. Les Tourbillons. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ec0931-652f-4937-8ad1-f73153a33183'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a4ef9e7-4a13-46f4-a2b2-5c8f46be4412', 8, 'VIII', 'Les Cyclopes. Rondeau', 'VIII. Les Cyclopes. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a4ef9e7-4a13-46f4-a2b2-5c8f46be4412'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aea56dde-29d3-4f83-9908-7317048328d2', 9, 'IX', 'Le Lardon. Menuet', 'IX. Le Lardon. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea56dde-29d3-4f83-9908-7317048328d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee8a68b1-235f-439e-ace7-5b843985cd87', 10, 'X', 'La Boiteuse', 'X. La Boiteuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:506136f6-b8f1-4684-b94f-49bdb5ed5100'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee8a68b1-235f-439e-ace7-5b843985cd87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af589b74-3090-4cac-8519-9b41f055badd', 3, NULL, '미뉴에트 C장조', 'Menuet en rondeau in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 2권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af589b74-3090-4cac-8519-9b41f055badd'
);


-- RCT 5–6 클라브생 곡집 3권

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라브생 곡집 3권', 'Nouvelles suites de pièces de clavecin', 'album', 'RCT 5–6', NULL, NULL, 1727, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라브생 곡집 3권'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e93d592c-bce5-4c5a-9aca-b33bbfecd082'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e93d592c-bce5-4c5a-9aca-b33bbfecd082'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e93d592c-bce5-4c5a-9aca-b33bbfecd082'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6', 1, NULL, '모음곡 A단조', 'Suite in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:824a9fae-a861-350e-a4fb-99fb6d83ca8c', 1, 'I', '알르망드', 'I. Allemande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:824a9fae-a861-350e-a4fb-99fb6d83ca8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4609ea9-74d6-4843-afdc-db3f502539d0', 2, 'II', '쿠랑트', 'II. Courante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4609ea9-74d6-4843-afdc-db3f502539d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:236afb99-6201-3870-a2d8-fcdd803716fd', 3, 'III', '사라방드', 'III. Sarabande', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:236afb99-6201-3870-a2d8-fcdd803716fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8f5187d-2c2b-3285-bb76-656f26dac37e', 4, 'IV', 'Les Trois Mains', 'IV. Les Trois Mains', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8f5187d-2c2b-3285-bb76-656f26dac37e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fd867b0-907a-38a7-88e5-c0ec12455b86', 5, 'V', 'Fanfarinette', 'V. Fanfarinette', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fd867b0-907a-38a7-88e5-c0ec12455b86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef6e4823-e2b2-31fc-a14a-0c7ba669ee02', 6, 'VI', 'La Triomphante', 'VI. La Triomphante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef6e4823-e2b2-31fc-a14a-0c7ba669ee02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 48 AND linked.composer_id = 10), 'musicbrainz:a6ee20f1-38e0-3112-8848-cd8b9cc27974', 7, 'VII', '가보트와 6개의 변주', 'VII. Gavotte et six doubles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1bef6be1-afa8-4bba-92c3-d91b8d8b04c6'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6ee20f1-38e0-3112-8848-cd8b9cc27974'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421', 2, NULL, '모음곡 G장조/G단조', 'Suite in G major/G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:008078b4-09b1-462f-ac57-6615fadada45', 1, 'I', 'Les Tricotets. Rondeau', 'I. Les Tricotets. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:008078b4-09b1-462f-ac57-6615fadada45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc688739-10ad-49d6-817c-ed965ad30a31', 2, 'II', 'L''Indifférente', 'II. L''Indifférente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc688739-10ad-49d6-817c-ed965ad30a31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f9e1711c-5cb8-4a7f-bbc7-640a2d3e7f16', 3, 'III', '미뉴에트 I – 미뉴에트 II', 'III. Menuet I – Menuet II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9e1711c-5cb8-4a7f-bbc7-640a2d3e7f16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, (SELECT linked.id FROM pieces linked WHERE linked.id = 49 AND linked.composer_id = 10), 'musicbrainz:604f1ac6-fefd-4b0a-a24f-44eb0feaa3b8', 4, 'IV', '암탉 (La Poule)', 'IV. La Poule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:604f1ac6-fefd-4b0a-a24f-44eb0feaa3b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11ba3e82-d2f2-48b2-86c3-ea556d0ea860', 5, 'V', 'Les Triolets', 'V. Les Triolets', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11ba3e82-d2f2-48b2-86c3-ea556d0ea860'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b3f32c1-f787-432b-b5e7-2cc9a6da9543', 6, 'VI', 'Les Sauvages', 'VI. Les Sauvages', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b3f32c1-f787-432b-b5e7-2cc9a6da9543'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a72fe8cd-c4d2-48d5-a4fe-6f6f790d98e9', 7, 'VII', 'L''Enharmonique. Gracieusement', 'VII. L''Enharmonique. Gracieusement', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a72fe8cd-c4d2-48d5-a4fe-6f6f790d98e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ff370b6-e5c8-43ec-8881-33880eff4eec', 8, 'VIII', 'L''Égyptienne', 'VIII. L''Égyptienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:462b8f88-10bd-4bbb-a195-fbe038011421'
WHERE p.composer_id = 10 AND p.title = '클라브생 곡집 3권' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ff370b6-e5c8-43ec-8881-33880eff4eec'
);


-- RCT 7–11 클라브생 합주곡집

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라브생 합주곡집', 'Pièces de clavecin en concerts', 'album', 'RCT 7–11', NULL, NULL, 1741, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라브생 합주곡집'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b0318b-0a84-49e9-8d08-152e8cdc874b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd8b0318b-0a84-49e9-8d08-152e8cdc874b'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd8b0318b-0a84-49e9-8d08-152e8cdc874b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d1f761c-70dc-4408-80bb-207e7c91726e', 1, NULL, '합주곡 C단조', 'Premier concert in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d1f761c-70dc-4408-80bb-207e7c91726e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:be7eeac2-6aae-4857-9b23-38b3be827ff6', 1, 'I', 'La Coulicam', 'I. La Coulicam', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6d1f761c-70dc-4408-80bb-207e7c91726e'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be7eeac2-6aae-4857-9b23-38b3be827ff6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db66e333-3fee-42d1-9ad2-5a01d100b0c1', 2, 'II', 'La Livri. Rondeau gracieux', 'II. La Livri. Rondeau gracieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6d1f761c-70dc-4408-80bb-207e7c91726e'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db66e333-3fee-42d1-9ad2-5a01d100b0c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:518d2614-dc30-4bcd-9e3b-bad5e1e4cb33', 3, 'III', 'Le Vézinet', 'III. Le Vézinet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6d1f761c-70dc-4408-80bb-207e7c91726e'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:518d2614-dc30-4bcd-9e3b-bad5e1e4cb33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fd7dfb4-4b82-4e69-a4af-90de969c4957', 2, NULL, '합주곡 G장조', 'Deuxième concert in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fd7dfb4-4b82-4e69-a4af-90de969c4957'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f46e3c2-1101-4bfd-b9d8-f71efa1798b2', 1, 'I', 'La Laborde', 'I. La Laborde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4fd7dfb4-4b82-4e69-a4af-90de969c4957'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f46e3c2-1101-4bfd-b9d8-f71efa1798b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:64976713-8fff-4366-864d-296fa2689be4', 2, 'II', 'La Boucon. Air gracieux', 'II. La Boucon. Air gracieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4fd7dfb4-4b82-4e69-a4af-90de969c4957'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64976713-8fff-4366-864d-296fa2689be4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d26e4ae4-bbc8-41b4-9d08-1ce7ca1a7657', 3, 'III', 'L''Agaçante', 'III. L''Agaçante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4fd7dfb4-4b82-4e69-a4af-90de969c4957'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26e4ae4-bbc8-41b4-9d08-1ce7ca1a7657'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'classicmap:rameau:rameau-rct7-11:2-4', 4, 'IV', '미뉴에트 I – 미뉴에트 II', 'IV. Premier menuet – Deuxième menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4fd7dfb4-4b82-4e69-a4af-90de969c4957'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rameau:rameau-rct7-11:2-4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af584700-c5a6-4b45-9144-29b22e145479', 3, NULL, '합주곡 A장조', 'Troisième concert in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af584700-c5a6-4b45-9144-29b22e145479'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:13683412-eb4e-4b62-96e5-15c5c2972ef0', 1, 'I', 'La Lapoplinière', 'I. La Lapoplinière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:af584700-c5a6-4b45-9144-29b22e145479'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13683412-eb4e-4b62-96e5-15c5c2972ef0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'classicmap:rameau:rameau-rct7-11:3-2', 2, 'II', 'La Timide. Premier rondeau – Deuxième rondeau', 'II. La Timide. Premier rondeau – Deuxième rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:af584700-c5a6-4b45-9144-29b22e145479'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rameau:rameau-rct7-11:3-2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'classicmap:rameau:rameau-rct7-11:3-3', 3, 'III', '탕부랭 I – 탕부랭 II', 'III. Premier tambourin – Deuxième tambourin en rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:af584700-c5a6-4b45-9144-29b22e145479'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:rameau:rameau-rct7-11:3-3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a70b6f0b-87bc-450a-be67-51a318a96f53', 4, NULL, '합주곡 B♭장조', 'Quatrième concert in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a70b6f0b-87bc-450a-be67-51a318a96f53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d10338a-af5c-4168-8ad2-a0bb5ed34976', 1, 'I', 'La Pantomime', 'I. La Pantomime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a70b6f0b-87bc-450a-be67-51a318a96f53'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d10338a-af5c-4168-8ad2-a0bb5ed34976'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fefeed07-42e8-4531-893d-92e6b621a47c', 2, 'II', 'L''Indiscrète. Rondeau', 'II. L''Indiscrète. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a70b6f0b-87bc-450a-be67-51a318a96f53'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fefeed07-42e8-4531-893d-92e6b621a47c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8841d442-2cf9-4ce4-b063-3f1534cc5230', 3, 'III', 'La Rameau', 'III. La Rameau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a70b6f0b-87bc-450a-be67-51a318a96f53'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8841d442-2cf9-4ce4-b063-3f1534cc5230'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c944e675-a99e-4b87-86eb-048371ee54f1', 5, NULL, '합주곡 D단조', 'Cinquième concert in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c944e675-a99e-4b87-86eb-048371ee54f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fcb40d94-d134-428c-8b63-3617a79390ee', 1, 'I', 'La Forqueray. Fugue', 'I. La Forqueray. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c944e675-a99e-4b87-86eb-048371ee54f1'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcb40d94-d134-428c-8b63-3617a79390ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d5f1257-23aa-4f38-8696-177b9c4fbb70', 2, 'II', 'La Cupis', 'II. La Cupis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c944e675-a99e-4b87-86eb-048371ee54f1'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d5f1257-23aa-4f38-8696-177b9c4fbb70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b6e8ca2-d8c4-49fd-9047-83742e016f78', 3, 'III', 'La Marais', 'III. La Marais', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c944e675-a99e-4b87-86eb-048371ee54f1'
WHERE p.composer_id = 10 AND p.title = '클라브생 합주곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b6e8ca2-d8c4-49fd-9047-83742e016f78'
);


-- RCT 12 클라브생 곡 <La Dauphine>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라브생 곡 <La Dauphine>', 'La Dauphine', 'song', 'RCT 12', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라브생 곡 <La Dauphine>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a9b6054-65cb-4115-8678-123e88a1d85a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7a9b6054-65cb-4115-8678-123e88a1d85a'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡 <La Dauphine>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a9b6054-65cb-4115-8678-123e88a1d85a'
);


-- RCT 12bis 클라브생 곡 <Les petits marteaux>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라브생 곡 <Les petits marteaux>', 'Les petits marteaux', 'song', 'RCT 12bis', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라브생 곡 <Les petits marteaux>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65496ebd-2dff-4058-8caf-21a9672719ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65496ebd-2dff-4058-8caf-21a9672719ab'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '클라브생 곡 <Les petits marteaux>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65496ebd-2dff-4058-8caf-21a9672719ab'
);


-- RCT 13 모테트 <Deus noster refugium>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Deus noster refugium>', 'Deus noster refugium', 'song', 'RCT 13', NULL, NULL, 1715, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Deus noster refugium>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72456f0e-c607-40f7-96f5-57be30d4af32'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72456f0e-c607-40f7-96f5-57be30d4af32'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '모테트 <Deus noster refugium>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72456f0e-c607-40f7-96f5-57be30d4af32'
);


-- RCT 14 모테트 <In convertendo>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <In convertendo>', 'In convertendo', 'song', 'RCT 14', NULL, NULL, 1751, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <In convertendo>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3f00a92-fec0-476b-a00e-b4b07b01bf86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3f00a92-fec0-476b-a00e-b4b07b01bf86'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '모테트 <In convertendo>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3f00a92-fec0-476b-a00e-b4b07b01bf86'
);


-- RCT 15 모테트 <Quam dilecta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Quam dilecta>', 'Quam dilecta', 'song', 'RCT 15', NULL, NULL, 1715, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Quam dilecta>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '219ed202-4805-4b8e-afab-6fd6e1852cb1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '219ed202-4805-4b8e-afab-6fd6e1852cb1'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '모테트 <Quam dilecta>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '219ed202-4805-4b8e-afab-6fd6e1852cb1'
);


-- RCT 16 모테트 <Laboravi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Laboravi>', 'Laboravi', 'song', 'RCT 16', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Laboravi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19884eb0-af8d-4fc2-b650-bf92beee9507'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19884eb0-af8d-4fc2-b650-bf92beee9507'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '모테트 <Laboravi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19884eb0-af8d-4fc2-b650-bf92beee9507'
);


-- RCT 17 카논 <Ah! loin de rire, pleurons>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Ah! loin de rire, pleurons>', 'Ah! loin de rire, pleurons', 'song', 'RCT 17', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Ah! loin de rire, pleurons>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31905d53-0c55-42e7-8d1a-26ce9e14a157'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '31905d53-0c55-42e7-8d1a-26ce9e14a157'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '카논 <Ah! loin de rire, pleurons>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '31905d53-0c55-42e7-8d1a-26ce9e14a157'
);


-- RCT 18 카논 <Avec du vin, endormons-nous>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Avec du vin, endormons-nous>', 'Avec du vin, endormons-nous', 'song', 'RCT 18', NULL, NULL, 1719, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Avec du vin, endormons-nous>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78d0d774-1a34-4181-b73d-c5c754088b0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78d0d774-1a34-4181-b73d-c5c754088b0f'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '카논 <Avec du vin, endormons-nous>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78d0d774-1a34-4181-b73d-c5c754088b0f'
);


-- RCT 18bis 카논 <L'épouse entre deux draps>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <L''épouse entre deux draps>', 'L''épouse entre deux draps', 'song', 'RCT 18bis', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <L''épouse entre deux draps>'
);


-- RCT 18ter 카논 <Je suis un fou Madame>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Je suis un fou Madame>', 'Je suis un fou Madame', 'song', 'RCT 18ter', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Je suis un fou Madame>'
);


-- RCT 19 카논 <Mes chers amis, quittez vos rouges bords>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Mes chers amis, quittez vos rouges bords>', 'Mes chers amis, quittez vos rouges bords', 'song', 'RCT 19', NULL, NULL, 1780, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Mes chers amis, quittez vos rouges bords>'
);


-- RCT 20 카논 <Réveillez-vous, dormeur sans fin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Réveillez-vous, dormeur sans fin>', 'Réveillez-vous, dormeur sans fin', 'song', 'RCT 20', NULL, NULL, 1722, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Réveillez-vous, dormeur sans fin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb3fc529-a92e-445b-95ed-1b80ec4e6147'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb3fc529-a92e-445b-95ed-1b80ec4e6147'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '카논 <Réveillez-vous, dormeur sans fin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb3fc529-a92e-445b-95ed-1b80ec4e6147'
);


-- RCT 20bis 카논 <Si tu ne prends garde à toi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Si tu ne prends garde à toi>', 'Si tu ne prends garde à toi', 'song', 'RCT 20bis', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Si tu ne prends garde à toi>'
);


-- RCT 21.1 가곡 <L'amante préoccupée>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <L''amante préoccupée>', 'L''amante préoccupée (A l''objet que j''adore)', 'song', 'RCT 21.1', NULL, NULL, 1763, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <L''amante préoccupée>'
);


-- RCT 21.2 가곡 <Lucas, pour se gausser de nous>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lucas, pour se gausser de nous>', 'Lucas, pour se gausser de nous', 'song', 'RCT 21.2', NULL, NULL, 1707, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lucas, pour se gausser de nous>'
);


-- RCT 21.3 가곡 <Non, non, le dieu qui sait aimer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Non, non, le dieu qui sait aimer>', 'Non, non, le dieu qui sait aimer', 'song', 'RCT 21.3', NULL, NULL, 1763, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Non, non, le dieu qui sait aimer>'
);


-- RCT 21.4 가곡 <Un Bourbon ouvre sa carrière>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Un Bourbon ouvre sa carrière>', 'Un Bourbon ouvre sa carrière (Un héros ouvre sa carrière)', 'song', 'RCT 21.4', NULL, NULL, 1751, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Un Bourbon ouvre sa carrière>'
);


-- RCT 22 칸타타 <Les amants trahis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Les amants trahis>', 'Les amants trahis', 'song', 'RCT 22', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Les amants trahis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2933e3aa-0880-4200-b271-e3e886f79196'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2933e3aa-0880-4200-b271-e3e886f79196'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '칸타타 <Les amants trahis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2933e3aa-0880-4200-b271-e3e886f79196'
);


-- RCT 23 칸타타 <Aquilon et Orithie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Aquilon et Orithie>', 'Aquilon et Orithie', 'song', 'RCT 23', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Aquilon et Orithie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad83d2f2-ba45-4856-a916-858df5a238a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad83d2f2-ba45-4856-a916-858df5a238a1'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '칸타타 <Aquilon et Orithie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad83d2f2-ba45-4856-a916-858df5a238a1'
);


-- RCT 24 칸타타 <Le berger fidèle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Le berger fidèle>', 'Le berger fidèle', 'song', 'RCT 24', NULL, NULL, 1728, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Le berger fidèle>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '207634c7-3c6a-4e3b-8fd4-1bc57638d14e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '207634c7-3c6a-4e3b-8fd4-1bc57638d14e'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '칸타타 <Le berger fidèle>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '207634c7-3c6a-4e3b-8fd4-1bc57638d14e'
);


-- RCT 25 칸타타 <Cantate pour le jour de la Saint Louis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Cantate pour le jour de la Saint Louis>', 'Cantate pour le jour de la Saint Louis', 'song', 'RCT 25', NULL, NULL, 1740, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Cantate pour le jour de la Saint Louis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4281a710-dbb1-46fe-9588-43955df4bafc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4281a710-dbb1-46fe-9588-43955df4bafc'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '칸타타 <Cantate pour le jour de la Saint Louis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4281a710-dbb1-46fe-9588-43955df4bafc'
);


-- RCT 26 칸타타 <L'impatience>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <L''impatience>', 'L''impatience', 'song', 'RCT 26', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <L''impatience>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6f8ed2a-851a-4ef8-8584-6f32b1d3e0b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c6f8ed2a-851a-4ef8-8584-6f32b1d3e0b8'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '칸타타 <L''impatience>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c6f8ed2a-851a-4ef8-8584-6f32b1d3e0b8'
);


-- RCT 27 칸타타 <Orphée>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Orphée>', 'Orphée', 'song', 'RCT 27', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Orphée>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de4a0072-6d15-49a7-8c68-cc15855a5649'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'de4a0072-6d15-49a7-8c68-cc15855a5649'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '칸타타 <Orphée>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'de4a0072-6d15-49a7-8c68-cc15855a5649'
);


-- RCT 28 칸타타 <Thétis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Thétis>', 'Thétis', 'song', 'RCT 28', NULL, NULL, 1720, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Thétis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8d4e681-42eb-4792-962f-177a90e70e7d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f8d4e681-42eb-4792-962f-177a90e70e7d'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '칸타타 <Thétis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f8d4e681-42eb-4792-962f-177a90e70e7d'
);


-- RCT 43 오페라 <이폴리트와 아리시>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '856d4cbb-98a0-4df7-8ce8-64c0db7a2864'
FROM pieces p
WHERE p.id = 51 AND p.composer_id = 10
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '856d4cbb-98a0-4df7-8ce8-64c0db7a2864'
);


-- RCT 44 오페라-발레 <우아한 인도의 나라들>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b407211e-3002-39b2-ae06-f6d1311c3b1a'
FROM pieces p
WHERE p.id = 46 AND p.composer_id = 10
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b407211e-3002-39b2-ae06-f6d1311c3b1a'
);


-- RCT 32 오페라 <카스토르와 폴뤽스>

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e9b357a8-b0e4-4605-adac-ee28de94d293'
FROM pieces p
WHERE p.id = 50 AND p.composer_id = 10
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9b357a8-b0e4-4605-adac-ee28de94d293'
);


-- RCT 41 오페라-발레 <Les fêtes d'Hébé>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라-발레 <Les fêtes d''Hébé>', 'Les fêtes d''Hébé, ou Les talents lyriques', 'song', 'RCT 41', NULL, NULL, 1739, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라-발레 <Les fêtes d''Hébé>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '346d25ea-a60c-495a-b374-43476cbfe869'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '346d25ea-a60c-495a-b374-43476cbfe869'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라-발레 <Les fêtes d''Hébé>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '346d25ea-a60c-495a-b374-43476cbfe869'
);


-- RCT 35 오페라 <다르다뉘스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <다르다뉘스>', 'Dardanus', 'song', 'RCT 35', NULL, NULL, 1739, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <다르다뉘스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd56fbf98-30f5-419a-b872-11a7a6164165'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd56fbf98-30f5-419a-b872-11a7a6164165'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <다르다뉘스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd56fbf98-30f5-419a-b872-11a7a6164165'
);


-- RCT 54 코메디-발레 <La princesse de Navarre>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '코메디-발레 <La princesse de Navarre>', 'La princesse de Navarre', 'song', 'RCT 54', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '코메디-발레 <La princesse de Navarre>'
);


-- RCT 53 오페라 <플라테>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <플라테>', 'Platée', 'song', 'RCT 53', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <플라테>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '047b396a-2888-4173-9162-800d0e815224'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '047b396a-2888-4173-9162-800d0e815224'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <플라테>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '047b396a-2888-4173-9162-800d0e815224'
);


-- RCT 39 오페라-발레 <Les fêtes de Polymnie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라-발레 <Les fêtes de Polymnie>', 'Les fêtes de Polymnie', 'song', 'RCT 39', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라-발레 <Les fêtes de Polymnie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1211160-db6c-4e58-ae4d-1fc3341e7471'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a1211160-db6c-4e58-ae4d-1fc3341e7471'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라-발레 <Les fêtes de Polymnie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a1211160-db6c-4e58-ae4d-1fc3341e7471'
);


-- RCT 59 오페라-발레 <Le temple de la gloire>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라-발레 <Le temple de la gloire>', 'Le temple de la gloire', 'song', 'RCT 59', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라-발레 <Le temple de la gloire>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3d06e7e-25b2-4e45-b25f-7f2f92242933'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a3d06e7e-25b2-4e45-b25f-7f2f92242933'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라-발레 <Le temple de la gloire>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3d06e7e-25b2-4e45-b25f-7f2f92242933'
);


-- RCT 40 오페라 <Les fêtes de Ramire>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Les fêtes de Ramire>', 'Les fêtes de Ramire', 'song', 'RCT 40', NULL, NULL, 1745, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Les fêtes de Ramire>'
);


-- RCT 38 오페라-발레 <Les fêtes de l'Hymen et de l'Amour>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라-발레 <Les fêtes de l''Hymen et de l''Amour>', 'Les fêtes de l''Hymen et de l''Amour, ou Les dieux d''Égypte', 'song', 'RCT 38', NULL, NULL, 1747, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라-발레 <Les fêtes de l''Hymen et de l''Amour>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a05f69b-c697-48dd-99d3-9f8ddca64544'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a05f69b-c697-48dd-99d3-9f8ddca64544'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라-발레 <Les fêtes de l''Hymen et de l''Amour>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a05f69b-c697-48dd-99d3-9f8ddca64544'
);


-- RCT 60 오페라 <자이스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <자이스>', 'Zaïs', 'song', 'RCT 60', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <자이스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5dd16c2-7933-47d3-aa9c-b675b0bffa5e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5dd16c2-7933-47d3-aa9c-b675b0bffa5e'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <자이스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5dd16c2-7933-47d3-aa9c-b675b0bffa5e'
);


-- RCT 52 오페라 <피그말리온>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <피그말리온>', 'Pigmalion', 'song', 'RCT 52', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <피그말리온>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2288bead-cf58-4dfc-89ad-e1916c2e9a08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2288bead-cf58-4dfc-89ad-e1916c2e9a08'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <피그말리온>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2288bead-cf58-4dfc-89ad-e1916c2e9a08'
);


-- RCT 58 오페라-발레 <Les surprises de l'Amour>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라-발레 <Les surprises de l''Amour>', 'Les surprises de l''Amour', 'song', 'RCT 58', NULL, NULL, 1748, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라-발레 <Les surprises de l''Amour>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd33de277-2560-4324-831f-b9919c1c306f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd33de277-2560-4324-831f-b9919c1c306f'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라-발레 <Les surprises de l''Amour>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd33de277-2560-4324-831f-b9919c1c306f'
);


-- RCT 49 오페라 <나이스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <나이스>', 'Naïs', 'song', 'RCT 49', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <나이스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5c8e05b-c9ac-45d0-a268-283d89d128c2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b5c8e05b-c9ac-45d0-a268-283d89d128c2'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <나이스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b5c8e05b-c9ac-45d0-a268-283d89d128c2'
);


-- RCT 62 오페라 <조로아스트르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <조로아스트르>', 'Zoroastre', 'song', 'RCT 62', NULL, NULL, 1749, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <조로아스트르>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '736e1153-d82e-4d38-b534-2a5f91801f64'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '736e1153-d82e-4d38-b534-2a5f91801f64'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <조로아스트르>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '736e1153-d82e-4d38-b534-2a5f91801f64'
);


-- RCT 29 오페라 <Acante et Céphise>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Acante et Céphise>', 'Acante et Céphise, ou La sympathie', 'song', 'RCT 29', NULL, NULL, 1751, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Acante et Céphise>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28f1f1ec-fcd3-4587-a761-9c02847dd2b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '28f1f1ec-fcd3-4587-a761-9c02847dd2b7'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <Acante et Céphise>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28f1f1ec-fcd3-4587-a761-9c02847dd2b7'
);


-- RCT 42 오페라 <La guirlande>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La guirlande>', 'La guirlande, ou Les fleurs enchantées', 'song', 'RCT 42', NULL, NULL, 1751, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La guirlande>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81437d97-eac4-42c1-9975-93fa9afddccd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81437d97-eac4-42c1-9975-93fa9afddccd'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <La guirlande>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81437d97-eac4-42c1-9975-93fa9afddccd'
);


-- RCT 34 오페라 <Daphnis et Eglé>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Daphnis et Eglé>', 'Daphnis et Eglé', 'song', 'RCT 34', NULL, NULL, 1753, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Daphnis et Eglé>'
);


-- RCT 57 오페라 <Les Sibarites>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Les Sibarites>', 'Les Sibarites', 'song', 'RCT 57', NULL, NULL, 1753, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Les Sibarites>'
);


-- RCT 48 오페라 <La naissance d'Osiris>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La naissance d''Osiris>', 'La naissance d''Osiris, ou La fête Pamilie', 'song', 'RCT 48', NULL, NULL, 1754, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La naissance d''Osiris>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c71175d0-2ee0-4351-a5c6-678efb23dc30'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c71175d0-2ee0-4351-a5c6-678efb23dc30'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <La naissance d''Osiris>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c71175d0-2ee0-4351-a5c6-678efb23dc30'
);


-- RCT 30 오페라 <아나크레옹>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <아나크레옹>', 'Anacréon', 'song', 'RCT 30', NULL, NULL, 1754, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <아나크레옹>'
);


-- RCT 51 오페라 <팔라댕>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <팔라댕>', 'Les Paladins', 'song', 'RCT 51', NULL, NULL, 1760, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <팔라댕>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f37422a-af67-467c-8a54-0fdaec578250'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0f37422a-af67-467c-8a54-0fdaec578250'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <팔라댕>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0f37422a-af67-467c-8a54-0fdaec578250'
);


-- RCT 31 오페라 <보레아드>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <보레아드>', 'Les Boréades', 'song', 'RCT 31', NULL, NULL, 1763, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <보레아드>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2db1005-e478-4695-90b0-b2e7c1c85606'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2db1005-e478-4695-90b0-b2e7c1c85606'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <보레아드>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2db1005-e478-4695-90b0-b2e7c1c85606'
);


-- RCT 50 오페라 <Nélée et Myrthis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Nélée et Myrthis>', 'Nélée et Myrthis', 'song', 'RCT 50', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Nélée et Myrthis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc740d98-0f8b-44ca-b73d-fcf64c015ad3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc740d98-0f8b-44ca-b73d-fcf64c015ad3'
FROM pieces p
WHERE p.composer_id = 10 AND p.title = '오페라 <Nélée et Myrthis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc740d98-0f8b-44ca-b73d-fcf64c015ad3'
);


-- RCT 61 오페라 <제피르>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <제피르>', 'Zéphire', 'song', 'RCT 61', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 10
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <제피르>'
);


-- 47 「탕부랭」은 1724년 곡집 E단조 모음곡(RCT 2)의 곡이다.
UPDATE pieces piece
SET piece.opus_number = 'RCT 2'
WHERE piece.id = 47 AND piece.composer_id = 10 AND piece.opus_number = 'RCT 3';
