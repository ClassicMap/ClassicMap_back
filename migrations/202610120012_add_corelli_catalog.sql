-- 코렐리 작품을 출판 단위로 채운다(카탈로그: Op.·WoO). 작품 9개(묶음 6, 다악장 3, 낱곡 0),
-- 새 작품 7개, 기존 작품 2개, part 86개, 그 아래 294개, 기존 낱곡 연결 2개.
--
-- 정한 것
--   Op. 1–6 은 12곡 묶음, 안의 소나타·협주곡 악장은 그 아래 part. WoO 는 진위가 굳은 1·2·5 만.
--   59·60 은 Op. 6·Op. 3 묶음 자체, 57 「크리스마스 협주곡」·58 「라 폴리아」는 각 묶음의 part 로 잇는다.
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

-- Op. 1 3성부 교회 소나타 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성부 교회 소나타 Op. 1', '12 Trio Sonatas (Sonate da chiesa), Op. 1', 'album', NULL, 'Op.', '1', 1681, 'manual', 1
FROM composers c
WHERE c.id = 12
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성부 교회 소나타 Op. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f324929b-4422-4ccc-9b1c-f090b62a4cbe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f324929b-4422-4ccc-9b1c-f090b62a4cbe'
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f324929b-4422-4ccc-9b1c-f090b62a4cbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ea97409-5b5e-4d2f-ab0c-8d9f2cc0b2cb', 1, NULL, '교회 소나타 F장조', 'No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ea97409-5b5e-4d2f-ab0c-8d9f2cc0b2cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67f1dd10-d819-39dd-83bb-0c3bd06b285f', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4ea97409-5b5e-4d2f-ab0c-8d9f2cc0b2cb'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f1dd10-d819-39dd-83bb-0c3bd06b285f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39e69ceb-2863-3051-bae7-ff0d8b3c2403', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4ea97409-5b5e-4d2f-ab0c-8d9f2cc0b2cb'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39e69ceb-2863-3051-bae7-ff0d8b3c2403'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4cd8fb83-8de9-310f-970d-756d34c1246a', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4ea97409-5b5e-4d2f-ab0c-8d9f2cc0b2cb'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cd8fb83-8de9-310f-970d-756d34c1246a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2064e99-5d4c-36b1-8b17-e5faaab356d3', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4ea97409-5b5e-4d2f-ab0c-8d9f2cc0b2cb'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2064e99-5d4c-36b1-8b17-e5faaab356d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4250247-5b72-4019-8184-19332fcf04b4', 2, NULL, '교회 소나타 E단조', 'No. 2 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4250247-5b72-4019-8184-19332fcf04b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7dd0af9e-c7fc-37af-b0ae-fa9f0ff181d2', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4250247-5b72-4019-8184-19332fcf04b4'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dd0af9e-c7fc-37af-b0ae-fa9f0ff181d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3119e66-0a42-3c14-a53a-cc16f79cdb01', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4250247-5b72-4019-8184-19332fcf04b4'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3119e66-0a42-3c14-a53a-cc16f79cdb01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:676d0ab1-1a86-38e4-a1c9-425fcf40baa6', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4250247-5b72-4019-8184-19332fcf04b4'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:676d0ab1-1a86-38e4-a1c9-425fcf40baa6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:012ee5ac-6769-345d-aa19-e4c9600d07b3', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f4250247-5b72-4019-8184-19332fcf04b4'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:012ee5ac-6769-345d-aa19-e4c9600d07b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f69b9a3-8cb6-400f-adb9-82d747711f1f', 3, NULL, '교회 소나타 A장조', 'No. 3 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f69b9a3-8cb6-400f-adb9-82d747711f1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c189584-004f-36d2-8f78-bb9ddcd43b7b', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f69b9a3-8cb6-400f-adb9-82d747711f1f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c189584-004f-36d2-8f78-bb9ddcd43b7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84e79768-3888-385e-abfe-6a3f6ca4d450', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f69b9a3-8cb6-400f-adb9-82d747711f1f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84e79768-3888-385e-abfe-6a3f6ca4d450'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0f51cf3-9d07-3b45-83cf-e87a1f5b5e6c', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f69b9a3-8cb6-400f-adb9-82d747711f1f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0f51cf3-9d07-3b45-83cf-e87a1f5b5e6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6357059-2c55-3973-a51f-c28678052bf5', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1f69b9a3-8cb6-400f-adb9-82d747711f1f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6357059-2c55-3973-a51f-c28678052bf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d089b50-1702-4569-8e0e-bf24a0b1f7c0', 4, NULL, '교회 소나타 A단조', 'No. 4 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d089b50-1702-4569-8e0e-bf24a0b1f7c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ed9a7f2-1907-3f77-b743-9a25aa16ab3e', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d089b50-1702-4569-8e0e-bf24a0b1f7c0'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ed9a7f2-1907-3f77-b743-9a25aa16ab3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efdea3ea-1ec8-353d-8e78-2106ad3193d6', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d089b50-1702-4569-8e0e-bf24a0b1f7c0'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efdea3ea-1ec8-353d-8e78-2106ad3193d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79d4c449-2641-3e1f-97de-90828c5a8392', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d089b50-1702-4569-8e0e-bf24a0b1f7c0'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79d4c449-2641-3e1f-97de-90828c5a8392'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c030d18-bc7a-3483-93aa-f7a6b6789102', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d089b50-1702-4569-8e0e-bf24a0b1f7c0'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c030d18-bc7a-3483-93aa-f7a6b6789102'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa6fc439-7765-410c-a093-e28f52324008', 5, NULL, '교회 소나타 B♭장조', 'No. 5 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa6fc439-7765-410c-a093-e28f52324008'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1a89fb51-d13b-3f3c-b092-c69526ef4962', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa6fc439-7765-410c-a093-e28f52324008'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a89fb51-d13b-3f3c-b092-c69526ef4962'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:956d9e32-b8a7-307d-babf-4e5b64305a3a', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa6fc439-7765-410c-a093-e28f52324008'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:956d9e32-b8a7-307d-babf-4e5b64305a3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1e4e05d2-209f-3ff9-a5fc-121c9a544ed1', 3, 'III', 'Adagio – Allegro', 'III. Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa6fc439-7765-410c-a093-e28f52324008'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e4e05d2-209f-3ff9-a5fc-121c9a544ed1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:91875b7d-d23d-3be5-9e05-339e21f8ad8c', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa6fc439-7765-410c-a093-e28f52324008'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91875b7d-d23d-3be5-9e05-339e21f8ad8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbf60bf2-d35d-4cad-958f-34df47926ae3', 6, NULL, '교회 소나타 B단조', 'No. 6 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbf60bf2-d35d-4cad-958f-34df47926ae3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:577af906-e3d1-3707-82e8-642069d5bad4', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbf60bf2-d35d-4cad-958f-34df47926ae3'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:577af906-e3d1-3707-82e8-642069d5bad4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4cb1ee43-2094-3efe-b1f8-0b5ef42fcfad', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbf60bf2-d35d-4cad-958f-34df47926ae3'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cb1ee43-2094-3efe-b1f8-0b5ef42fcfad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2901cc70-40bf-3e11-b0ae-327bd966c014', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbf60bf2-d35d-4cad-958f-34df47926ae3'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2901cc70-40bf-3e11-b0ae-327bd966c014'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1770286e-f307-3255-a887-5910b40330ea', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fbf60bf2-d35d-4cad-958f-34df47926ae3'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1770286e-f307-3255-a887-5910b40330ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b997059-6c34-4b71-ba42-ef7647fbe341', 7, NULL, '교회 소나타 C장조', 'No. 7 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b997059-6c34-4b71-ba42-ef7647fbe341'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6a94bae-a8d4-33a1-a144-3ca6015ea975', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5b997059-6c34-4b71-ba42-ef7647fbe341'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6a94bae-a8d4-33a1-a144-3ca6015ea975'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a68c4603-7b27-3477-9377-44f01c3bff65', 2, 'II', 'Grave', 'II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5b997059-6c34-4b71-ba42-ef7647fbe341'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a68c4603-7b27-3477-9377-44f01c3bff65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c7d0c64-171f-3c1f-96a5-82bbd4e15ec5', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5b997059-6c34-4b71-ba42-ef7647fbe341'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c7d0c64-171f-3c1f-96a5-82bbd4e15ec5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0768b89f-2f57-404d-9740-662a738bf7bc', 8, NULL, '교회 소나타 C단조', 'No. 8 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0768b89f-2f57-404d-9740-662a738bf7bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80ac29fc-a9a0-35ac-a64b-bd34c10c562c', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0768b89f-2f57-404d-9740-662a738bf7bc'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80ac29fc-a9a0-35ac-a64b-bd34c10c562c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6723475d-822a-3859-bbda-4fab6a8a2253', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0768b89f-2f57-404d-9740-662a738bf7bc'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6723475d-822a-3859-bbda-4fab6a8a2253'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eeaab564-ac67-3771-8097-4fc2047c8446', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0768b89f-2f57-404d-9740-662a738bf7bc'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeaab564-ac67-3771-8097-4fc2047c8446'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df503140-71bc-3e8b-85b0-e78084ea4dc9', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0768b89f-2f57-404d-9740-662a738bf7bc'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df503140-71bc-3e8b-85b0-e78084ea4dc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f65d0cf2-21d5-4900-95b4-adf54e45b801', 9, NULL, '교회 소나타 G장조', 'No. 9 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f65d0cf2-21d5-4900-95b4-adf54e45b801'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bc4c304-8d8b-39d4-bc6a-e80adc4441df', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f65d0cf2-21d5-4900-95b4-adf54e45b801'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bc4c304-8d8b-39d4-bc6a-e80adc4441df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:925d4432-3697-3ccb-97a9-3c7cf0e8a83d', 2, 'II', 'Adagio – Allegro', 'II. Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f65d0cf2-21d5-4900-95b4-adf54e45b801'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:925d4432-3697-3ccb-97a9-3c7cf0e8a83d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eee01b86-2011-398e-92a3-cd0e18973628', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f65d0cf2-21d5-4900-95b4-adf54e45b801'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eee01b86-2011-398e-92a3-cd0e18973628'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f62ba44d-b0c4-3458-89b1-321466f89099', 4, 'IV', 'Allegro – Adagio', 'IV. Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f65d0cf2-21d5-4900-95b4-adf54e45b801'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f62ba44d-b0c4-3458-89b1-321466f89099'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5412fb98-bbef-474f-9e25-3d25dc13c73f', 10, NULL, '교회 소나타 G단조', 'No. 10 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5412fb98-bbef-474f-9e25-3d25dc13c73f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c28a6d0e-344e-34a4-8bba-447d889209e1', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5412fb98-bbef-474f-9e25-3d25dc13c73f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c28a6d0e-344e-34a4-8bba-447d889209e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8bb553aa-a198-3b04-b561-e473edf48351', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5412fb98-bbef-474f-9e25-3d25dc13c73f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb553aa-a198-3b04-b561-e473edf48351'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f247e606-6595-32ae-8425-ee5e4095e62e', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5412fb98-bbef-474f-9e25-3d25dc13c73f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f247e606-6595-32ae-8425-ee5e4095e62e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54bd7458-8235-349d-a135-62a25ec7fb59', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5412fb98-bbef-474f-9e25-3d25dc13c73f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54bd7458-8235-349d-a135-62a25ec7fb59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cef56529-ba0e-3b08-bc30-c094faaa3c8b', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5412fb98-bbef-474f-9e25-3d25dc13c73f'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cef56529-ba0e-3b08-bc30-c094faaa3c8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91bc2d97-d67a-4d1c-8990-f6cc0e91de0a', 11, NULL, '교회 소나타 D단조', 'No. 11 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91bc2d97-d67a-4d1c-8990-f6cc0e91de0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:558a055f-a962-3f9f-8fe5-26def4e9fa9d', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91bc2d97-d67a-4d1c-8990-f6cc0e91de0a'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:558a055f-a962-3f9f-8fe5-26def4e9fa9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55ecc491-da8c-3513-89ba-1007210ca599', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91bc2d97-d67a-4d1c-8990-f6cc0e91de0a'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55ecc491-da8c-3513-89ba-1007210ca599'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb47c6c0-7c70-3279-b316-46b9f8b4532e', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91bc2d97-d67a-4d1c-8990-f6cc0e91de0a'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb47c6c0-7c70-3279-b316-46b9f8b4532e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:473866aa-ac8f-3e9f-83a9-ec01416b19fd', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91bc2d97-d67a-4d1c-8990-f6cc0e91de0a'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:473866aa-ac8f-3e9f-83a9-ec01416b19fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24c6924f-eb65-4517-a096-cea8d92d6269', 12, NULL, '교회 소나타 D장조', 'No. 12 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24c6924f-eb65-4517-a096-cea8d92d6269'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e2412db-8a70-3e85-9b5b-92bc21ce2b9e', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24c6924f-eb65-4517-a096-cea8d92d6269'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e2412db-8a70-3e85-9b5b-92bc21ce2b9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10c1b583-86f4-348f-a9cc-8a1c2647b4dc', 2, 'II', 'Largo e puntato', 'II. Largo e puntato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24c6924f-eb65-4517-a096-cea8d92d6269'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10c1b583-86f4-348f-a9cc-8a1c2647b4dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7e567e9-8a22-37b8-bc24-13eb13e84e84', 3, 'III', 'Grave', 'III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24c6924f-eb65-4517-a096-cea8d92d6269'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7e567e9-8a22-37b8-bc24-13eb13e84e84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce550d4d-1d58-3d8b-93ce-3206d2e45b4d', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:24c6924f-eb65-4517-a096-cea8d92d6269'
WHERE p.composer_id = 12 AND p.title = '3성부 교회 소나타 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce550d4d-1d58-3d8b-93ce-3206d2e45b4d'
);


-- Op. 2 3성부 실내 소나타 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성부 실내 소나타 Op. 2', '12 Trio Sonatas (Sonate da camera), Op. 2', 'album', NULL, 'Op.', '2', 1685, 'manual', 1
FROM composers c
WHERE c.id = 12
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성부 실내 소나타 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ef1c22c-1584-46d8-841d-53616d057094'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6ef1c22c-1584-46d8-841d-53616d057094'
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6ef1c22c-1584-46d8-841d-53616d057094'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a34e568-b0f8-44e5-a64e-ba2dd21fc70d', 1, NULL, '실내 소나타 D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a34e568-b0f8-44e5-a64e-ba2dd21fc70d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:77fbbfb9-593e-312f-a577-74f4c919c5c9', 1, 'I', '프렐류드', 'I. Preludio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5a34e568-b0f8-44e5-a64e-ba2dd21fc70d'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77fbbfb9-593e-312f-a577-74f4c919c5c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96ef63b8-01ad-3bba-bdec-fd1783178646', 2, 'II', '알르망드. Largo', 'II. Allemanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5a34e568-b0f8-44e5-a64e-ba2dd21fc70d'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96ef63b8-01ad-3bba-bdec-fd1783178646'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:249c1d32-11ee-3ccc-8638-a436c98ad2b0', 3, 'III', '쿠랑트. Allegro', 'III. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5a34e568-b0f8-44e5-a64e-ba2dd21fc70d'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:249c1d32-11ee-3ccc-8638-a436c98ad2b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a62b3db-298f-3d5f-803c-fc167972c591', 4, 'IV', '가보트. Allegro', 'IV. Gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5a34e568-b0f8-44e5-a64e-ba2dd21fc70d'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a62b3db-298f-3d5f-803c-fc167972c591'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:476933b6-17b3-4f9c-9498-c277689b3337', 2, NULL, '실내 소나타 D단조', 'No. 2 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:476933b6-17b3-4f9c-9498-c277689b3337'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dacf3fb5-ec25-35b8-b29c-d9d0ccf1a89f', 1, 'I', '알르망드. Adagio', 'I. Allemanda: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:476933b6-17b3-4f9c-9498-c277689b3337'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dacf3fb5-ec25-35b8-b29c-d9d0ccf1a89f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3284c15b-07ed-3ff5-896b-d20820009470', 2, 'II', '쿠랑트. Allegro', 'II. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:476933b6-17b3-4f9c-9498-c277689b3337'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3284c15b-07ed-3ff5-896b-d20820009470'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:824ed311-179f-39fa-b157-6f714a4259fb', 3, 'III', '지그. Allegro', 'III. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:476933b6-17b3-4f9c-9498-c277689b3337'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:824ed311-179f-39fa-b157-6f714a4259fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:763e43e7-5e41-4186-b42d-5c23cbeda35e', 3, NULL, '실내 소나타 C장조', 'No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:763e43e7-5e41-4186-b42d-5c23cbeda35e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ffddeeb-e902-39f9-a1dd-1f8fa4191689', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:763e43e7-5e41-4186-b42d-5c23cbeda35e'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ffddeeb-e902-39f9-a1dd-1f8fa4191689'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d2b601e-def6-3be3-9711-dd3e32ffd2a4', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:763e43e7-5e41-4186-b42d-5c23cbeda35e'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d2b601e-def6-3be3-9711-dd3e32ffd2a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2626ddb0-3dd9-3e8e-8e2b-0eec4ee755a0', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:763e43e7-5e41-4186-b42d-5c23cbeda35e'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2626ddb0-3dd9-3e8e-8e2b-0eec4ee755a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d88ca38-b252-384a-87d9-111db293b286', 4, 'IV', '알르망드. Presto', 'IV. Allemanda: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:763e43e7-5e41-4186-b42d-5c23cbeda35e'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d88ca38-b252-384a-87d9-111db293b286'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84ed2543-61e2-4f9c-b6c0-3388dc1a6f01', 4, NULL, '실내 소나타 E단조', 'No. 4 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84ed2543-61e2-4f9c-b6c0-3388dc1a6f01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8899f4ad-91f9-3ab0-80d7-afcd1048ec9a', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84ed2543-61e2-4f9c-b6c0-3388dc1a6f01'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8899f4ad-91f9-3ab0-80d7-afcd1048ec9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f749e47f-b992-30cd-919b-df052753ec0e', 2, 'II', '알르망드. Presto', 'II. Allemanda: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84ed2543-61e2-4f9c-b6c0-3388dc1a6f01'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f749e47f-b992-30cd-919b-df052753ec0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f782eec1-5c95-383a-9569-f3412272f60b', 3, 'III', 'Grave. Adagio', 'III. Grave: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84ed2543-61e2-4f9c-b6c0-3388dc1a6f01'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f782eec1-5c95-383a-9569-f3412272f60b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1471dd13-2101-3f48-85e8-ff40af4e011a', 4, 'IV', '지그. Allegro', 'IV. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84ed2543-61e2-4f9c-b6c0-3388dc1a6f01'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1471dd13-2101-3f48-85e8-ff40af4e011a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eee46c8a-643b-424b-be18-296dd090d85f', 5, NULL, '실내 소나타 B♭장조', 'No. 5 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eee46c8a-643b-424b-be18-296dd090d85f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de24c756-a183-3606-beae-34a0d9270572', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eee46c8a-643b-424b-be18-296dd090d85f'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de24c756-a183-3606-beae-34a0d9270572'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05802317-6b1d-32d5-9243-e2a94b307cb2', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eee46c8a-643b-424b-be18-296dd090d85f'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05802317-6b1d-32d5-9243-e2a94b307cb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a3b57c96-4677-30c5-b7a3-c7738e978781', 3, 'III', '사라방드. Adagio', 'III. Sarabanda: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eee46c8a-643b-424b-be18-296dd090d85f'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3b57c96-4677-30c5-b7a3-c7738e978781'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9c5b302-de24-36e8-9b17-0e7e380bb0ba', 4, 'IV', 'Tempo di gavotta. Allegro', 'IV. Tempo di gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eee46c8a-643b-424b-be18-296dd090d85f'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9c5b302-de24-36e8-9b17-0e7e380bb0ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8ab49b9-5ff9-4a66-8855-c0d0955f34b8', 6, NULL, '실내 소나타 G단조', 'No. 6 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8ab49b9-5ff9-4a66-8855-c0d0955f34b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:751a6e5e-1026-3145-bc86-3c9a47acf438', 1, 'I', '알르망드. Largo', 'I. Allemanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8ab49b9-5ff9-4a66-8855-c0d0955f34b8'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:751a6e5e-1026-3145-bc86-3c9a47acf438'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa57b030-8150-312d-9515-ddd0bdb4e640', 2, 'II', '쿠랑트. Allegro', 'II. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8ab49b9-5ff9-4a66-8855-c0d0955f34b8'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa57b030-8150-312d-9515-ddd0bdb4e640'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6341ce70-0942-3bac-b5f9-4ef9d5b69e84', 3, 'III', '지그. Allegro', 'III. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8ab49b9-5ff9-4a66-8855-c0d0955f34b8'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6341ce70-0942-3bac-b5f9-4ef9d5b69e84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7ec1614c-155c-47f9-bbf4-d3427cbc4e53', 7, NULL, '실내 소나타 F장조', 'No. 7 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ec1614c-155c-47f9-bbf4-d3427cbc4e53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:35b5dd69-b837-3974-836b-2888756cd9cb', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7ec1614c-155c-47f9-bbf4-d3427cbc4e53'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35b5dd69-b837-3974-836b-2888756cd9cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cfb6bc8e-0379-3bbe-94d1-e62a60df27e6', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7ec1614c-155c-47f9-bbf4-d3427cbc4e53'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfb6bc8e-0379-3bbe-94d1-e62a60df27e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ec8380d-ebc9-3706-b599-d6c0ea2720ab', 3, 'III', '쿠랑트. Allegro', 'III. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7ec1614c-155c-47f9-bbf4-d3427cbc4e53'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ec8380d-ebc9-3706-b599-d6c0ea2720ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96fe2860-216e-35e6-b23e-ca08df25ea23', 4, 'IV', '지그. Allegro', 'IV. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7ec1614c-155c-47f9-bbf4-d3427cbc4e53'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96fe2860-216e-35e6-b23e-ca08df25ea23'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18c5066d-77f6-4049-8016-1a543c0d9176', 8, NULL, '실내 소나타 B단조', 'No. 8 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18c5066d-77f6-4049-8016-1a543c0d9176'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dce4fe9c-f562-3cdc-aa32-668b79521078', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18c5066d-77f6-4049-8016-1a543c0d9176'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dce4fe9c-f562-3cdc-aa32-668b79521078'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:929a6173-51f5-3a79-9a48-9c76bb5f82c1', 2, 'II', '알르망드. Largo', 'II. Allemanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18c5066d-77f6-4049-8016-1a543c0d9176'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:929a6173-51f5-3a79-9a48-9c76bb5f82c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9356ec02-10e4-3832-a497-f69177e8e2c3', 3, 'III', 'Tempo di sarabanda. Adagio', 'III. Tempo di sarabanda: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18c5066d-77f6-4049-8016-1a543c0d9176'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9356ec02-10e4-3832-a497-f69177e8e2c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6427fc9-c90b-369b-9e15-d4f110c2aed4', 4, 'IV', 'Tempo di gavotta. Allegro', 'IV. Tempo di gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:18c5066d-77f6-4049-8016-1a543c0d9176'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6427fc9-c90b-369b-9e15-d4f110c2aed4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0cd14982-8ac7-4935-85a4-8f43abe4576a', 9, NULL, '실내 소나타 F#단조', 'No. 9 in F# minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0cd14982-8ac7-4935-85a4-8f43abe4576a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cde78d33-2825-30e8-9f41-5b2c59abae57', 1, 'I', '알르망드. Largo', 'I. Allemanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0cd14982-8ac7-4935-85a4-8f43abe4576a'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cde78d33-2825-30e8-9f41-5b2c59abae57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a13cde79-5a27-3456-8867-1f9865007da8', 2, 'II', 'Tempo di sarabanda. Largo', 'II. Tempo di sarabanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0cd14982-8ac7-4935-85a4-8f43abe4576a'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a13cde79-5a27-3456-8867-1f9865007da8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4222907e-dd00-303a-b4c7-e8784a1c4392', 3, 'III', '지그. Allegro', 'III. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0cd14982-8ac7-4935-85a4-8f43abe4576a'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4222907e-dd00-303a-b4c7-e8784a1c4392'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a65a1998-d6b9-4bfc-b2cd-ebfafbfcf9d6', 10, NULL, '실내 소나타 E장조', 'No. 10 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a65a1998-d6b9-4bfc-b2cd-ebfafbfcf9d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0b73c26f-9dff-33e6-93d6-b94626820279', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a65a1998-d6b9-4bfc-b2cd-ebfafbfcf9d6'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b73c26f-9dff-33e6-93d6-b94626820279'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d9c330f1-720c-3b1c-a4d4-ef4c03325aa9', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a65a1998-d6b9-4bfc-b2cd-ebfafbfcf9d6'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9c330f1-720c-3b1c-a4d4-ef4c03325aa9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:507125bf-0eab-341f-a9b5-b8e1b08429f7', 3, 'III', '사라방드. Largo', 'III. Sarabanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a65a1998-d6b9-4bfc-b2cd-ebfafbfcf9d6'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:507125bf-0eab-341f-a9b5-b8e1b08429f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94aea709-5a09-3029-bf2c-0a1ea98bdef1', 4, 'IV', '쿠랑트. Allegro', 'IV. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a65a1998-d6b9-4bfc-b2cd-ebfafbfcf9d6'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94aea709-5a09-3029-bf2c-0a1ea98bdef1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc3af7cf-68d2-49c7-b620-ac1d81955026', 11, NULL, '실내 소나타 E♭장조', 'No. 11 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc3af7cf-68d2-49c7-b620-ac1d81955026'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b601d432-d2d7-3579-bc8c-629f92f62522', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc3af7cf-68d2-49c7-b620-ac1d81955026'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b601d432-d2d7-3579-bc8c-629f92f62522'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9778e8cd-f620-3356-b02e-687b297e5237', 2, 'II', '알르망드. Presto', 'II. Allemanda: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc3af7cf-68d2-49c7-b620-ac1d81955026'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9778e8cd-f620-3356-b02e-687b297e5237'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ca2aab19-c4a8-3de1-a50b-d397a7b75431', 3, 'III', '지그. Allegro', 'III. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc3af7cf-68d2-49c7-b620-ac1d81955026'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca2aab19-c4a8-3de1-a50b-d397a7b75431'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bc74172-0c64-360a-83b2-655f53baa7c0', 12, NULL, '실내 소나타 G장조', 'No. 12 in G major (Ciacona)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bc74172-0c64-360a-83b2-655f53baa7c0'
);


-- Op. 3 3성부 교회 소나타

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2a0e142-ef43-4dfc-a4a8-0d255bdafc67'
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2a0e142-ef43-4dfc-a4a8-0d255bdafc67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab2c147a-518b-4291-bb3f-b7351c96bcbc', 1, NULL, '교회 소나타 F장조', 'No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab2c147a-518b-4291-bb3f-b7351c96bcbc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:370c4ecb-7a18-388b-b522-3b6fe40eda1a', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab2c147a-518b-4291-bb3f-b7351c96bcbc'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:370c4ecb-7a18-388b-b522-3b6fe40eda1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a112bbc-1cbb-3a10-9726-1198ba6b1555', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab2c147a-518b-4291-bb3f-b7351c96bcbc'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a112bbc-1cbb-3a10-9726-1198ba6b1555'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f03601e6-dac1-3ba2-a2f1-3e6e5ea0be45', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab2c147a-518b-4291-bb3f-b7351c96bcbc'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f03601e6-dac1-3ba2-a2f1-3e6e5ea0be45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0aaafc6f-b256-3915-a7c0-dc8393378a0e', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab2c147a-518b-4291-bb3f-b7351c96bcbc'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aaafc6f-b256-3915-a7c0-dc8393378a0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2da85e99-7519-48a4-862e-e34c44547aa7', 2, NULL, '교회 소나타 D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2da85e99-7519-48a4-862e-e34c44547aa7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:525d5eaa-e709-3b57-9190-90d0aac42d2b', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2da85e99-7519-48a4-862e-e34c44547aa7'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:525d5eaa-e709-3b57-9190-90d0aac42d2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eb8712c3-60cc-309c-a94a-9658fc2875f9', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2da85e99-7519-48a4-862e-e34c44547aa7'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb8712c3-60cc-309c-a94a-9658fc2875f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d148fb6c-2ac4-38ad-90fc-08930605fbeb', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2da85e99-7519-48a4-862e-e34c44547aa7'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d148fb6c-2ac4-38ad-90fc-08930605fbeb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d9e2594-8e3b-3bb0-84c8-798046b2308c', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2da85e99-7519-48a4-862e-e34c44547aa7'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d9e2594-8e3b-3bb0-84c8-798046b2308c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97e30e42-daef-4b3f-8786-8b9a713890e9', 3, NULL, '교회 소나타 B♭장조', 'No. 3 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97e30e42-daef-4b3f-8786-8b9a713890e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:715d20fa-d77b-39db-ad35-5e39ae33bba2', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97e30e42-daef-4b3f-8786-8b9a713890e9'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:715d20fa-d77b-39db-ad35-5e39ae33bba2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ffe7a03-7c9d-3d35-86ae-5f977ba57163', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97e30e42-daef-4b3f-8786-8b9a713890e9'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ffe7a03-7c9d-3d35-86ae-5f977ba57163'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00acb5a6-ee62-3d50-9ffd-0bb2e3c23776', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97e30e42-daef-4b3f-8786-8b9a713890e9'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00acb5a6-ee62-3d50-9ffd-0bb2e3c23776'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e7486673-0726-3669-8848-e8303a2845c7', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97e30e42-daef-4b3f-8786-8b9a713890e9'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7486673-0726-3669-8848-e8303a2845c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d34537e9-3d6a-4dfb-911c-5217bf3f5ed4', 4, NULL, '교회 소나타 B단조', 'No. 4 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d34537e9-3d6a-4dfb-911c-5217bf3f5ed4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ec04467-4029-3e54-891a-da296de84722', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d34537e9-3d6a-4dfb-911c-5217bf3f5ed4'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ec04467-4029-3e54-891a-da296de84722'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28e64df4-0fb2-3ccf-9d4a-259607e652c9', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d34537e9-3d6a-4dfb-911c-5217bf3f5ed4'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28e64df4-0fb2-3ccf-9d4a-259607e652c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ca5a94e-bf93-3a93-a0f1-fb93e94c1abe', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d34537e9-3d6a-4dfb-911c-5217bf3f5ed4'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ca5a94e-bf93-3a93-a0f1-fb93e94c1abe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad44dbf0-9b99-3313-9205-ecd2ecfac5fc', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d34537e9-3d6a-4dfb-911c-5217bf3f5ed4'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad44dbf0-9b99-3313-9205-ecd2ecfac5fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fba79dac-e025-4075-8777-97b48c291a75', 5, NULL, '교회 소나타 D단조', 'No. 5 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fba79dac-e025-4075-8777-97b48c291a75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:804495b0-884f-34a2-bfb8-181719da20d7', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fba79dac-e025-4075-8777-97b48c291a75'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:804495b0-884f-34a2-bfb8-181719da20d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1dc689e-4bfe-3047-ab66-4c93f53475a8', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fba79dac-e025-4075-8777-97b48c291a75'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1dc689e-4bfe-3047-ab66-4c93f53475a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b3d5242-3390-3df8-ba22-6021e480ccc3', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fba79dac-e025-4075-8777-97b48c291a75'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b3d5242-3390-3df8-ba22-6021e480ccc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6172327d-c7e1-39f7-b1e1-1334071bc60c', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fba79dac-e025-4075-8777-97b48c291a75'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6172327d-c7e1-39f7-b1e1-1334071bc60c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e85d1b7d-ce0a-4dbe-b576-89f8fc5516d0', 6, NULL, '교회 소나타 G장조', 'No. 6 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e85d1b7d-ce0a-4dbe-b576-89f8fc5516d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b25b27b-d174-3666-b27a-fefffdea6b7e', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e85d1b7d-ce0a-4dbe-b576-89f8fc5516d0'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b25b27b-d174-3666-b27a-fefffdea6b7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f0fc3eb-111f-3d36-8947-f2d3eab11759', 2, 'II', 'Grave', 'II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e85d1b7d-ce0a-4dbe-b576-89f8fc5516d0'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f0fc3eb-111f-3d36-8947-f2d3eab11759'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bb526b7-73b5-36a3-91de-c8cb1185e9cb', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e85d1b7d-ce0a-4dbe-b576-89f8fc5516d0'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bb526b7-73b5-36a3-91de-c8cb1185e9cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0d1694a-2b92-3952-a0ae-cee9a4da343a', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e85d1b7d-ce0a-4dbe-b576-89f8fc5516d0'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d1694a-2b92-3952-a0ae-cee9a4da343a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaab42d0-881a-4846-975d-a87fb0d499d5', 7, NULL, '교회 소나타 E단조', 'No. 7 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaab42d0-881a-4846-975d-a87fb0d499d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9f94a659-8486-3afb-a9b8-ce3577f72a82', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eaab42d0-881a-4846-975d-a87fb0d499d5'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f94a659-8486-3afb-a9b8-ce3577f72a82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d1ce9783-3966-3343-8a80-8c46acab91f5', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eaab42d0-881a-4846-975d-a87fb0d499d5'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1ce9783-3966-3343-8a80-8c46acab91f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f7e2d468-95b9-3577-b634-788869c02e32', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eaab42d0-881a-4846-975d-a87fb0d499d5'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7e2d468-95b9-3577-b634-788869c02e32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:965ac5b0-d74f-3025-875a-b01967ac5473', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eaab42d0-881a-4846-975d-a87fb0d499d5'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:965ac5b0-d74f-3025-875a-b01967ac5473'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:338b8474-9e18-4c77-83fb-d1cf9f57940d', 8, NULL, '교회 소나타 C장조', 'No. 8 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:338b8474-9e18-4c77-83fb-d1cf9f57940d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfc0fa7c-7265-371f-83bc-268aa9952768', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:338b8474-9e18-4c77-83fb-d1cf9f57940d'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfc0fa7c-7265-371f-83bc-268aa9952768'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ad76fc03-a209-32ee-a0f2-561816d3dce7', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:338b8474-9e18-4c77-83fb-d1cf9f57940d'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad76fc03-a209-32ee-a0f2-561816d3dce7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aacfaf6a-437d-30e2-821e-642e8e267e56', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:338b8474-9e18-4c77-83fb-d1cf9f57940d'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aacfaf6a-437d-30e2-821e-642e8e267e56'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9301c46c-7450-3fa1-810c-9c56629b787e', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:338b8474-9e18-4c77-83fb-d1cf9f57940d'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9301c46c-7450-3fa1-810c-9c56629b787e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a3b4038-1eb9-42f3-95cb-ee5fa2fffe91', 9, NULL, '교회 소나타 F단조', 'No. 9 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a3b4038-1eb9-42f3-95cb-ee5fa2fffe91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e1d7a607-134b-3987-99e7-46588b0250a3', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9a3b4038-1eb9-42f3-95cb-ee5fa2fffe91'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1d7a607-134b-3987-99e7-46588b0250a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dc2cc148-82d3-369e-aabc-c8b6f574c218', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9a3b4038-1eb9-42f3-95cb-ee5fa2fffe91'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc2cc148-82d3-369e-aabc-c8b6f574c218'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7d72f9cc-584c-3ccc-89c1-2ae79cfdfeb7', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9a3b4038-1eb9-42f3-95cb-ee5fa2fffe91'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d72f9cc-584c-3ccc-89c1-2ae79cfdfeb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8aa373a3-8c9b-30d5-9447-6c18b6c59316', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9a3b4038-1eb9-42f3-95cb-ee5fa2fffe91'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aa373a3-8c9b-30d5-9447-6c18b6c59316'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7221ae3a-ed6f-4082-ac5c-914208bd5c3c', 10, NULL, '교회 소나타 A단조', 'No. 10 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7221ae3a-ed6f-4082-ac5c-914208bd5c3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:939ce448-902e-30e9-aec7-7ca73d42548f', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7221ae3a-ed6f-4082-ac5c-914208bd5c3c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:939ce448-902e-30e9-aec7-7ca73d42548f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6fd5c3e-baf8-342f-9e3b-586921875543', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7221ae3a-ed6f-4082-ac5c-914208bd5c3c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6fd5c3e-baf8-342f-9e3b-586921875543'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8f5cfaf-e5c7-3efe-a10e-f5cbba545a7a', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7221ae3a-ed6f-4082-ac5c-914208bd5c3c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8f5cfaf-e5c7-3efe-a10e-f5cbba545a7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c7d05480-bb5e-309e-9d9e-94a9a2d66efa', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7221ae3a-ed6f-4082-ac5c-914208bd5c3c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7d05480-bb5e-309e-9d9e-94a9a2d66efa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cc8b127-9cfc-4f95-a5cf-19543003fc97', 11, NULL, '교회 소나타 G단조', 'No. 11 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cc8b127-9cfc-4f95-a5cf-19543003fc97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27d4d36c-4a11-37c8-a9d6-923fe62fc1b3', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9cc8b127-9cfc-4f95-a5cf-19543003fc97'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27d4d36c-4a11-37c8-a9d6-923fe62fc1b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:acb810be-6283-3d31-88a7-a493dbd81102', 2, 'II', 'Presto', 'II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9cc8b127-9cfc-4f95-a5cf-19543003fc97'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acb810be-6283-3d31-88a7-a493dbd81102'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:135afddf-7e95-3620-8fde-7d050cf8d2da', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9cc8b127-9cfc-4f95-a5cf-19543003fc97'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:135afddf-7e95-3620-8fde-7d050cf8d2da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d1611f5-35ed-3eac-9ea7-10947070182c', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9cc8b127-9cfc-4f95-a5cf-19543003fc97'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d1611f5-35ed-3eac-9ea7-10947070182c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26af8d66-d163-44a1-8251-c76a2e54ed7c', 12, NULL, '교회 소나타 A장조', 'No. 12 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26af8d66-d163-44a1-8251-c76a2e54ed7c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b539199a-13fd-3e48-a339-fbc38296dab1', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26af8d66-d163-44a1-8251-c76a2e54ed7c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b539199a-13fd-3e48-a339-fbc38296dab1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4165c27e-d567-36e2-8292-ae664115179b', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26af8d66-d163-44a1-8251-c76a2e54ed7c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4165c27e-d567-36e2-8292-ae664115179b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df7e4523-d1e5-390f-9b55-54064b97c299', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26af8d66-d163-44a1-8251-c76a2e54ed7c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df7e4523-d1e5-390f-9b55-54064b97c299'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3db24ffb-9148-3ae5-beaf-263c65da717d', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26af8d66-d163-44a1-8251-c76a2e54ed7c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3db24ffb-9148-3ae5-beaf-263c65da717d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2490ea57-ed72-392c-9b16-c604fd052a24', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26af8d66-d163-44a1-8251-c76a2e54ed7c'
WHERE p.id = 60 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2490ea57-ed72-392c-9b16-c604fd052a24'
);


-- Op. 4 3성부 실내 소나타 Op. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성부 실내 소나타 Op. 4', '12 Trio Sonatas (Sonate da camera), Op. 4', 'album', NULL, 'Op.', '4', 1694, 'manual', 1
FROM composers c
WHERE c.id = 12
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성부 실내 소나타 Op. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea194734-04d3-45cc-a3c6-3ff2ffa546d3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea194734-04d3-45cc-a3c6-3ff2ffa546d3'
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea194734-04d3-45cc-a3c6-3ff2ffa546d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:406b766b-920b-4892-b1b6-7dd14516e4c3', 1, NULL, '실내 소나타 C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:406b766b-920b-4892-b1b6-7dd14516e4c3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:955936e1-cdb9-3781-be91-291adfe4a5c7', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:406b766b-920b-4892-b1b6-7dd14516e4c3'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:955936e1-cdb9-3781-be91-291adfe4a5c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:978496ad-4dd6-3c96-b180-b0c09bc04202', 2, 'II', '쿠랑트. Allegro', 'II. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:406b766b-920b-4892-b1b6-7dd14516e4c3'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:978496ad-4dd6-3c96-b180-b0c09bc04202'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52b36028-5e70-38a8-bec8-6f623837a7ad', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:406b766b-920b-4892-b1b6-7dd14516e4c3'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52b36028-5e70-38a8-bec8-6f623837a7ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55fcea81-2cf7-3fc9-b810-bd26f708e9e5', 4, 'IV', '알르망드. Presto', 'IV. Allemanda: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:406b766b-920b-4892-b1b6-7dd14516e4c3'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55fcea81-2cf7-3fc9-b810-bd26f708e9e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6d6d853-3b25-4c9f-9c5a-23779ab6b394', 2, NULL, '실내 소나타 G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6d6d853-3b25-4c9f-9c5a-23779ab6b394'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a47e844a-1fb2-3bfc-a71f-328813341843', 1, 'I', '프렐류드. Grave', 'I. Preludio: Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6d6d853-3b25-4c9f-9c5a-23779ab6b394'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a47e844a-1fb2-3bfc-a71f-328813341843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6046bee2-8cfe-3422-869f-3c9b090fbdb6', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6d6d853-3b25-4c9f-9c5a-23779ab6b394'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6046bee2-8cfe-3422-869f-3c9b090fbdb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d988f520-f64a-3bf4-8ad2-9d271614c2af', 3, 'III', 'Grave', 'III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6d6d853-3b25-4c9f-9c5a-23779ab6b394'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d988f520-f64a-3bf4-8ad2-9d271614c2af'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae1dd405-6325-3d34-8339-36942d045d04', 4, 'IV', '쿠랑트. Vivace', 'IV. Corrente: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c6d6d853-3b25-4c9f-9c5a-23779ab6b394'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae1dd405-6325-3d34-8339-36942d045d04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e56bc7d5-a60b-4887-aed4-fbee898e9fbb', 3, NULL, '실내 소나타 A장조', 'No. 3 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e56bc7d5-a60b-4887-aed4-fbee898e9fbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:43215f1d-a108-3f0c-8d10-30744c53e6fe', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e56bc7d5-a60b-4887-aed4-fbee898e9fbb'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43215f1d-a108-3f0c-8d10-30744c53e6fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5bd04880-e5ea-3f0a-9193-cee3f40979e8', 2, 'II', '쿠랑트. Allegro', 'II. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e56bc7d5-a60b-4887-aed4-fbee898e9fbb'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bd04880-e5ea-3f0a-9193-cee3f40979e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d8db5263-4700-3ac7-a87b-053e5949c92a', 3, 'III', '사라방드. Largo', 'III. Sarabanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e56bc7d5-a60b-4887-aed4-fbee898e9fbb'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8db5263-4700-3ac7-a87b-053e5949c92a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9211a3f3-0b4e-320d-a77d-1744da4f94dc', 4, 'IV', 'Tempo di gavotta. Allegro', 'IV. Tempo di gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e56bc7d5-a60b-4887-aed4-fbee898e9fbb'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9211a3f3-0b4e-320d-a77d-1744da4f94dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2e44a20-4bc1-4258-ad3b-91e8ebec58c5', 4, NULL, '실내 소나타 D장조', 'No. 4 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2e44a20-4bc1-4258-ad3b-91e8ebec58c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54386e19-edfc-38f0-bf68-77755c7f1928', 1, 'I', '프렐류드. Grave', 'I. Preludio: Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2e44a20-4bc1-4258-ad3b-91e8ebec58c5'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54386e19-edfc-38f0-bf68-77755c7f1928'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ced2c8d7-516b-3e43-bb78-cbe8b5c7b093', 2, 'II', '쿠랑트. Allegro', 'II. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2e44a20-4bc1-4258-ad3b-91e8ebec58c5'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ced2c8d7-516b-3e43-bb78-cbe8b5c7b093'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31305a5f-db63-33f2-b97e-af941af18fdd', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2e44a20-4bc1-4258-ad3b-91e8ebec58c5'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31305a5f-db63-33f2-b97e-af941af18fdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d50247c-52db-3ed4-8190-6edeca09aa93', 4, 'IV', '지그. Allegro', 'IV. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a2e44a20-4bc1-4258-ad3b-91e8ebec58c5'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d50247c-52db-3ed4-8190-6edeca09aa93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e2071af-7f37-4263-aab6-2016edf3f454', 5, NULL, '실내 소나타 A단조', 'No. 5 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e2071af-7f37-4263-aab6-2016edf3f454'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea850656-6e7c-308e-849f-07981deb4c9b', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e2071af-7f37-4263-aab6-2016edf3f454'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea850656-6e7c-308e-849f-07981deb4c9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc82d30d-1e73-31bb-9561-02c2e3804aa8', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e2071af-7f37-4263-aab6-2016edf3f454'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc82d30d-1e73-31bb-9561-02c2e3804aa8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:272017f8-85b9-3566-b177-7bd0358dbc44', 3, 'III', '쿠랑트. Vivace', 'III. Corrente: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e2071af-7f37-4263-aab6-2016edf3f454'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:272017f8-85b9-3566-b177-7bd0358dbc44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:214cb20f-b3f6-36d0-87ad-c41f17f29f20', 4, 'IV', '가보트. Allegro', 'IV. Gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e2071af-7f37-4263-aab6-2016edf3f454'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:214cb20f-b3f6-36d0-87ad-c41f17f29f20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7a3cda4-eff6-4651-8669-1ee97b304acc', 6, NULL, '실내 소나타 E장조', 'No. 6 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a3cda4-eff6-4651-8669-1ee97b304acc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a318e13-a6d4-3f64-93bc-11f00520495f', 1, 'I', '프렐류드. Adagio – Allegro – Adagio – Allegro – Adagio', 'I. Preludio. Adagio – Allegro – Adagio – Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7a3cda4-eff6-4651-8669-1ee97b304acc'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a318e13-a6d4-3f64-93bc-11f00520495f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b16832e2-407a-3b1a-a354-fde173bb28c7', 2, 'II', '알르망드. Allegro', 'II. Allemanda. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7a3cda4-eff6-4651-8669-1ee97b304acc'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b16832e2-407a-3b1a-a354-fde173bb28c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fa8121cd-69d3-3f35-a433-a0bd5f898311', 3, 'III', '지그. Allegro', 'III. Giga. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f7a3cda4-eff6-4651-8669-1ee97b304acc'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa8121cd-69d3-3f35-a433-a0bd5f898311'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c13b05ea-2ef7-48ab-9de0-fb304ae612d5', 7, NULL, '실내 소나타 F장조', 'No. 7 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c13b05ea-2ef7-48ab-9de0-fb304ae612d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f49c791b-194e-3619-8d1c-dd3ec2274592', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c13b05ea-2ef7-48ab-9de0-fb304ae612d5'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49c791b-194e-3619-8d1c-dd3ec2274592'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:798ef3f9-91b6-3ca7-b211-800f75587034', 2, 'II', '쿠랑트. Allegro – Grave', 'II. Corrente: Allegro – Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c13b05ea-2ef7-48ab-9de0-fb304ae612d5'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:798ef3f9-91b6-3ca7-b211-800f75587034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d15ab832-5a2c-3a09-a7ea-d9cb93bf768f', 3, 'III', '사라방드. Vivace', 'III. Sarabanda: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c13b05ea-2ef7-48ab-9de0-fb304ae612d5'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d15ab832-5a2c-3a09-a7ea-d9cb93bf768f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:990002c0-3a88-3db3-813a-5a4da211ecaa', 4, 'IV', '지그. Allegro', 'IV. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c13b05ea-2ef7-48ab-9de0-fb304ae612d5'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:990002c0-3a88-3db3-813a-5a4da211ecaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9db7565-ca30-4590-b812-7d72091198b6', 8, NULL, '실내 소나타 D단조', 'No. 8 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9db7565-ca30-4590-b812-7d72091198b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1ec07b57-10ed-38d7-9701-e47fe8db8b09', 1, 'I', '프렐류드. Grave', 'I. Preludio: Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9db7565-ca30-4590-b812-7d72091198b6'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ec07b57-10ed-38d7-9701-e47fe8db8b09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6d0f87d1-1f29-3468-ad40-d271466e1906', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9db7565-ca30-4590-b812-7d72091198b6'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d0f87d1-1f29-3468-ad40-d271466e1906'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:10838541-78ac-3a40-b665-6c00763fca7b', 3, 'III', '사라방드. Allegro', 'III. Sarabanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a9db7565-ca30-4590-b812-7d72091198b6'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:10838541-78ac-3a40-b665-6c00763fca7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3242c209-afca-4d92-81f4-19c1d06b45e4', 9, NULL, '실내 소나타 B♭장조', 'No. 9 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3242c209-afca-4d92-81f4-19c1d06b45e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ffafe30-361d-32a3-994b-3198196845b7', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3242c209-afca-4d92-81f4-19c1d06b45e4'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ffafe30-361d-32a3-994b-3198196845b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95daa56c-7ac5-37fa-b11c-2eed9700e1e3', 2, 'II', '쿠랑트. Allegro', 'II. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3242c209-afca-4d92-81f4-19c1d06b45e4'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95daa56c-7ac5-37fa-b11c-2eed9700e1e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cb904f71-11aa-3f70-8d7a-2d0f1b461ef1', 3, 'III', 'Grave', 'III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3242c209-afca-4d92-81f4-19c1d06b45e4'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb904f71-11aa-3f70-8d7a-2d0f1b461ef1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e5f8a3a-da43-33f1-98f3-80a9be63e1c0', 4, 'IV', 'Tempo di gavotta. Allegro', 'IV. Tempo di gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3242c209-afca-4d92-81f4-19c1d06b45e4'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e5f8a3a-da43-33f1-98f3-80a9be63e1c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fb856cf-353d-461b-be46-04f5f7b45dda', 10, NULL, '실내 소나타 G장조', 'No. 10 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fb856cf-353d-461b-be46-04f5f7b45dda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e434e79a-ab95-310c-a293-ac1f5dd046fa', 1, 'I', '프렐류드. Adagio – Allegro', 'I. Preludio: Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fb856cf-353d-461b-be46-04f5f7b45dda'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e434e79a-ab95-310c-a293-ac1f5dd046fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a5bb0c62-b4ba-3e73-8424-237d464f6977', 2, 'II', 'Grave', 'II. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fb856cf-353d-461b-be46-04f5f7b45dda'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5bb0c62-b4ba-3e73-8424-237d464f6977'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc5e56f7-52a1-3ef5-a1c1-3d86594b8b22', 3, 'III', 'Tempo di gavotta – Presto', 'III. Tempo di gavotta – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6fb856cf-353d-461b-be46-04f5f7b45dda'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc5e56f7-52a1-3ef5-a1c1-3d86594b8b22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:054c3063-b871-4834-89ff-9e2037545ef4', 11, NULL, '실내 소나타 C단조', 'No. 11 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:054c3063-b871-4834-89ff-9e2037545ef4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27c259fd-6438-30e2-b464-e273eb42be78', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:054c3063-b871-4834-89ff-9e2037545ef4'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27c259fd-6438-30e2-b464-e273eb42be78'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a6179cf-868e-3e45-9b93-c9b56a1737f2', 2, 'II', '쿠랑트. Allegro', 'II. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:054c3063-b871-4834-89ff-9e2037545ef4'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a6179cf-868e-3e45-9b93-c9b56a1737f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:31ab7df8-7aa6-3d83-9beb-a6f2fc697abd', 3, 'III', '알르망드. Allegro', 'III. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:054c3063-b871-4834-89ff-9e2037545ef4'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31ab7df8-7aa6-3d83-9beb-a6f2fc697abd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9950c31a-f4bc-491a-856a-1e1fe58226ef', 12, NULL, '실내 소나타 B단조', 'No. 12 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9950c31a-f4bc-491a-856a-1e1fe58226ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6cedf5ce-9fbe-3b7f-bebb-89683578f4cb', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9950c31a-f4bc-491a-856a-1e1fe58226ef'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cedf5ce-9fbe-3b7f-bebb-89683578f4cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f251ef0-6a9b-3070-ab07-a5e88477cd1a', 2, 'II', '알르망드. Presto', 'II. Allemanda: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9950c31a-f4bc-491a-856a-1e1fe58226ef'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f251ef0-6a9b-3070-ab07-a5e88477cd1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79f26502-3d50-33f5-a555-2a7713f59856', 3, 'III', '지그. Allegro', 'III. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9950c31a-f4bc-491a-856a-1e1fe58226ef'
WHERE p.composer_id = 12 AND p.title = '3성부 실내 소나타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79f26502-3d50-33f5-a555-2a7713f59856'
);


-- Op. 5 바이올린 소나타 Op. 5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 Op. 5', '12 Violin Sonatas, Op. 5', 'album', NULL, 'Op.', '5', 1700, 'manual', 1
FROM composers c
WHERE c.id = 12
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 Op. 5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85c1b7f8-0e8b-49f2-b234-570365469329'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '85c1b7f8-0e8b-49f2-b234-570365469329'
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85c1b7f8-0e8b-49f2-b234-570365469329'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:444b672c-e08d-4aa8-88c0-fcdc3b331317', 1, NULL, '바이올린 소나타 D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:444b672c-e08d-4aa8-88c0-fcdc3b331317'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c5f2efc-c0f2-3a3f-9717-14829f2dfb95', 1, 'I', 'Grave – Allegro', 'I. Grave – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:444b672c-e08d-4aa8-88c0-fcdc3b331317'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c5f2efc-c0f2-3a3f-9717-14829f2dfb95'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fdb98c87-5a13-3dc2-90d4-2c8edea05259', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:444b672c-e08d-4aa8-88c0-fcdc3b331317'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdb98c87-5a13-3dc2-90d4-2c8edea05259'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63753cea-c5ad-3793-9298-4fa57a178316', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:444b672c-e08d-4aa8-88c0-fcdc3b331317'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63753cea-c5ad-3793-9298-4fa57a178316'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ad42e0f-0b3a-3aa1-83f6-41a2746f9a05', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:444b672c-e08d-4aa8-88c0-fcdc3b331317'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ad42e0f-0b3a-3aa1-83f6-41a2746f9a05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88f72dff-902e-3720-89f6-62b320426c90', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:444b672c-e08d-4aa8-88c0-fcdc3b331317'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f72dff-902e-3720-89f6-62b320426c90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91d4391e-87c1-439a-828b-8e84eff04992', 2, NULL, '바이올린 소나타 B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91d4391e-87c1-439a-828b-8e84eff04992'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3e797f35-28b6-3c07-8950-3352a6db3fc0', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91d4391e-87c1-439a-828b-8e84eff04992'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e797f35-28b6-3c07-8950-3352a6db3fc0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:debba2d4-7071-3831-910c-8ec8ae139c07', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91d4391e-87c1-439a-828b-8e84eff04992'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:debba2d4-7071-3831-910c-8ec8ae139c07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e618a7a2-65d9-3ad5-83f3-974c6046a181', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91d4391e-87c1-439a-828b-8e84eff04992'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e618a7a2-65d9-3ad5-83f3-974c6046a181'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:25c5b916-e53d-3ee3-90d9-daa3532b7ebd', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91d4391e-87c1-439a-828b-8e84eff04992'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25c5b916-e53d-3ee3-90d9-daa3532b7ebd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6e5b2f85-537b-3918-98df-a24ba48cbf08', 5, 'V', 'Vivace', 'V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:91d4391e-87c1-439a-828b-8e84eff04992'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e5b2f85-537b-3918-98df-a24ba48cbf08'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4409d00d-48ec-499a-a084-5ab949612da0', 3, NULL, '바이올린 소나타 C장조', 'No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4409d00d-48ec-499a-a084-5ab949612da0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1853e7b1-c6b6-3b60-a22a-f04010123d22', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4409d00d-48ec-499a-a084-5ab949612da0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1853e7b1-c6b6-3b60-a22a-f04010123d22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cdca5b52-f762-35bf-b01a-e213e0caff11', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4409d00d-48ec-499a-a084-5ab949612da0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdca5b52-f762-35bf-b01a-e213e0caff11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3308fe97-b70e-32e9-be2c-ba0700349976', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4409d00d-48ec-499a-a084-5ab949612da0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3308fe97-b70e-32e9-be2c-ba0700349976'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4a48b5c-a254-3e4a-8973-0076f4e767ce', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4409d00d-48ec-499a-a084-5ab949612da0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4a48b5c-a254-3e4a-8973-0076f4e767ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e25b89d6-a271-3abf-9573-e839c651f3fe', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4409d00d-48ec-499a-a084-5ab949612da0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e25b89d6-a271-3abf-9573-e839c651f3fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fea37be7-a2df-4f96-b393-f7eaa997c5f3', 4, NULL, '바이올린 소나타 F장조', 'No. 4 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fea37be7-a2df-4f96-b393-f7eaa997c5f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b0fff44b-544f-3dd6-8ea6-5ae61f0592b0', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fea37be7-a2df-4f96-b393-f7eaa997c5f3'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0fff44b-544f-3dd6-8ea6-5ae61f0592b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a23b87e3-6f6d-3136-9f90-07e9d1954051', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fea37be7-a2df-4f96-b393-f7eaa997c5f3'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a23b87e3-6f6d-3136-9f90-07e9d1954051'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:434a532c-db5c-3a7c-989e-d70853fba9bf', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fea37be7-a2df-4f96-b393-f7eaa997c5f3'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:434a532c-db5c-3a7c-989e-d70853fba9bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:01900662-362d-36de-8190-768dbc1e9f69', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fea37be7-a2df-4f96-b393-f7eaa997c5f3'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01900662-362d-36de-8190-768dbc1e9f69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2debc0d8-1bb6-3478-aa1f-207b9193b7fe', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fea37be7-a2df-4f96-b393-f7eaa997c5f3'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2debc0d8-1bb6-3478-aa1f-207b9193b7fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b65e259b-eab4-4635-8c92-7eff3b058ce4', 5, NULL, '바이올린 소나타 G단조', 'No. 5 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b65e259b-eab4-4635-8c92-7eff3b058ce4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:daf76523-74c1-36ad-bd1e-a76ca834229d', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b65e259b-eab4-4635-8c92-7eff3b058ce4'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:daf76523-74c1-36ad-bd1e-a76ca834229d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f89089a0-8850-39e2-abba-e113329bffb7', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b65e259b-eab4-4635-8c92-7eff3b058ce4'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f89089a0-8850-39e2-abba-e113329bffb7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7a0f281-dd17-35f9-8f32-a193bb2e8cfc', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b65e259b-eab4-4635-8c92-7eff3b058ce4'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7a0f281-dd17-35f9-8f32-a193bb2e8cfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5652ce01-d38d-34d6-b4e0-5fa69d991dd6', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b65e259b-eab4-4635-8c92-7eff3b058ce4'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5652ce01-d38d-34d6-b4e0-5fa69d991dd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6788294-2a54-39bd-81c7-a7cab92f72b4', 5, 'V', '지그. Allegro', 'V. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b65e259b-eab4-4635-8c92-7eff3b058ce4'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6788294-2a54-39bd-81c7-a7cab92f72b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f38f6402-d6f3-4db7-a8f3-2c452504176c', 6, NULL, '바이올린 소나타 A장조', 'No. 6 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f38f6402-d6f3-4db7-a8f3-2c452504176c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab5ed119-f058-3cce-9f1c-07e9e4ce5554', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f38f6402-d6f3-4db7-a8f3-2c452504176c'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab5ed119-f058-3cce-9f1c-07e9e4ce5554'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8cdbbbfa-1397-36a8-b6f9-1b44b828d7e0', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f38f6402-d6f3-4db7-a8f3-2c452504176c'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cdbbbfa-1397-36a8-b6f9-1b44b828d7e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b07b0c74-63c9-34b5-9071-b2f1dc41b937', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f38f6402-d6f3-4db7-a8f3-2c452504176c'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b07b0c74-63c9-34b5-9071-b2f1dc41b937'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2856f3c4-1358-33d5-8cd7-ef7d24ebebca', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f38f6402-d6f3-4db7-a8f3-2c452504176c'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2856f3c4-1358-33d5-8cd7-ef7d24ebebca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a00aedf3-e5a6-34a6-b94e-356516f0fe32', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f38f6402-d6f3-4db7-a8f3-2c452504176c'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a00aedf3-e5a6-34a6-b94e-356516f0fe32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26a84781-e775-4b68-9d92-065a72c2b2a7', 7, NULL, '바이올린 소나타 D단조', 'No. 7 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26a84781-e775-4b68-9d92-065a72c2b2a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc06b5a2-bd86-33a8-9a5b-f026dfc07e30', 1, 'I', '프렐류드. Vivace', 'I. Preludio: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26a84781-e775-4b68-9d92-065a72c2b2a7'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc06b5a2-bd86-33a8-9a5b-f026dfc07e30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0cdc4ee-b689-3ceb-8fe5-3ef9bf699342', 2, 'II', '쿠랑트. Allegro', 'II. Corrente: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26a84781-e775-4b68-9d92-065a72c2b2a7'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0cdc4ee-b689-3ceb-8fe5-3ef9bf699342'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a942ba2f-0a66-33dc-a708-ad5823459c54', 3, 'III', '사라방드. Largo', 'III. Sarabanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26a84781-e775-4b68-9d92-065a72c2b2a7'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a942ba2f-0a66-33dc-a708-ad5823459c54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b8feaa9-94eb-3830-b487-5e555e623c6d', 4, 'IV', '지그. Allegro', 'IV. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:26a84781-e775-4b68-9d92-065a72c2b2a7'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b8feaa9-94eb-3830-b487-5e555e623c6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c8d453b-0989-4e70-b15f-57ecbf72eb6a', 8, NULL, '바이올린 소나타 E단조', 'No. 8 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c8d453b-0989-4e70-b15f-57ecbf72eb6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b688d52d-cbe8-3374-b7ab-7267cdcf23f3', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4c8d453b-0989-4e70-b15f-57ecbf72eb6a'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b688d52d-cbe8-3374-b7ab-7267cdcf23f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6520d37b-6d2f-3777-8462-c9c482138b1c', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4c8d453b-0989-4e70-b15f-57ecbf72eb6a'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6520d37b-6d2f-3777-8462-c9c482138b1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3aa6a48e-cfbf-33e8-b59a-408d6c515932', 3, 'III', '사라방드. Largo', 'III. Sarabanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4c8d453b-0989-4e70-b15f-57ecbf72eb6a'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3aa6a48e-cfbf-33e8-b59a-408d6c515932'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:acc92b3b-d9e1-3c16-9d7c-f1c55d1b3d4a', 4, 'IV', '지그. Allegro', 'IV. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4c8d453b-0989-4e70-b15f-57ecbf72eb6a'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acc92b3b-d9e1-3c16-9d7c-f1c55d1b3d4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88b60b5f-a9b0-4386-80ae-56cf63011332', 9, NULL, '바이올린 소나타 A장조', 'No. 9 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88b60b5f-a9b0-4386-80ae-56cf63011332'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee225e96-48df-37a2-9010-777bb0d330dc', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88b60b5f-a9b0-4386-80ae-56cf63011332'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee225e96-48df-37a2-9010-777bb0d330dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:535df286-7dba-351d-83b0-fda3209590c0', 2, 'II', '지그. Allegro', 'II. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88b60b5f-a9b0-4386-80ae-56cf63011332'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:535df286-7dba-351d-83b0-fda3209590c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50f65b08-7f67-3d4c-95b6-597fb2482c94', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88b60b5f-a9b0-4386-80ae-56cf63011332'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50f65b08-7f67-3d4c-95b6-597fb2482c94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5106c491-51d2-3d58-b302-c1e1bd012a78', 4, 'IV', 'Tempo di gavotta. Allegro', 'IV. Tempo di gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88b60b5f-a9b0-4386-80ae-56cf63011332'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5106c491-51d2-3d58-b302-c1e1bd012a78'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab60494c-e97f-4e6a-b242-13828cc4bcf8', 10, NULL, '바이올린 소나타 F장조', 'No. 10 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab60494c-e97f-4e6a-b242-13828cc4bcf8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3194af26-a94f-3bdd-a001-231c0c650879', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab60494c-e97f-4e6a-b242-13828cc4bcf8'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3194af26-a94f-3bdd-a001-231c0c650879'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:64314f45-b711-3171-b206-e636e5de499a', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab60494c-e97f-4e6a-b242-13828cc4bcf8'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64314f45-b711-3171-b206-e636e5de499a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:383aa19b-113f-3a0f-b91e-9e391ce2204a', 3, 'III', '사라방드. Largo', 'III. Sarabanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab60494c-e97f-4e6a-b242-13828cc4bcf8'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:383aa19b-113f-3a0f-b91e-9e391ce2204a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:994b49e0-f02d-3bff-80a1-e003abf4dcb2', 4, 'IV', '가보트. Allegro', 'IV. Gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab60494c-e97f-4e6a-b242-13828cc4bcf8'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:994b49e0-f02d-3bff-80a1-e003abf4dcb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:07e4b00c-e8a5-36c0-be53-50dc40132725', 5, 'V', '지그. Allegro', 'V. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ab60494c-e97f-4e6a-b242-13828cc4bcf8'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07e4b00c-e8a5-36c0-be53-50dc40132725'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f517ce89-55bb-418a-83b4-e9f4b152f3e0', 11, NULL, '바이올린 소나타 E장조', 'No. 11 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f517ce89-55bb-418a-83b4-e9f4b152f3e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67e77824-a102-3399-b165-eba471fd76b9', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f517ce89-55bb-418a-83b4-e9f4b152f3e0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67e77824-a102-3399-b165-eba471fd76b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fb1895f-e257-3e00-a3c9-1066a3c06f13', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f517ce89-55bb-418a-83b4-e9f4b152f3e0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fb1895f-e257-3e00-a3c9-1066a3c06f13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4229a877-2779-3166-a114-ac04d25b7568', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f517ce89-55bb-418a-83b4-e9f4b152f3e0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4229a877-2779-3166-a114-ac04d25b7568'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ed543d2-5165-3504-b4eb-0d138bb511eb', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f517ce89-55bb-418a-83b4-e9f4b152f3e0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ed543d2-5165-3504-b4eb-0d138bb511eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12aad1bd-af3f-3564-8d51-17f71870cad2', 5, 'V', '가보트. Allegro', 'V. Gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f517ce89-55bb-418a-83b4-e9f4b152f3e0'
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12aad1bd-af3f-3564-8d51-17f71870cad2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 58 AND linked.composer_id = 12), 'musicbrainz:b279ae2e-5c7e-332d-882e-9294fb7ac92e', 12, NULL, '바이올린 소나타 D단조 "라 폴리아"', 'No. 12 in D minor "La Folia"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '바이올린 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b279ae2e-5c7e-332d-882e-9294fb7ac92e'
);


-- Op. 6 12개의 합주 협주곡

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5155e79-1086-4359-bdf3-2c0757114ddb'
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5155e79-1086-4359-bdf3-2c0757114ddb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:502d6fb7-7d0e-45fa-8cbd-b7a9fd827c92', 1, NULL, '합주 협주곡 D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:502d6fb7-7d0e-45fa-8cbd-b7a9fd827c92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:553b23c7-ac41-3dfd-867a-45bfc7b5ab2b', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:502d6fb7-7d0e-45fa-8cbd-b7a9fd827c92'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:553b23c7-ac41-3dfd-867a-45bfc7b5ab2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fbc1083-d4f0-3287-a23e-bc08dae05aa6', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:502d6fb7-7d0e-45fa-8cbd-b7a9fd827c92'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fbc1083-d4f0-3287-a23e-bc08dae05aa6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:49155e39-d23e-3e14-8b46-ddbb870427d7', 3, 'III', 'Largo – Allegro', 'III. Largo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:502d6fb7-7d0e-45fa-8cbd-b7a9fd827c92'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49155e39-d23e-3e14-8b46-ddbb870427d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ae5a255-ab81-33fb-9f05-10af35960b8f', 4, 'IV', 'Largo – Allegro', 'IV. Largo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:502d6fb7-7d0e-45fa-8cbd-b7a9fd827c92'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ae5a255-ab81-33fb-9f05-10af35960b8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b65792aa-d27c-3703-b4d4-4061e3f8e6d0', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:502d6fb7-7d0e-45fa-8cbd-b7a9fd827c92'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b65792aa-d27c-3703-b4d4-4061e3f8e6d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e64fae8-af33-4757-b8be-80d147da475e', 2, NULL, '합주 협주곡 F장조', 'No. 2 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e64fae8-af33-4757-b8be-80d147da475e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:352a615f-e2d8-3736-9d5c-1812c82f25d5', 1, 'I', 'Vivace – Allegro – Adagio', 'I. Vivace – Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e64fae8-af33-4757-b8be-80d147da475e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:352a615f-e2d8-3736-9d5c-1812c82f25d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2484d996-9aa6-35be-94ef-2b900d71ba84', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e64fae8-af33-4757-b8be-80d147da475e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2484d996-9aa6-35be-94ef-2b900d71ba84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:08c1b6e4-0d0e-3415-94af-34fda9d5e094', 3, 'III', 'Grave – Largo', 'III. Grave – Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e64fae8-af33-4757-b8be-80d147da475e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08c1b6e4-0d0e-3415-94af-34fda9d5e094'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0511cd5f-bdbb-3d45-b7a1-190fb9ed0746', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0e64fae8-af33-4757-b8be-80d147da475e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0511cd5f-bdbb-3d45-b7a1-190fb9ed0746'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15206c9e-42f1-4e89-a239-5057578d0987', 3, NULL, '합주 협주곡 C단조', 'No. 3 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15206c9e-42f1-4e89-a239-5057578d0987'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:88aea9f8-a9e5-3de1-9e8a-96ef2ec0a5de', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15206c9e-42f1-4e89-a239-5057578d0987'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88aea9f8-a9e5-3de1-9e8a-96ef2ec0a5de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bef29f4f-17bb-3e2e-aec8-240540f7d5ee', 2, 'II', 'Allegro – Adagio', 'II. Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15206c9e-42f1-4e89-a239-5057578d0987'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bef29f4f-17bb-3e2e-aec8-240540f7d5ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0c462779-19c7-3f23-913c-f88824e43658', 3, 'III', 'Grave', 'III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15206c9e-42f1-4e89-a239-5057578d0987'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c462779-19c7-3f23-913c-f88824e43658'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4aaa8e82-a344-347b-92b6-c61796adcdea', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15206c9e-42f1-4e89-a239-5057578d0987'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4aaa8e82-a344-347b-92b6-c61796adcdea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:315b1997-1e89-3227-ad74-63d5adebf425', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:15206c9e-42f1-4e89-a239-5057578d0987'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:315b1997-1e89-3227-ad74-63d5adebf425'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:629402a8-83e7-45aa-9eb5-9bb61ed92c20', 4, NULL, '합주 협주곡 D장조', 'No. 4 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:629402a8-83e7-45aa-9eb5-9bb61ed92c20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a38e850e-7077-32ca-8b91-411a5c84646b', 1, 'I', 'Adagio – Allegro', 'I. Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:629402a8-83e7-45aa-9eb5-9bb61ed92c20'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a38e850e-7077-32ca-8b91-411a5c84646b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0d8945b-25bf-30cf-a2f4-3595f24926e8', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:629402a8-83e7-45aa-9eb5-9bb61ed92c20'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d8945b-25bf-30cf-a2f4-3595f24926e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:864d94ac-accd-3a11-af83-e7f260c7ffdb', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:629402a8-83e7-45aa-9eb5-9bb61ed92c20'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:864d94ac-accd-3a11-af83-e7f260c7ffdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50651431-1596-3257-bcd4-009a0cbfbc35', 4, 'IV', 'Allegro – 지그. Presto', 'IV. Allegro – Giga: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:629402a8-83e7-45aa-9eb5-9bb61ed92c20'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50651431-1596-3257-bcd4-009a0cbfbc35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:703cd02c-cd7d-4c5f-aed7-11ea772e045f', 5, NULL, '합주 협주곡 B♭장조', 'No. 5 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:703cd02c-cd7d-4c5f-aed7-11ea772e045f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3a762c5-56a4-3514-8375-3bdbf5fe7798', 1, 'I', 'Adagio – Allegro – Adagio', 'I. Adagio – Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:703cd02c-cd7d-4c5f-aed7-11ea772e045f'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3a762c5-56a4-3514-8375-3bdbf5fe7798'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:36e5c5e3-1cb5-3a8d-98a0-bbba85485107', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:703cd02c-cd7d-4c5f-aed7-11ea772e045f'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36e5c5e3-1cb5-3a8d-98a0-bbba85485107'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3f34063a-3b53-39f2-b1b8-d922b9600e05', 3, 'III', 'Allegro – Adagio', 'III. Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:703cd02c-cd7d-4c5f-aed7-11ea772e045f'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f34063a-3b53-39f2-b1b8-d922b9600e05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3a2e701-05ae-37ee-a75e-e1d0241723e2', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:703cd02c-cd7d-4c5f-aed7-11ea772e045f'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3a2e701-05ae-37ee-a75e-e1d0241723e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:76909406-f3e1-32ec-89d2-5b93e96a59b0', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:703cd02c-cd7d-4c5f-aed7-11ea772e045f'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76909406-f3e1-32ec-89d2-5b93e96a59b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:976636d4-61a5-4d90-8127-d87217ae6406', 6, NULL, '합주 협주곡 F장조', 'No. 6 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:976636d4-61a5-4d90-8127-d87217ae6406'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f3ab48fa-7247-39ab-adf8-ea459e1749bd', 1, 'I', 'Adagio', 'I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:976636d4-61a5-4d90-8127-d87217ae6406'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3ab48fa-7247-39ab-adf8-ea459e1749bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cfb7b73f-faee-3698-8ba6-472d8e92b65a', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:976636d4-61a5-4d90-8127-d87217ae6406'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfb7b73f-faee-3698-8ba6-472d8e92b65a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3af83685-5b07-372d-b2a7-48e13d7ccc01', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:976636d4-61a5-4d90-8127-d87217ae6406'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af83685-5b07-372d-b2a7-48e13d7ccc01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:03f7319a-31f8-362d-9e43-11338bf66cfc', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:976636d4-61a5-4d90-8127-d87217ae6406'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03f7319a-31f8-362d-9e43-11338bf66cfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f96e0ad-1cfa-366e-9cd7-dce80b2f361e', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:976636d4-61a5-4d90-8127-d87217ae6406'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f96e0ad-1cfa-366e-9cd7-dce80b2f361e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb73bde6-318d-45b8-ac05-2691eab3f911', 7, NULL, '합주 협주곡 D장조', 'No. 7 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb73bde6-318d-45b8-ac05-2691eab3f911'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae29001c-315d-3ed3-bda7-a1d70c3f141b', 1, 'I', 'Vivace – Allegro – Adagio', 'I. Vivace – Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb73bde6-318d-45b8-ac05-2691eab3f911'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae29001c-315d-3ed3-bda7-a1d70c3f141b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f93273ba-75a6-3b05-8a49-06e9ac593326', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb73bde6-318d-45b8-ac05-2691eab3f911'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f93273ba-75a6-3b05-8a49-06e9ac593326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70a0d81b-1e1f-357d-a8d3-7645e71c6fd1', 3, 'III', 'Andante largo', 'III. Andante largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb73bde6-318d-45b8-ac05-2691eab3f911'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70a0d81b-1e1f-357d-a8d3-7645e71c6fd1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7dea2ab-7189-343f-84a8-d2bc5bad8b65', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb73bde6-318d-45b8-ac05-2691eab3f911'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7dea2ab-7189-343f-84a8-d2bc5bad8b65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d3bc414-c7ba-3667-b815-c3191f8e3123', 5, 'V', 'Vivace', 'V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb73bde6-318d-45b8-ac05-2691eab3f911'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d3bc414-c7ba-3667-b815-c3191f8e3123'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 57 AND linked.composer_id = 12), 'musicbrainz:a5c09747-917c-41c8-9e17-a24a649fb95e', 8, NULL, '합주 협주곡 G단조 "크리스마스 협주곡"', 'No. 8 in G minor "Christmas Concerto"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5c09747-917c-41c8-9e17-a24a649fb95e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:674bc0bd-4c45-3694-ab0e-5bcf83f84ebd', 1, 'I', 'Vivace – Grave', 'I. Vivace – Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5c09747-917c-41c8-9e17-a24a649fb95e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:674bc0bd-4c45-3694-ab0e-5bcf83f84ebd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c879457a-e00a-3332-ab78-d5e1ea2b61b8', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5c09747-917c-41c8-9e17-a24a649fb95e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c879457a-e00a-3332-ab78-d5e1ea2b61b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:39c56318-f185-3f57-a033-1e42ef37a1f3', 3, 'III', 'Adagio – Allegro – Adagio', 'III. Adagio – Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5c09747-917c-41c8-9e17-a24a649fb95e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39c56318-f185-3f57-a033-1e42ef37a1f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a0cfba5a-831f-37cd-874b-2d53c30da410', 4, 'IV', 'Vivace', 'IV. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5c09747-917c-41c8-9e17-a24a649fb95e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0cfba5a-831f-37cd-874b-2d53c30da410'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9996b31-b3bc-3121-9666-ceb34ffd1128', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5c09747-917c-41c8-9e17-a24a649fb95e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9996b31-b3bc-3121-9666-ceb34ffd1128'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc74a1ae-5770-3f28-97a7-6d6ddbe225db', 6, 'VI', 'Largo – 파스토랄레 ad libitum', 'VI. Largo – Pastorale ad libitum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a5c09747-917c-41c8-9e17-a24a649fb95e'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc74a1ae-5770-3f28-97a7-6d6ddbe225db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f94e4505-8e8c-4695-bd7a-6e08a7d9f87d', 9, NULL, '합주 협주곡 F장조', 'No. 9 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f94e4505-8e8c-4695-bd7a-6e08a7d9f87d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:38303bed-95e7-3070-896c-b02c6f4079ea', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f94e4505-8e8c-4695-bd7a-6e08a7d9f87d'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38303bed-95e7-3070-896c-b02c6f4079ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c7e4ffb-49b7-349d-bb53-fe49b104442b', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f94e4505-8e8c-4695-bd7a-6e08a7d9f87d'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c7e4ffb-49b7-349d-bb53-fe49b104442b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:65240f4d-30b2-3724-a4aa-03e52f41584d', 3, 'III', '쿠랑트. Vivace', 'III. Corrente: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f94e4505-8e8c-4695-bd7a-6e08a7d9f87d'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65240f4d-30b2-3724-a4aa-03e52f41584d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ccc8da5-118e-3174-9bb9-1932184d4d9c', 4, 'IV', '가보트. Allegro', 'IV. Gavotta: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f94e4505-8e8c-4695-bd7a-6e08a7d9f87d'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ccc8da5-118e-3174-9bb9-1932184d4d9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0310e1d-3667-35f3-b32c-6b61ab33ef59', 5, 'V', 'Adagio', 'V. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f94e4505-8e8c-4695-bd7a-6e08a7d9f87d'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0310e1d-3667-35f3-b32c-6b61ab33ef59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5360d0c3-9e3b-371e-a595-68369ba3d2a4', 6, 'VI', '미뉴에트. Vivace', 'VI. Minuetto: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f94e4505-8e8c-4695-bd7a-6e08a7d9f87d'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5360d0c3-9e3b-371e-a595-68369ba3d2a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad4ab223-323e-4e9a-a8fe-82a288725135', 10, NULL, '합주 협주곡 C장조', 'No. 10 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad4ab223-323e-4e9a-a8fe-82a288725135'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a3cb8f9-b1a7-3ea4-9ee6-78dfc6f13528', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad4ab223-323e-4e9a-a8fe-82a288725135'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a3cb8f9-b1a7-3ea4-9ee6-78dfc6f13528'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7658caab-59e8-3682-a608-44f0572d2ac0', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad4ab223-323e-4e9a-a8fe-82a288725135'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7658caab-59e8-3682-a608-44f0572d2ac0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:73a1ed77-c98a-343c-bef2-c7c7a6ff81fe', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad4ab223-323e-4e9a-a8fe-82a288725135'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73a1ed77-c98a-343c-bef2-c7c7a6ff81fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b8b0f73-b57e-3a38-86bf-404a486834e9', 4, 'IV', '쿠랑트. Vivace', 'IV. Corrente: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad4ab223-323e-4e9a-a8fe-82a288725135'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b8b0f73-b57e-3a38-86bf-404a486834e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b98e2df-dfc7-3286-83a3-2f88a5a49658', 5, 'V', 'Allegro', 'V. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad4ab223-323e-4e9a-a8fe-82a288725135'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b98e2df-dfc7-3286-83a3-2f88a5a49658'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:719f81c6-087d-30bf-939e-d210b48aad5c', 6, 'VI', '미뉴에트. Vivace', 'VI. Minuetto: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ad4ab223-323e-4e9a-a8fe-82a288725135'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:719f81c6-087d-30bf-939e-d210b48aad5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea655a9b-3270-4d60-a72d-bef0ec044c0c', 11, NULL, '합주 협주곡 B♭장조', 'No. 11 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea655a9b-3270-4d60-a72d-bef0ec044c0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a892ae3-35d8-3428-8099-4d259c9ec318', 1, 'I', '프렐류드. Largo', 'I. Preludio: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea655a9b-3270-4d60-a72d-bef0ec044c0c'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a892ae3-35d8-3428-8099-4d259c9ec318'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1bf20fed-f5f8-3da1-83bd-b50a0c693694', 2, 'II', '알르망드. Allegro', 'II. Allemanda: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea655a9b-3270-4d60-a72d-bef0ec044c0c'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bf20fed-f5f8-3da1-83bd-b50a0c693694'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7e46c319-1776-3370-a2d5-9a28b5d75acf', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea655a9b-3270-4d60-a72d-bef0ec044c0c'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e46c319-1776-3370-a2d5-9a28b5d75acf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f09a5c39-82e4-48e0-b100-c28d989f168d', 4, 'IV', 'Largo', 'IV. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea655a9b-3270-4d60-a72d-bef0ec044c0c'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f09a5c39-82e4-48e0-b100-c28d989f168d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6027d71-1039-3457-99cf-acc3cab7fa92', 5, 'V', '사라방드. Largo', 'V. Sarabanda: Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea655a9b-3270-4d60-a72d-bef0ec044c0c'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6027d71-1039-3457-99cf-acc3cab7fa92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6f7d116-762d-3bd9-b8d4-2c9126c7b289', 6, 'VI', '지그. Vivace', 'VI. Giga: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea655a9b-3270-4d60-a72d-bef0ec044c0c'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6f7d116-762d-3bd9-b8d4-2c9126c7b289'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d2f2eec-e806-4f6e-b8c0-4d1d74fcddc3', 12, NULL, '합주 협주곡 F장조', 'No. 12 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d2f2eec-e806-4f6e-b8c0-4d1d74fcddc3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b556f98b-7bda-3e98-a6f8-222a29299be2', 1, 'I', '프렐류드. Adagio', 'I. Preludio: Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d2f2eec-e806-4f6e-b8c0-4d1d74fcddc3'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b556f98b-7bda-3e98-a6f8-222a29299be2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7112f1b4-b18e-3b51-b2d8-71842833ea97', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d2f2eec-e806-4f6e-b8c0-4d1d74fcddc3'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7112f1b4-b18e-3b51-b2d8-71842833ea97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cc258e8f-85d5-38cc-ab6f-d90cfcef261d', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d2f2eec-e806-4f6e-b8c0-4d1d74fcddc3'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc258e8f-85d5-38cc-ab6f-d90cfcef261d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:900d18d6-3a44-352d-9fa7-b7e65a515137', 4, 'IV', '사라방드. Vivace', 'IV. Sarabanda: Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d2f2eec-e806-4f6e-b8c0-4d1d74fcddc3'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:900d18d6-3a44-352d-9fa7-b7e65a515137'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5dd321e8-1e30-388b-a523-d7120b76951e', 5, 'V', '지그. Allegro', 'V. Giga: Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d2f2eec-e806-4f6e-b8c0-4d1d74fcddc3'
WHERE p.id = 59 AND p.composer_id = 12
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dd321e8-1e30-388b-a523-d7120b76951e'
);


-- WoO 1 신포니아 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 D단조', 'Sinfonia in D minor to "Santa Beatrice d''Este"', 'album', 'WoO 1', NULL, NULL, 1689, 'manual', 1
FROM composers c
WHERE c.id = 12
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 D단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cafca75c-4336-4c67-8b91-5e802c2aeafb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cafca75c-4336-4c67-8b91-5e802c2aeafb'
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '신포니아 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cafca75c-4336-4c67-8b91-5e802c2aeafb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38e616b5-3f9b-3512-a352-aac5cefe1b07', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '신포니아 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38e616b5-3f9b-3512-a352-aac5cefe1b07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8a63725-901b-378f-a1f1-746642c4d0c6', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '신포니아 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8a63725-901b-378f-a1f1-746642c4d0c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fa76e2b-8bab-336c-a362-7cf2c1405907', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '신포니아 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fa76e2b-8bab-336c-a362-7cf2c1405907'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:739cd241-cefe-3c4e-8292-77f420149dbc', 4, 'IV', 'Largo assai', 'IV. Largo assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '신포니아 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:739cd241-cefe-3c4e-8292-77f420149dbc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1bd32ae0-68eb-3549-972e-29c7a70bf558', 5, 'V', 'Vivace', 'V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '신포니아 D단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd32ae0-68eb-3549-972e-29c7a70bf558'
);


-- WoO 2 4성부 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4성부 소나타', 'Sonata a quattro', 'album', 'WoO 2', NULL, NULL, 1699, 'manual', 1
FROM composers c
WHERE c.id = 12
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4성부 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd09df0c-4e24-4034-b97d-0c4329608a3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd09df0c-4e24-4034-b97d-0c4329608a3e'
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '4성부 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd09df0c-4e24-4034-b97d-0c4329608a3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:648adb1d-4a80-3662-aa64-a44e4b7e4b19', 1, 'I', 'Adagio – Andante largo', 'I. Adagio – Andante largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '4성부 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:648adb1d-4a80-3662-aa64-a44e4b7e4b19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:757b773e-bf90-3c48-8225-e6c0e9f7f992', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '4성부 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:757b773e-bf90-3c48-8225-e6c0e9f7f992'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3cc5474-468e-3891-ad9b-8d0d85640598', 3, 'III', 'Grave', 'III. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '4성부 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3cc5474-468e-3891-ad9b-8d0d85640598'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b902463a-888a-31a2-807f-cd698a12a9c0', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '4성부 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b902463a-888a-31a2-807f-cd698a12a9c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b7e5e70-d7e6-3afc-9e49-288ee5919676', 5, 'V', 'Vivace', 'V. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '4성부 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b7e5e70-d7e6-3afc-9e49-288ee5919676'
);


-- WoO 5 트리오 소나타 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 A장조', 'Trio Sonata in A major', 'album', 'WoO 5', NULL, NULL, 1714, 'manual', 1
FROM composers c
WHERE c.id = 12
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2152af71-c602-4cae-8865-1893fe4cabcb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2152af71-c602-4cae-8865-1893fe4cabcb'
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '트리오 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2152af71-c602-4cae-8865-1893fe4cabcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0616cd36-994c-3b0a-b2ee-4caf65e08f49', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '트리오 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0616cd36-994c-3b0a-b2ee-4caf65e08f49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88b70e34-d6c6-302d-a370-496c72bfa5b4', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '트리오 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88b70e34-d6c6-302d-a370-496c72bfa5b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a316e4c6-c8b0-3f1b-b5d9-e78423ff1b75', 3, 'III', 'Adagio', 'III. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '트리오 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a316e4c6-c8b0-3f1b-b5d9-e78423ff1b75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d589011-d364-399f-9ed0-53807f4a38d5', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 12 AND p.title = '트리오 소나타 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d589011-d364-399f-9ed0-53807f4a38d5'
);

