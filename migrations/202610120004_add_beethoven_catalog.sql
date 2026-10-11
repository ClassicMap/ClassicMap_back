-- 베토벤 작품을 출판 단위로 채운다. 작품 356개(묶음 50, 다악장 75, 낱곡 231), part 541, 그 아래 162.
-- 새 작품 343개, 기존 13개(MBID), 「월광」 78 은 「피아노 소나타 Op. 27」 2번 part 로 잇는다.
--
-- 정한 것
--   Op. 2·10·31(소나타 3곡), Op. 14·27·49(2곡), Op. 18(4중주 6곡), Op. 59, Op. 1, Op. 12·30, Op. 5·102,
--     바가텔 Op. 33·119·126 등은 묶음이고, 안의 소나타·4중주 악장은 그 아래 part 다.
--   민요 편곡(Op. 108, WoO 152–158)은 뺀다. 민요 주제 변주곡 Op. 105·107 은 넣는다.
--   2014년 신판 WoO 206–228 의 완성 곡과 Hess 34·229·274 도 넣는다.
--   변주곡(Op. 35·120, WoO 80 등)은 변주별 part 없이 둔다.
--   자기 편곡 Op. 38·61a·134 와 베토벤이 고친 남의 편곡 Op. 41·42·104 는 넣고, 위작 Op. 63·64 는 뺀다.
--   <레오노레> 서곡 1–3번은 Op. 138·72a·72b 로 따로 두고, 옛 판 오페라 <레오노레> 는 뺀다.
--
-- 공통: 자료는 seed_pipeline/curation/catalog-wave1-2026-10-11/<작곡가>/catalog.json 이고, 본문은 그 폴더의
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

-- Op. 1 피아노 3중주 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 Op. 1', '3 Piano Trios, Op. 1', 'album', NULL, 'Op.', '1', 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 Op. 1'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c15293c6-faf3-4d8f-9bf4-b800f7a19154'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c15293c6-faf3-4d8f-9bf4-b800f7a19154'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c15293c6-faf3-4d8f-9bf4-b800f7a19154'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65b1caca-9073-4284-b5fa-29b928810b86', 1, NULL, '피아노 3중주 1번 E♭장조', 'Piano Trio No. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65b1caca-9073-4284-b5fa-29b928810b86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:45eaf2c4-28d9-3783-bd43-dc2ab5fd0cb9', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65b1caca-9073-4284-b5fa-29b928810b86'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45eaf2c4-28d9-3783-bd43-dc2ab5fd0cb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:622d3722-fe83-3c68-930f-fa462304a0bb', 2, 'II', 'Adagio cantabile', 'II. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65b1caca-9073-4284-b5fa-29b928810b86'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:622d3722-fe83-3c68-930f-fa462304a0bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c49df12-b467-3630-9ccd-0bd42976bbf8', 3, 'III', '스케르초. Allegro assai – 트리오', 'III. Scherzo. Allegro assai – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65b1caca-9073-4284-b5fa-29b928810b86'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c49df12-b467-3630-9ccd-0bd42976bbf8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d4c1181-1913-3e82-aff0-01e74af78e5f', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:65b1caca-9073-4284-b5fa-29b928810b86'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d4c1181-1913-3e82-aff0-01e74af78e5f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d298dbe-c189-4c67-9982-936460a7ba88', 2, NULL, '피아노 3중주 2번 G장조', 'Piano Trio No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d298dbe-c189-4c67-9982-936460a7ba88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b4df7307-0dbf-31e0-9864-89b829324c63', 1, 'I', 'Adagio – Allegro vivace', 'I. Adagio – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d298dbe-c189-4c67-9982-936460a7ba88'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4df7307-0dbf-31e0-9864-89b829324c63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a9e4fd8-a3ad-3a43-bfca-f65b9927320f', 2, 'II', 'Largo con espressione', 'II. Largo con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d298dbe-c189-4c67-9982-936460a7ba88'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a9e4fd8-a3ad-3a43-bfca-f65b9927320f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b41b33f-951c-3db1-9d31-5f669fae5f16', 3, 'III', '스케르초. Allegro – 트리오', 'III. Scherzo. Allegro – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d298dbe-c189-4c67-9982-936460a7ba88'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b41b33f-951c-3db1-9d31-5f669fae5f16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:17e3e4d9-0bee-3f34-83df-d5e496ad14d6', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4d298dbe-c189-4c67-9982-936460a7ba88'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17e3e4d9-0bee-3f34-83df-d5e496ad14d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f00d2f8d-6ae3-4a3a-8306-f14b0e56ed16', 3, NULL, '피아노 3중주 3번 C단조', 'Piano Trio No. 3 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f00d2f8d-6ae3-4a3a-8306-f14b0e56ed16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7ae69e0-3e67-3f3a-a63d-c229f2000ad7', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f00d2f8d-6ae3-4a3a-8306-f14b0e56ed16'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7ae69e0-3e67-3f3a-a63d-c229f2000ad7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82345b88-0de0-3fac-b33f-c09b84739309', 2, 'II', 'Andante cantabile con variazioni', 'II. Andante cantabile con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f00d2f8d-6ae3-4a3a-8306-f14b0e56ed16'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82345b88-0de0-3fac-b33f-c09b84739309'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1bd3db81-3b45-3acc-8b78-1f4d6dc54435', 3, 'III', '미뉴에트. Quasi allegro', 'III. Menuetto. Quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f00d2f8d-6ae3-4a3a-8306-f14b0e56ed16'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1bd3db81-3b45-3acc-8b78-1f4d6dc54435'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:de628e28-bc07-35a0-a20b-2b7185f081c5', 4, 'IV', '피날레. Prestissimo', 'IV. Finale. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f00d2f8d-6ae3-4a3a-8306-f14b0e56ed16'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de628e28-bc07-35a0-a20b-2b7185f081c5'
);


-- Op. 2 피아노 소나타 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 2', '3 Piano Sonatas, Op. 2', 'album', NULL, 'Op.', '2', 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 2'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc2b8f7f-8619-4a0d-8337-5d8659366555'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc2b8f7f-8619-4a0d-8337-5d8659366555'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc2b8f7f-8619-4a0d-8337-5d8659366555'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d99b54dc-9a4c-4b34-ba9c-1223d7e0b1c5', 1, NULL, '피아노 소나타 1번 F단조', 'Piano Sonata No. 1 in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d99b54dc-9a4c-4b34-ba9c-1223d7e0b1c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a78520e0-0211-3b5a-a65d-2dbc22714fff', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d99b54dc-9a4c-4b34-ba9c-1223d7e0b1c5'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a78520e0-0211-3b5a-a65d-2dbc22714fff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bea1b893-2732-33ad-bc47-84eac5c58f00', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d99b54dc-9a4c-4b34-ba9c-1223d7e0b1c5'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bea1b893-2732-33ad-bc47-84eac5c58f00'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2bd7e1ea-c696-3be4-a40a-27e2b95e074a', 3, 'III', '미뉴에트. Allegretto', 'III. Menuetto. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d99b54dc-9a4c-4b34-ba9c-1223d7e0b1c5'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bd7e1ea-c696-3be4-a40a-27e2b95e074a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b755e900-804a-312d-9946-da49e5d1581f', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d99b54dc-9a4c-4b34-ba9c-1223d7e0b1c5'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b755e900-804a-312d-9946-da49e5d1581f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a2ed89a-05ea-4c0d-9833-8cd659d1bd20', 2, NULL, '피아노 소나타 2번 A장조', 'Piano Sonata No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a2ed89a-05ea-4c0d-9833-8cd659d1bd20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c001a2eb-9493-3273-a3df-dea8b543fc92', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a2ed89a-05ea-4c0d-9833-8cd659d1bd20'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c001a2eb-9493-3273-a3df-dea8b543fc92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cd5ab598-756c-3da2-8196-39f0cae57b75', 2, 'II', 'Largo appassionato', 'II. Largo appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a2ed89a-05ea-4c0d-9833-8cd659d1bd20'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd5ab598-756c-3da2-8196-39f0cae57b75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9b9be9f-b037-3035-a48e-42dba309c7cc', 3, 'III', '스케르초. Allegretto', 'III. Scherzo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a2ed89a-05ea-4c0d-9833-8cd659d1bd20'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9b9be9f-b037-3035-a48e-42dba309c7cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:616222d2-d59e-31e3-85cc-cc66a9f507d8', 4, 'IV', '론도. Grazioso', 'IV. Rondo. Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2a2ed89a-05ea-4c0d-9833-8cd659d1bd20'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:616222d2-d59e-31e3-85cc-cc66a9f507d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4ad988b-b0b2-4c25-863b-e2b8e13c78d3', 3, NULL, '피아노 소나타 3번 C장조', 'Piano Sonata No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4ad988b-b0b2-4c25-863b-e2b8e13c78d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:072edf91-1e60-3255-bc52-5a1aeb3c7212', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4ad988b-b0b2-4c25-863b-e2b8e13c78d3'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:072edf91-1e60-3255-bc52-5a1aeb3c7212'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a11b4d2-261d-3425-a452-0971b7a1e692', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4ad988b-b0b2-4c25-863b-e2b8e13c78d3'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a11b4d2-261d-3425-a452-0971b7a1e692'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a7c73d7a-21ff-3399-816c-aad2b82c0045', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4ad988b-b0b2-4c25-863b-e2b8e13c78d3'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7c73d7a-21ff-3399-816c-aad2b82c0045'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db3feebb-999f-3a75-bf1b-ddf6412c9b2d', 4, 'IV', 'Allegro assai', 'IV. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e4ad988b-b0b2-4c25-863b-e2b8e13c78d3'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db3feebb-999f-3a75-bf1b-ddf6412c9b2d'
);


-- Op. 3 현악 3중주 1번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 3중주 1번 E♭장조', 'String Trio No. 1 in E♭ major', 'album', 'Op. 3', NULL, NULL, 1794, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 3중주 1번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a33cdb4e-ea1f-455d-8f10-4dbcdde56d0a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a33cdb4e-ea1f-455d-8f10-4dbcdde56d0a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a33cdb4e-ea1f-455d-8f10-4dbcdde56d0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f4975f1-acf4-366b-b17c-d22666ac9c1b', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f4975f1-acf4-366b-b17c-d22666ac9c1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d36940ac-5625-3024-ab60-063e94b3263d', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d36940ac-5625-3024-ab60-063e94b3263d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9a78970-a548-39d4-a312-cc9633c9055e', 3, 'III', '미뉴에트. Allegretto', 'III. Menuetto. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9a78970-a548-39d4-a312-cc9633c9055e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2b8626c-c7e2-3646-90f4-0e669de51fe4', 4, 'IV', 'Adagio', 'IV. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2b8626c-c7e2-3646-90f4-0e669de51fe4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e506b20-3e6c-3532-9625-3dbdb71cd9ab', 5, 'V', '미뉴에트. Moderato', 'V. Menuetto. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e506b20-3e6c-3532-9625-3dbdb71cd9ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bce4b771-aeaf-3bfe-8a23-3f172e8a7759', 6, 'VI', '피날레. Allegro', 'VI. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 1번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bce4b771-aeaf-3bfe-8a23-3f172e8a7759'
);


-- Op. 4 현악 5중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주 E♭장조', 'String Quintet in E♭ major', 'album', 'Op. 4', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac4567da-ed05-4d70-b698-719c58906452'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac4567da-ed05-4d70-b698-719c58906452'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac4567da-ed05-4d70-b698-719c58906452'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1274b22b-108d-30c0-9119-25f856d37999', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1274b22b-108d-30c0-9119-25f856d37999'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80a3e6c1-123e-3e93-8b16-765c7abd4e39', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80a3e6c1-123e-3e93-8b16-765c7abd4e39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87f7578d-825a-377f-95e7-cb2d97679072', 3, 'III', '미뉴에트 più Allegretto – 트리오', 'III. Menuetto più Allegretto – Trio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87f7578d-825a-377f-95e7-cb2d97679072'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1edbaa61-999f-3143-9382-efed8cca3a20', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1edbaa61-999f-3143-9382-efed8cca3a20'
);


-- Op. 5 첼로 소나타 Op. 5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 소나타 Op. 5', '2 Cello Sonatas, Op. 5', 'album', NULL, 'Op.', '5', 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 소나타 Op. 5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6839959f-e575-4b56-8aca-e6d9cb477cdd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6839959f-e575-4b56-8aca-e6d9cb477cdd'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6839959f-e575-4b56-8aca-e6d9cb477cdd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b29f014e-84aa-451c-a80b-6a0d1ad09517', 1, NULL, '첼로 소나타 1번 F장조', 'Cello Sonata No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b29f014e-84aa-451c-a80b-6a0d1ad09517'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d622cfd2-2dde-376f-bc24-17986d7b64d3', 1, 'I', 'Adagio sostenuto – Allegro', 'I. Adagio sostenuto – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b29f014e-84aa-451c-a80b-6a0d1ad09517'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d622cfd2-2dde-376f-bc24-17986d7b64d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2a453f3-7566-3ff0-a6a7-44d325208568', 2, 'II', '론도. Allegro vivace', 'II. Rondo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b29f014e-84aa-451c-a80b-6a0d1ad09517'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2a453f3-7566-3ff0-a6a7-44d325208568'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b73e0d0e-8109-4560-b9ba-29eb167c7b16', 2, NULL, '첼로 소나타 2번 G단조', 'Cello Sonata No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b73e0d0e-8109-4560-b9ba-29eb167c7b16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c125d304-d6c3-3d5d-8e61-b05f19e93f2f', 1, 'I', 'Adagio sostenuto e espressivo – Allegro molto più tosto presto', 'I. Adagio sostenuto e espressivo – Allegro molto più tosto presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b73e0d0e-8109-4560-b9ba-29eb167c7b16'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c125d304-d6c3-3d5d-8e61-b05f19e93f2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57ae1b07-5a51-3e6d-aadd-adbeca073127', 2, 'II', '론도. Allegro', 'II. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b73e0d0e-8109-4560-b9ba-29eb167c7b16'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57ae1b07-5a51-3e6d-aadd-adbeca073127'
);


-- Op. 6 네 손을 위한 피아노 소나타 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 피아노 소나타 D장조', 'Sonata for Piano Four Hands in D major', 'album', 'Op. 6', NULL, NULL, 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 피아노 소나타 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '714609cd-9139-4e1c-86eb-b25be40fc119'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '714609cd-9139-4e1c-86eb-b25be40fc119'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '네 손을 위한 피아노 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '714609cd-9139-4e1c-86eb-b25be40fc119'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f99c1698-d555-3d0c-8c68-7c61187656db', 1, 'I', 'Allegro molto', 'I. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '네 손을 위한 피아노 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f99c1698-d555-3d0c-8c68-7c61187656db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:206a8f92-f8a5-3ed8-895c-077817ba429a', 2, 'II', '론도. Moderato', 'II. Rondo. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '네 손을 위한 피아노 소나타 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:206a8f92-f8a5-3ed8-895c-077817ba429a'
);


-- Op. 7 피아노 소나타 4번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 4번 E♭장조', 'Piano Sonata No. 4 in E♭ major', 'album', 'Op. 7', NULL, NULL, 1798, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 4번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f99c736a-9e65-4c13-813a-51776987993d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f99c736a-9e65-4c13-813a-51776987993d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 4번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f99c736a-9e65-4c13-813a-51776987993d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2be5754-815a-3045-a4b4-1108b00ebbb9', 1, 'I', 'Allegro molto e con brio', 'I. Allegro molto e con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 4번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2be5754-815a-3045-a4b4-1108b00ebbb9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59d4726f-889c-3bc0-ae22-923b3ad6f40f', 2, 'II', 'Largo, con gran espressione', 'II. Largo, con gran espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 4번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59d4726f-889c-3bc0-ae22-923b3ad6f40f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48c2ad24-3b7e-34b9-ab3b-8756ec40aa98', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 4번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c2ad24-3b7e-34b9-ab3b-8756ec40aa98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:642c3a1e-73d4-3d26-b8bb-759bdec6ca57', 4, 'IV', '론도. Poco allegretto e grazioso', 'IV. Rondo. Poco allegretto e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 4번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:642c3a1e-73d4-3d26-b8bb-759bdec6ca57'
);


-- Op. 8 현악 3중주를 위한 세레나데 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 3중주를 위한 세레나데 D장조', 'Serenade for String Trio in D major', 'album', 'Op. 8', NULL, NULL, 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 3중주를 위한 세레나데 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a28eb888-944c-41f5-86a5-5142df2b465b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a28eb888-944c-41f5-86a5-5142df2b465b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a28eb888-944c-41f5-86a5-5142df2b465b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a60c756-cf49-3318-8c96-d90c5fb20bf7', 1, 'I', '행진곡. Allegro – Adagio', 'I. Marcia. Allegro – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a60c756-cf49-3318-8c96-d90c5fb20bf7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0620f560-bf5c-338f-a02e-4b4375ab7ef2', 2, 'II', '미뉴에트. Allegretto', 'II. Menuetto. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0620f560-bf5c-338f-a02e-4b4375ab7ef2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:43e5cf76-9ddd-3849-8874-33a2ec33da9e', 3, 'III', 'Adagio – 스케르초. Allegro molto – Adagio – Allegro molto – Adagio', 'III. Adagio – Scherzo. Allegro molto – Adagio – Allegro molto – Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:43e5cf76-9ddd-3849-8874-33a2ec33da9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e53974b-309f-3cc6-988c-e16293427043', 4, 'IV', 'Allegretto alla Polacca', 'IV. Allegretto alla Polacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e53974b-309f-3cc6-988c-e16293427043'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8610dd01-02b2-3f0f-8d0f-aee25cd6fb16', 5, 'V', '주제와 변주. Andante quasi allegretto – 행진곡. Allegro', 'V. Tema con variazioni. Andante quasi allegretto – Marcia. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8610dd01-02b2-3f0f-8d0f-aee25cd6fb16'
);


-- Op. 9 현악 3중주 Op. 9

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 3중주 Op. 9', '3 String Trios, Op. 9', 'album', NULL, 'Op.', '9', 1798, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 3중주 Op. 9'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a08f6489-80c3-4b34-a20a-ea3fe523a104'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a08f6489-80c3-4b34-a20a-ea3fe523a104'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a08f6489-80c3-4b34-a20a-ea3fe523a104'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:899e038c-262f-4367-a287-88e0f552715c', 1, NULL, '현악 3중주 3번 G장조', 'String Trio No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:899e038c-262f-4367-a287-88e0f552715c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:733e4e69-9d14-37c4-8eef-b9f1c46ad4b3', 1, 'I', 'Adagio – Allegro con brio', 'I. Adagio – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:899e038c-262f-4367-a287-88e0f552715c'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:733e4e69-9d14-37c4-8eef-b9f1c46ad4b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b431778-ac42-3610-95b2-462e584bf849', 2, 'II', 'Adagio, ma non tanto, e cantabile', 'II. Adagio, ma non tanto, e cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:899e038c-262f-4367-a287-88e0f552715c'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b431778-ac42-3610-95b2-462e584bf849'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4560eba8-c080-344c-a2dc-43128ef42b5e', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:899e038c-262f-4367-a287-88e0f552715c'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4560eba8-c080-344c-a2dc-43128ef42b5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ef12e7b-2206-3f71-92ab-7ee5cb5f843f', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:899e038c-262f-4367-a287-88e0f552715c'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ef12e7b-2206-3f71-92ab-7ee5cb5f843f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a065f31c-e671-4faa-9784-78c90809b4b3', 2, NULL, '현악 3중주 4번 D장조', 'String Trio No. 4 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a065f31c-e671-4faa-9784-78c90809b4b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4637df2c-e306-3e02-8691-0a299e6102f2', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a065f31c-e671-4faa-9784-78c90809b4b3'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4637df2c-e306-3e02-8691-0a299e6102f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1cb68d86-bf4f-35e9-8dcb-f58a707c1f2d', 2, 'II', 'Andante quasi Allegretto', 'II. Andante quasi Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a065f31c-e671-4faa-9784-78c90809b4b3'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cb68d86-bf4f-35e9-8dcb-f58a707c1f2d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:50b1d254-5ed9-3a79-a9e8-d28732c943ba', 3, 'III', '미뉴에트. Allegro', 'III. Menuetto. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a065f31c-e671-4faa-9784-78c90809b4b3'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b1d254-5ed9-3a79-a9e8-d28732c943ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4a0d5363-064c-3de4-93a1-794e3c067182', 4, 'IV', '론도. Allegro', 'IV. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a065f31c-e671-4faa-9784-78c90809b4b3'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a0d5363-064c-3de4-93a1-794e3c067182'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0208aa44-daa9-4b0f-8663-889afad5c734', 3, NULL, '현악 3중주 5번 C단조', 'String Trio No. 5 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0208aa44-daa9-4b0f-8663-889afad5c734'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce50fed0-8324-34d0-8d94-72e355fe8959', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0208aa44-daa9-4b0f-8663-889afad5c734'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce50fed0-8324-34d0-8d94-72e355fe8959'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0e1398a-d6e0-3a14-baa3-1a0a466233aa', 2, 'II', 'Adagio con espressione', 'II. Adagio con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0208aa44-daa9-4b0f-8663-889afad5c734'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0e1398a-d6e0-3a14-baa3-1a0a466233aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5970a0c3-3620-3181-9aa8-47dd78dd9252', 3, 'III', '스케르초. Allegro molto e vivace', 'III. Scherzo. Allegro molto e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0208aa44-daa9-4b0f-8663-889afad5c734'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5970a0c3-3620-3181-9aa8-47dd78dd9252'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7bea47ef-27ef-3937-a7b6-b081f6e54af2', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0208aa44-daa9-4b0f-8663-889afad5c734'
WHERE p.composer_id = 15 AND p.title = '현악 3중주 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bea47ef-27ef-3937-a7b6-b081f6e54af2'
);


-- Op. 10 피아노 소나타 Op. 10

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 10', '3 Piano Sonatas, Op. 10', 'album', NULL, 'Op.', '10', 1798, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 10'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed5be2d7-f19d-4e29-955a-468cda8b1a80'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed5be2d7-f19d-4e29-955a-468cda8b1a80'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed5be2d7-f19d-4e29-955a-468cda8b1a80'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aeaff78-1cc6-47e6-b0af-5250ef923974', 1, NULL, '피아노 소나타 5번 C단조', 'Piano Sonata No. 5 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aeaff78-1cc6-47e6-b0af-5250ef923974'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cbaec6c8-fe06-3f1a-abfd-95419e96275b', 1, 'I', 'Allegro molto e con brio', 'I. Allegro molto e con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0aeaff78-1cc6-47e6-b0af-5250ef923974'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cbaec6c8-fe06-3f1a-abfd-95419e96275b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:efc4c635-2bc3-3e9a-afe0-b769f21fa5d5', 2, 'II', 'Adagio molto', 'II. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0aeaff78-1cc6-47e6-b0af-5250ef923974'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efc4c635-2bc3-3e9a-afe0-b769f21fa5d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1d839de2-18aa-38d2-b012-ba7757c502f9', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0aeaff78-1cc6-47e6-b0af-5250ef923974'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d839de2-18aa-38d2-b012-ba7757c502f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f914810-c6ef-47d1-b7fc-a0e61d5d98f5', 2, NULL, '피아노 소나타 6번 F장조', 'Piano Sonata No. 6 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f914810-c6ef-47d1-b7fc-a0e61d5d98f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:41deedcc-ce29-3976-9fe5-0e812362d655', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f914810-c6ef-47d1-b7fc-a0e61d5d98f5'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41deedcc-ce29-3976-9fe5-0e812362d655'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bbd38584-640e-3180-83b5-5ea1191a51d8', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f914810-c6ef-47d1-b7fc-a0e61d5d98f5'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bbd38584-640e-3180-83b5-5ea1191a51d8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:99938d1c-f9d2-3b5b-a114-264e1f0f80e4', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5f914810-c6ef-47d1-b7fc-a0e61d5d98f5'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99938d1c-f9d2-3b5b-a114-264e1f0f80e4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e093609-d578-4fd6-a919-92962dc9899d', 3, NULL, '피아노 소나타 7번 D장조', 'Piano Sonata No. 7 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e093609-d578-4fd6-a919-92962dc9899d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f92e93a-90a6-3c0d-a7fb-ff03fb2d2a13', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e093609-d578-4fd6-a919-92962dc9899d'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f92e93a-90a6-3c0d-a7fb-ff03fb2d2a13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16bdccf7-68ab-3203-a444-6a763cdc57d4', 2, 'II', 'Largo e mesto', 'II. Largo e mesto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e093609-d578-4fd6-a919-92962dc9899d'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16bdccf7-68ab-3203-a444-6a763cdc57d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:813a8489-8797-30d1-befe-ee8067b659df', 3, 'III', '미뉴에트. Allegro', 'III. Menuetto. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e093609-d578-4fd6-a919-92962dc9899d'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:813a8489-8797-30d1-befe-ee8067b659df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5eb35b7a-ed13-3a5a-8654-c20531d44296', 4, 'IV', '론도. Allegro', 'IV. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8e093609-d578-4fd6-a919-92962dc9899d'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eb35b7a-ed13-3a5a-8654-c20531d44296'
);


-- Op. 11 피아노 3중주 4번 B♭장조 "가센하우어"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 4번 B♭장조 "가센하우어"', 'Piano Trio No. 4 in B♭ major "Gassenhauer"', 'album', 'Op. 11', NULL, NULL, 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 4번 B♭장조 "가센하우어"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13735c98-6c84-4848-a415-f77d499a6d7a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13735c98-6c84-4848-a415-f77d499a6d7a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 4번 B♭장조 "가센하우어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13735c98-6c84-4848-a415-f77d499a6d7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bafe3098-a336-40e1-9a6e-f31ea21c1d26', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 4번 B♭장조 "가센하우어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bafe3098-a336-40e1-9a6e-f31ea21c1d26'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb995722-8493-4fac-a627-96b7c4862b3a', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 4번 B♭장조 "가센하우어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb995722-8493-4fac-a627-96b7c4862b3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7366c857-7ee9-4cd4-ba46-2c217ba1fca5', 3, 'III', 'Allegretto con variazioni', 'III. Allegretto con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 4번 B♭장조 "가센하우어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7366c857-7ee9-4cd4-ba46-2c217ba1fca5'
);


-- Op. 12 바이올린 소나타 Op. 12

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 Op. 12', '3 Violin Sonatas, Op. 12', 'album', NULL, 'Op.', '12', 1798, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 Op. 12'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a2ede75-f397-4c5f-b244-f4ae023a4e41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2a2ede75-f397-4c5f-b244-f4ae023a4e41'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2a2ede75-f397-4c5f-b244-f4ae023a4e41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6ff2181-8556-3f9c-be53-d84fcb882288', 1, NULL, '바이올린 소나타 1번 D장조', 'Violin Sonata No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6ff2181-8556-3f9c-be53-d84fcb882288'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4c32042-0f54-3932-b10e-c13d45c12967', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6ff2181-8556-3f9c-be53-d84fcb882288'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4c32042-0f54-3932-b10e-c13d45c12967'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:533153cf-a074-34d7-a95f-4c81a0be431d', 2, 'II', '주제와 변주. Andante con moto', 'II. Tema con Variazioni. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6ff2181-8556-3f9c-be53-d84fcb882288'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:533153cf-a074-34d7-a95f-4c81a0be431d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:60ed0f04-3ad7-3943-ae2c-e0989fa5d6c4', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f6ff2181-8556-3f9c-be53-d84fcb882288'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60ed0f04-3ad7-3943-ae2c-e0989fa5d6c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed41d818-251c-3335-8d84-9fd625a622f5', 2, NULL, '바이올린 소나타 2번 A장조', 'Violin Sonata No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed41d818-251c-3335-8d84-9fd625a622f5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d89ccc90-0c53-306f-8ed9-dfc751aff01e', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed41d818-251c-3335-8d84-9fd625a622f5'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d89ccc90-0c53-306f-8ed9-dfc751aff01e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e4a6b7d2-28bf-3442-8727-871548dee399', 2, 'II', 'Andante più tosto allegretto', 'II. Andante più tosto allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed41d818-251c-3335-8d84-9fd625a622f5'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4a6b7d2-28bf-3442-8727-871548dee399'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4e25536-becc-3bc3-b9a9-c35fe860eb09', 3, 'III', 'Allegro piacevole', 'III. Allegro piacevole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed41d818-251c-3335-8d84-9fd625a622f5'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4e25536-becc-3bc3-b9a9-c35fe860eb09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fca336a-343a-316d-b582-fcca9d602758', 3, NULL, '바이올린 소나타 3번 E♭장조', 'Violin Sonata No. 3 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fca336a-343a-316d-b582-fcca9d602758'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cf3f4d10-3bd3-3a2b-9544-4a4dd02086e2', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8fca336a-343a-316d-b582-fcca9d602758'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf3f4d10-3bd3-3a2b-9544-4a4dd02086e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3325f516-49a1-3145-b2de-82052b8a43ff', 2, 'II', 'Adagio con molto espressione', 'II. Adagio con molto espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8fca336a-343a-316d-b582-fcca9d602758'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3325f516-49a1-3145-b2de-82052b8a43ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54c05ad5-a5c6-39d3-b55e-47e2d005452e', 3, 'III', '론도. Allegro molto', 'III. Rondo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:8fca336a-343a-316d-b582-fcca9d602758'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 12' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54c05ad5-a5c6-39d3-b55e-47e2d005452e'
);


-- Op. 13 피아노 소나타 8번 C단조 "비창"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1c58466-6c16-3e01-a52c-2483f041b84f', 1, 'I', 'Grave – Allegro di molto e con brio', 'I. Grave – Allegro di molto e con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 79 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1c58466-6c16-3e01-a52c-2483f041b84f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57c4a1d2-4cd1-3629-93d1-2f36aca922e3', 2, 'II', 'Adagio cantabile', 'II. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 79 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c4a1d2-4cd1-3629-93d1-2f36aca922e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ea9a6a3-48b1-32d4-9dc2-bcebf94cbf05', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 79 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ea9a6a3-48b1-32d4-9dc2-bcebf94cbf05'
);


-- Op. 14 피아노 소나타 Op. 14

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 14', '2 Piano Sonatas, Op. 14', 'album', NULL, 'Op.', '14', 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 14'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f69459b-ee9c-4d5f-8dbc-c7acc190cb90'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f69459b-ee9c-4d5f-8dbc-c7acc190cb90'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f69459b-ee9c-4d5f-8dbc-c7acc190cb90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee8cc1d1-eda4-4505-964f-ba5bce7d577c', 1, NULL, '피아노 소나타 9번 E장조', 'Piano Sonata No. 9 in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee8cc1d1-eda4-4505-964f-ba5bce7d577c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1cbc82c9-8808-34cc-ad23-3ebcc7942fb1', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee8cc1d1-eda4-4505-964f-ba5bce7d577c'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cbc82c9-8808-34cc-ad23-3ebcc7942fb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:54dd49e4-be88-3d70-9bba-19f5c4452352', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee8cc1d1-eda4-4505-964f-ba5bce7d577c'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54dd49e4-be88-3d70-9bba-19f5c4452352'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7356c482-e19d-3e79-ae37-ec0b8447b270', 3, 'III', '론도. Allegro comodo', 'III. Rondo. Allegro comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ee8cc1d1-eda4-4505-964f-ba5bce7d577c'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7356c482-e19d-3e79-ae37-ec0b8447b270'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bab36973-3546-4f24-8bc1-2c7bc3e14e83', 2, NULL, '피아노 소나타 10번 G장조', 'Piano Sonata No. 10 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bab36973-3546-4f24-8bc1-2c7bc3e14e83'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:84e50be4-86da-336e-a1f2-ce196d4ce6f7', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bab36973-3546-4f24-8bc1-2c7bc3e14e83'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84e50be4-86da-336e-a1f2-ce196d4ce6f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8304d7d-f7bd-3129-bc1b-bdd6a4f240bf', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bab36973-3546-4f24-8bc1-2c7bc3e14e83'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8304d7d-f7bd-3129-bc1b-bdd6a4f240bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ab2150e6-632a-3aef-b869-99e31fc613cd', 3, 'III', '스케르초. Allegro assai', 'III. Scherzo. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:bab36973-3546-4f24-8bc1-2c7bc3e14e83'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab2150e6-632a-3aef-b869-99e31fc613cd'
);


-- Op. 15 피아노 협주곡 1번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 1번 C장조', 'Piano Concerto No. 1 in C major', 'album', 'Op. 15', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 1번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cce0fdf5-ef20-40ee-8df8-1f22fb8a8ac0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cce0fdf5-ef20-40ee-8df8-1f22fb8a8ac0'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cce0fdf5-ef20-40ee-8df8-1f22fb8a8ac0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a97bddd6-2567-3cc5-b9ef-f8fbe33c5086', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a97bddd6-2567-3cc5-b9ef-f8fbe33c5086'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cedd2f0-7594-33d3-b71e-850b823587c0', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cedd2f0-7594-33d3-b71e-850b823587c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfbbd9e6-daca-309e-8647-e6d4cf6ac467', 3, 'III', '론도. Allegro scherzando', 'III. Rondo. Allegro scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfbbd9e6-daca-309e-8647-e6d4cf6ac467'
);


-- Op. 16 피아노와 관악을 위한 5중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관악을 위한 5중주 E♭장조', 'Quintet for Piano and Winds in E♭ major', 'album', 'Op. 16', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관악을 위한 5중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fc7349d-c99b-45bc-85cd-b9645b827a50'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7fc7349d-c99b-45bc-85cd-b9645b827a50'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노와 관악을 위한 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7fc7349d-c99b-45bc-85cd-b9645b827a50'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09fdfa27-6f04-3e21-a02a-2bfd748ae19f', 1, 'I', 'Grave – Allegro ma non troppo', 'I. Grave – Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노와 관악을 위한 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09fdfa27-6f04-3e21-a02a-2bfd748ae19f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8079cd11-136e-366f-a7ca-3aefa04918d0', 2, 'II', 'Andante cantabile', 'II. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노와 관악을 위한 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8079cd11-136e-366f-a7ca-3aefa04918d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35a94722-4ebf-3e66-aac7-bd0fcadd8d22', 3, 'III', '론도. Allegro ma non troppo', 'III. Rondo. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노와 관악을 위한 5중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35a94722-4ebf-3e66-aac7-bd0fcadd8d22'
);


-- Op. 17 호른 소나타 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '호른 소나타 F장조', 'Horn Sonata in F major', 'album', 'Op. 17', NULL, NULL, 1800, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '호른 소나타 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e8cb6f9-4e3a-3a7e-992d-8f5c1d233624'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4e8cb6f9-4e3a-3a7e-992d-8f5c1d233624'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '호른 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e8cb6f9-4e3a-3a7e-992d-8f5c1d233624'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d726244d-f910-3420-b21c-3fcf8fad6db9', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '호른 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d726244d-f910-3420-b21c-3fcf8fad6db9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ea4f245-438e-3a84-a5d5-1a90aeff4179', 2, 'II', 'Poco adagio, quasi andante', 'II. Poco adagio, quasi andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '호른 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ea4f245-438e-3a84-a5d5-1a90aeff4179'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80f33d56-355a-3a28-8b7e-9f9fcd119406', 3, 'III', '론도. Allegro moderato', 'III. Rondo. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '호른 소나타 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f33d56-355a-3a28-8b7e-9f9fcd119406'
);


-- Op. 18 현악 4중주 Op. 18

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 Op. 18', '6 String Quartets, Op. 18', 'album', NULL, 'Op.', '18', 1800, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 Op. 18'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e53e5c3-02d2-4b7c-99c0-5f63a91553e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e53e5c3-02d2-4b7c-99c0-5f63a91553e1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e53e5c3-02d2-4b7c-99c0-5f63a91553e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1f556cb-d8a0-4b84-800f-e28ec489c7cc', 1, NULL, '현악 4중주 1번 F장조', 'String Quartet No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1f556cb-d8a0-4b84-800f-e28ec489c7cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:feff6e27-3220-3482-bbd3-6110682d4be8', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1f556cb-d8a0-4b84-800f-e28ec489c7cc'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feff6e27-3220-3482-bbd3-6110682d4be8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b5ccbac-2679-3110-a2d5-2e2f6ba5d60e', 2, 'II', 'Adagio affettuoso ed appassionato', 'II. Adagio affettuoso ed appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1f556cb-d8a0-4b84-800f-e28ec489c7cc'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b5ccbac-2679-3110-a2d5-2e2f6ba5d60e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5cd670ab-0b1c-3471-ad4b-fd1f3500520f', 3, 'III', '스케르초. Allegro molto', 'III. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1f556cb-d8a0-4b84-800f-e28ec489c7cc'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cd670ab-0b1c-3471-ad4b-fd1f3500520f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f1421412-12a0-3cb7-ac9b-c77856a8c7e0', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1f556cb-d8a0-4b84-800f-e28ec489c7cc'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1421412-12a0-3cb7-ac9b-c77856a8c7e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc9651a1-ca09-4e74-aaeb-fbbf01ae8181', 2, NULL, '현악 4중주 2번 G장조', 'String Quartet No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc9651a1-ca09-4e74-aaeb-fbbf01ae8181'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4566106-9841-3b5e-a3b9-24163c4cd521', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc9651a1-ca09-4e74-aaeb-fbbf01ae8181'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4566106-9841-3b5e-a3b9-24163c4cd521'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dd527f6e-3dd0-3e83-914d-0b42301b4f9e', 2, 'II', 'Adagio cantabile – Allegro – Tempo I', 'II. Adagio cantabile – Allegro – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc9651a1-ca09-4e74-aaeb-fbbf01ae8181'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd527f6e-3dd0-3e83-914d-0b42301b4f9e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:479285ee-0baa-35dc-8782-7ab0b992ab63', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc9651a1-ca09-4e74-aaeb-fbbf01ae8181'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:479285ee-0baa-35dc-8782-7ab0b992ab63'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff870751-7759-3b43-a9be-84d055e5afe7', 4, 'IV', 'Allegro molto, quasi Presto', 'IV. Allegro molto, quasi Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fc9651a1-ca09-4e74-aaeb-fbbf01ae8181'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff870751-7759-3b43-a9be-84d055e5afe7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c2937a5-73e7-4a90-856b-878df5879a79', 3, NULL, '현악 4중주 3번 D장조', 'String Quartet No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c2937a5-73e7-4a90-856b-878df5879a79'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71dc6451-cfdb-3176-b3cb-2b4c1f70c4c4', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c2937a5-73e7-4a90-856b-878df5879a79'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71dc6451-cfdb-3176-b3cb-2b4c1f70c4c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5b05d93d-07b1-3f5d-9990-f0b1a345e74b', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c2937a5-73e7-4a90-856b-878df5879a79'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b05d93d-07b1-3f5d-9990-f0b1a345e74b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef18a63b-8dc5-32af-9d90-a5e8dadd274b', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c2937a5-73e7-4a90-856b-878df5879a79'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef18a63b-8dc5-32af-9d90-a5e8dadd274b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:554addc1-29d7-3d17-9c2f-932b0e877dab', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0c2937a5-73e7-4a90-856b-878df5879a79'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:554addc1-29d7-3d17-9c2f-932b0e877dab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3758f33c-1d85-4c1c-bd57-1f70fd4e9ad1', 4, NULL, '현악 4중주 4번 C단조', 'String Quartet No. 4 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3758f33c-1d85-4c1c-bd57-1f70fd4e9ad1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:21136360-9846-3fd3-b3be-9483342f7861', 1, 'I', 'Allegro ma non tanto', 'I. Allegro ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3758f33c-1d85-4c1c-bd57-1f70fd4e9ad1'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21136360-9846-3fd3-b3be-9483342f7861'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:12c44101-bd1d-3d4e-9b80-c64988a0e61f', 2, 'II', 'Andante scherzoso quasi allegretto', 'II. Andante scherzoso quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3758f33c-1d85-4c1c-bd57-1f70fd4e9ad1'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12c44101-bd1d-3d4e-9b80-c64988a0e61f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e984e1cc-f936-3e4a-b887-fcbeb86c1d77', 3, 'III', '미뉴에트. Allegretto', 'III. Menuetto. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3758f33c-1d85-4c1c-bd57-1f70fd4e9ad1'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e984e1cc-f936-3e4a-b887-fcbeb86c1d77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff919637-cb06-312d-a340-1cfb2d353205', 4, 'IV', 'Allegro – Prestissimo', 'IV. Allegro – Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3758f33c-1d85-4c1c-bd57-1f70fd4e9ad1'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff919637-cb06-312d-a340-1cfb2d353205'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d891907-08cf-4528-9061-73786e3f6975', 5, NULL, '현악 4중주 5번 A장조', 'String Quartet No. 5 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d891907-08cf-4528-9061-73786e3f6975'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:866af7df-625f-37fd-a94b-c78e7c4fcf98', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d891907-08cf-4528-9061-73786e3f6975'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:866af7df-625f-37fd-a94b-c78e7c4fcf98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f0b7776-326b-3d80-9e8d-5d5f7836d412', 2, 'II', '미뉴에트', 'II. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d891907-08cf-4528-9061-73786e3f6975'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f0b7776-326b-3d80-9e8d-5d5f7836d412'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3355278-c8f2-3299-af7d-0a251b58de1b', 3, 'III', 'Andante cantabile', 'III. Andante cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d891907-08cf-4528-9061-73786e3f6975'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3355278-c8f2-3299-af7d-0a251b58de1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0eb2702a-d8e4-362b-8297-e2979dc5ba9d', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1d891907-08cf-4528-9061-73786e3f6975'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0eb2702a-d8e4-362b-8297-e2979dc5ba9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76de79fa-71f2-4178-9e01-9a0015826031', 6, NULL, '현악 4중주 6번 B♭장조', 'String Quartet No. 6 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76de79fa-71f2-4178-9e01-9a0015826031'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d3c69a2c-54b5-398f-91c6-763c112d056c', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76de79fa-71f2-4178-9e01-9a0015826031'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3c69a2c-54b5-398f-91c6-763c112d056c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dea28f50-5b54-3f7c-be94-ca1a350fed02', 2, 'II', 'Adagio ma non troppo', 'II. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76de79fa-71f2-4178-9e01-9a0015826031'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea28f50-5b54-3f7c-be94-ca1a350fed02'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f2dba615-f1a4-355a-83c0-73daec78d09d', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76de79fa-71f2-4178-9e01-9a0015826031'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2dba615-f1a4-355a-83c0-73daec78d09d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f7c1f93-3d1f-3ae3-9b66-f4f09a8d2588', 4, 'IV', 'Adagio "La malinconia" – Allegretto quasi allegro', 'IV. Adagio "La malinconia" – Allegretto quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:76de79fa-71f2-4178-9e01-9a0015826031'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f7c1f93-3d1f-3ae3-9b66-f4f09a8d2588'
);


-- Op. 19 피아노 협주곡 2번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 2번 B♭장조', 'Piano Concerto No. 2 in B♭ major', 'album', 'Op. 19', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 2번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '198cb225-1307-4fcc-a868-050ae17761c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '198cb225-1307-4fcc-a868-050ae17761c9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '198cb225-1307-4fcc-a868-050ae17761c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c47fa1a-9e9c-3298-937a-8a9a0ba04950', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c47fa1a-9e9c-3298-937a-8a9a0ba04950'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e9557cb-9f31-325f-b1fc-756bb3398565', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e9557cb-9f31-325f-b1fc-756bb3398565'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af2da01d-18cb-3620-a2d2-2ca62d187545', 3, 'III', '론도. Molto allegro', 'III. Rondo. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 2번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af2da01d-18cb-3620-a2d2-2ca62d187545'
);


-- Op. 20 7중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7중주 E♭장조', 'Septet in E♭ major', 'album', 'Op. 20', NULL, NULL, 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '256a56ee-1057-4bf8-b08c-3a127c3ec85b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '256a56ee-1057-4bf8-b08c-3a127c3ec85b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '256a56ee-1057-4bf8-b08c-3a127c3ec85b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a4f985d-5d9a-3b0c-b975-dda8111be3b8', 1, 'I', 'Adagio – Allegro con brio', 'I. Adagio – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a4f985d-5d9a-3b0c-b975-dda8111be3b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99ef9a50-3bbb-36dd-9195-3e7198ae3726', 2, 'II', 'Adagio cantabile', 'II. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99ef9a50-3bbb-36dd-9195-3e7198ae3726'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f09375e-41a4-3afe-9d7f-7bc8ab8f57f9', 3, 'III', 'Tempo di Menuetto', 'III. Tempo di Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f09375e-41a4-3afe-9d7f-7bc8ab8f57f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c7cc7a4-fd4a-389a-b823-862eeba459b3', 4, 'IV', '주제와 변주. Andante', 'IV. Tema con variazioni. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c7cc7a4-fd4a-389a-b823-862eeba459b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f152761d-5bdb-39ab-a99e-87c3a634a39c', 5, 'V', '스케르초. Allegro molto e vivace', 'V. Scherzo. Allegro molto e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f152761d-5bdb-39ab-a99e-87c3a634a39c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19d47c86-cf37-3225-8273-b52143655bfe', 6, 'VI', 'Andante con moto alla marcia – Presto', 'VI. Andante con moto alla marcia – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19d47c86-cf37-3225-8273-b52143655bfe'
);


-- Op. 21 교향곡 1번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 1번 C장조', 'Symphony No. 1 in C major', 'album', 'Op. 21', NULL, NULL, 1800, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 1번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c9a74de-88aa-361a-bdea-d200eae8073c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c9a74de-88aa-361a-bdea-d200eae8073c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c9a74de-88aa-361a-bdea-d200eae8073c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80297632-7cf5-3dae-b36e-230c87ef8c30', 1, 'I', 'Adagio molto – Allegro con brio', 'I. Adagio molto – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80297632-7cf5-3dae-b36e-230c87ef8c30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e14b863a-b725-341c-88c8-8464f2e817ce', 2, 'II', 'Andante cantabile con moto', 'II. Andante cantabile con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e14b863a-b725-341c-88c8-8464f2e817ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80f24253-c32c-3646-92d1-b46726c5e612', 3, 'III', '미뉴에트. Allegro molto e vivace', 'III. Menuetto. Allegro molto e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80f24253-c32c-3646-92d1-b46726c5e612'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa0d2fab-8d31-3df1-8072-4da945dd7682', 4, 'IV', 'Adagio – Allegro molto e vivace', 'IV. Adagio – Allegro molto e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa0d2fab-8d31-3df1-8072-4da945dd7682'
);


-- Op. 22 피아노 소나타 11번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 11번 B♭장조', 'Piano Sonata No. 11 in B♭ major', 'album', 'Op. 22', NULL, NULL, 1800, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 11번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94bc3c50-ea92-421f-b9a7-c9bc2b0b4695'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94bc3c50-ea92-421f-b9a7-c9bc2b0b4695'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 11번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94bc3c50-ea92-421f-b9a7-c9bc2b0b4695'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad7807bd-bb3f-3a11-a1ac-fff2d6948453', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 11번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad7807bd-bb3f-3a11-a1ac-fff2d6948453'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f728d17-47e2-30ff-b6ca-3b99ef5cf8d6', 2, 'II', 'Adagio con molto espressione', 'II. Adagio con molto espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 11번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f728d17-47e2-30ff-b6ca-3b99ef5cf8d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96686c7f-f45c-3bd6-97c2-ec5bbb0aee0b', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 11번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96686c7f-f45c-3bd6-97c2-ec5bbb0aee0b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89c83d85-2d06-38fa-8c79-c703e3f5b85e', 4, 'IV', '론도. Allegretto', 'IV. Rondo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 11번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89c83d85-2d06-38fa-8c79-c703e3f5b85e'
);


-- Op. 23 바이올린 소나타 4번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 4번 A단조', 'Violin Sonata No. 4 in A minor', 'album', 'Op. 23', NULL, NULL, 1800, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 4번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e15a97c-7024-3851-b761-c69767d45aac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e15a97c-7024-3851-b761-c69767d45aac'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e15a97c-7024-3851-b761-c69767d45aac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b59a9645-6d0f-31dc-bd75-3ac193ff73e8', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b59a9645-6d0f-31dc-bd75-3ac193ff73e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0e46551-5651-3606-abfd-448f3c535a39', 2, 'II', 'Andante scherzoso, più allegretto', 'II. Andante scherzoso, più allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0e46551-5651-3606-abfd-448f3c535a39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea7ae9cd-727e-38d3-b973-edaf13e316f4', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 4번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea7ae9cd-727e-38d3-b973-edaf13e316f4'
);


-- Op. 24 바이올린 소나타 5번 F장조 "봄"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7747d90f-1c09-3fbf-9e89-afd9e7fc8c66', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 439 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7747d90f-1c09-3fbf-9e89-afd9e7fc8c66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cadb4323-933c-3179-aa0f-02bd96dcb97e', 2, 'II', 'Adagio molto espressivo', 'II. Adagio molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 439 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cadb4323-933c-3179-aa0f-02bd96dcb97e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea55176-799c-3e7e-8820-59a960ce34a2', 3, 'III', '스케르초. Allegro molto', 'III. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 439 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea55176-799c-3e7e-8820-59a960ce34a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b77408b-f7b3-3da1-995e-58592a9e224d', 4, 'IV', '론도. Allegro ma non troppo', 'IV. Rondo. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 439 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b77408b-f7b3-3da1-995e-58592a9e224d'
);


-- Op. 25 플루트, 바이올린, 비올라를 위한 세레나데 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 바이올린, 비올라를 위한 세레나데 D장조', 'Serenade for Flute, Violin and Viola in D major', 'album', 'Op. 25', NULL, NULL, 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 바이올린, 비올라를 위한 세레나데 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f9818be-d298-4861-8726-eca89b05fc93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f9818be-d298-4861-8726-eca89b05fc93'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트, 바이올린, 비올라를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f9818be-d298-4861-8726-eca89b05fc93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9247a9f2-01b2-30f7-9226-884f6acec3ed', 1, 'I', 'Entrada. Allegro', 'I. Entrada. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트, 바이올린, 비올라를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9247a9f2-01b2-30f7-9226-884f6acec3ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0cc8534-00ee-3c03-9bbf-a29d92c9c49e', 2, 'II', 'Tempo ordinario d''un Minuetto', 'II. Tempo ordinario d''un Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트, 바이올린, 비올라를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0cc8534-00ee-3c03-9bbf-a29d92c9c49e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:048e98f3-e6ab-341c-ab58-d6c6086004f0', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트, 바이올린, 비올라를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:048e98f3-e6ab-341c-ab58-d6c6086004f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0f3768e-019d-38ed-b37f-cf8175f5b0f0', 4, 'IV', 'Andante con Variazioni', 'IV. Andante con Variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트, 바이올린, 비올라를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0f3768e-019d-38ed-b37f-cf8175f5b0f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c30b0ae-1834-3187-b9ea-4774b79abb09', 5, 'V', 'Allegro scherzando e vivace', 'V. Allegro scherzando e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트, 바이올린, 비올라를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c30b0ae-1834-3187-b9ea-4774b79abb09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc34ef24-d830-3e9c-822f-e32c27f98477', 6, 'VI', 'Adagio – Allegro vivace e disinvolto', 'VI. Adagio – Allegro vivace e disinvolto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트, 바이올린, 비올라를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc34ef24-d830-3e9c-822f-e32c27f98477'
);


-- Op. 26 피아노 소나타 12번 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 12번 A♭장조', 'Piano Sonata No. 12 in A♭ major', 'album', 'Op. 26', NULL, NULL, 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 12번 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bff859ad-5e24-4a7f-8717-855dfac72925'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bff859ad-5e24-4a7f-8717-855dfac72925'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 12번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bff859ad-5e24-4a7f-8717-855dfac72925'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4609500c-f6c3-3d31-af7e-9a557e18f933', 1, 'I', 'Andante con Variazioni', 'I. Andante con Variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 12번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4609500c-f6c3-3d31-af7e-9a557e18f933'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9ff3daa-a11b-3dfb-a278-5e4c66d8bd96', 2, 'II', '스케르초. Allegro molto', 'II. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 12번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9ff3daa-a11b-3dfb-a278-5e4c66d8bd96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f8833b6-03aa-31d9-98f1-ae754c7067ea', 3, 'III', '영웅의 죽음을 애도하는 장송 행진곡', 'III. Marcia funebre sulla morte d''un Eroe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 12번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f8833b6-03aa-31d9-98f1-ae754c7067ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90f2732e-b7f6-33c4-9829-f60e4cb32108', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 12번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90f2732e-b7f6-33c4-9829-f60e4cb32108'
);


-- Op. 27 피아노 소나타 Op. 27

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 27', '2 Piano Sonatas "quasi una fantasia", Op. 27', 'album', NULL, 'Op.', '27', 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 27'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcd958bd-7f94-4f46-803b-dc24a0fbe050'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bcd958bd-7f94-4f46-803b-dc24a0fbe050'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bcd958bd-7f94-4f46-803b-dc24a0fbe050'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98f63744-cec6-393a-8868-c5a0b6facbfe', 1, NULL, '피아노 소나타 13번 E♭장조', 'Piano Sonata No. 13 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98f63744-cec6-393a-8868-c5a0b6facbfe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fce5a48d-a54d-3e5d-8275-c529ab2aa880', 1, 'I', 'Andante – Allegro – Tempo I', 'I. Andante – Allegro – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98f63744-cec6-393a-8868-c5a0b6facbfe'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fce5a48d-a54d-3e5d-8275-c529ab2aa880'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b9d471bf-ac74-3927-abdc-641bf6289ae5', 2, 'II', 'Allegro molto e vivace', 'II. Allegro molto e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98f63744-cec6-393a-8868-c5a0b6facbfe'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9d471bf-ac74-3927-abdc-641bf6289ae5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d40cb00-f659-3d11-b935-80009a9667d3', 3, 'III', 'Adagio con espressione', 'III. Adagio con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98f63744-cec6-393a-8868-c5a0b6facbfe'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d40cb00-f659-3d11-b935-80009a9667d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da187923-a131-364e-b30f-38f8bf2ed0e2', 4, 'IV', 'Allegro vivace – Presto', 'IV. Allegro vivace – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98f63744-cec6-393a-8868-c5a0b6facbfe'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da187923-a131-364e-b30f-38f8bf2ed0e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 78 AND linked.composer_id = 15), 'musicbrainz:d754d820-2036-39f6-9fd5-636cda85b3b2', 2, NULL, '피아노 소나타 14번 C#단조 "월광"', 'Piano Sonata No. 14 in C# minor "Moonlight"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d754d820-2036-39f6-9fd5-636cda85b3b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11e7e520-f430-306c-90b8-183cbf3cc761', 1, 'I', 'Adagio sostenuto', 'I. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d754d820-2036-39f6-9fd5-636cda85b3b2'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11e7e520-f430-306c-90b8-183cbf3cc761'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:670cf65d-db7d-3ef0-936b-f0817fe647b2', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d754d820-2036-39f6-9fd5-636cda85b3b2'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:670cf65d-db7d-3ef0-936b-f0817fe647b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9632b37d-010b-3936-9293-36053e95e146', 3, 'III', 'Presto agitato', 'III. Presto agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d754d820-2036-39f6-9fd5-636cda85b3b2'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 27' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9632b37d-010b-3936-9293-36053e95e146'
);


-- Op. 28 피아노 소나타 15번 D장조 "전원"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 15번 D장조 "전원"', 'Piano Sonata No. 15 in D major "Pastoral"', 'album', 'Op. 28', NULL, NULL, 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 15번 D장조 "전원"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85b66ee4-ada7-3256-8423-a48d849b9b55'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '85b66ee4-ada7-3256-8423-a48d849b9b55'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 15번 D장조 "전원"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '85b66ee4-ada7-3256-8423-a48d849b9b55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbd1d119-17dc-32fa-a9eb-4fdff75f42da', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 15번 D장조 "전원"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbd1d119-17dc-32fa-a9eb-4fdff75f42da'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2952a1e5-6f44-3c2c-9c70-1c300926f9ee', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 15번 D장조 "전원"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2952a1e5-6f44-3c2c-9c70-1c300926f9ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39cfa23b-844f-3c2e-a3f2-5d7dee2840d4', 3, 'III', '스케르초. Allegro vivace', 'III. Scherzo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 15번 D장조 "전원"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39cfa23b-844f-3c2e-a3f2-5d7dee2840d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82c09e45-fc6f-35f2-9b5e-9fa54053c5cc', 4, 'IV', '론도. Allegro ma non troppo', 'IV. Rondo. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 15번 D장조 "전원"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82c09e45-fc6f-35f2-9b5e-9fa54053c5cc'
);


-- Op. 29 현악 5중주 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주 C장조', 'String Quintet in C major', 'album', 'Op. 29', NULL, NULL, 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7916a97-4745-455f-be16-5063d3a50e16'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7916a97-4745-455f-be16-5063d3a50e16'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7916a97-4745-455f-be16-5063d3a50e16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e69a906e-d401-3bd3-b405-9aebbb775a20', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e69a906e-d401-3bd3-b405-9aebbb775a20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f49627ea-5b2f-3a68-ba16-cd8b0fcd87db', 2, 'II', 'Adagio molto espressivo', 'II. Adagio molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f49627ea-5b2f-3a68-ba16-cd8b0fcd87db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee2412c7-7416-3793-bd9c-df071bd3a966', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee2412c7-7416-3793-bd9c-df071bd3a966'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48ce1053-3661-310c-ae0a-a04d09e8ba4c', 4, 'IV', 'Presto', 'IV. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48ce1053-3661-310c-ae0a-a04d09e8ba4c'
);


-- Op. 30 바이올린 소나타 Op. 30

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 Op. 30', '3 Violin Sonatas, Op. 30', 'album', NULL, 'Op.', '30', 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 Op. 30'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2a1939b-6783-4f7a-a9f4-bb4c1756a06c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2a1939b-6783-4f7a-a9f4-bb4c1756a06c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2a1939b-6783-4f7a-a9f4-bb4c1756a06c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf8f4ec0-42e8-34d2-a93c-68443764766b', 1, NULL, '바이올린 소나타 6번 A장조', 'Violin Sonata No. 6 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf8f4ec0-42e8-34d2-a93c-68443764766b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e20a8f15-91fe-3b5d-a60c-2454f796036d', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cf8f4ec0-42e8-34d2-a93c-68443764766b'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e20a8f15-91fe-3b5d-a60c-2454f796036d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e14b969a-24b9-3d63-9301-5fd466d72d31', 2, 'II', 'Adagio molto espressivo', 'II. Adagio molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cf8f4ec0-42e8-34d2-a93c-68443764766b'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e14b969a-24b9-3d63-9301-5fd466d72d31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d92eda99-4ac7-384d-a9c3-c576755d81b3', 3, 'III', 'Allegretto con variazioni', 'III. Allegretto con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cf8f4ec0-42e8-34d2-a93c-68443764766b'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d92eda99-4ac7-384d-a9c3-c576755d81b3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0ff68eb-c09d-3af3-8880-0ebc4f3ff2b5', 2, NULL, '바이올린 소나타 7번 C단조', 'Violin Sonata No. 7 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0ff68eb-c09d-3af3-8880-0ebc4f3ff2b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:56e61f0a-f576-37be-ae8a-a6682aca2fe9', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0ff68eb-c09d-3af3-8880-0ebc4f3ff2b5'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56e61f0a-f576-37be-ae8a-a6682aca2fe9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2d34fe19-71a6-35eb-bd63-d0115b5dc051', 2, 'II', 'Adagio cantabile', 'II. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0ff68eb-c09d-3af3-8880-0ebc4f3ff2b5'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d34fe19-71a6-35eb-bd63-d0115b5dc051'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:094624cd-d0c7-3e84-91f7-1520d0c5c059', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0ff68eb-c09d-3af3-8880-0ebc4f3ff2b5'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:094624cd-d0c7-3e84-91f7-1520d0c5c059'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2f2535b6-49ed-3884-ab39-59a42453488c', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a0ff68eb-c09d-3af3-8880-0ebc4f3ff2b5'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f2535b6-49ed-3884-ab39-59a42453488c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34970703-dd36-4daa-b5fa-759c5b38bf9b', 3, NULL, '바이올린 소나타 8번 G장조', 'Violin Sonata No. 8 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34970703-dd36-4daa-b5fa-759c5b38bf9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f5b390a0-9711-33e3-aa89-d220813c03aa', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:34970703-dd36-4daa-b5fa-759c5b38bf9b'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5b390a0-9711-33e3-aa89-d220813c03aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:041d809e-b9ab-34e9-a94a-ed103c153f89', 2, 'II', 'Tempo di menuetto, ma molto moderato e grazioso', 'II. Tempo di menuetto, ma molto moderato e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:34970703-dd36-4daa-b5fa-759c5b38bf9b'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:041d809e-b9ab-34e9-a94a-ed103c153f89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:acbe71e2-3077-381b-a8a6-620d10f29d3e', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:34970703-dd36-4daa-b5fa-759c5b38bf9b'
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 Op. 30' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acbe71e2-3077-381b-a8a6-620d10f29d3e'
);


-- Op. 31 피아노 소나타 Op. 31

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 31', '3 Piano Sonatas, Op. 31', 'album', NULL, 'Op.', '31', 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 31'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '173f1261-1665-48d1-86dd-f1da6e2ac9f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '173f1261-1665-48d1-86dd-f1da6e2ac9f2'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '173f1261-1665-48d1-86dd-f1da6e2ac9f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e9f3cae-aebd-408e-9d12-6f86e39604d1', 1, NULL, '피아노 소나타 16번 G장조', 'Piano Sonata No. 16 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e9f3cae-aebd-408e-9d12-6f86e39604d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:64a80c49-0f2a-37c9-b46d-a94e25a481c1', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e9f3cae-aebd-408e-9d12-6f86e39604d1'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64a80c49-0f2a-37c9-b46d-a94e25a481c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5d6411d4-cd22-3b4c-9902-060e51aee5d5', 2, 'II', 'Adagio grazioso', 'II. Adagio grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e9f3cae-aebd-408e-9d12-6f86e39604d1'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d6411d4-cd22-3b4c-9902-060e51aee5d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a9453ff-5eb6-339d-9241-e71525e0bf9c', 3, 'III', '론도. Allegretto', 'III. Rondo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4e9f3cae-aebd-408e-9d12-6f86e39604d1'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a9453ff-5eb6-339d-9241-e71525e0bf9c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3edecd40-7725-4037-ad2c-b4d34fe903d9', 2, NULL, '피아노 소나타 17번 D단조 "템페스트"', 'Piano Sonata No. 17 in D minor "Tempest"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3edecd40-7725-4037-ad2c-b4d34fe903d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e8440c0e-14c6-365f-9527-95c8dee93eef', 1, 'I', 'Largo – Allegro', 'I. Largo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3edecd40-7725-4037-ad2c-b4d34fe903d9'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8440c0e-14c6-365f-9527-95c8dee93eef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4d62af62-c5af-3400-9ab8-809732514650', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3edecd40-7725-4037-ad2c-b4d34fe903d9'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d62af62-c5af-3400-9ab8-809732514650'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3d8ae4dd-a5f9-3bdf-b63f-4544a99e0fc6', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3edecd40-7725-4037-ad2c-b4d34fe903d9'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d8ae4dd-a5f9-3bdf-b63f-4544a99e0fc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eab83ac8-7c6e-42f2-ab1a-f4f75418bd8e', 3, NULL, '피아노 소나타 18번 E♭장조 "사냥"', 'Piano Sonata No. 18 in E♭ major "The Hunt"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eab83ac8-7c6e-42f2-ab1a-f4f75418bd8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:78e92c5a-d4ac-3745-a887-d06d2e6f3ed9', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eab83ac8-7c6e-42f2-ab1a-f4f75418bd8e'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78e92c5a-d4ac-3745-a887-d06d2e6f3ed9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55fe6750-72c2-3ed5-8825-894bd42ed01b', 2, 'II', '스케르초. Allegretto vivace', 'II. Scherzo. Allegretto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eab83ac8-7c6e-42f2-ab1a-f4f75418bd8e'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55fe6750-72c2-3ed5-8825-894bd42ed01b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:563e8800-234e-3b8f-b336-e71d1115b674', 3, 'III', '미뉴에트. Moderato e grazioso', 'III. Minuetto. Moderato e grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eab83ac8-7c6e-42f2-ab1a-f4f75418bd8e'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:563e8800-234e-3b8f-b336-e71d1115b674'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b10deee7-c8d6-3465-a9ea-61a20a3bca15', 4, 'IV', 'Presto con fuoco', 'IV. Presto con fuoco', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eab83ac8-7c6e-42f2-ab1a-f4f75418bd8e'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 31' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b10deee7-c8d6-3465-a9ea-61a20a3bca15'
);


-- Op. 32 가곡 <희망에 부쳐> (1805)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <희망에 부쳐> (1805)', '"An die Hoffnung" (1805)', 'song', 'Op. 32', NULL, NULL, 1805, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <희망에 부쳐> (1805)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24bc0b52-2537-3bb2-ba9b-12d2c23473c9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24bc0b52-2537-3bb2-ba9b-12d2c23473c9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <희망에 부쳐> (1805)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24bc0b52-2537-3bb2-ba9b-12d2c23473c9'
);


-- Op. 33 바가텔 Op. 33

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 Op. 33', '7 Bagatelles, Op. 33', 'album', NULL, 'Op.', '33', 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 Op. 33'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94a19e47-2c1d-425b-b4f0-63d62d5bf788'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '94a19e47-2c1d-425b-b4f0-63d62d5bf788'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '94a19e47-2c1d-425b-b4f0-63d62d5bf788'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30f0d049-827f-3651-bf50-c1e3181351d7', 1, NULL, 'E♭장조', 'No. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30f0d049-827f-3651-bf50-c1e3181351d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f480a377-2d3d-3f53-9e6f-0ff68e41bc77', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f480a377-2d3d-3f53-9e6f-0ff68e41bc77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83570405-bb0c-34fa-8eed-d3f4e46c9505', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83570405-bb0c-34fa-8eed-d3f4e46c9505'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15e9e7c4-08b0-342a-9b3a-b652ca513a47', 4, NULL, 'A장조', 'No. 4 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15e9e7c4-08b0-342a-9b3a-b652ca513a47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e8cee2e-5af8-3ddd-94f4-802e2881fba4', 5, NULL, 'C장조', 'No. 5 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e8cee2e-5af8-3ddd-94f4-802e2881fba4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2886a63e-c8e7-314f-93c5-0ce12ae52dfb', 6, NULL, 'D장조', 'No. 6 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2886a63e-c8e7-314f-93c5-0ce12ae52dfb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c2ef755-6d4a-357a-9acb-7167b06fd9c8', 7, NULL, 'A♭장조', 'No. 7 in A♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 33' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c2ef755-6d4a-357a-9acb-7167b06fd9c8'
);


-- Op. 34 창작 주제에 의한 6개의 변주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '창작 주제에 의한 6개의 변주곡 F장조', '6 Variations on an Original Theme in F major', 'song', 'Op. 34', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '창작 주제에 의한 6개의 변주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8567cf95-2e70-3023-a6d9-39934076009e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8567cf95-2e70-3023-a6d9-39934076009e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '창작 주제에 의한 6개의 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8567cf95-2e70-3023-a6d9-39934076009e'
);


-- Op. 35 창작 주제에 의한 15개의 변주곡과 푸가 E♭장조 "에로이카 변주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '창작 주제에 의한 15개의 변주곡과 푸가 E♭장조 "에로이카 변주곡"', '15 Variations and a Fugue on an Original Theme in E♭ major "Eroica Variations"', 'song', 'Op. 35', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '창작 주제에 의한 15개의 변주곡과 푸가 E♭장조 "에로이카 변주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e8a2fc5-14a8-33f3-b2f3-7d4c79f43c8f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e8a2fc5-14a8-33f3-b2f3-7d4c79f43c8f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '창작 주제에 의한 15개의 변주곡과 푸가 E♭장조 "에로이카 변주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e8a2fc5-14a8-33f3-b2f3-7d4c79f43c8f'
);


-- Op. 36 교향곡 2번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 2번 D장조', 'Symphony No. 2 in D major', 'album', 'Op. 36', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 2번 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c33b26a-6683-3b37-84e1-42f3f5221322'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c33b26a-6683-3b37-84e1-42f3f5221322'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c33b26a-6683-3b37-84e1-42f3f5221322'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f742f305-690b-3490-ad61-a79c1ce49326', 1, 'I', 'Adagio molto – Allegro con brio', 'I. Adagio molto – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f742f305-690b-3490-ad61-a79c1ce49326'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44e70da9-fe33-36ae-8fbc-1bb13c60c6e8', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44e70da9-fe33-36ae-8fbc-1bb13c60c6e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8207bfb7-840a-3156-a15f-a0e682459a01', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8207bfb7-840a-3156-a15f-a0e682459a01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ed9fc1c-800d-3094-b6d0-4438f1dee7d7', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 2번 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ed9fc1c-800d-3094-b6d0-4438f1dee7d7'
);


-- Op. 37 피아노 협주곡 3번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 3번 C단조', 'Piano Concerto No. 3 in C minor', 'album', 'Op. 37', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 3번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82506d40-77ad-4aa7-9e3d-392d5cfb13c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82506d40-77ad-4aa7-9e3d-392d5cfb13c7'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 3번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82506d40-77ad-4aa7-9e3d-392d5cfb13c7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6843235-961a-37ab-85a4-a0e7e027f752', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 3번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6843235-961a-37ab-85a4-a0e7e027f752'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:125f5a1f-9868-35e9-85dc-22944c888b13', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 3번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:125f5a1f-9868-35e9-85dc-22944c888b13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0117bb25-80f2-317a-a274-aadff00d53ca', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 3번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0117bb25-80f2-317a-a274-aadff00d53ca'
);


-- Op. 38 7중주를 옮긴 피아노 3중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7중주를 옮긴 피아노 3중주 E♭장조', 'Piano Trio in E♭ major (after the Septet, Op. 20)', 'album', 'Op. 38', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7중주를 옮긴 피아노 3중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '341233fa-0b21-405b-b695-2c999dfd3e88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '341233fa-0b21-405b-b695-2c999dfd3e88'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주를 옮긴 피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '341233fa-0b21-405b-b695-2c999dfd3e88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29bb720d-fc91-4f6e-8758-eec38a9ff212', 1, 'I', 'Adagio – Allegro con brio', 'I. Adagio – Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주를 옮긴 피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29bb720d-fc91-4f6e-8758-eec38a9ff212'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f1c9e8e-6a74-4c38-8c25-a8d197e8da42', 2, 'II', 'Adagio cantabile', 'II. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주를 옮긴 피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f1c9e8e-6a74-4c38-8c25-a8d197e8da42'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:036f1e9c-c41a-4bde-801c-1fd3a1605cab', 3, 'III', 'Tempo di menuetto', 'III. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주를 옮긴 피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:036f1e9c-c41a-4bde-801c-1fd3a1605cab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5eb04c01-798d-4435-8aae-ea976c38fdab', 4, 'IV', 'Andante con variazioni', 'IV. Andante con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주를 옮긴 피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5eb04c01-798d-4435-8aae-ea976c38fdab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29ab0d1a-3dc1-4796-afb5-92f40f32462b', 5, 'V', '스케르초. Allegro molto e vivace', 'V. Scherzo. Allegro molto e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주를 옮긴 피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29ab0d1a-3dc1-4796-afb5-92f40f32462b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7638531f-bb9f-4a50-a648-cba3c1b33123', 6, 'VI', 'Andante con moto alla marcia – Presto', 'VI. Andante con moto alla marcia – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '7중주를 옮긴 피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7638531f-bb9f-4a50-a648-cba3c1b33123'
);


-- Op. 39 모든 장조를 거치는 2개의 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모든 장조를 거치는 2개의 전주곡', '2 Preludes through all 12 Major Keys, Op. 39', 'album', 'Op. 39', NULL, NULL, 1789, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모든 장조를 거치는 2개의 전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5852d0f8-3925-477e-9904-c9497cabad01'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5852d0f8-3925-477e-9904-c9497cabad01'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '모든 장조를 거치는 2개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5852d0f8-3925-477e-9904-c9497cabad01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:624706a1-2cc9-3cae-abfa-25fe663abb3e', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '모든 장조를 거치는 2개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:624706a1-2cc9-3cae-abfa-25fe663abb3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:49b1a8f2-9b91-3ddc-acb6-62e497921eea', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '모든 장조를 거치는 2개의 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:49b1a8f2-9b91-3ddc-acb6-62e497921eea'
);


-- Op. 40 바이올린 로망스 1번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 로망스 1번 G장조', 'Romance for Violin and Orchestra No. 1 in G major', 'song', 'Op. 40', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 로망스 1번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2eddf53e-7d48-3d7c-9121-65bd9b776d67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2eddf53e-7d48-3d7c-9121-65bd9b776d67'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 로망스 1번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2eddf53e-7d48-3d7c-9121-65bd9b776d67'
);


-- Op. 41 플루트와 피아노를 위한 세레나데 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 피아노를 위한 세레나데 D장조', 'Serenade for Flute (or Violin) and Piano in D major', 'album', 'Op. 41', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 피아노를 위한 세레나데 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f622ae52-91f4-4709-9000-7704da328c70'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f622ae52-91f4-4709-9000-7704da328c70'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f622ae52-91f4-4709-9000-7704da328c70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e150b42-6a2e-432b-be31-162d024feb3b', 1, 'I', 'Entrada – Allegro', 'I. Entrada – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e150b42-6a2e-432b-be31-162d024feb3b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:033b3f2a-f6c4-4cd3-ab77-826db9cc5661', 2, 'II', 'Tempo ordinario d''un menuetto', 'II. Tempo ordinario d''un menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:033b3f2a-f6c4-4cd3-ab77-826db9cc5661'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0663887b-6c78-4b09-8c36-e205defdab73', 3, 'III', 'Molto allegro', 'III. Molto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0663887b-6c78-4b09-8c36-e205defdab73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f215619-2137-4e2a-90c9-34a0ff14c7de', 4, 'IV', 'Andante con variazioni', 'IV. Andante con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f215619-2137-4e2a-90c9-34a0ff14c7de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66254d3c-2a6e-4c74-90e2-e4c8150f58d5', 5, 'V', 'Allegro, scherzo e vivace', 'V. Allegro, scherzo e vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66254d3c-2a6e-4c74-90e2-e4c8150f58d5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f546e61d-4690-4422-aa6b-82d2d9435b94', 6, 'VI', 'Adagio', 'VI. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f546e61d-4690-4422-aa6b-82d2d9435b94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:026f278f-49e4-4a4c-a0be-889eb854aaf6', 7, 'VII', 'Allegro vivace e disinvolto', 'VII. Allegro vivace e disinvolto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 세레나데 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:026f278f-49e4-4a4c-a0be-889eb854aaf6'
);


-- Op. 42 비올라와 피아노를 위한 녹투르노 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라와 피아노를 위한 녹투르노 D장조', 'Notturno for Viola and Piano in D major', 'album', 'Op. 42', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라와 피아노를 위한 녹투르노 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e00600dd-984d-4e3d-bf00-1ba88f075e4c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e00600dd-984d-4e3d-bf00-1ba88f075e4c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 피아노를 위한 녹투르노 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e00600dd-984d-4e3d-bf00-1ba88f075e4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36233de2-119c-3928-a600-d17fbc823491', 1, 'I', '행진곡', 'I. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 피아노를 위한 녹투르노 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36233de2-119c-3928-a600-d17fbc823491'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4426359f-90be-387f-9fb1-34e9240da855', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 피아노를 위한 녹투르노 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4426359f-90be-387f-9fb1-34e9240da855'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a127a220-3406-364b-b47d-65cecad41aee', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 피아노를 위한 녹투르노 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a127a220-3406-364b-b47d-65cecad41aee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:100c47ab-bd9b-3c0e-b335-981bfa91261c', 4, 'IV', 'Adagio – 스케르초', 'IV. Adagio – Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 피아노를 위한 녹투르노 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:100c47ab-bd9b-3c0e-b335-981bfa91261c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d4614e3-e585-3ad3-ae8c-b125e12a0a6f', 5, 'V', 'Allegretto alla Polacca', 'V. Allegretto alla Polacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 피아노를 위한 녹투르노 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d4614e3-e585-3ad3-ae8c-b125e12a0a6f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e922762d-3dc5-3a55-b415-6f8fec9215a1', 6, 'VI', 'Andante quasi Allegretto', 'VI. Andante quasi Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 피아노를 위한 녹투르노 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e922762d-3dc5-3a55-b415-6f8fec9215a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b90c006-4a03-3bb9-844f-78da70ae8980', 7, 'VII', '행진곡', 'VII. Marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 피아노를 위한 녹투르노 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b90c006-4a03-3bb9-844f-78da70ae8980'
);


-- Op. 43 발레 <프로메테우스의 창조물>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <프로메테우스의 창조물>', 'The Creatures of Prometheus', 'song', 'Op. 43', NULL, NULL, 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <프로메테우스의 창조물>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7de3a5e2-a5d9-3ea8-ad4d-fdd7459d9c4d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7de3a5e2-a5d9-3ea8-ad4d-fdd7459d9c4d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '발레 <프로메테우스의 창조물>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7de3a5e2-a5d9-3ea8-ad4d-fdd7459d9c4d'
);


-- Op. 44 피아노 3중주를 위한 창작 주제에 의한 14개의 변주곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주를 위한 창작 주제에 의한 14개의 변주곡 E♭장조', '14 Variations on an Original Theme in E♭ major for Piano Trio', 'song', 'Op. 44', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주를 위한 창작 주제에 의한 14개의 변주곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e7fd588-7967-386f-aafc-44ea6a87660d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e7fd588-7967-386f-aafc-44ea6a87660d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주를 위한 창작 주제에 의한 14개의 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e7fd588-7967-386f-aafc-44ea6a87660d'
);


-- Op. 45 네 손을 위한 행진곡 Op. 45

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 행진곡 Op. 45', '3 Marches for Piano Four Hands, Op. 45', 'album', NULL, 'Op.', '45', 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 행진곡 Op. 45'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f545326-e3e8-4090-a60b-4e3f650bea29'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f545326-e3e8-4090-a60b-4e3f650bea29'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '네 손을 위한 행진곡 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f545326-e3e8-4090-a60b-4e3f650bea29'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40d0944f-5be3-3ef6-bd5f-73ca6a796c71', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '네 손을 위한 행진곡 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40d0944f-5be3-3ef6-bd5f-73ca6a796c71'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcbcd34a-38b7-3a9f-9584-5b54caea5e52', 2, NULL, 'E♭장조', 'No. 2 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '네 손을 위한 행진곡 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcbcd34a-38b7-3a9f-9584-5b54caea5e52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83cb62e0-34d2-328f-a544-1bf7e94baad1', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '네 손을 위한 행진곡 Op. 45' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83cb62e0-34d2-328f-a544-1bf7e94baad1'
);


-- Op. 46 가곡 <아델라이데>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <아델라이데>', '"Adelaide"', 'song', 'Op. 46', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <아델라이데>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9debb7b4-9f71-376f-92ce-84a8dabcfd2d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9debb7b4-9f71-376f-92ce-84a8dabcfd2d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <아델라이데>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9debb7b4-9f71-376f-92ce-84a8dabcfd2d'
);


-- Op. 47 바이올린 소나타 9번 A장조 "크로이처"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c84d54a4-457e-3dc9-9ced-535e2cc3a347', 1, 'I', 'Adagio sostenuto – Presto', 'I. Adagio sostenuto – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26029 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c84d54a4-457e-3dc9-9ced-535e2cc3a347'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b49b1ab9-8e71-3fe9-8916-5764ae1a2b1f', 2, 'II', 'Andante con variazioni', 'II. Andante con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26029 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b49b1ab9-8e71-3fe9-8916-5764ae1a2b1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65ecbc97-d015-3d6c-b599-7dee875327fa', 3, 'III', '피날레. Presto', 'III. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26029 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65ecbc97-d015-3d6c-b599-7dee875327fa'
);


-- Op. 48 겔레르트 시에 의한 6개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '겔레르트 시에 의한 6개의 가곡', '6 Songs on Poems by Gellert, Op. 48', 'album', 'Op. 48', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '겔레르트 시에 의한 6개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13f5e49b-567a-4f61-bff1-422556156ee7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13f5e49b-567a-4f61-bff1-422556156ee7'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '겔레르트 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13f5e49b-567a-4f61-bff1-422556156ee7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0d24cd2-4cfa-398a-ae78-2ff1090b7f6c', 1, NULL, 'Bitten', 'Bitten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '겔레르트 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d24cd2-4cfa-398a-ae78-2ff1090b7f6c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a5f623f-b822-3330-8339-de6efa083bd5', 2, NULL, 'Die Liebe des Nächsten', 'Die Liebe des Nächsten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '겔레르트 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a5f623f-b822-3330-8339-de6efa083bd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2cc5d890-ecfc-3bbf-939e-247e8b506183', 3, NULL, 'Vom Tode', 'Vom Tode', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '겔레르트 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cc5d890-ecfc-3bbf-939e-247e8b506183'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f76ea5fb-9579-31ce-817f-d3b820d9ef0f', 4, NULL, '자연에서의 신의 영광 (Die Ehre Gottes aus der Natur)', 'Die Ehre Gottes aus der Natur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '겔레르트 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f76ea5fb-9579-31ce-817f-d3b820d9ef0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:642d707c-0939-3ff9-a150-8f5ce631dcc2', 5, NULL, 'Gottes Macht und Vorsehung', 'Gottes Macht und Vorsehung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '겔레르트 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:642d707c-0939-3ff9-a150-8f5ce631dcc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2f2524e-fb07-33c2-923b-7e415e016e83', 6, NULL, 'Bußlied', 'Bußlied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '겔레르트 시에 의한 6개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2f2524e-fb07-33c2-923b-7e415e016e83'
);


-- Op. 49 피아노 소나타 Op. 49

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 Op. 49', '2 Piano Sonatas, Op. 49', 'album', NULL, 'Op.', '49', 1798, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 Op. 49'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4b6fec2-1f30-4a72-9fed-d1862a3fa13c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd4b6fec2-1f30-4a72-9fed-d1862a3fa13c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd4b6fec2-1f30-4a72-9fed-d1862a3fa13c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05ffeac8-0648-43b5-9a7b-ebfae308dada', 1, NULL, '피아노 소나타 19번 G단조', 'Piano Sonata No. 19 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05ffeac8-0648-43b5-9a7b-ebfae308dada'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8547e452-2d64-31b9-8076-0750bf454cfe', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:05ffeac8-0648-43b5-9a7b-ebfae308dada'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8547e452-2d64-31b9-8076-0750bf454cfe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c61a2acd-a5ec-3df2-9edb-7d05518cb212', 2, 'II', '론도. Allegro', 'II. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:05ffeac8-0648-43b5-9a7b-ebfae308dada'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c61a2acd-a5ec-3df2-9edb-7d05518cb212'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69f6660b-42e7-4aa4-94e6-ec358c79d0a1', 2, NULL, '피아노 소나타 20번 G장조', 'Piano Sonata No. 20 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69f6660b-42e7-4aa4-94e6-ec358c79d0a1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8cc68ace-398d-3ddc-b614-9ea2ba4bc2e5', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:69f6660b-42e7-4aa4-94e6-ec358c79d0a1'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cc68ace-398d-3ddc-b614-9ea2ba4bc2e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f013473f-725f-34e6-bde0-e9845ea17b7a', 2, 'II', 'Tempo di menuetto', 'II. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:69f6660b-42e7-4aa4-94e6-ec358c79d0a1'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 Op. 49' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f013473f-725f-34e6-bde0-e9845ea17b7a'
);


-- Op. 50 바이올린 로망스 2번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 로망스 2번 F장조', 'Romance for Violin and Orchestra No. 2 in F major', 'song', 'Op. 50', NULL, NULL, 1798, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 로망스 2번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd525f1d-079c-3989-ad4d-063d150659c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dd525f1d-079c-3989-ad4d-063d150659c5'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 로망스 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dd525f1d-079c-3989-ad4d-063d150659c5'
);


-- Op. 51 론도 Op. 51

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 Op. 51', '2 Rondos, Op. 51', 'album', NULL, 'Op.', '51', 1798, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 Op. 51'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b5da767-0c71-493f-a841-8953ce1985b6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b5da767-0c71-493f-a841-8953ce1985b6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '론도 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b5da767-0c71-493f-a841-8953ce1985b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46b85f3f-b493-3f42-80f7-8498fe4af4fc', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '론도 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46b85f3f-b493-3f42-80f7-8498fe4af4fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b8b33c5-7ed3-3a14-a3e7-0332521506da', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '론도 Op. 51' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b8b33c5-7ed3-3a14-a3e7-0332521506da'
);


-- Op. 52 가곡집 Op. 52

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 Op. 52', '8 Songs, Op. 52', 'album', NULL, 'Op.', '52', 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 Op. 52'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4069c57-523c-4b58-8bc0-63128b07a31b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4069c57-523c-4b58-8bc0-63128b07a31b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4069c57-523c-4b58-8bc0-63128b07a31b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48dfdf49-08d0-38ad-a795-902ed87c224f', 1, NULL, 'Urians Reise um die Welt', 'Urians Reise um die Welt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48dfdf49-08d0-38ad-a795-902ed87c224f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b59514a1-b1da-306c-abd1-56cfdc7d6247', 2, NULL, 'Feuerfarb', 'Feuerfarb', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b59514a1-b1da-306c-abd1-56cfdc7d6247'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c45d4f31-f86b-355f-b8c7-9268e8a6733a', 3, NULL, 'Das Liedchen von der Ruhe', 'Das Liedchen von der Ruhe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c45d4f31-f86b-355f-b8c7-9268e8a6733a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:638124ae-7a26-35d4-857f-9dbea0f36eda', 4, NULL, 'Maigesang', 'Maigesang', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:638124ae-7a26-35d4-857f-9dbea0f36eda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9f7e83c-4550-361b-a791-e8a4fd542ea7', 5, NULL, 'Mollys Abschied', 'Mollys Abschied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f7e83c-4550-361b-a791-e8a4fd542ea7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2a076d8-503b-3789-b7bd-2328252a37e8', 6, NULL, 'Die Liebe', 'Die Liebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2a076d8-503b-3789-b7bd-2328252a37e8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a14b657-003d-32c2-a23c-4d0efb89f0cb', 7, NULL, '마르모트 (Marmotte)', 'Marmotte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a14b657-003d-32c2-a23c-4d0efb89f0cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69862a27-e295-308c-940f-7b0a7ab85ee2', 8, NULL, 'Das Blümchen Wunderhold', 'Das Blümchen Wunderhold', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 52' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69862a27-e295-308c-940f-7b0a7ab85ee2'
);


-- Op. 53 피아노 소나타 21번 C장조 "발트슈타인"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 21번 C장조 "발트슈타인"', 'Piano Sonata No. 21 in C major "Waldstein"', 'album', 'Op. 53', NULL, NULL, 1804, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 21번 C장조 "발트슈타인"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3c9dc10-0f58-3fcd-9b9f-bd455e386941'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a3c9dc10-0f58-3fcd-9b9f-bd455e386941'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 21번 C장조 "발트슈타인"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a3c9dc10-0f58-3fcd-9b9f-bd455e386941'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd6d9d60-ac80-3cac-9d82-28fb02a7b064', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 21번 C장조 "발트슈타인"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd6d9d60-ac80-3cac-9d82-28fb02a7b064'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50587852-9cd7-338a-a41a-131967df2ca4', 2, 'II', '서주. Adagio molto', 'II. Introduzione. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 21번 C장조 "발트슈타인"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50587852-9cd7-338a-a41a-131967df2ca4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe340921-a4cf-3871-939c-bc2e479cacd2', 3, 'III', '론도. Allegretto moderato – Prestissimo', 'III. Rondo. Allegretto moderato – Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 21번 C장조 "발트슈타인"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe340921-a4cf-3871-939c-bc2e479cacd2'
);


-- Op. 54 피아노 소나타 22번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 22번 F장조', 'Piano Sonata No. 22 in F major', 'album', 'Op. 54', NULL, NULL, 1804, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 22번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b943c15-b04f-4c37-b4e9-bdddc5471bd6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4b943c15-b04f-4c37-b4e9-bdddc5471bd6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 22번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4b943c15-b04f-4c37-b4e9-bdddc5471bd6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8e6c518-30da-3dc1-acdc-72a08442455f', 1, 'I', 'Tempo di menuetto', 'I. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 22번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8e6c518-30da-3dc1-acdc-72a08442455f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cfcb382-3ccd-3742-8ba7-bc830a32a0b4', 2, 'II', 'Allegretto – Più allegro', 'II. Allegretto – Più allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 22번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cfcb382-3ccd-3742-8ba7-bc830a32a0b4'
);


-- Op. 55 교향곡 3번 E♭장조 "영웅"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96719aa1-cc41-38b4-82b6-a647d2a902be', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 77 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96719aa1-cc41-38b4-82b6-a647d2a902be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddd8c7a4-22e2-3fc1-87c5-0b79141711e2', 2, 'II', '장송 행진곡. Adagio assai', 'II. Marcia funebre. Adagio assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 77 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddd8c7a4-22e2-3fc1-87c5-0b79141711e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f8c063f-4d8d-3625-9c32-9b99579e5930', 3, 'III', '스케르초. Allegro vivace', 'III. Scherzo. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 77 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f8c063f-4d8d-3625-9c32-9b99579e5930'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:933adf97-a018-3cc8-b91a-6877cf8dc802', 4, 'IV', '피날레. Allegro molto', 'IV. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 77 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:933adf97-a018-3cc8-b91a-6877cf8dc802'
);


-- Op. 56 3중 협주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중 협주곡 C장조', 'Triple Concerto for Violin, Cello and Piano in C major', 'album', 'Op. 56', NULL, NULL, 1805, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중 협주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '178f118a-ebd7-43e1-b9f5-719a1691f15b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '178f118a-ebd7-43e1-b9f5-719a1691f15b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '3중 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '178f118a-ebd7-43e1-b9f5-719a1691f15b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ae459db-3dfb-37d6-b5e2-5effe5933b7a', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '3중 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ae459db-3dfb-37d6-b5e2-5effe5933b7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8ed6201-9299-39d9-97be-971c8d002d1d', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '3중 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8ed6201-9299-39d9-97be-971c8d002d1d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f305c60-c0b8-35f4-a41c-3da763705ddc', 3, 'III', '론도 alla polacca', 'III. Rondo alla polacca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '3중 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f305c60-c0b8-35f4-a41c-3da763705ddc'
);


-- Op. 57 피아노 소나타 23번 F단조 "열정"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c813b9f9-97c5-3e21-8f99-265c0ecef0b8', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 440 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c813b9f9-97c5-3e21-8f99-265c0ecef0b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f061e0c-fd76-36ff-8ea0-5c6671e0a183', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 440 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f061e0c-fd76-36ff-8ea0-5c6671e0a183'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:810e6450-7e87-329d-9739-687406e80dba', 3, 'III', 'Allegro ma non troppo', 'III. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 440 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:810e6450-7e87-329d-9739-687406e80dba'
);


-- Op. 58 피아노 협주곡 4번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 4번 G장조', 'Piano Concerto No. 4 in G major', 'album', 'Op. 58', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 4번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dd17c0c-8b35-41a3-b23d-e47786277fb4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2dd17c0c-8b35-41a3-b23d-e47786277fb4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dd17c0c-8b35-41a3-b23d-e47786277fb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60da45e9-2479-3b95-91ba-45d27ee14897', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60da45e9-2479-3b95-91ba-45d27ee14897'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5877ea7b-5fb6-3536-b1be-1615185cbe43', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5877ea7b-5fb6-3536-b1be-1615185cbe43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8039ddb5-587f-350c-ad78-126ca9782aed', 3, 'III', '론도. Vivace', 'III. Rondo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 4번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8039ddb5-587f-350c-ad78-126ca9782aed'
);


-- Op. 59 현악 4중주 Op. 59 "라주모프스키"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 Op. 59 "라주모프스키"', '3 String Quartets "Razumovsky", Op. 59', 'album', 'Op. 59', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 Op. 59 "라주모프스키"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13c0c417-12ef-41f2-88bb-619a13ca619f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13c0c417-12ef-41f2-88bb-619a13ca619f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13c0c417-12ef-41f2-88bb-619a13ca619f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9833ed4b-e167-40c5-8ef4-6775bed7444e', 1, NULL, '현악 4중주 7번 F장조', 'String Quartet No. 7 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9833ed4b-e167-40c5-8ef4-6775bed7444e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4f73f3a5-5753-3950-ab9d-118d8cdfbdf6', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9833ed4b-e167-40c5-8ef4-6775bed7444e'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f73f3a5-5753-3950-ab9d-118d8cdfbdf6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5d47ea94-9d02-3f71-8313-2842f9e5d5f6', 2, 'II', 'Allegretto vivace e sempre scherzando', 'II. Allegretto vivace e sempre scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9833ed4b-e167-40c5-8ef4-6775bed7444e'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d47ea94-9d02-3f71-8313-2842f9e5d5f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1c0c9ba8-a3ba-3075-abcf-e9a46a199632', 3, 'III', 'Adagio molto', 'III. Adagio molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9833ed4b-e167-40c5-8ef4-6775bed7444e'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c0c9ba8-a3ba-3075-abcf-e9a46a199632'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:edf861ac-3aa2-354f-b07f-7d23b4427b54', 4, 'IV', '러시아 주제. Allegro', 'IV. Thème russe. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9833ed4b-e167-40c5-8ef4-6775bed7444e'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edf861ac-3aa2-354f-b07f-7d23b4427b54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa6befc6-32ba-4692-87d8-15bd67ae7290', 2, NULL, '현악 4중주 8번 E단조', 'String Quartet No. 8 in E minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa6befc6-32ba-4692-87d8-15bd67ae7290'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:318f61d4-c5f8-31df-b00e-1111cac180cb', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa6befc6-32ba-4692-87d8-15bd67ae7290'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:318f61d4-c5f8-31df-b00e-1111cac180cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:00b31789-f2c5-36c5-ba5d-c9b4bbed71ea', 2, 'II', 'Molto adagio – Si tratta questo pezzo con molto di sentimento', 'II. Molto adagio – Si tratta questo pezzo con molto di sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa6befc6-32ba-4692-87d8-15bd67ae7290'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00b31789-f2c5-36c5-ba5d-c9b4bbed71ea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:524a015b-2095-36f1-ae9e-2baa7e3a4975', 3, 'III', 'Allegretto – Maggiore', 'III. Allegretto – Maggiore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa6befc6-32ba-4692-87d8-15bd67ae7290'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:524a015b-2095-36f1-ae9e-2baa7e3a4975'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c8178ccf-77a0-3782-b856-c6434ec3a843', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:aa6befc6-32ba-4692-87d8-15bd67ae7290'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8178ccf-77a0-3782-b856-c6434ec3a843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:297b54c8-03f8-49ea-8288-a5421e059e20', 3, NULL, '현악 4중주 9번 C장조', 'String Quartet No. 9 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:297b54c8-03f8-49ea-8288-a5421e059e20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea38a3b8-d08e-3903-9c4f-b593fcf455f9', 1, 'I', 'Andante con moto – Allegro vivace', 'I. Andante con moto – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:297b54c8-03f8-49ea-8288-a5421e059e20'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea38a3b8-d08e-3903-9c4f-b593fcf455f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c80c51d8-dd9b-3a49-81e4-24280d5fe248', 2, 'II', 'Andante con moto quasi allegretto', 'II. Andante con moto quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:297b54c8-03f8-49ea-8288-a5421e059e20'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c80c51d8-dd9b-3a49-81e4-24280d5fe248'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:846a7595-ade7-3632-8f09-8afdf24a64a9', 3, 'III', '미뉴에트. Grazioso', 'III. Minuetto. Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:297b54c8-03f8-49ea-8288-a5421e059e20'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:846a7595-ade7-3632-8f09-8afdf24a64a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8a42d819-da68-3844-a9be-54da32c45626', 4, 'IV', 'Allegro molto', 'IV. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:297b54c8-03f8-49ea-8288-a5421e059e20'
WHERE p.composer_id = 15 AND p.title = '현악 4중주 Op. 59 "라주모프스키"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a42d819-da68-3844-a9be-54da32c45626'
);


-- Op. 60 교향곡 4번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 4번 B♭장조', 'Symphony No. 4 in B♭ major', 'album', 'Op. 60', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 4번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '273fea50-59bf-4711-81c8-035502b40c24'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '273fea50-59bf-4711-81c8-035502b40c24'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 4번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '273fea50-59bf-4711-81c8-035502b40c24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:424a3448-2afe-3d24-ad8d-22539100bf05', 1, 'I', 'Adagio – Allegro vivace', 'I. Adagio – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 4번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:424a3448-2afe-3d24-ad8d-22539100bf05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19ed94d7-978e-34e7-9c35-ac9b7ef26c2e', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 4번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19ed94d7-978e-34e7-9c35-ac9b7ef26c2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:328d0a2b-f38c-3bb6-835b-b8cdcd9130e3', 3, 'III', 'Allegro vivace', 'III. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 4번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:328d0a2b-f38c-3bb6-835b-b8cdcd9130e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:894f3107-9db4-33ba-bc47-e7c52f4468ed', 4, 'IV', 'Allegro ma non troppo', 'IV. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 4번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:894f3107-9db4-33ba-bc47-e7c52f4468ed'
);


-- Op. 61 바이올린 협주곡 D장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42d81164-7e2f-3583-bba2-5e4e481ba4b1', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 81 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42d81164-7e2f-3583-bba2-5e4e481ba4b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da878d11-c80d-381a-9b0f-a430c796a42d', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 81 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da878d11-c80d-381a-9b0f-a430c796a42d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c95b848-5c05-315f-8e60-6b822212b3f4', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 81 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c95b848-5c05-315f-8e60-6b822212b3f4'
);


-- Op. 61a 피아노 협주곡 D장조 (바이올린 협주곡 편곡)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 D장조 (바이올린 협주곡 편곡)', 'Piano Concerto in D major (after the Violin Concerto)', 'album', 'Op. 61a', NULL, NULL, 1807, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 D장조 (바이올린 협주곡 편곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b71b611d-bd0a-443d-a48c-0b30c875b3fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b71b611d-bd0a-443d-a48c-0b30c875b3fc'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 D장조 (바이올린 협주곡 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b71b611d-bd0a-443d-a48c-0b30c875b3fc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3938bceb-5416-3d8d-a80f-4eccade95a24', 1, 'I', 'Allegro ma non troppo', 'I. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 D장조 (바이올린 협주곡 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3938bceb-5416-3d8d-a80f-4eccade95a24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a37774ee-dae5-3e4e-8b68-0efb031cb41d', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 D장조 (바이올린 협주곡 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a37774ee-dae5-3e4e-8b68-0efb031cb41d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84efad83-f99f-386a-9eb5-d5d724a7ece1', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 D장조 (바이올린 협주곡 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84efad83-f99f-386a-9eb5-d5d724a7ece1'
);


-- Op. 62 서곡 <코리올란> C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <코리올란> C단조', 'Coriolan Overture in C minor', 'song', 'Op. 62', NULL, NULL, 1807, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <코리올란> C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82c92c7d-5875-333f-bccd-5e9254d78710'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82c92c7d-5875-333f-bccd-5e9254d78710'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '서곡 <코리올란> C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82c92c7d-5875-333f-bccd-5e9254d78710'
);


-- Op. 65 장면과 아리아 <아! 배신자여>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '장면과 아리아 <아! 배신자여>', 'Scena and Aria "Ah! perfido"', 'song', 'Op. 65', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '장면과 아리아 <아! 배신자여>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b351914e-9fc4-3802-9b37-f207dc232b25'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b351914e-9fc4-3802-9b37-f207dc232b25'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장면과 아리아 <아! 배신자여>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b351914e-9fc4-3802-9b37-f207dc232b25'
);


-- Op. 66 <마술피리>의 "Ein Mädchen oder Weibchen" 주제에 의한 12개의 변주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<마술피리>의 "Ein Mädchen oder Weibchen" 주제에 의한 12개의 변주곡 F장조', '12 Variations in F major on "Ein Mädchen oder Weibchen" from Mozart''s The Magic Flute', 'song', 'Op. 66', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<마술피리>의 "Ein Mädchen oder Weibchen" 주제에 의한 12개의 변주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35f59b69-7724-3ea6-a5e1-ee1ae332a04f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35f59b69-7724-3ea6-a5e1-ee1ae332a04f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<마술피리>의 "Ein Mädchen oder Weibchen" 주제에 의한 12개의 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35f59b69-7724-3ea6-a5e1-ee1ae332a04f'
);


-- Op. 67 교향곡 5번 C단조 "운명"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6f9ecc3-24d1-38ed-b8a0-091f7cd0c6b2', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 75 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6f9ecc3-24d1-38ed-b8a0-091f7cd0c6b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3bc742da-f67b-36c9-b31e-6ed09fdbdadd', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 75 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bc742da-f67b-36c9-b31e-6ed09fdbdadd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5831439d-e776-3b0e-ad34-c1a112d96e6d', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 75 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5831439d-e776-3b0e-ad34-c1a112d96e6d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7eacabfd-c702-3eb6-8738-322555d6a521', 4, 'IV', 'Allegro', 'IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 75 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eacabfd-c702-3eb6-8738-322555d6a521'
);


-- Op. 68 교향곡 6번 F장조 "전원"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d4b8437e-5ee6-33b2-9462-3bb0d51ec0a0', 1, 'I', '시골에 도착했을 때의 즐거운 기분. Allegro ma non troppo', 'I. Erwachen heiterer Empfindungen bei der Ankunft auf dem Lande. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 437 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4b8437e-5ee6-33b2-9462-3bb0d51ec0a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a954237b-a56f-38e3-8d0b-739570dbcd6a', 2, 'II', '시냇가의 정경. Andante molto mosso', 'II. Szene am Bach. Andante molto mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 437 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a954237b-a56f-38e3-8d0b-739570dbcd6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc77216a-d316-3e92-8ee8-9b1cf3027ba9', 3, 'III', '시골 사람들의 즐거운 모임. Allegro', 'III. Lustiges Zusammensein der Landleute. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 437 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc77216a-d316-3e92-8ee8-9b1cf3027ba9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21b4c0c6-35ff-36a5-aeeb-ee4f0e30cc7d', 4, 'IV', '천둥, 폭풍. Allegro', 'IV. Gewitter, Sturm. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 437 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21b4c0c6-35ff-36a5-aeeb-ee4f0e30cc7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08202a87-8263-3f82-9d6e-09daf309615a', 5, 'V', '목동의 노래. 폭풍 뒤의 기쁨과 감사. Allegretto', 'V. Hirtengesang. Frohe und dankbare Gefühle nach dem Sturm. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 437 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08202a87-8263-3f82-9d6e-09daf309615a'
);


-- Op. 69 첼로 소나타 3번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 소나타 3번 A장조', 'Cello Sonata No. 3 in A major', 'album', 'Op. 69', NULL, NULL, 1807, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 소나타 3번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '015dadf8-f382-434b-b88a-3838e7199358'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '015dadf8-f382-434b-b88a-3838e7199358'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 3번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '015dadf8-f382-434b-b88a-3838e7199358'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98d80cc2-b5e1-3be8-b244-995d2af0b918', 1, 'I', 'Allegro ma non tanto', 'I. Allegro ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 3번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98d80cc2-b5e1-3be8-b244-995d2af0b918'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84aeb042-86ee-3d3f-97dd-59572693f678', 2, 'II', '스케르초. Allegro molto', 'II. Scherzo. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 3번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84aeb042-86ee-3d3f-97dd-59572693f678'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:760a061e-0001-30a5-b14f-1d203428fd96', 3, 'III', 'Adagio cantabile – Allegro vivace', 'III. Adagio cantabile – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 3번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:760a061e-0001-30a5-b14f-1d203428fd96'
);


-- Op. 70 피아노 3중주 Op. 70

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 Op. 70', '2 Piano Trios, Op. 70', 'album', NULL, 'Op.', '70', 1808, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 Op. 70'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ad519bd-aa0c-4104-ac38-83b74d28745e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ad519bd-aa0c-4104-ac38-83b74d28745e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ad519bd-aa0c-4104-ac38-83b74d28745e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35ede325-8b06-4b8c-bff1-48e1c22c5eb3', 1, NULL, '피아노 3중주 5번 D장조 "유령"', 'Piano Trio No. 5 in D major "Ghost"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35ede325-8b06-4b8c-bff1-48e1c22c5eb3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:962c9d83-8aa1-30a7-a4a6-5643bacbc053', 1, 'I', 'Allegro vivace e con brio', 'I. Allegro vivace e con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:35ede325-8b06-4b8c-bff1-48e1c22c5eb3'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:962c9d83-8aa1-30a7-a4a6-5643bacbc053'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2586e2ad-557b-3bae-9cb0-96100565de59', 2, 'II', 'Largo assai e espressivo', 'II. Largo assai e espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:35ede325-8b06-4b8c-bff1-48e1c22c5eb3'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2586e2ad-557b-3bae-9cb0-96100565de59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:51bf1b7e-91b1-3f5b-89d9-897b89a8b415', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:35ede325-8b06-4b8c-bff1-48e1c22c5eb3'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51bf1b7e-91b1-3f5b-89d9-897b89a8b415'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:89684875-11ca-45a1-b91e-4aac5bed6747', 2, NULL, '피아노 3중주 6번 E♭장조', 'Piano Trio No. 6 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89684875-11ca-45a1-b91e-4aac5bed6747'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57a0d83d-2f76-3ebd-b212-d4a2ce20cf1a', 1, 'I', 'Poco sostenuto – Allegro ma non troppo', 'I. Poco sostenuto – Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89684875-11ca-45a1-b91e-4aac5bed6747'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57a0d83d-2f76-3ebd-b212-d4a2ce20cf1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:16712264-cf36-3628-a716-11e0ad5d3fa9', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89684875-11ca-45a1-b91e-4aac5bed6747'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16712264-cf36-3628-a716-11e0ad5d3fa9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3700d007-f449-3ef2-8f5c-db86843bcd9b', 3, 'III', 'Allegretto ma non troppo', 'III. Allegretto ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89684875-11ca-45a1-b91e-4aac5bed6747'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3700d007-f449-3ef2-8f5c-db86843bcd9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da0ccfa4-d34b-3015-987e-d4b3c4c8f84d', 4, 'IV', '피날레. Allegro', 'IV. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:89684875-11ca-45a1-b91e-4aac5bed6747'
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 Op. 70' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da0ccfa4-d34b-3015-987e-d4b3c4c8f84d'
);


-- Op. 71 관악 6중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 6중주 E♭장조', 'Wind Sextet in E♭ major', 'album', 'Op. 71', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 6중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36331457-a628-4327-986d-ce3c22783b1c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '36331457-a628-4327-986d-ce3c22783b1c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '36331457-a628-4327-986d-ce3c22783b1c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa1f2636-f36c-3345-8969-e88da4f8507f', 1, 'I', 'Adagio – Allegro', 'I. Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa1f2636-f36c-3345-8969-e88da4f8507f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:542ce1ba-9a3a-3ec7-8aeb-5ee2e4990336', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:542ce1ba-9a3a-3ec7-8aeb-5ee2e4990336'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f78392b-861f-3737-96cf-2140b52de4df', 3, 'III', '미뉴에트. Quasi Allegretto', 'III. Menuetto. Quasi Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f78392b-861f-3737-96cf-2140b52de4df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a39afbc-4aef-3fe5-a0f0-c3f61483dd6d', 4, 'IV', '론도. Allegro', 'IV. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a39afbc-4aef-3fe5-a0f0-c3f61483dd6d'
);


-- Op. 72 오페라 <피델리오>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <피델리오>', 'Fidelio', 'song', 'Op. 72', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <피델리오>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af3cad37-3157-4752-af8e-9d413366dde4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af3cad37-3157-4752-af8e-9d413366dde4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '오페라 <피델리오>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af3cad37-3157-4752-af8e-9d413366dde4'
);


-- Op. 72a <레오노레> 서곡 2번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<레오노레> 서곡 2번 C장조', 'Leonore Overture No. 2 in C major', 'song', 'Op. 72a', NULL, NULL, 1805, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<레오노레> 서곡 2번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68c28f5b-e2bc-3359-be6a-5e3d37f9736e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '68c28f5b-e2bc-3359-be6a-5e3d37f9736e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<레오노레> 서곡 2번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '68c28f5b-e2bc-3359-be6a-5e3d37f9736e'
);


-- Op. 72b <레오노레> 서곡 3번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<레오노레> 서곡 3번 C장조', 'Leonore Overture No. 3 in C major', 'song', 'Op. 72b', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<레오노레> 서곡 3번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '591fcf82-a054-3dbc-a3a9-6b952b05e2a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '591fcf82-a054-3dbc-a3a9-6b952b05e2a7'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<레오노레> 서곡 3번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '591fcf82-a054-3dbc-a3a9-6b952b05e2a7'
);


-- Op. 73 피아노 협주곡 5번 E♭장조 "황제"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:913bc84d-158b-3ac3-821e-6cc5e46c9bb5', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 80 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:913bc84d-158b-3ac3-821e-6cc5e46c9bb5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffdf5002-45cc-3533-898e-b43441b8aa3f', 2, 'II', 'Adagio un poco mosso', 'II. Adagio un poco mosso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 80 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffdf5002-45cc-3533-898e-b43441b8aa3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b6b0a615-adf9-3427-a3ba-cd34556d9997', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 80 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6b0a615-adf9-3427-a3ba-cd34556d9997'
);


-- Op. 74 현악 4중주 10번 E♭장조 "하프"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 10번 E♭장조 "하프"', 'String Quartet No. 10 in E♭ major "Harp"', 'album', 'Op. 74', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 10번 E♭장조 "하프"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdb3af54-4c10-4c8d-9147-0e7c3400f7cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fdb3af54-4c10-4c8d-9147-0e7c3400f7cc'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 10번 E♭장조 "하프"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdb3af54-4c10-4c8d-9147-0e7c3400f7cc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be0b9c47-fb23-3bad-9447-85dfc410205f', 1, 'I', 'Poco adagio – Allegro', 'I. Poco adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 10번 E♭장조 "하프"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be0b9c47-fb23-3bad-9447-85dfc410205f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9a39b73-ecd2-36d3-b3a8-7d69b77ae8a4', 2, 'II', 'Adagio ma non troppo', 'II. Adagio ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 10번 E♭장조 "하프"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9a39b73-ecd2-36d3-b3a8-7d69b77ae8a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:882040a4-3149-3d7e-b40d-d9e827cfcdb6', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 10번 E♭장조 "하프"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:882040a4-3149-3d7e-b40d-d9e827cfcdb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7dc3427-8fa0-3b3a-a4e9-5b157770afcb', 4, 'IV', 'Allegretto con variazioni', 'IV. Allegretto con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 10번 E♭장조 "하프"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7dc3427-8fa0-3b3a-a4e9-5b157770afcb'
);


-- Op. 75 가곡집 Op. 75

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡집 Op. 75', '6 Songs, Op. 75', 'album', NULL, 'Op.', '75', 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡집 Op. 75'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1628888f-9000-426d-89e5-0c61161887db'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1628888f-9000-426d-89e5-0c61161887db'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1628888f-9000-426d-89e5-0c61161887db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55f816d2-2b82-32c2-a236-ab130bee5293', 1, NULL, '미뇽 (Mignon)', 'Mignon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55f816d2-2b82-32c2-a236-ab130bee5293'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71c35628-8de0-36aa-91fc-930de374d4b6', 2, NULL, 'Neue Liebe, neues Leben', 'Neue Liebe, neues Leben', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71c35628-8de0-36aa-91fc-930de374d4b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00021cd2-1218-32a7-8ee2-44d8384054e0', 3, NULL, 'Aus Goethes Faust', 'Aus Goethes Faust', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00021cd2-1218-32a7-8ee2-44d8384054e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bfb894b9-e51a-3af1-bd0c-b95703701980', 4, NULL, 'Gretels Warnung', 'Gretels Warnung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfb894b9-e51a-3af1-bd0c-b95703701980'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9997194-a3a6-3c65-b749-c5585f835d8a', 5, NULL, 'An den fernen Geliebten', 'An den fernen Geliebten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9997194-a3a6-3c65-b749-c5585f835d8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afbcc716-7cb7-3775-9d5b-c720a000eae2', 6, NULL, 'Der Zufriedene', 'Der Zufriedene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡집 Op. 75' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afbcc716-7cb7-3775-9d5b-c720a000eae2'
);


-- Op. 76 창작 주제에 의한 6개의 변주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '창작 주제에 의한 6개의 변주곡 D장조', '6 Variations on an Original Theme in D major', 'song', 'Op. 76', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '창작 주제에 의한 6개의 변주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0eccb5ff-6244-3950-b635-7ed04bff497e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0eccb5ff-6244-3950-b635-7ed04bff497e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '창작 주제에 의한 6개의 변주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0eccb5ff-6244-3950-b635-7ed04bff497e'
);


-- Op. 77 환상곡 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 G단조', 'Fantasia in G minor', 'song', 'Op. 77', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '960585c6-3f15-307f-8df7-f686f95aef53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '960585c6-3f15-307f-8df7-f686f95aef53'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '환상곡 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '960585c6-3f15-307f-8df7-f686f95aef53'
);


-- Op. 78 피아노 소나타 24번 F#장조 "테레제"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 24번 F#장조 "테레제"', 'Piano Sonata No. 24 in F# major "À Thérèse"', 'album', 'Op. 78', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 24번 F#장조 "테레제"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47207de2-91f8-3cd3-a029-47ab5f12fd5c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '47207de2-91f8-3cd3-a029-47ab5f12fd5c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 24번 F#장조 "테레제"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '47207de2-91f8-3cd3-a029-47ab5f12fd5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db69f268-01ba-35ef-a151-39dff04e7fff', 1, 'I', 'Adagio cantabile – Allegro ma non troppo', 'I. Adagio cantabile – Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 24번 F#장조 "테레제"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db69f268-01ba-35ef-a151-39dff04e7fff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d3ad3708-019b-36bb-a99e-80b1f3e97482', 2, 'II', 'Allegro vivace', 'II. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 24번 F#장조 "테레제"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d3ad3708-019b-36bb-a99e-80b1f3e97482'
);


-- Op. 79 피아노 소나타 25번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 25번 G장조', 'Piano Sonata No. 25 in G major', 'album', 'Op. 79', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 25번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '318b575a-a5f8-3408-8ed5-0c5b85611b86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '318b575a-a5f8-3408-8ed5-0c5b85611b86'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 25번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '318b575a-a5f8-3408-8ed5-0c5b85611b86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:670f2ce0-a976-384b-92ee-b15fb888b227', 1, 'I', 'Presto alla tedesca', 'I. Presto alla tedesca', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 25번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:670f2ce0-a976-384b-92ee-b15fb888b227'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:19ce9a53-1db4-334f-a3bd-968b3832c8fa', 2, 'II', 'Andante espressivo', 'II. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 25번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:19ce9a53-1db4-334f-a3bd-968b3832c8fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66582311-f08e-3b6d-a453-cdd3b8e65c23', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 25번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66582311-f08e-3b6d-a453-cdd3b8e65c23'
);


-- Op. 80 합창 환상곡 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '합창 환상곡 C단조', 'Choral Fantasy in C minor', 'song', 'Op. 80', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '합창 환상곡 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29d54cda-8a84-3e7a-9984-6085fec39624'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29d54cda-8a84-3e7a-9984-6085fec39624'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '합창 환상곡 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29d54cda-8a84-3e7a-9984-6085fec39624'
);


-- Op. 81a 피아노 소나타 26번 E♭장조 "고별"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 26번 E♭장조 "고별"', 'Piano Sonata No. 26 in E♭ major "Les Adieux"', 'album', 'Op. 81a', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 26번 E♭장조 "고별"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9406d239-0efc-40e5-be6c-fbb15a3a091f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9406d239-0efc-40e5-be6c-fbb15a3a091f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 26번 E♭장조 "고별"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9406d239-0efc-40e5-be6c-fbb15a3a091f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c77882db-f275-394f-a59c-7f37061d240f', 1, 'I', '고별. Adagio – Allegro', 'I. Das Lebewohl. Adagio – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 26번 E♭장조 "고별"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c77882db-f275-394f-a59c-7f37061d240f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a6e3a8dd-affd-3e3f-9924-21ade3626e8e', 2, 'II', '부재. Andante espressivo', 'II. Abwesenheit. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 26번 E♭장조 "고별"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6e3a8dd-affd-3e3f-9924-21ade3626e8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0ef7021-e61e-331d-9322-2925bf1d2f9a', 3, 'III', '재회. Vivacissimamente', 'III. Das Wiedersehen. Vivacissimamente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 26번 E♭장조 "고별"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0ef7021-e61e-331d-9322-2925bf1d2f9a'
);


-- Op. 81b 두 대의 호른과 현악 4중주를 위한 6중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 호른과 현악 4중주를 위한 6중주 E♭장조', 'Sextet for 2 Horns and String Quartet in E♭ major', 'album', 'Op. 81b', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 호른과 현악 4중주를 위한 6중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6db33013-410e-46a9-9878-3979e29eb453'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6db33013-410e-46a9-9878-3979e29eb453'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 호른과 현악 4중주를 위한 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6db33013-410e-46a9-9878-3979e29eb453'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7a0b158-8e56-3091-bc46-c258cad9d4f7', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 호른과 현악 4중주를 위한 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7a0b158-8e56-3091-bc46-c258cad9d4f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63a4c2a0-2a83-32ef-b2a8-54da603ffcf0', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 호른과 현악 4중주를 위한 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63a4c2a0-2a83-32ef-b2a8-54da603ffcf0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af0c529a-4ffe-38d7-8166-bda69e043806', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 호른과 현악 4중주를 위한 6중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af0c529a-4ffe-38d7-8166-bda69e043806'
);


-- Op. 82 4개의 아리에타와 2중창

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 아리에타와 2중창', '4 Ariettas and a Duet, Op. 82', 'album', 'Op. 82', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 아리에타와 2중창'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '708fc2db-7e6f-4276-bd99-44e09fde1d94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '708fc2db-7e6f-4276-bd99-44e09fde1d94'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4개의 아리에타와 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '708fc2db-7e6f-4276-bd99-44e09fde1d94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60a88413-3655-45d5-8c31-406dd3fcbaf5', 1, NULL, 'Dimmi, ben mio, che m''ami (Hoffnung)', 'Dimmi, ben mio, che m''ami (Hoffnung)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4개의 아리에타와 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60a88413-3655-45d5-8c31-406dd3fcbaf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18502619-8218-439c-b66d-a4a4220b21dd', 2, NULL, 'T''intendo, sì, mio cor (Liebes-Klage)', 'T''intendo, sì, mio cor (Liebes-Klage)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4개의 아리에타와 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18502619-8218-439c-b66d-a4a4220b21dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80c9bce1-6dc4-4c7c-b4c0-6a1b5c274735', 3, NULL, 'L''amante impaziente (Arietta buffa)', 'L''amante impaziente (Arietta buffa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4개의 아리에타와 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80c9bce1-6dc4-4c7c-b4c0-6a1b5c274735'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7414887-c379-46c1-96c6-3f22d6261343', 4, NULL, 'L''amante impaziente (Arietta assai seriosa)', 'L''amante impaziente (Arietta assai seriosa)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4개의 아리에타와 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7414887-c379-46c1-96c6-3f22d6261343'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54bb951a-2edd-4782-9f97-29eaca8a0b9d', 5, NULL, 'Odi l''aura che dolce sospira (Lebensgenuss)', 'Odi l''aura che dolce sospira (Lebensgenuss), duet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4개의 아리에타와 2중창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54bb951a-2edd-4782-9f97-29eaca8a0b9d'
);


-- Op. 83 괴테 시에 의한 3개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '괴테 시에 의한 3개의 가곡', '3 Songs on Poems by Goethe, Op. 83', 'album', 'Op. 83', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '괴테 시에 의한 3개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '347d1f6b-a6d6-430b-b42d-54723077aaf1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '347d1f6b-a6d6-430b-b42d-54723077aaf1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '괴테 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '347d1f6b-a6d6-430b-b42d-54723077aaf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25ed2bdc-69d7-3448-9964-1601ca5fa0f3', 1, NULL, 'Wonne der Wehmut', 'Wonne der Wehmut', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '괴테 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25ed2bdc-69d7-3448-9964-1601ca5fa0f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0f15213-1a61-32dd-95a1-0cd1a0bc8ba4', 2, NULL, 'Sehnsucht', 'Sehnsucht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '괴테 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0f15213-1a61-32dd-95a1-0cd1a0bc8ba4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87d54435-6953-3565-bfa8-c7c864fd89e9', 3, NULL, 'Mit einem gemalten Band', 'Mit einem gemalten Band', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '괴테 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87d54435-6953-3565-bfa8-c7c864fd89e9'
);


-- Op. 84 부수음악 <에그몬트>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <에그몬트>', 'Egmont, incidental music', 'song', 'Op. 84', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <에그몬트>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd42bc69b-e432-4cf8-aaea-a5178271ee52'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd42bc69b-e432-4cf8-aaea-a5178271ee52'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '부수음악 <에그몬트>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd42bc69b-e432-4cf8-aaea-a5178271ee52'
);


-- Op. 85 오라토리오 <감람산 위의 그리스도>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <감람산 위의 그리스도>', 'Christus am Ölberge (Christ on the Mount of Olives)', 'song', 'Op. 85', NULL, NULL, 1804, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <감람산 위의 그리스도>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc807c4c-825f-4318-9254-5f7306c3d9c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fc807c4c-825f-4318-9254-5f7306c3d9c6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '오라토리오 <감람산 위의 그리스도>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fc807c4c-825f-4318-9254-5f7306c3d9c6'
);


-- Op. 86 미사 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사 C장조', 'Mass in C major', 'album', 'Op. 86', NULL, NULL, 1807, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ed5a88e-f16b-4ee5-ab3f-55f26cf30e0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ed5a88e-f16b-4ee5-ab3f-55f26cf30e0e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ed5a88e-f16b-4ee5-ab3f-55f26cf30e0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c17a4ed7-e613-3af8-9421-10d7831c6e68', 1, 'I', '키리에. Andante con moto assai vivace quasi Allegretto ma non troppo', 'I. Kyrie. Andante con moto assai vivace quasi Allegretto ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c17a4ed7-e613-3af8-9421-10d7831c6e68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4143426e-17d5-3bf3-a314-446e16deeb51', 2, 'II', '글로리아. Allegro con brio', 'II. Gloria. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4143426e-17d5-3bf3-a314-446e16deeb51'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6424173d-3d01-36d5-9c3c-f32875383071', 3, 'III', '크레도. Allegro con brio', 'III. Credo. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6424173d-3d01-36d5-9c3c-f32875383071'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fe3eb9f-0628-3595-b83e-5a7fedb03a8e', 4, 'IV', '상투스. Adagio – Allegro – Allegretto ma non troppo – Allegro', 'IV. Sanctus. Adagio – Allegro – Allegretto ma non troppo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fe3eb9f-0628-3595-b83e-5a7fedb03a8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a716e446-4b6f-30b4-aacc-77b807d0b764', 5, 'V', '아뉴스 데이. Poco andante – Allegro ma non troppo – Andante con moto, tempo del kyrie', 'V. Agnus Dei. Poco andante – Allegro ma non troppo – Andante con moto, tempo del kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미사 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a716e446-4b6f-30b4-aacc-77b807d0b764'
);


-- Op. 87 두 대의 오보에와 잉글리시 호른을 위한 3중주 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 오보에와 잉글리시 호른을 위한 3중주 C장조', 'Trio for 2 Oboes and English Horn in C major', 'album', 'Op. 87', NULL, NULL, 1794, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 오보에와 잉글리시 호른을 위한 3중주 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20e58ad1-913f-452e-9a99-12c8afdd5ac9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20e58ad1-913f-452e-9a99-12c8afdd5ac9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 오보에와 잉글리시 호른을 위한 3중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20e58ad1-913f-452e-9a99-12c8afdd5ac9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2030f0dd-6d2e-3e7e-8e40-4dc40ee2836c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 오보에와 잉글리시 호른을 위한 3중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2030f0dd-6d2e-3e7e-8e40-4dc40ee2836c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1400f242-e21c-315c-9dd8-6b3729b55375', 2, 'II', 'Adagio cantabile', 'II. Adagio cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 오보에와 잉글리시 호른을 위한 3중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1400f242-e21c-315c-9dd8-6b3729b55375'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a375f5c9-e39c-3269-b4d0-a41bb454ee6a', 3, 'III', '미뉴에트. Allegro molto. 스케르초', 'III. Menuetto. Allegro molto. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 오보에와 잉글리시 호른을 위한 3중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a375f5c9-e39c-3269-b4d0-a41bb454ee6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd402577-150b-3ec3-b004-f61ccdb9bf09', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 오보에와 잉글리시 호른을 위한 3중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd402577-150b-3ec3-b004-f61ccdb9bf09'
);


-- Op. 88 가곡 <Das Glück der Freundschaft>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Das Glück der Freundschaft>', '"Das Glück der Freundschaft"', 'song', 'Op. 88', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Das Glück der Freundschaft>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d3b9ae1-3794-3e6a-be90-6755b571bb93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1d3b9ae1-3794-3e6a-be90-6755b571bb93'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Das Glück der Freundschaft>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1d3b9ae1-3794-3e6a-be90-6755b571bb93'
);


-- Op. 89 폴로네즈 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 C장조', 'Polonaise in C major', 'song', 'Op. 89', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07fe6d51-7f5b-3822-b435-99dcb4b1a7d6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07fe6d51-7f5b-3822-b435-99dcb4b1a7d6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '폴로네즈 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07fe6d51-7f5b-3822-b435-99dcb4b1a7d6'
);


-- Op. 90 피아노 소나타 27번 E단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 27번 E단조', 'Piano Sonata No. 27 in E minor', 'album', 'Op. 90', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 27번 E단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fabb904b-bf7f-3698-8c1b-ce2923850e09'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fabb904b-bf7f-3698-8c1b-ce2923850e09'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 27번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fabb904b-bf7f-3698-8c1b-ce2923850e09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c0310e2-3b11-316e-9699-7ef41d55e5db', 1, 'I', 'Mit Lebhaftigkeit und durchaus mit Empfindung und Ausdruck', 'I. Mit Lebhaftigkeit und durchaus mit Empfindung und Ausdruck', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 27번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c0310e2-3b11-316e-9699-7ef41d55e5db'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56e36407-22ba-3a74-9a37-75c3b1d0baea', 2, 'II', 'Nicht zu geschwind und sehr singbar vorzutragen', 'II. Nicht zu geschwind und sehr singbar vorzutragen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 27번 E단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56e36407-22ba-3a74-9a37-75c3b1d0baea'
);


-- Op. 91 전쟁 교향곡 <웰링턴의 승리>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전쟁 교향곡 <웰링턴의 승리>', 'Wellington''s Victory (Battle Symphony)', 'album', 'Op. 91', NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전쟁 교향곡 <웰링턴의 승리>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50051337-6106-3bd5-a2d9-4159e8836df9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50051337-6106-3bd5-a2d9-4159e8836df9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '전쟁 교향곡 <웰링턴의 승리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50051337-6106-3bd5-a2d9-4159e8836df9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0c301bd-b712-3e3f-9f94-e2e79d08f53f', 1, 'I', '전투', 'I. Schlacht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '전쟁 교향곡 <웰링턴의 승리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c301bd-b712-3e3f-9f94-e2e79d08f53f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb539179-6a01-3b21-ad83-5c284be95f29', 2, 'II', '승리 교향곡', 'II. Siegessinfonie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '전쟁 교향곡 <웰링턴의 승리>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb539179-6a01-3b21-ad83-5c284be95f29'
);


-- Op. 92 교향곡 7번 A장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:63a41aed-3edb-38a7-a622-1eae0213f83e', 1, 'I', 'Poco sostenuto – Vivace', 'I. Poco sostenuto – Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 438 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63a41aed-3edb-38a7-a622-1eae0213f83e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04cc89e6-9194-3b2f-b568-132020ebccb8', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 438 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04cc89e6-9194-3b2f-b568-132020ebccb8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cbad2a8-1735-3d49-a1cc-050b04daa47b', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 438 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cbad2a8-1735-3d49-a1cc-050b04daa47b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c6c11d3-bb5f-3016-82f4-62b39487651c', 4, 'IV', 'Allegro con brio', 'IV. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 438 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c6c11d3-bb5f-3016-82f4-62b39487651c'
);


-- Op. 93 교향곡 8번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 8번 F장조', 'Symphony No. 8 in F major', 'album', 'Op. 93', NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 8번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '256f32ec-94c5-44e8-b3fc-a027d92eec09'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '256f32ec-94c5-44e8-b3fc-a027d92eec09'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 8번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '256f32ec-94c5-44e8-b3fc-a027d92eec09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c510d90f-df95-3df8-9ce5-69041c6d876d', 1, 'I', 'Allegro vivace e con brio', 'I. Allegro vivace e con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 8번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c510d90f-df95-3df8-9ce5-69041c6d876d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a03494e8-f696-32dc-a4f6-b211aa70b617', 2, 'II', 'Allegretto scherzando', 'II. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 8번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a03494e8-f696-32dc-a4f6-b211aa70b617'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1efe8667-e6fd-329f-9d18-bbf786dc45ad', 3, 'III', 'Tempo di menuetto', 'III. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 8번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1efe8667-e6fd-329f-9d18-bbf786dc45ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36946885-d3bc-3a67-97c0-78a0e7dfa008', 4, 'IV', 'Allegro vivace', 'IV. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '교향곡 8번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36946885-d3bc-3a67-97c0-78a0e7dfa008'
);


-- Op. 94 가곡 <희망에 부쳐> (1815)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <희망에 부쳐> (1815)', '"An die Hoffnung" (1815)', 'song', 'Op. 94', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <희망에 부쳐> (1815)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b97c031-e41f-3797-b9f1-3ffdfea7d785'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b97c031-e41f-3797-b9f1-3ffdfea7d785'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <희망에 부쳐> (1815)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b97c031-e41f-3797-b9f1-3ffdfea7d785'
);


-- Op. 95 현악 4중주 11번 F단조 "세리오소"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 11번 F단조 "세리오소"', 'String Quartet No. 11 in F minor "Serioso"', 'album', 'Op. 95', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 11번 F단조 "세리오소"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8883f4bf-8760-4f48-a158-e0a2b72c6657'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8883f4bf-8760-4f48-a158-e0a2b72c6657'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 11번 F단조 "세리오소"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8883f4bf-8760-4f48-a158-e0a2b72c6657'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13c54ab7-99bf-3573-98ea-a6cd2d791d03', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 11번 F단조 "세리오소"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13c54ab7-99bf-3573-98ea-a6cd2d791d03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54357e34-cb74-3293-929a-29f3bec3455b', 2, 'II', 'Allegretto ma non troppo', 'II. Allegretto ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 11번 F단조 "세리오소"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54357e34-cb74-3293-929a-29f3bec3455b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77573fb3-ac1a-3d91-bdcd-aa0622b8c3e9', 3, 'III', 'Allegro assai vivace ma serioso', 'III. Allegro assai vivace ma serioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 11번 F단조 "세리오소"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77573fb3-ac1a-3d91-bdcd-aa0622b8c3e9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cd287e1-212e-31b5-b12e-02e4bbf55b89', 4, 'IV', 'Larghetto espressivo – Allegretto agitato – Allegro', 'IV. Larghetto espressivo – Allegretto agitato – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 11번 F단조 "세리오소"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cd287e1-212e-31b5-b12e-02e4bbf55b89'
);


-- Op. 96 바이올린 소나타 10번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 10번 G장조', 'Violin Sonata No. 10 in G major', 'album', 'Op. 96', NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 10번 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70c541fc-4cc7-31da-aa44-4b8766f0ff19'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '70c541fc-4cc7-31da-aa44-4b8766f0ff19'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 10번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '70c541fc-4cc7-31da-aa44-4b8766f0ff19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22e58e59-91ca-302e-8507-1ef3189c1928', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 10번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22e58e59-91ca-302e-8507-1ef3189c1928'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbaa607e-0bd8-353a-9c8d-5ba81e185575', 2, 'II', 'Adagio espressivo', 'II. Adagio espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 10번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbaa607e-0bd8-353a-9c8d-5ba81e185575'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7873998c-d0b5-32bc-91d8-349c5077265e', 3, 'III', '스케르초. Allegro', 'III. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 10번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7873998c-d0b5-32bc-91d8-349c5077265e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e2fda1d4-2a46-39ba-a239-8d4807be177d', 4, 'IV', 'Poco allegretto', 'IV. Poco allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린 소나타 10번 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e2fda1d4-2a46-39ba-a239-8d4807be177d'
);


-- Op. 97 피아노 3중주 7번 B♭장조 "대공"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4a46776-9b85-3a14-aff9-1001753bb955', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 441 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4a46776-9b85-3a14-aff9-1001753bb955'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80b8e166-6c00-3bc1-bf6b-e039aac1189e', 2, 'II', '스케르초. Allegro', 'II. Scherzo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 441 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80b8e166-6c00-3bc1-bf6b-e039aac1189e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab33fd2d-cb54-3b37-9793-6ec6c279142e', 3, 'III', 'Andante cantabile ma però con moto', 'III. Andante cantabile ma però con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 441 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab33fd2d-cb54-3b37-9793-6ec6c279142e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8c7c79c1-424d-34ca-b959-6084f340a2d0', 4, 'IV', 'Allegro moderato', 'IV. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 441 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c7c79c1-424d-34ca-b959-6084f340a2d0'
);


-- Op. 98 연가곡집 <멀리 있는 연인에게>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡집 <멀리 있는 연인에게>', 'An die ferne Geliebte, Op. 98', 'album', 'Op. 98', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡집 <멀리 있는 연인에게>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f2741ec-c3b2-3901-959c-f257710c188c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f2741ec-c3b2-3901-959c-f257710c188c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '연가곡집 <멀리 있는 연인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f2741ec-c3b2-3901-959c-f257710c188c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e05a96ec-0028-47c3-89ce-dc20706700ad', 1, NULL, 'Auf dem Hügel sitz ich spähend', 'Auf dem Hügel sitz ich spähend', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '연가곡집 <멀리 있는 연인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e05a96ec-0028-47c3-89ce-dc20706700ad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:780757d9-ffe7-4d25-ac87-8d8bb07c784a', 2, NULL, 'Wo die Berge so blau', 'Wo die Berge so blau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '연가곡집 <멀리 있는 연인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:780757d9-ffe7-4d25-ac87-8d8bb07c784a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bedc13ee-bfed-4781-873d-035d1d3676b6', 3, NULL, 'Leichte Segler in den Höhen', 'Leichte Segler in den Höhen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '연가곡집 <멀리 있는 연인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bedc13ee-bfed-4781-873d-035d1d3676b6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31fa0f18-3450-4bea-8649-068bcb1b73a0', 4, NULL, 'Diese Wolken in den Höhen', 'Diese Wolken in den Höhen', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '연가곡집 <멀리 있는 연인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31fa0f18-3450-4bea-8649-068bcb1b73a0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:996423a3-3928-4481-a7a9-16ceef1e3849', 5, NULL, 'Es kehret der Maien, es blühet die Au', 'Es kehret der Maien, es blühet die Au', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '연가곡집 <멀리 있는 연인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:996423a3-3928-4481-a7a9-16ceef1e3849'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:250cc245-9f53-4a81-8a80-dbb611a614e3', 6, NULL, 'Nimm sie hin denn, diese Lieder', 'Nimm sie hin denn, diese Lieder', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '연가곡집 <멀리 있는 연인에게>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:250cc245-9f53-4a81-8a80-dbb611a614e3'
);


-- Op. 99 가곡 <Der Mann von Wort>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Mann von Wort>', '"Der Mann von Wort"', 'song', 'Op. 99', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Mann von Wort>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e084b312-98ba-3f47-9bce-732906718a0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e084b312-98ba-3f47-9bce-732906718a0b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Der Mann von Wort>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e084b312-98ba-3f47-9bce-732906718a0b'
);


-- Op. 100 2중창 <Merkenstein>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Merkenstein>', '"Merkenstein" for one or two voices', 'song', 'Op. 100', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Merkenstein>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f30de073-9bfe-3ed6-afba-90cd0e452ab3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f30de073-9bfe-3ed6-afba-90cd0e452ab3'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '2중창 <Merkenstein>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f30de073-9bfe-3ed6-afba-90cd0e452ab3'
);


-- Op. 101 피아노 소나타 28번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 28번 A장조', 'Piano Sonata No. 28 in A major', 'album', 'Op. 101', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 28번 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '494b657c-aa57-4df6-a750-ee79ac323967'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '494b657c-aa57-4df6-a750-ee79ac323967'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 28번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '494b657c-aa57-4df6-a750-ee79ac323967'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7d0b300-9708-333f-86d6-f9e499cb3448', 1, 'I', 'Etwas lebhaft und mit der innigsten Empfindung. Allegretto ma non troppo', 'I. Etwas lebhaft und mit der innigsten Empfindung. Allegretto ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 28번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7d0b300-9708-333f-86d6-f9e499cb3448'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02af76d5-d154-3324-adb0-f0c33601dccd', 2, 'II', 'Lebhaft, marschmäßig. Vivace alla marcia', 'II. Lebhaft, marschmäßig. Vivace alla marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 28번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02af76d5-d154-3324-adb0-f0c33601dccd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:30b5222e-3f2c-3b76-aa8c-ad3792f46ed6', 3, 'III', 'Langsam und sehnsuchtsvoll. Adagio, ma non troppo, con affetto', 'III. Langsam und sehnsuchtsvoll. Adagio, ma non troppo, con affetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 28번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b5222e-3f2c-3b76-aa8c-ad3792f46ed6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33bac9ad-bd03-3a2b-86ba-364e3d0c1b2a', 4, 'IV', 'Geschwind, doch nicht zu sehr und mit Entschlossenheit. Allegro', 'IV. Geschwind, doch nicht zu sehr und mit Entschlossenheit. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 28번 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33bac9ad-bd03-3a2b-86ba-364e3d0c1b2a'
);


-- Op. 102 첼로 소나타 Op. 102

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로 소나타 Op. 102', '2 Cello Sonatas, Op. 102', 'album', NULL, 'Op.', '102', 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로 소나타 Op. 102'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39b3b802-8670-4ba0-b00c-c39f8bd0fa0f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '39b3b802-8670-4ba0-b00c-c39f8bd0fa0f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '39b3b802-8670-4ba0-b00c-c39f8bd0fa0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bc47d51-8310-4a78-98ea-4ee765cef99d', 1, NULL, '첼로 소나타 4번 C장조', 'Cello Sonata No. 4 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bc47d51-8310-4a78-98ea-4ee765cef99d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a95dc472-8055-3c02-97de-04600b0cb2ff', 1, 'I', 'Andante – Allegro vivace', 'I. Andante – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc47d51-8310-4a78-98ea-4ee765cef99d'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a95dc472-8055-3c02-97de-04600b0cb2ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a9482249-e722-3833-85be-6b0acfdb23ff', 2, 'II', 'Adagio – Tempo d''andante – Allegro vivace', 'II. Adagio – Tempo d''andante – Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6bc47d51-8310-4a78-98ea-4ee765cef99d'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9482249-e722-3833-85be-6b0acfdb23ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3a8f347a-023d-4d9b-ac84-9b02c4612ab0', 2, NULL, '첼로 소나타 5번 D장조', 'Cello Sonata No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a8f347a-023d-4d9b-ac84-9b02c4612ab0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e0805a49-5447-3aa2-8565-fddc1374f443', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a8f347a-023d-4d9b-ac84-9b02c4612ab0'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0805a49-5447-3aa2-8565-fddc1374f443'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e786a32b-22c1-3f7d-94f6-36c4bb5338ae', 2, 'II', 'Adagio con molto sentimento d''affetto', 'II. Adagio con molto sentimento d''affetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a8f347a-023d-4d9b-ac84-9b02c4612ab0'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e786a32b-22c1-3f7d-94f6-36c4bb5338ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:db2814ed-c0d7-32e8-b0bc-8803f8064700', 3, 'III', 'Allegro – Allegro fugato', 'III. Allegro – Allegro fugato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a8f347a-023d-4d9b-ac84-9b02c4612ab0'
WHERE p.composer_id = 15 AND p.title = '첼로 소나타 Op. 102' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db2814ed-c0d7-32e8-b0bc-8803f8064700'
);


-- Op. 103 관악 8중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 8중주 E♭장조', 'Wind Octet in E♭ major', 'album', 'Op. 103', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 8중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f85aec5-75a7-4cf8-b6ad-b54e4a05b816'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f85aec5-75a7-4cf8-b6ad-b54e4a05b816'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 8중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f85aec5-75a7-4cf8-b6ad-b54e4a05b816'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fadb8daa-a95b-3793-af0e-3bb16a72bc20', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 8중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fadb8daa-a95b-3793-af0e-3bb16a72bc20'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e93c5840-d976-3c54-b4ba-f6042e03b6c0', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 8중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e93c5840-d976-3c54-b4ba-f6042e03b6c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:660efe88-29bf-3e97-94bb-64e4fe0470c0', 3, 'III', '미뉴에트. Allegro', 'III. Menuetto. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 8중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:660efe88-29bf-3e97-94bb-64e4fe0470c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b8dee61-deab-37d8-bcd1-0647941de17b', 4, 'IV', '피날레. Presto', 'IV. Finale. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 8중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b8dee61-deab-37d8-bcd1-0647941de17b'
);


-- Op. 104 현악 5중주 C단조 (피아노 3중주 편곡)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주 C단조 (피아노 3중주 편곡)', 'String Quintet in C minor (after Piano Trio Op. 1 No. 3)', 'album', 'Op. 104', NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주 C단조 (피아노 3중주 편곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9c22326-f9b4-4255-a839-54d1a8278d4c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b9c22326-f9b4-4255-a839-54d1a8278d4c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C단조 (피아노 3중주 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b9c22326-f9b4-4255-a839-54d1a8278d4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc42fddc-2d7f-4fb6-9dd5-dbbb6ed6bd15', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C단조 (피아노 3중주 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc42fddc-2d7f-4fb6-9dd5-dbbb6ed6bd15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0f0a231-273e-49e4-a0f4-7ce26d65489e', 2, 'II', 'Andante cantabile, con variazioni', 'II. Andante cantabile, con variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C단조 (피아노 3중주 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0f0a231-273e-49e4-a0f4-7ce26d65489e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a573bb5f-82e7-4777-a823-69189055cb15', 3, 'III', '미뉴에트. Quasi allegro', 'III. Menuetto. Quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C단조 (피아노 3중주 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a573bb5f-82e7-4777-a823-69189055cb15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:460f85dc-753f-484f-9ba2-0d4931e8e70e', 4, 'IV', 'Prestissimo', 'IV. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주 C단조 (피아노 3중주 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:460f85dc-753f-484f-9ba2-0d4931e8e70e'
);


-- Op. 105 플루트와 피아노를 위한 민요 주제와 변주 Op. 105

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 피아노를 위한 민요 주제와 변주 Op. 105', '6 National Airs with Variations for Flute (or Violin) and Piano, Op. 105', 'album', NULL, 'Op.', '105', 1819, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 105'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e496744-4846-41ee-9244-7720c162885d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5e496744-4846-41ee-9244-7720c162885d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 105' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5e496744-4846-41ee-9244-7720c162885d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de08de30-efc0-32b4-9f4a-7e9b0370b18b', 1, NULL, '스코틀랜드 노래 "The Cottage Maid"', 'Air écossais "The Cottage Maid"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 105' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de08de30-efc0-32b4-9f4a-7e9b0370b18b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4502c092-dd6e-325d-81ef-ff13eef72aa3', 2, NULL, '스코틀랜드 노래 "Von edlem Geschlecht war Shinkin"', 'Air écossais "Von edlem Geschlecht war Shinkin"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 105' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4502c092-dd6e-325d-81ef-ff13eef72aa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9ab99f4-0ee9-3ce3-9322-e43949ae826b', 3, NULL, '오스트리아 노래 "A Schüsserl und a Reindl"', 'Air autrichien "A Schüsserl und a Reindl"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 105' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9ab99f4-0ee9-3ce3-9322-e43949ae826b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0c0e255-55d9-300e-898d-f1a97c2aeca6', 4, NULL, '스코틀랜드 노래 "The Last Rose of Summer"', 'Air écossais "The Last Rose of Summer"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 105' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0c0e255-55d9-300e-898d-f1a97c2aeca6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93231bc0-16e1-3c52-9bd9-97f13ddd9489', 5, NULL, '스코틀랜드 노래 "Chiling O''Guiry"', 'Air écossais "Chiling O''Guiry"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 105' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93231bc0-16e1-3c52-9bd9-97f13ddd9489'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:855b19e4-2cf3-3c6f-9527-b88c6e5f2874', 6, NULL, '스코틀랜드 노래 "Paddy Whack"', 'Air écossais "Paddy Whack"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 105' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:855b19e4-2cf3-3c6f-9527-b88c6e5f2874'
);


-- Op. 106 피아노 소나타 29번 B♭장조 "함머클라비어"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 29번 B♭장조 "함머클라비어"', 'Piano Sonata No. 29 in B♭ major "Hammerklavier"', 'album', 'Op. 106', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 29번 B♭장조 "함머클라비어"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a622b0d-b0c0-405e-b49e-05b70c108284'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4a622b0d-b0c0-405e-b49e-05b70c108284'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 29번 B♭장조 "함머클라비어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4a622b0d-b0c0-405e-b49e-05b70c108284'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80cbaf7b-a1da-3fc5-b650-6eb72a803980', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 29번 B♭장조 "함머클라비어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80cbaf7b-a1da-3fc5-b650-6eb72a803980'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7813c9cf-6054-3ef3-b9ed-8ae4690581c9', 2, 'II', '스케르초. Assai vivace', 'II. Scherzo. Assai vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 29번 B♭장조 "함머클라비어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7813c9cf-6054-3ef3-b9ed-8ae4690581c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d110747-f011-41d4-9ce5-a1fad9abed2f', 3, 'III', 'Adagio sostenuto. Appassionato e molto con sentimento', 'III. Adagio sostenuto. Appassionato e molto con sentimento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 29번 B♭장조 "함머클라비어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d110747-f011-41d4-9ce5-a1fad9abed2f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cfa82cd6-bcb5-39dd-9beb-c98e275c7c84', 4, 'IV', 'Largo – Allegro risoluto', 'IV. Largo – Allegro risoluto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 29번 B♭장조 "함머클라비어"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfa82cd6-bcb5-39dd-9beb-c98e275c7c84'
);


-- Op. 107 플루트와 피아노를 위한 민요 주제와 변주 Op. 107

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트와 피아노를 위한 민요 주제와 변주 Op. 107', '10 National Airs with Variations for Flute (or Violin) and Piano, Op. 107', 'album', NULL, 'Op.', '107', 1819, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '301fdac2-17c4-48b7-a77f-525def240bd2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '301fdac2-17c4-48b7-a77f-525def240bd2'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '301fdac2-17c4-48b7-a77f-525def240bd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f2c324e-716d-3ec0-8a73-c8a2d2fd546e', 1, NULL, '티롤 노래 "I bin a Tiroler Bua"', 'Air tirolien "I bin a Tiroler Bua"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f2c324e-716d-3ec0-8a73-c8a2d2fd546e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3ae26ed-c3f3-35f1-8d05-8a7f18d7e0fd', 2, NULL, '스코틀랜드 노래 "Bonny Laddie, Highland Laddie"', 'Air écossais "Bonny Laddie, Highland Laddie"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3ae26ed-c3f3-35f1-8d05-8a7f18d7e0fd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe4b722a-9ccc-3b6a-a972-cb095500a6f0', 3, NULL, '소러시아 노래', 'Air de la petite Russie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe4b722a-9ccc-3b6a-a972-cb095500a6f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:214d03a5-73f5-33d8-a38b-f465aa72efcb', 4, NULL, '스코틀랜드 노래 "St. Patrick''s Day"', 'Air écossais "St. Patrick''s Day"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:214d03a5-73f5-33d8-a38b-f465aa72efcb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0aa98c70-3c38-3e70-a9f8-f95533f8cfa5', 5, NULL, '티롤 노래 "A Madel, ja a Madel"', 'Air tirolien "A Madel, ja a Madel"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0aa98c70-3c38-3e70-a9f8-f95533f8cfa5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f477d51-8163-3178-bffe-07f0d3686b97', 6, NULL, '스코틀랜드 노래 "Peggy''s Daughter"', 'Air écossais "Peggy''s Daughter"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f477d51-8163-3178-bffe-07f0d3686b97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:673f2a40-08cf-391c-aff6-0622dcfa204a', 7, NULL, '러시아 노래 "Schöne Minka"', 'Air russe "Schöne Minka"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:673f2a40-08cf-391c-aff6-0622dcfa204a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1aa2194c-39f4-3d82-9f26-ea380d001214', 8, NULL, '스코틀랜드 노래 "O Mary at thy window be"', 'Air écossais "O Mary at thy window be"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1aa2194c-39f4-3d82-9f26-ea380d001214'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2d1b75d-8301-3e6a-a414-fe3b0a8c7650', 9, NULL, '스코틀랜드 노래 "O Thou art the Lad of my Heart"', 'Air écossais "O Thou art the Lad of my Heart"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2d1b75d-8301-3e6a-a414-fe3b0a8c7650'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cd1a655-e585-35a2-8cd0-463cd12ec5c0', 10, NULL, '스코틀랜드 노래 "The Highland Watch"', 'Air écossais "The Highland Watch"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '플루트와 피아노를 위한 민요 주제와 변주 Op. 107' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cd1a655-e585-35a2-8cd0-463cd12ec5c0'
);


-- Op. 109 피아노 소나타 30번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 30번 E장조', 'Piano Sonata No. 30 in E major', 'album', 'Op. 109', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 30번 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7405e6a1-130e-4c22-bc33-bcd43c560a55'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7405e6a1-130e-4c22-bc33-bcd43c560a55'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 30번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7405e6a1-130e-4c22-bc33-bcd43c560a55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9cb1817a-12b0-3717-aa38-7cd6b57fc4f7', 1, 'I', 'Vivace, ma non troppo', 'I. Vivace, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 30번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9cb1817a-12b0-3717-aa38-7cd6b57fc4f7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de44b358-aaa8-3b1f-8585-cea2c572af7a', 2, 'II', 'Prestissimo', 'II. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 30번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de44b358-aaa8-3b1f-8585-cea2c572af7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e34dd23-fe25-3f7f-9762-ac128c7b26eb', 3, 'III', 'Gesangvoll, mit innigster Empfindung. Andante molto cantabile ed espressivo', 'III. Gesangvoll, mit innigster Empfindung. Andante molto cantabile ed espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 30번 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e34dd23-fe25-3f7f-9762-ac128c7b26eb'
);


-- Op. 110 피아노 소나타 31번 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 31번 A♭장조', 'Piano Sonata No. 31 in A♭ major', 'album', 'Op. 110', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 31번 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c310018-3a56-400a-a6bb-ec0cbebe0545'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c310018-3a56-400a-a6bb-ec0cbebe0545'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 31번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c310018-3a56-400a-a6bb-ec0cbebe0545'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5102b059-2457-30a8-8013-d45acf9ed266', 1, 'I', 'Moderato cantabile molto espressivo', 'I. Moderato cantabile molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 31번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5102b059-2457-30a8-8013-d45acf9ed266'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e83b7804-7b03-37f9-bfed-f8ab96a49e85', 2, 'II', 'Allegro molto', 'II. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 31번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e83b7804-7b03-37f9-bfed-f8ab96a49e85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:989195d3-99b5-35f2-b296-9cc3979f14e0', 3, 'III', 'Adagio, ma non troppo – 푸가. Allegro ma non troppo', 'III. Adagio, ma non troppo – Fuga. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 31번 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:989195d3-99b5-35f2-b296-9cc3979f14e0'
);


-- Op. 111 피아노 소나타 32번 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 32번 C단조', 'Piano Sonata No. 32 in C minor', 'album', 'Op. 111', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 32번 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1767f1b8-6374-3ad8-8772-3b5ebd40a53a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1767f1b8-6374-3ad8-8772-3b5ebd40a53a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 32번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1767f1b8-6374-3ad8-8772-3b5ebd40a53a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88fb51a0-8dac-365d-8e00-055aa97f4d43', 1, 'I', 'Maestoso – Allegro con brio ed appassionato', 'I. Maestoso – Allegro con brio ed appassionato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 32번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88fb51a0-8dac-365d-8e00-055aa97f4d43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:607559e1-ac3d-36af-8abc-f9a1756330b6', 2, 'II', '아리에타. Adagio molto semplice e cantabile', 'II. Arietta. Adagio molto semplice e cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 32번 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:607559e1-ac3d-36af-8abc-f9a1756330b6'
);


-- Op. 112 칸타타 <고요한 바다와 즐거운 항해>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <고요한 바다와 즐거운 항해>', 'Meeresstille und glückliche Fahrt (Calm Sea and Prosperous Voyage)', 'song', 'Op. 112', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <고요한 바다와 즐거운 항해>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '880bdc81-727b-324c-86e9-793963bfb43e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '880bdc81-727b-324c-86e9-793963bfb43e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '칸타타 <고요한 바다와 즐거운 항해>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '880bdc81-727b-324c-86e9-793963bfb43e'
);


-- Op. 113 부수음악 <아테네의 폐허>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <아테네의 폐허>', 'The Ruins of Athens, incidental music', 'song', 'Op. 113', NULL, NULL, 1811, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <아테네의 폐허>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c494808-f84e-3ab0-9b1d-7f2911fed537'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c494808-f84e-3ab0-9b1d-7f2911fed537'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '부수음악 <아테네의 폐허>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c494808-f84e-3ab0-9b1d-7f2911fed537'
);


-- Op. 114 <헌당식>을 위한 행진곡과 합창

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헌당식>을 위한 행진곡과 합창', 'March and Chorus for "The Consecration of the House"', 'song', 'Op. 114', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<헌당식>을 위한 행진곡과 합창'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be1ae8f6-bead-4d4d-a96f-74bc4d656320'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'be1ae8f6-bead-4d4d-a96f-74bc4d656320'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<헌당식>을 위한 행진곡과 합창' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'be1ae8f6-bead-4d4d-a96f-74bc4d656320'
);


-- Op. 115 서곡 <명명축일> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <명명축일> C장조', 'Zur Namensfeier Overture in C major', 'song', 'Op. 115', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <명명축일> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff13fd8c-510e-3503-bad4-ad754ff978f3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff13fd8c-510e-3503-bad4-ad754ff978f3'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '서곡 <명명축일> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff13fd8c-510e-3503-bad4-ad754ff978f3'
);


-- Op. 116 3중창 <Tremate, empi, tremate>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3중창 <Tremate, empi, tremate>', '"Tremate, empi, tremate" for soprano, tenor and bass', 'song', 'Op. 116', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3중창 <Tremate, empi, tremate>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83729b66-e4ac-3fd0-8042-bca5a67d9715'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '83729b66-e4ac-3fd0-8042-bca5a67d9715'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '3중창 <Tremate, empi, tremate>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '83729b66-e4ac-3fd0-8042-bca5a67d9715'
);


-- Op. 117 부수음악 <슈테판 왕>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <슈테판 왕>', 'King Stephen, incidental music', 'song', 'Op. 117', NULL, NULL, 1811, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <슈테판 왕>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f632a34-ffa3-3840-91c5-cdcfda788939'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f632a34-ffa3-3840-91c5-cdcfda788939'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '부수음악 <슈테판 왕>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f632a34-ffa3-3840-91c5-cdcfda788939'
);


-- Op. 118 4성부와 현악 4중주를 위한 <비가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4성부와 현악 4중주를 위한 <비가>', 'Elegischer Gesang for 4 voices and string quartet', 'song', 'Op. 118', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4성부와 현악 4중주를 위한 <비가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b41aae76-b252-375f-98b8-b19b6bda7a52'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b41aae76-b252-375f-98b8-b19b6bda7a52'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4성부와 현악 4중주를 위한 <비가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b41aae76-b252-375f-98b8-b19b6bda7a52'
);


-- Op. 119 바가텔 Op. 119

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 Op. 119', '11 Bagatelles, Op. 119', 'album', NULL, 'Op.', '119', 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 Op. 119'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80e8d310-4268-41fd-95e2-4e1c8fbb0090'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '80e8d310-4268-41fd-95e2-4e1c8fbb0090'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '80e8d310-4268-41fd-95e2-4e1c8fbb0090'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:749bcb2a-d776-34f7-a950-ebed281477cd', 1, NULL, 'G단조', 'No. 1 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:749bcb2a-d776-34f7-a950-ebed281477cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2cd87da-3502-381c-a57c-8ce3bc70150d', 2, NULL, 'C장조', 'No. 2 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2cd87da-3502-381c-a57c-8ce3bc70150d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce7f1b63-a3c5-354f-a559-465b5393e034', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce7f1b63-a3c5-354f-a559-465b5393e034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02c7368d-d06c-3524-b494-90f9ed402d28', 4, NULL, 'A장조', 'No. 4 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02c7368d-d06c-3524-b494-90f9ed402d28'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7eedb023-e8c5-31a2-a75a-12bba21f6737', 5, NULL, 'C단조', 'No. 5 in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7eedb023-e8c5-31a2-a75a-12bba21f6737'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:971cf3e4-89a0-3f19-86f1-d4b811c707f9', 6, NULL, 'G장조', 'No. 6 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:971cf3e4-89a0-3f19-86f1-d4b811c707f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7319920-358d-33cf-a4a3-9e0d893d3477', 7, NULL, 'C장조', 'No. 7 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7319920-358d-33cf-a4a3-9e0d893d3477'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aea30c67-b939-33a4-b540-0994e68701e2', 8, NULL, 'C장조', 'No. 8 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aea30c67-b939-33a4-b540-0994e68701e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9d36c6c-cd00-3758-9c76-c73381ae9732', 9, NULL, 'A단조', 'No. 9 in A minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9d36c6c-cd00-3758-9c76-c73381ae9732'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e67487ed-336a-329d-bb73-c358cd752cec', 10, NULL, 'A장조', 'No. 10 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e67487ed-336a-329d-bb73-c358cd752cec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38683fb3-092d-3e72-82c8-77c4ffe4f13c', 11, NULL, 'B♭장조', 'No. 11 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 119' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38683fb3-092d-3e72-82c8-77c4ffe4f13c'
);


-- Op. 120 디아벨리 왈츠 주제에 의한 33개의 변주곡 C장조 "디아벨리 변주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '디아벨리 왈츠 주제에 의한 33개의 변주곡 C장조 "디아벨리 변주곡"', '33 Variations on a Waltz by Diabelli in C major "Diabelli Variations"', 'song', 'Op. 120', NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '디아벨리 왈츠 주제에 의한 33개의 변주곡 C장조 "디아벨리 변주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c9f6dbc-ea30-4a2c-b775-db345d277d96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c9f6dbc-ea30-4a2c-b775-db345d277d96'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '디아벨리 왈츠 주제에 의한 33개의 변주곡 C장조 "디아벨리 변주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c9f6dbc-ea30-4a2c-b775-db345d277d96'
);


-- Op. 121a "Ich bin der Schneider Kakadu" 주제에 의한 10개의 변주곡 G장조 "카카두 변주곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"Ich bin der Schneider Kakadu" 주제에 의한 10개의 변주곡 G장조 "카카두 변주곡"', '10 Variations on "Ich bin der Schneider Kakadu" in G major "Kakadu Variations"', 'song', 'Op. 121a', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"Ich bin der Schneider Kakadu" 주제에 의한 10개의 변주곡 G장조 "카카두 변주곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c117617f-4f80-3792-ada4-4841a3d080d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c117617f-4f80-3792-ada4-4841a3d080d5'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '"Ich bin der Schneider Kakadu" 주제에 의한 10개의 변주곡 G장조 "카카두 변주곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c117617f-4f80-3792-ada4-4841a3d080d5'
);


-- Op. 121b 소프라노, 합창과 관현악을 위한 <Opferlied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소프라노, 합창과 관현악을 위한 <Opferlied>', 'Opferlied for soprano, chorus and orchestra', 'song', 'Op. 121b', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소프라노, 합창과 관현악을 위한 <Opferlied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3509f3c-5c88-4f53-bb61-de41f4f96445'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3509f3c-5c88-4f53-bb61-de41f4f96445'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '소프라노, 합창과 관현악을 위한 <Opferlied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3509f3c-5c88-4f53-bb61-de41f4f96445'
);


-- Op. 122 <Bundeslied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Bundeslied>', 'Bundeslied for 2 voices, chorus and winds', 'song', 'Op. 122', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Bundeslied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89e48a3d-0600-3e0c-90e0-91e55ca54caa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '89e48a3d-0600-3e0c-90e0-91e55ca54caa'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<Bundeslied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89e48a3d-0600-3e0c-90e0-91e55ca54caa'
);


-- Op. 123 장엄 미사 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '장엄 미사 D장조', 'Missa solemnis in D major', 'album', 'Op. 123', NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '장엄 미사 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3e0be2d-874d-44b8-9beb-2b04ad528e1a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3e0be2d-874d-44b8-9beb-2b04ad528e1a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장엄 미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3e0be2d-874d-44b8-9beb-2b04ad528e1a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ba14d02-ba80-3679-aed6-f8e15a643c8a', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장엄 미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ba14d02-ba80-3679-aed6-f8e15a643c8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e714bbcd-2690-3497-963b-b8bf226bf6f3', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장엄 미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e714bbcd-2690-3497-963b-b8bf226bf6f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3c1c68b-2312-38dd-8742-9bd10bcb24ba', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장엄 미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3c1c68b-2312-38dd-8742-9bd10bcb24ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36dc99ff-cffa-3faa-88ac-7f544541d985', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장엄 미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36dc99ff-cffa-3faa-88ac-7f544541d985'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b9493211-11c1-336d-89c7-387802269e0b', 5, 'V', '아뉴스 데이', 'V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장엄 미사 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b9493211-11c1-336d-89c7-387802269e0b'
);


-- Op. 124 서곡 <헌당식> C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서곡 <헌당식> C장조', 'The Consecration of the House Overture in C major', 'song', 'Op. 124', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서곡 <헌당식> C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3aeba557-693c-3d56-98e2-e9804fc245fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3aeba557-693c-3d56-98e2-e9804fc245fb'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '서곡 <헌당식> C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3aeba557-693c-3d56-98e2-e9804fc245fb'
);


-- Op. 125 교향곡 9번 D단조 "합창"

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3308d248-b287-38e9-9718-0119d7a3bf9d', 1, 'I', 'Allegro ma non troppo, un poco maestoso', 'I. Allegro ma non troppo, un poco maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 76 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3308d248-b287-38e9-9718-0119d7a3bf9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87f3a5a6-fb92-381b-892b-5fc50ed0f2c1', 2, 'II', '스케르초. Molto vivace – Presto', 'II. Scherzo. Molto vivace – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 76 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87f3a5a6-fb92-381b-892b-5fc50ed0f2c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ebf3fc1-4dd4-361b-a441-bf1dc9421e34', 3, 'III', 'Adagio molto e cantabile – Andante moderato – Tempo I – Andante moderato – Adagio – Lo stesso tempo', 'III. Adagio molto e cantabile – Andante moderato – Tempo I – Andante moderato – Adagio – Lo stesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 76 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ebf3fc1-4dd4-361b-a441-bf1dc9421e34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3761b925-82b2-3a61-9581-57751dee2e9e', 4, 'IV', '피날레. Presto – Allegro assai', 'IV. Finale. Presto – Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 76 AND p.composer_id = 15
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3761b925-82b2-3a61-9581-57751dee2e9e'
);


-- Op. 126 바가텔 Op. 126

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 Op. 126', '6 Bagatelles, Op. 126', 'album', NULL, 'Op.', '126', 1824, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 Op. 126'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b749491a-48bf-4098-9793-5a3e12ebf1fb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b749491a-48bf-4098-9793-5a3e12ebf1fb'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b749491a-48bf-4098-9793-5a3e12ebf1fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cda2aaf0-8325-3be9-80fd-674fde430b32', 1, NULL, 'G장조', 'No. 1 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cda2aaf0-8325-3be9-80fd-674fde430b32'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a6af3aa-df4e-332f-bb06-eec3f927138d', 2, NULL, 'G단조', 'No. 2 in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a6af3aa-df4e-332f-bb06-eec3f927138d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:977af672-ee0b-3a71-b9df-50f44d42683d', 3, NULL, 'E♭장조', 'No. 3 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:977af672-ee0b-3a71-b9df-50f44d42683d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:485d9757-d8f9-333d-9e7c-d2d9f6371d14', 4, NULL, 'B단조', 'No. 4 in B minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:485d9757-d8f9-333d-9e7c-d2d9f6371d14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7dce0300-97d1-330d-ae4c-0605f4c402ab', 5, NULL, 'G장조', 'No. 5 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7dce0300-97d1-330d-ae4c-0605f4c402ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8b4bde1-2d64-3cff-a333-a54fd51426c8', 6, NULL, 'E♭장조', 'No. 6 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 Op. 126' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8b4bde1-2d64-3cff-a333-a54fd51426c8'
);


-- Op. 127 현악 4중주 12번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 12번 E♭장조', 'String Quartet No. 12 in E♭ major', 'album', 'Op. 127', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 12번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6472a326-4143-46f3-b302-829553e97d7b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6472a326-4143-46f3-b302-829553e97d7b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 12번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6472a326-4143-46f3-b302-829553e97d7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d422dd1-b3f2-3976-bd18-aaeb2e2c49b0', 1, 'I', 'Maestoso – Allegro', 'I. Maestoso – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 12번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d422dd1-b3f2-3976-bd18-aaeb2e2c49b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2447e847-0c59-3376-ba94-14354c1ca195', 2, 'II', 'Adagio, ma non troppo e molto cantabile – Andante con moto – Adagio molto espressivo – Tempo I', 'II. Adagio, ma non troppo e molto cantabile – Andante con moto – Adagio molto espressivo – Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 12번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2447e847-0c59-3376-ba94-14354c1ca195'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bff9938c-391b-3043-a602-58921797fcb6', 3, 'III', 'Scherzando. Vivace', 'III. Scherzando. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 12번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bff9938c-391b-3043-a602-58921797fcb6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:40f67834-34a2-36dd-b981-6466f1b2615e', 4, 'IV', 'Allegro – Allegro comodo', 'IV. Allegro – Allegro comodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 12번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:40f67834-34a2-36dd-b981-6466f1b2615e'
);


-- Op. 128 가곡 <입맞춤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <입맞춤>', '"Der Kuss"', 'song', 'Op. 128', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <입맞춤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79f8a73a-3638-3e66-999c-4d1b2bcf3c7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79f8a73a-3638-3e66-999c-4d1b2bcf3c7f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <입맞춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79f8a73a-3638-3e66-999c-4d1b2bcf3c7f'
);


-- Op. 129 론도 아 카프리치오 G장조 "잃어버린 동전에 대한 분노"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 아 카프리치오 G장조 "잃어버린 동전에 대한 분노"', 'Rondo a capriccio in G major "Rage over a Lost Penny"', 'song', 'Op. 129', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 아 카프리치오 G장조 "잃어버린 동전에 대한 분노"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '591cd920-eaf1-3f3d-aedf-036334351472'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '591cd920-eaf1-3f3d-aedf-036334351472'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '론도 아 카프리치오 G장조 "잃어버린 동전에 대한 분노"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '591cd920-eaf1-3f3d-aedf-036334351472'
);


-- Op. 130 현악 4중주 13번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 13번 B♭장조', 'String Quartet No. 13 in B♭ major', 'album', 'Op. 130', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 13번 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56fc7235-9483-4f8e-beda-e11197e507e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56fc7235-9483-4f8e-beda-e11197e507e1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 13번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56fc7235-9483-4f8e-beda-e11197e507e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:caf4678f-28ef-3ab0-8181-3b280952c4ee', 1, 'I', 'Adagio ma non troppo – Allegro', 'I. Adagio ma non troppo – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 13번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:caf4678f-28ef-3ab0-8181-3b280952c4ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6d7c470-26e0-3544-b9b6-b91b696215ac', 2, 'II', 'Presto', 'II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 13번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6d7c470-26e0-3544-b9b6-b91b696215ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b645b06b-f0eb-3b06-a965-991e240655b8', 3, 'III', 'Andante con moto, ma non troppo', 'III. Andante con moto, ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 13번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b645b06b-f0eb-3b06-a965-991e240655b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b5896c8-df95-3d60-91b5-95487b5763c5', 4, 'IV', 'Alla danza tedesca. Allegro assai', 'IV. Alla danza tedesca. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 13번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b5896c8-df95-3d60-91b5-95487b5763c5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9211f7e7-db74-3f18-a91d-a0b506f188bb', 5, 'V', '카바티나. Adagio molto espressivo', 'V. Cavatina. Adagio molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 13번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9211f7e7-db74-3f18-a91d-a0b506f188bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:680cfc4c-78af-30e9-86e0-8a9491d4ec0a', 6, 'VI', '피날레. Allegro', 'VI. Finale. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 13번 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:680cfc4c-78af-30e9-86e0-8a9491d4ec0a'
);


-- Op. 131 현악 4중주 14번 C#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 14번 C#단조', 'String Quartet No. 14 in C# minor', 'album', 'Op. 131', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 14번 C#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ce0f214-f37a-407e-907d-2a4ab7a80757'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7ce0f214-f37a-407e-907d-2a4ab7a80757'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 14번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7ce0f214-f37a-407e-907d-2a4ab7a80757'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:603902de-098c-3a89-892a-c6806ad6788d', 1, 'I', 'Adagio, ma non troppo e molto espressivo', 'I. Adagio, ma non troppo e molto espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 14번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:603902de-098c-3a89-892a-c6806ad6788d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2de37f90-64ac-3d9a-9099-1a12696167df', 2, 'II', 'Allegro molto vivace', 'II. Allegro molto vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 14번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2de37f90-64ac-3d9a-9099-1a12696167df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56705d13-15b0-3972-9e2a-eea54c03a48e', 3, 'III', 'Allegro moderato', 'III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 14번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56705d13-15b0-3972-9e2a-eea54c03a48e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c791dcb-8f64-3e78-a929-ace435a2190b', 4, 'IV', 'Andante ma non troppo e molto cantabile – Più mosso – Andante moderato e lusinghiero – Adagio – Allegretto – Adagio, ma non troppo e semplice – Allegretto', 'IV. Andante ma non troppo e molto cantabile – Più mosso – Andante moderato e lusinghiero – Adagio – Allegretto – Adagio, ma non troppo e semplice – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 14번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c791dcb-8f64-3e78-a929-ace435a2190b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13ea5fb4-5fa3-3092-9575-480983342c54', 5, 'V', 'Presto – Molto poco adagio', 'V. Presto – Molto poco adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 14번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13ea5fb4-5fa3-3092-9575-480983342c54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b77f533a-3c52-331a-918a-eea808a3f620', 6, 'VI', 'Adagio quasi un poco andante', 'VI. Adagio quasi un poco andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 14번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b77f533a-3c52-331a-918a-eea808a3f620'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0846cac6-a5b1-3f9a-b770-71158936bb90', 7, 'VII', 'Allegro', 'VII. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 14번 C#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0846cac6-a5b1-3f9a-b770-71158936bb90'
);


-- Op. 132 현악 4중주 15번 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 15번 A단조', 'String Quartet No. 15 in A minor', 'album', 'Op. 132', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 15번 A단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2638304f-0c71-40e6-9572-375c85e1cdf4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2638304f-0c71-40e6-9572-375c85e1cdf4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2638304f-0c71-40e6-9572-375c85e1cdf4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:493eb9a7-f0b5-322d-ac85-3df467bdcdd3', 1, 'I', 'Assai sostenuto – Allegro', 'I. Assai sostenuto – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:493eb9a7-f0b5-322d-ac85-3df467bdcdd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ec4b3ba-dda3-3d59-a486-87e4d63302b4', 2, 'II', 'Allegro ma non tanto', 'II. Allegro ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ec4b3ba-dda3-3d59-a486-87e4d63302b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:278e5737-e548-33c8-8299-321c2dacfb24', 3, 'III', '리디아 선법에 의한, 병에서 나은 이가 신께 바치는 거룩한 감사의 노래. Molto adagio – Andante', 'III. Heiliger Dankgesang eines Genesenen an die Gottheit, in der lydischen Tonart. Molto adagio – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:278e5737-e548-33c8-8299-321c2dacfb24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0a236b8-f7ec-3118-b54f-fdaae1346561', 4, 'IV', 'Alla Marcia, vivace assai – Più allegro', 'IV. Alla Marcia, vivace assai – Più allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0a236b8-f7ec-3118-b54f-fdaae1346561'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:240af4ba-42c4-30f9-8c87-c1869f07d167', 5, 'V', 'Allegro appassionato – Presto', 'V. Allegro appassionato – Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 15번 A단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:240af4ba-42c4-30f9-8c87-c1869f07d167'
);


-- Op. 133 대푸가 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '대푸가 B♭장조', 'Große Fuge in B♭ major', 'song', 'Op. 133', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '대푸가 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc6eba78-85ef-3834-a400-a34e0d8856d9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc6eba78-85ef-3834-a400-a34e0d8856d9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '대푸가 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc6eba78-85ef-3834-a400-a34e0d8856d9'
);


-- Op. 134 네 손을 위한 대푸가 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '네 손을 위한 대푸가 B♭장조', 'Große Fuge in B♭ major for Piano Four Hands', 'song', 'Op. 134', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '네 손을 위한 대푸가 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb90ab00-25de-308b-b843-371f1ee91e7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb90ab00-25de-308b-b843-371f1ee91e7f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '네 손을 위한 대푸가 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb90ab00-25de-308b-b843-371f1ee91e7f'
);


-- Op. 135 현악 4중주 16번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 16번 F장조', 'String Quartet No. 16 in F major', 'album', 'Op. 135', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 16번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d973e8d-37c0-4709-ad45-1fff7a014f65'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4d973e8d-37c0-4709-ad45-1fff7a014f65'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 16번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4d973e8d-37c0-4709-ad45-1fff7a014f65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acdde794-dc68-35f7-b2a8-195945d400c6', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 16번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acdde794-dc68-35f7-b2a8-195945d400c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cea4ac2f-ecff-3f96-a25a-426580aced97', 2, 'II', 'Vivace', 'II. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 16번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cea4ac2f-ecff-3f96-a25a-426580aced97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dab29fbb-64ee-3103-b212-00afb2dbd4d1', 3, 'III', 'Lento assai, e cantante tranquillo', 'III. Lento assai, e cantante tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 16번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dab29fbb-64ee-3103-b212-00afb2dbd4d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66725171-7f7d-3b81-ab5a-85f8bbae1f24', 4, 'IV', '어렵게 내린 결심. Grave, ma non troppo tratto – Allegro', 'IV. Der schwer gefasste Entschluss. Grave, ma non troppo tratto – Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 16번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66725171-7f7d-3b81-ab5a-85f8bbae1f24'
);


-- Op. 136 칸타타 <영광의 순간>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <영광의 순간>', 'Der glorreiche Augenblick', 'song', 'Op. 136', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <영광의 순간>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc018d86-d75f-4b8c-a83d-674d92ac66ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc018d86-d75f-4b8c-a83d-674d92ac66ec'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '칸타타 <영광의 순간>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc018d86-d75f-4b8c-a83d-674d92ac66ec'
);


-- Op. 137 현악 5중주를 위한 푸가 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 5중주를 위한 푸가 D장조', 'Fugue for String Quintet in D major', 'song', 'Op. 137', NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 5중주를 위한 푸가 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '12d02cf8-143c-4282-af3a-6170695cf0e8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '12d02cf8-143c-4282-af3a-6170695cf0e8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 5중주를 위한 푸가 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '12d02cf8-143c-4282-af3a-6170695cf0e8'
);


-- Op. 138 <레오노레> 서곡 1번 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<레오노레> 서곡 1번 C장조', 'Leonore Overture No. 1 in C major', 'song', 'Op. 138', NULL, NULL, 1807, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<레오노레> 서곡 1번 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '899f9dd3-5e19-37bd-8815-969f9ddeb59a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '899f9dd3-5e19-37bd-8815-969f9ddeb59a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<레오노레> 서곡 1번 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '899f9dd3-5e19-37bd-8815-969f9ddeb59a'
);


-- WoO 1 발레 <기사 발레>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <기사 발레>', 'Musik zu einem Ritterballett', 'song', 'WoO 1', NULL, NULL, 1791, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <기사 발레>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b01d683-f3ec-4d43-a6ef-e067e366ebce'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3b01d683-f3ec-4d43-a6ef-e067e366ebce'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '발레 <기사 발레>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3b01d683-f3ec-4d43-a6ef-e067e366ebce'
);


-- WoO 2a <타르페야>를 위한 개선 행진곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<타르페야>를 위한 개선 행진곡 C장조', 'Triumphal March for Tarpeja in C major', 'song', 'WoO 2a', NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<타르페야>를 위한 개선 행진곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e10f3fd9-dbfc-4cd4-afa1-6ee95e29024c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e10f3fd9-dbfc-4cd4-afa1-6ee95e29024c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<타르페야>를 위한 개선 행진곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e10f3fd9-dbfc-4cd4-afa1-6ee95e29024c'
);


-- WoO 2b <레오노레> 2막 서주 (1805)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<레오노레> 2막 서주 (1805)', 'Introduction to Act II of Leonore (1805)', 'song', 'WoO 2b', NULL, NULL, 1805, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<레오노레> 2막 서주 (1805)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae6900c1-7a92-4215-91c5-19910fd12d36'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae6900c1-7a92-4215-91c5-19910fd12d36'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<레오노레> 2막 서주 (1805)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae6900c1-7a92-4215-91c5-19910fd12d36'
);


-- WoO 3 축하 미뉴에트 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축하 미뉴에트 E♭장조', 'Gratulations-Menuett in E♭ major', 'song', 'WoO 3', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축하 미뉴에트 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72eee37f-129a-3484-b908-bb4b0443df0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '72eee37f-129a-3484-b908-bb4b0443df0b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '축하 미뉴에트 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '72eee37f-129a-3484-b908-bb4b0443df0b'
);


-- WoO 4 피아노 협주곡 0번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 0번 E♭장조', 'Piano Concerto No. 0 in E♭ major', 'album', 'WoO 4', NULL, NULL, 1784, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 0번 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67b1eda3-4c44-457e-9deb-aa1c0b95e0f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '67b1eda3-4c44-457e-9deb-aa1c0b95e0f2'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 0번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '67b1eda3-4c44-457e-9deb-aa1c0b95e0f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:78af4834-9875-41ae-96c4-a6800c22d357', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 0번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:78af4834-9875-41ae-96c4-a6800c22d357'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0c68298-7030-42f1-8726-355df1afd69e', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 0번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0c68298-7030-42f1-8726-355df1afd69e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:594d2ee5-4cb3-49ab-9245-d1b293356c6d', 3, 'III', '론도. Allegretto', 'III. Rondo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 협주곡 0번 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:594d2ee5-4cb3-49ab-9245-d1b293356c6d'
);


-- WoO 6 피아노와 관현악을 위한 론도 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관현악을 위한 론도 B♭장조', 'Rondo for Piano and Orchestra in B♭ major', 'song', 'WoO 6', NULL, NULL, 1793, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관현악을 위한 론도 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcfd79c5-2501-3e3a-91c5-cb702987f998'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fcfd79c5-2501-3e3a-91c5-cb702987f998'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노와 관현악을 위한 론도 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fcfd79c5-2501-3e3a-91c5-cb702987f998'
);


-- WoO 7 미뉴에트 WoO 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 WoO 7', '12 Minuets for Orchestra, WoO 7', 'album', NULL, 'WoO', '7', 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 WoO 7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55c8acde-ffee-4478-bf3c-53d2e802e9c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55c8acde-ffee-4478-bf3c-53d2e802e9c8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55c8acde-ffee-4478-bf3c-53d2e802e9c8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a6b12be-28e0-3082-ab5b-167261b4407b', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a6b12be-28e0-3082-ab5b-167261b4407b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36d4b3f3-201d-32af-a430-e6e9858df4b1', 2, NULL, 'B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36d4b3f3-201d-32af-a430-e6e9858df4b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2750d82-e2ee-3ece-ae56-38b2e4fa719b', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2750d82-e2ee-3ece-ae56-38b2e4fa719b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:138ea2de-ab4c-33c3-bca9-e73004c3a3d0', 4, NULL, 'E♭장조', 'No. 4 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:138ea2de-ab4c-33c3-bca9-e73004c3a3d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:de766e40-0a3b-3c4f-9462-324d590f5496', 5, NULL, 'C장조', 'No. 5 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:de766e40-0a3b-3c4f-9462-324d590f5496'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59e2dad6-bc6a-33c8-ba2f-849ba536b102', 6, NULL, 'A장조', 'No. 6 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59e2dad6-bc6a-33c8-ba2f-849ba536b102'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53491faf-f4c7-3132-bbd2-80393fbbbc34', 7, NULL, 'D장조', 'No. 7 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53491faf-f4c7-3132-bbd2-80393fbbbc34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:264dc60c-e011-37ed-a0e0-9db778fc5c99', 8, NULL, 'B♭장조', 'No. 8 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:264dc60c-e011-37ed-a0e0-9db778fc5c99'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b160835d-ef0d-3857-8369-edd8ccf2150f', 9, NULL, 'G장조', 'No. 9 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b160835d-ef0d-3857-8369-edd8ccf2150f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6c3a92a-53a7-3c93-b085-c8ea1d2085fe', 10, NULL, 'E♭장조', 'No. 10 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6c3a92a-53a7-3c93-b085-c8ea1d2085fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ce937a3-ad66-3515-ab10-d58b4181dd72', 11, NULL, 'C장조', 'No. 11 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ce937a3-ad66-3515-ab10-d58b4181dd72'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8585d220-3819-35c3-86d0-4baa89de8b78', 12, NULL, 'F장조', 'No. 12 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8585d220-3819-35c3-86d0-4baa89de8b78'
);


-- WoO 8 독일 무곡 WoO 8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '독일 무곡 WoO 8', '12 German Dances for Orchestra, WoO 8', 'album', NULL, 'WoO', '8', 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '독일 무곡 WoO 8'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84ef734b-927c-45db-839c-5edf33b1a0f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84ef734b-927c-45db-839c-5edf33b1a0f1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84ef734b-927c-45db-839c-5edf33b1a0f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ecc322d1-e4ef-3092-85db-76a139c95876', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ecc322d1-e4ef-3092-85db-76a139c95876'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f65deb85-3745-3679-8214-911374670293', 2, NULL, 'A장조', 'No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f65deb85-3745-3679-8214-911374670293'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9a05db0-19f9-3725-99ff-363d775b6fc4', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9a05db0-19f9-3725-99ff-363d775b6fc4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:076d7605-b33b-34d3-84d8-28cceb18adc6', 4, NULL, 'B♭장조', 'No. 4 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:076d7605-b33b-34d3-84d8-28cceb18adc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d3c5d97-6dd5-382a-a244-edfed32d2a0e', 5, NULL, 'E♭장조', 'No. 5 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d3c5d97-6dd5-382a-a244-edfed32d2a0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6ba0945-bc5f-3d34-b1d1-97c8442628ba', 6, NULL, 'G장조', 'No. 6 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6ba0945-bc5f-3d34-b1d1-97c8442628ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee115114-56d0-3ce7-8066-0f4e8fd65373', 7, NULL, 'C장조', 'No. 7 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee115114-56d0-3ce7-8066-0f4e8fd65373'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b683bf4-a5d4-3ba8-96ae-8fc0aa85dacf', 8, NULL, 'A장조', 'No. 8 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b683bf4-a5d4-3ba8-96ae-8fc0aa85dacf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c426cb2-718d-3f27-9c7c-6f5df8be77c0', 9, NULL, 'F장조', 'No. 9 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c426cb2-718d-3f27-9c7c-6f5df8be77c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb5140ca-1c9b-3b15-97cc-8a2ca9823c69', 10, NULL, 'D장조', 'No. 10 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb5140ca-1c9b-3b15-97cc-8a2ca9823c69'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:708193a5-c2ba-3b95-b4bd-712cdce2446b', 11, NULL, 'G장조', 'No. 11 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:708193a5-c2ba-3b95-b4bd-712cdce2446b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a58d0547-beb2-3f12-8e03-f842ad49cb62', 12, NULL, 'C장조', 'No. 12 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a58d0547-beb2-3f12-8e03-f842ad49cb62'
);


-- WoO 10 미뉴에트 WoO 10

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 WoO 10', '6 Minuets for Piano, WoO 10', 'album', NULL, 'WoO', '10', 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 WoO 10'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '373722d2-bab8-35e2-87c6-58fcb2063941'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '373722d2-bab8-35e2-87c6-58fcb2063941'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '373722d2-bab8-35e2-87c6-58fcb2063941'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99caabd2-9bf5-405b-a6b4-7ed405f0b38b', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99caabd2-9bf5-405b-a6b4-7ed405f0b38b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7182c63-a89d-37b8-8c38-2b737d86e9bc', 2, NULL, 'G장조', 'No. 2 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7182c63-a89d-37b8-8c38-2b737d86e9bc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:495f2c49-f6f2-4149-b2ea-fb0efc6f281a', 3, NULL, 'E♭장조', 'No. 3 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:495f2c49-f6f2-4149-b2ea-fb0efc6f281a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:55841f17-578d-4b98-90b4-4b0e6503b2e1', 4, NULL, 'B♭장조', 'No. 4 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55841f17-578d-4b98-90b4-4b0e6503b2e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:497a81ce-4f03-4642-b6dc-09f372d64ffd', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:497a81ce-4f03-4642-b6dc-09f372d64ffd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a9725675-7c1e-4377-b7e4-713bcdda1e07', 6, NULL, 'C장조', 'No. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 WoO 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a9725675-7c1e-4377-b7e4-713bcdda1e07'
);


-- WoO 11 렌틀러 WoO 11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '렌틀러 WoO 11', '7 Ländler for Piano, WoO 11', 'album', NULL, 'WoO', '11', 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '렌틀러 WoO 11'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '321b7c16-48ff-35b6-9a17-f057e448d9d0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '321b7c16-48ff-35b6-9a17-f057e448d9d0'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '321b7c16-48ff-35b6-9a17-f057e448d9d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5752e15-26ca-4c3f-9c0f-12f1f9951ea0', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5752e15-26ca-4c3f-9c0f-12f1f9951ea0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8ba003a-1b31-40f8-bf75-4a9ca396c0b5', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8ba003a-1b31-40f8-bf75-4a9ca396c0b5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:365263f9-8008-4ec9-814c-e57c24061808', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:365263f9-8008-4ec9-814c-e57c24061808'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0862e948-5119-4b6e-b5ca-132ef32e5e55', 4, NULL, 'D장조', 'No. 4 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0862e948-5119-4b6e-b5ca-132ef32e5e55'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84533e51-18bf-467b-bacf-e863b862be1b', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84533e51-18bf-467b-bacf-e863b862be1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce2d7e05-4249-4160-9611-4df320ca2f35', 6, NULL, 'D장조', 'No. 6 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce2d7e05-4249-4160-9611-4df320ca2f35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd0028e6-e796-476e-89e4-6364d3df9518', 7, NULL, 'D장조', 'No. 7 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd0028e6-e796-476e-89e4-6364d3df9518'
);


-- WoO 13 독일 무곡 WoO 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '독일 무곡 WoO 13', '12 German Dances for Piano, WoO 13', 'album', NULL, 'WoO', '13', 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '독일 무곡 WoO 13'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdd62649-a030-3bd3-8ac5-083d0d05d6ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fdd62649-a030-3bd3-8ac5-083d0d05d6ed'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdd62649-a030-3bd3-8ac5-083d0d05d6ed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bd00971-b728-415e-8220-c575bd04324b', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bd00971-b728-415e-8220-c575bd04324b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c9f9e083-0499-40c6-91b3-5973c543315b', 2, NULL, 'B♭장조', 'No. 2 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9f9e083-0499-40c6-91b3-5973c543315b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0126ef96-9443-46be-b0f9-69be4bb79502', 3, NULL, 'G장조', 'No. 3 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0126ef96-9443-46be-b0f9-69be4bb79502'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f398940-8a5a-4306-a9af-e1a401369b8c', 4, NULL, 'D장조', 'No. 4 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f398940-8a5a-4306-a9af-e1a401369b8c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3cf94d7e-ccb5-4ba9-837b-43e5fcdafdbf', 5, NULL, 'F장조', 'No. 5 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3cf94d7e-ccb5-4ba9-837b-43e5fcdafdbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a1fecdb-d109-4ba1-bda3-9e997019003d', 6, NULL, 'B♭장조', 'No. 6 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a1fecdb-d109-4ba1-bda3-9e997019003d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b1706c2-f1f8-4b32-b866-f817509aa972', 7, NULL, 'D장조', 'No. 7 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b1706c2-f1f8-4b32-b866-f817509aa972'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9fb5856-d14b-4c1c-9710-d22362ccba03', 8, NULL, 'G장조', 'No. 8 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9fb5856-d14b-4c1c-9710-d22362ccba03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb1aa5ee-7e8d-496a-bb84-d3c46aa39ea5', 9, NULL, 'E♭장조', 'No. 9 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb1aa5ee-7e8d-496a-bb84-d3c46aa39ea5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75eb4fb3-48d1-4db3-a41c-6e10f4ac7749', 10, NULL, 'C장조', 'No. 10 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75eb4fb3-48d1-4db3-a41c-6e10f4ac7749'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a1070b8-3f7e-4a37-b5e2-1bb6410dec3a', 11, NULL, 'A장조', 'No. 11 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a1070b8-3f7e-4a37-b5e2-1bb6410dec3a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:212533d2-4d34-4583-b858-8070444c23a5', 12, NULL, 'D장조', 'No. 12 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '독일 무곡 WoO 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:212533d2-4d34-4583-b858-8070444c23a5'
);


-- WoO 14 콩트르당스 WoO 14

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콩트르당스 WoO 14', '12 Contredanses for Orchestra, WoO 14', 'album', NULL, 'WoO', '14', 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콩트르당스 WoO 14'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4002548-fe15-49c8-8f5b-d00290e0a6be'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f4002548-fe15-49c8-8f5b-d00290e0a6be'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4002548-fe15-49c8-8f5b-d00290e0a6be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b23421a-050f-354e-a807-86ddc6d0887b', 1, NULL, 'C장조', 'No. 1 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b23421a-050f-354e-a807-86ddc6d0887b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42a2255a-d22d-3785-8b1e-4f9700543fd5', 2, NULL, 'A장조', 'No. 2 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42a2255a-d22d-3785-8b1e-4f9700543fd5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea467112-7d5e-3214-8106-d950dfb1daf8', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea467112-7d5e-3214-8106-d950dfb1daf8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47c968a4-c250-367e-8c9c-f1fd896cca76', 4, NULL, 'B♭장조', 'No. 4 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47c968a4-c250-367e-8c9c-f1fd896cca76'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a82e1093-e5db-32be-ace0-c6242eb0c4f9', 5, NULL, 'E♭장조', 'No. 5 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a82e1093-e5db-32be-ace0-c6242eb0c4f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aca76fcc-8872-3c17-bc9c-75fabdc19bc2', 6, NULL, 'C장조', 'No. 6 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aca76fcc-8872-3c17-bc9c-75fabdc19bc2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:443f3aac-1c63-3f2a-b054-47750bbcc298', 7, NULL, 'E♭장조', 'No. 7 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:443f3aac-1c63-3f2a-b054-47750bbcc298'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a094a0c8-d0f3-3c60-87c5-2a842180974d', 8, NULL, 'C장조', 'No. 8 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a094a0c8-d0f3-3c60-87c5-2a842180974d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:663fb18f-4041-3c61-bc59-4a7528a25a14', 9, NULL, 'A장조', 'No. 9 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:663fb18f-4041-3c61-bc59-4a7528a25a14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1548af26-d140-3746-8e9c-de45f9f0fc09', 10, NULL, 'C장조', 'No. 10 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1548af26-d140-3746-8e9c-de45f9f0fc09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7cc22afa-02bc-3252-b691-05c07053e9d6', 11, NULL, 'G장조', 'No. 11 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cc22afa-02bc-3252-b691-05c07053e9d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57431aa3-8ec4-3be7-a9ab-fea3b742ed4d', 12, NULL, 'E♭장조', 'No. 12 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '콩트르당스 WoO 14' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57431aa3-8ec4-3be7-a9ab-fea3b742ed4d'
);


-- WoO 15 렌틀러 WoO 15

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '렌틀러 WoO 15', '6 Ländler for 2 Violins and Double Bass, WoO 15', 'album', NULL, 'WoO', '15', 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '렌틀러 WoO 15'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82032af0-250a-4a99-95ea-e798c762aee0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82032af0-250a-4a99-95ea-e798c762aee0'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82032af0-250a-4a99-95ea-e798c762aee0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46d1206d-8bf6-3544-8a2e-f82b887e665c', 1, NULL, 'D장조', 'No. 1 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46d1206d-8bf6-3544-8a2e-f82b887e665c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59cf2a36-14e9-36c5-8efd-e72b3a27d654', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59cf2a36-14e9-36c5-8efd-e72b3a27d654'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:944ef994-db46-3c25-a8c3-0be803bbd305', 3, NULL, 'D장조', 'No. 3 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:944ef994-db46-3c25-a8c3-0be803bbd305'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ad34cedc-854d-329b-b396-43e6c22a9bb1', 4, NULL, 'D단조', 'No. 4 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ad34cedc-854d-329b-b396-43e6c22a9bb1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:891b567a-7d91-3eb4-a759-1e7e4e21584e', 5, NULL, 'D단조', 'No. 5 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:891b567a-7d91-3eb4-a759-1e7e4e21584e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8bcbd68-a850-302f-9acf-67485b0f1dee', 6, NULL, 'D단조', 'No. 6 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 WoO 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8bcbd68-a850-302f-9acf-67485b0f1dee'
);


-- WoO 18 군악 행진곡 F장조 "요르크 행진곡"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 행진곡 F장조 "요르크 행진곡"', 'March for Military Band in F major "Yorckscher Marsch"', 'song', 'WoO 18', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 행진곡 F장조 "요르크 행진곡"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '671d47b4-0d89-3cf8-bce7-341d3dc44591'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '671d47b4-0d89-3cf8-bce7-341d3dc44591'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '군악 행진곡 F장조 "요르크 행진곡"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '671d47b4-0d89-3cf8-bce7-341d3dc44591'
);


-- WoO 19 군악 행진곡 F장조 "Pferdemusik"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 행진곡 F장조 "Pferdemusik"', 'March for Military Band in F major', 'song', 'WoO 19', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 행진곡 F장조 "Pferdemusik"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8038e94-dd41-36b7-a91b-aa17ec2dec00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b8038e94-dd41-36b7-a91b-aa17ec2dec00'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '군악 행진곡 F장조 "Pferdemusik"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b8038e94-dd41-36b7-a91b-aa17ec2dec00'
);


-- WoO 20 군악 행진곡 C장조 "Zapfenstreich"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 행진곡 C장조 "Zapfenstreich"', 'March for Military Band in C major "Zapfenstreich"', 'song', 'WoO 20', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 행진곡 C장조 "Zapfenstreich"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0cda9db7-b5f3-3c61-94c2-effece5a424b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0cda9db7-b5f3-3c61-94c2-effece5a424b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '군악 행진곡 C장조 "Zapfenstreich"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0cda9db7-b5f3-3c61-94c2-effece5a424b'
);


-- WoO 21 군악 폴로네즈 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 폴로네즈 D장조', 'Polonaise for Military Band in D major', 'song', 'WoO 21', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 폴로네즈 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5734c96-e23d-303a-a301-c359ef5c346a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5734c96-e23d-303a-a301-c359ef5c346a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '군악 폴로네즈 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5734c96-e23d-303a-a301-c359ef5c346a'
);


-- WoO 22 군악 에코세즈 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 에코세즈 D장조', 'Écossaise for Military Band in D major', 'song', 'WoO 22', NULL, NULL, 1810, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 에코세즈 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a873365-87e5-3b77-8209-49e1357e9834'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7a873365-87e5-3b77-8209-49e1357e9834'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '군악 에코세즈 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7a873365-87e5-3b77-8209-49e1357e9834'
);


-- WoO 24 군악 행진곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 행진곡 D장조', 'March for Military Band in D major', 'song', 'WoO 24', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 행진곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57cacd65-ae1f-32ed-bb9c-2686c5446783'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '57cacd65-ae1f-32ed-bb9c-2686c5446783'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '군악 행진곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57cacd65-ae1f-32ed-bb9c-2686c5446783'
);


-- WoO 25 관악 8중주를 위한 론디노 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 8중주를 위한 론디노 E♭장조', 'Rondino for Wind Octet in E♭ major', 'song', 'WoO 25', NULL, NULL, 1793, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 8중주를 위한 론디노 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f148bcf-7e0f-3061-9baa-cf4af85ee48d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1f148bcf-7e0f-3061-9baa-cf4af85ee48d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 8중주를 위한 론디노 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1f148bcf-7e0f-3061-9baa-cf4af85ee48d'
);


-- WoO 26 두 대의 플루트를 위한 2중주 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 플루트를 위한 2중주 G장조', 'Duo for 2 Flutes in G major', 'album', 'WoO 26', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 플루트를 위한 2중주 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93a30cd0-b405-4196-a672-1416b9824ec1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93a30cd0-b405-4196-a672-1416b9824ec1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 플루트를 위한 2중주 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93a30cd0-b405-4196-a672-1416b9824ec1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cb9356f6-e711-3018-87f9-b1916ffc88bf', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 플루트를 위한 2중주 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cb9356f6-e711-3018-87f9-b1916ffc88bf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d8dcdf5-04dc-3561-a142-3406b17697ec', 2, 'II', '미뉴에트 quasi Allegretto', 'II. Minuetto quasi Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 플루트를 위한 2중주 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d8dcdf5-04dc-3561-a142-3406b17697ec'
);


-- WoO 28 <돈 조반니>의 "Là ci darem la mano" 주제에 의한 변주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<돈 조반니>의 "Là ci darem la mano" 주제에 의한 변주곡 C장조', 'Variations in C major on "Là ci darem la mano" from Mozart''s Don Giovanni', 'song', 'WoO 28', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<돈 조반니>의 "Là ci darem la mano" 주제에 의한 변주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '021019a0-ecfe-3bbf-92ac-0c945d7684c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '021019a0-ecfe-3bbf-92ac-0c945d7684c4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<돈 조반니>의 "Là ci darem la mano" 주제에 의한 변주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '021019a0-ecfe-3bbf-92ac-0c945d7684c4'
);


-- WoO 29 관악 6중주를 위한 행진곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 6중주를 위한 행진곡 B♭장조', 'March for Wind Sextet in B♭ major', 'song', 'WoO 29', NULL, NULL, 1798, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 6중주를 위한 행진곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f812fff-3ac6-396d-91fc-1d799f4fad11'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6f812fff-3ac6-396d-91fc-1d799f4fad11'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '관악 6중주를 위한 행진곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6f812fff-3ac6-396d-91fc-1d799f4fad11'
);


-- WoO 30 4대의 트롬본을 위한 에콸레

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4대의 트롬본을 위한 에콸레', '3 Equali for 4 Trombones, WoO 30', 'album', 'WoO 30', NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4대의 트롬본을 위한 에콸레'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f74c452d-b67f-401d-823a-3caebdbb9d7a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f74c452d-b67f-401d-823a-3caebdbb9d7a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4대의 트롬본을 위한 에콸레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f74c452d-b67f-401d-823a-3caebdbb9d7a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b79e3939-d254-3d3a-9a91-b7ef503b3fd3', 1, NULL, 'D단조', 'No. 1 in D minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4대의 트롬본을 위한 에콸레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b79e3939-d254-3d3a-9a91-b7ef503b3fd3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73241e48-1106-3f68-ac1e-0a421f985cac', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4대의 트롬본을 위한 에콸레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73241e48-1106-3f68-ac1e-0a421f985cac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8b089c8-9734-3de8-88c2-f45c961b6e0c', 3, NULL, 'B♭장조', 'No. 3 in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '4대의 트롬본을 위한 에콸레' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8b089c8-9734-3de8-88c2-f45c961b6e0c'
);


-- WoO 31 오르간 푸가 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오르간 푸가 D장조', 'Fugue for Organ in D major', 'song', 'WoO 31', NULL, NULL, 1783, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오르간 푸가 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '921375b2-2478-33da-9bac-be68d24c5e39'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '921375b2-2478-33da-9bac-be68d24c5e39'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '오르간 푸가 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '921375b2-2478-33da-9bac-be68d24c5e39'
);


-- WoO 32 비올라와 첼로를 위한 2중주 E♭장조 "안경"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라와 첼로를 위한 2중주 E♭장조 "안경"', 'Duo for Viola and Cello in E♭ major "with two obbligato eyeglasses"', 'album', 'WoO 32', NULL, NULL, 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라와 첼로를 위한 2중주 E♭장조 "안경"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46cb1944-ae65-4163-97ac-db04cd428c22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46cb1944-ae65-4163-97ac-db04cd428c22'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 첼로를 위한 2중주 E♭장조 "안경"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46cb1944-ae65-4163-97ac-db04cd428c22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:edce67c0-4fef-3cb5-a83f-55a4828bf93e', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 첼로를 위한 2중주 E♭장조 "안경"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:edce67c0-4fef-3cb5-a83f-55a4828bf93e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:83c9ddbe-37b8-3f77-85cc-5e6ebe4f5744', 2, 'II', '미뉴에트. Allegretto', 'II. Minuetto. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '비올라와 첼로를 위한 2중주 E♭장조 "안경"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:83c9ddbe-37b8-3f77-85cc-5e6ebe4f5744'
);


-- WoO 34 두 대의 바이올린을 위한 2중주 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바이올린을 위한 2중주 A장조', 'Duet for 2 Violins in A major', 'song', 'WoO 34', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바이올린을 위한 2중주 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe4f33f1-6d01-3f2b-ba3e-ea7182aec9fc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fe4f33f1-6d01-3f2b-ba3e-ea7182aec9fc'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 바이올린을 위한 2중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fe4f33f1-6d01-3f2b-ba3e-ea7182aec9fc'
);


-- WoO 35 두 대의 바이올린을 위한 카논 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바이올린을 위한 카논 A장조', 'Canon for 2 Violins in A major', 'song', 'WoO 35', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바이올린을 위한 카논 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '564192db-e8a5-3e63-88fc-312bd216e519'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '564192db-e8a5-3e63-88fc-312bd216e519'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '두 대의 바이올린을 위한 카논 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '564192db-e8a5-3e63-88fc-312bd216e519'
);


-- WoO 36 피아노 4중주 WoO 36

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 4중주 WoO 36', '3 Piano Quartets, WoO 36', 'album', NULL, 'WoO', '36', 1785, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 4중주 WoO 36'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b760f24-1b25-43ba-912c-1a6733513ba9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b760f24-1b25-43ba-912c-1a6733513ba9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b760f24-1b25-43ba-912c-1a6733513ba9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:268743c3-d64a-42f2-8d08-44d57ee4f579', 1, NULL, '피아노 4중주 1번 E♭장조', 'Piano Quartet No. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:268743c3-d64a-42f2-8d08-44d57ee4f579'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5081c0a5-6d56-35e1-b1bb-5725c7111550', 1, 'I', 'Adagio assai', 'I. Adagio assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:268743c3-d64a-42f2-8d08-44d57ee4f579'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5081c0a5-6d56-35e1-b1bb-5725c7111550'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:63034e90-c882-39ab-a62d-de2c12a381a5', 2, 'II', 'Allegro con spirito', 'II. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:268743c3-d64a-42f2-8d08-44d57ee4f579'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:63034e90-c882-39ab-a62d-de2c12a381a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:026c956c-d0a0-3879-be2b-038cfaebee53', 3, 'III', '주제와 변주. Cantabile – Allegretto', 'III. Tema con variazioni. Cantabile – Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:268743c3-d64a-42f2-8d08-44d57ee4f579'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:026c956c-d0a0-3879-be2b-038cfaebee53'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f845ef8-de4a-451d-b73d-130057ab5db8', 2, NULL, '피아노 4중주 2번 D장조', 'Piano Quartet No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f845ef8-de4a-451d-b73d-130057ab5db8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:82130bc3-fa31-3e8e-9f38-6dfbf76b7eaf', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f845ef8-de4a-451d-b73d-130057ab5db8'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82130bc3-fa31-3e8e-9f38-6dfbf76b7eaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aacc57d4-fccf-3913-b317-a60cd03574d2', 2, 'II', 'Andante con moto', 'II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f845ef8-de4a-451d-b73d-130057ab5db8'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aacc57d4-fccf-3913-b317-a60cd03574d2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:14d6c1dc-e756-3cb0-801b-1f33d9eca15c', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4f845ef8-de4a-451d-b73d-130057ab5db8'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14d6c1dc-e756-3cb0-801b-1f33d9eca15c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f952ead-6a53-4e19-b9e9-75371aab5c64', 3, NULL, '피아노 4중주 3번 C장조', 'Piano Quartet No. 3 in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f952ead-6a53-4e19-b9e9-75371aab5c64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7c8f9fd-7cf8-31e3-94cc-178e380f6156', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7f952ead-6a53-4e19-b9e9-75371aab5c64'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7c8f9fd-7cf8-31e3-94cc-178e380f6156'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e3e4af4-ef97-320d-8c15-eeb5d7898a66', 2, 'II', 'Adagio con espressione', 'II. Adagio con espressione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7f952ead-6a53-4e19-b9e9-75371aab5c64'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e3e4af4-ef97-320d-8c15-eeb5d7898a66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:26594aba-30dc-34d2-bbce-2326f42b0c45', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7f952ead-6a53-4e19-b9e9-75371aab5c64'
WHERE p.composer_id = 15 AND p.title = '피아노 4중주 WoO 36' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26594aba-30dc-34d2-bbce-2326f42b0c45'
);


-- WoO 37 피아노, 플루트, 바순을 위한 3중주 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노, 플루트, 바순을 위한 3중주 G장조', 'Trio for Piano, Flute and Bassoon in G major', 'album', 'WoO 37', NULL, NULL, 1786, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노, 플루트, 바순을 위한 3중주 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'abdb7fda-9d6f-4f2c-a91b-53ff181ebb89'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'abdb7fda-9d6f-4f2c-a91b-53ff181ebb89'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노, 플루트, 바순을 위한 3중주 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'abdb7fda-9d6f-4f2c-a91b-53ff181ebb89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f5af799-7a7f-3a50-b9c1-2cb89952ba1f', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노, 플루트, 바순을 위한 3중주 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f5af799-7a7f-3a50-b9c1-2cb89952ba1f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be4cbe14-0df7-30b7-aa08-b1dfa95841de', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노, 플루트, 바순을 위한 3중주 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be4cbe14-0df7-30b7-aa08-b1dfa95841de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:152fed3d-fab2-3dc4-b771-8741bc03bcf2', 3, 'III', '주제와 변주. Andante', 'III. Tema con variazioni. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노, 플루트, 바순을 위한 3중주 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:152fed3d-fab2-3dc4-b771-8741bc03bcf2'
);


-- WoO 38 피아노 3중주 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주 E♭장조', 'Piano Trio in E♭ major', 'album', 'WoO 38', NULL, NULL, 1791, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16992485-9f60-4646-8cfc-b9505255b73d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '16992485-9f60-4646-8cfc-b9505255b73d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '16992485-9f60-4646-8cfc-b9505255b73d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32c34e10-e282-330a-a9da-1b1aa37266a3', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c34e10-e282-330a-a9da-1b1aa37266a3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3beca88f-b642-3ff1-be02-0319462a1215', 2, 'II', '스케르초. Allegro ma non troppo', 'II. Scherzo. Allegro ma non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3beca88f-b642-3ff1-be02-0319462a1215'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5a8bb5b-1777-3ef8-a2d9-4e4a98beeff7', 3, 'III', '론도. Allegretto', 'III. Rondo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5a8bb5b-1777-3ef8-a2d9-4e4a98beeff7'
);


-- WoO 39 피아노 3중주를 위한 알레그레토 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 3중주를 위한 알레그레토 B♭장조', 'Allegretto for Piano Trio in B♭ major', 'song', 'WoO 39', NULL, NULL, 1812, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 3중주를 위한 알레그레토 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b122f2c-11d2-3c25-8e40-60217aea5539'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b122f2c-11d2-3c25-8e40-60217aea5539'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 3중주를 위한 알레그레토 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b122f2c-11d2-3c25-8e40-60217aea5539'
);


-- WoO 40 <피가로의 결혼>의 "Se vuol ballare" 주제에 의한 12개의 변주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<피가로의 결혼>의 "Se vuol ballare" 주제에 의한 12개의 변주곡 F장조', '12 Variations in F major on "Se vuol ballare" from Mozart''s The Marriage of Figaro', 'song', 'WoO 40', NULL, NULL, 1793, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<피가로의 결혼>의 "Se vuol ballare" 주제에 의한 12개의 변주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c92f35ad-93ff-322e-a3e8-a95a917f266c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c92f35ad-93ff-322e-a3e8-a95a917f266c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<피가로의 결혼>의 "Se vuol ballare" 주제에 의한 12개의 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c92f35ad-93ff-322e-a3e8-a95a917f266c'
);


-- WoO 41 바이올린과 피아노를 위한 론도 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 론도 G장조', 'Rondo for Violin and Piano in G major', 'song', 'WoO 41', NULL, NULL, 1794, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 론도 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '696a0e1e-e40d-300a-b76d-38d5e2c51348'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '696a0e1e-e40d-300a-b76d-38d5e2c51348'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린과 피아노를 위한 론도 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '696a0e1e-e40d-300a-b76d-38d5e2c51348'
);


-- WoO 42 바이올린과 피아노를 위한 독일 무곡 WoO 42

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 독일 무곡 WoO 42', '6 German Dances for Violin and Piano, WoO 42', 'album', NULL, 'WoO', '42', 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 독일 무곡 WoO 42'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84914a7d-54e2-3fd0-a28a-9694918d4dcc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '84914a7d-54e2-3fd0-a28a-9694918d4dcc'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린과 피아노를 위한 독일 무곡 WoO 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '84914a7d-54e2-3fd0-a28a-9694918d4dcc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ac4b094c-6bc9-4549-acdf-44345a98fb5c', 1, NULL, 'F장조', 'No. 1 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린과 피아노를 위한 독일 무곡 WoO 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac4b094c-6bc9-4549-acdf-44345a98fb5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5b94ed7-552f-4372-9073-12ccef2c3906', 2, NULL, 'D장조', 'No. 2 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린과 피아노를 위한 독일 무곡 WoO 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5b94ed7-552f-4372-9073-12ccef2c3906'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f35f7bd-6a16-4662-88e9-21593aa1b04e', 3, NULL, 'F장조', 'No. 3 in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린과 피아노를 위한 독일 무곡 WoO 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f35f7bd-6a16-4662-88e9-21593aa1b04e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5dfb8885-4c60-4d3e-ab09-8ccb3c2ddaf1', 4, NULL, 'A장조', 'No. 4 in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린과 피아노를 위한 독일 무곡 WoO 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5dfb8885-4c60-4d3e-ab09-8ccb3c2ddaf1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be330aa5-b928-4f13-a6fa-28b75f174ed7', 5, NULL, 'D장조', 'No. 5 in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린과 피아노를 위한 독일 무곡 WoO 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be330aa5-b928-4f13-a6fa-28b75f174ed7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:828b5060-2db5-4fbf-b34b-5a7a6f5b5f7b', 6, NULL, 'G장조', 'No. 6 in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바이올린과 피아노를 위한 독일 무곡 WoO 42' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:828b5060-2db5-4fbf-b34b-5a7a6f5b5f7b'
);


-- WoO 43a 만돌린과 피아노를 위한 소나티나 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '만돌린과 피아노를 위한 소나티나 C단조', 'Sonatina for Mandolin and Piano in C minor', 'song', 'WoO 43a', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '만돌린과 피아노를 위한 소나티나 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75430a42-c9fc-3094-a598-2f61e738f62d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '75430a42-c9fc-3094-a598-2f61e738f62d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '만돌린과 피아노를 위한 소나티나 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '75430a42-c9fc-3094-a598-2f61e738f62d'
);


-- WoO 43b 만돌린과 피아노를 위한 아다지오 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '만돌린과 피아노를 위한 아다지오 E♭장조', 'Adagio for Mandolin and Piano in E♭ major', 'song', 'WoO 43b', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '만돌린과 피아노를 위한 아다지오 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '789b310b-67e2-3615-80c8-6138b06c10e6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '789b310b-67e2-3615-80c8-6138b06c10e6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '만돌린과 피아노를 위한 아다지오 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '789b310b-67e2-3615-80c8-6138b06c10e6'
);


-- WoO 44a 만돌린과 피아노를 위한 소나티나 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '만돌린과 피아노를 위한 소나티나 C장조', 'Sonatina for Mandolin and Piano in C major', 'song', 'WoO 44a', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '만돌린과 피아노를 위한 소나티나 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '477841b6-280b-3419-b2a7-d1e233bbb476'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '477841b6-280b-3419-b2a7-d1e233bbb476'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '만돌린과 피아노를 위한 소나티나 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '477841b6-280b-3419-b2a7-d1e233bbb476'
);


-- WoO 44b 만돌린과 피아노를 위한 안단테와 변주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '만돌린과 피아노를 위한 안단테와 변주 D장조', 'Andante and Variations for Mandolin and Piano in D major', 'song', 'WoO 44b', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '만돌린과 피아노를 위한 안단테와 변주 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9e5e4cc-f217-3f33-b906-15803a103cfd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9e5e4cc-f217-3f33-b906-15803a103cfd'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '만돌린과 피아노를 위한 안단테와 변주 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9e5e4cc-f217-3f33-b906-15803a103cfd'
);


-- WoO 45 <유다스 마카베우스>의 "See, the conqu'ring hero comes" 주제에 의한 12개의 변주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<유다스 마카베우스>의 "See, the conqu''ring hero comes" 주제에 의한 12개의 변주곡 G장조', '12 Variations in G major on "See, the conqu''ring hero comes" from Handel''s Judas Maccabaeus', 'song', 'WoO 45', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<유다스 마카베우스>의 "See, the conqu''ring hero comes" 주제에 의한 12개의 변주곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6844409b-3a79-35b9-90d0-a447e652e5d5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6844409b-3a79-35b9-90d0-a447e652e5d5'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<유다스 마카베우스>의 "See, the conqu''ring hero comes" 주제에 의한 12개의 변주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6844409b-3a79-35b9-90d0-a447e652e5d5'
);


-- WoO 46 <마술피리>의 "Bei Männern, welche Liebe fühlen" 주제에 의한 7개의 변주곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<마술피리>의 "Bei Männern, welche Liebe fühlen" 주제에 의한 7개의 변주곡 E♭장조', '7 Variations in E♭ major on "Bei Männern, welche Liebe fühlen" from Mozart''s The Magic Flute', 'song', 'WoO 46', NULL, NULL, 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<마술피리>의 "Bei Männern, welche Liebe fühlen" 주제에 의한 7개의 변주곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5331745-ff89-3b4f-96ad-a9205819af1e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5331745-ff89-3b4f-96ad-a9205819af1e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<마술피리>의 "Bei Männern, welche Liebe fühlen" 주제에 의한 7개의 변주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5331745-ff89-3b4f-96ad-a9205819af1e'
);


-- WoO 47 피아노 소나타 WoO 47 "선제후"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 WoO 47 "선제후"', '3 Piano Sonatas "Kurfürstensonaten", WoO 47', 'album', 'WoO 47', NULL, NULL, 1783, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 WoO 47 "선제후"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f424fb01-37b0-4965-9fbd-93b17c96ecf3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f424fb01-37b0-4965-9fbd-93b17c96ecf3'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f424fb01-37b0-4965-9fbd-93b17c96ecf3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb53cd1a-547d-4678-95f2-246ccfba5433', 1, NULL, '피아노 소나타 E♭장조', 'Piano Sonata in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb53cd1a-547d-4678-95f2-246ccfba5433'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0e0b6bc3-2fb2-3d75-9f47-b7db9df1971f', 1, 'I', 'Allegro cantabile', 'I. Allegro cantabile', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb53cd1a-547d-4678-95f2-246ccfba5433'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e0b6bc3-2fb2-3d75-9f47-b7db9df1971f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f4670aab-c3bc-33d9-aeb1-fe500db8cd33', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb53cd1a-547d-4678-95f2-246ccfba5433'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4670aab-c3bc-33d9-aeb1-fe500db8cd33'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f81b4844-6a37-37f6-b2aa-5183a1eab81f', 3, 'III', '론도. Vivace', 'III. Rondo. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eb53cd1a-547d-4678-95f2-246ccfba5433'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f81b4844-6a37-37f6-b2aa-5183a1eab81f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:adaf6f4e-033c-413c-a743-a658fab8d4ae', 2, NULL, '피아노 소나타 F단조', 'Piano Sonata in F minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:adaf6f4e-033c-413c-a743-a658fab8d4ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:526380aa-7074-3307-9048-2d503e2b9800', 1, 'I', 'Larghetto maestoso', 'I. Larghetto maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adaf6f4e-033c-413c-a743-a658fab8d4ae'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:526380aa-7074-3307-9048-2d503e2b9800'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a8bf3f2-ef72-328d-a982-2d244ad6d9dc', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adaf6f4e-033c-413c-a743-a658fab8d4ae'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a8bf3f2-ef72-328d-a982-2d244ad6d9dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe5ec879-7d4c-3622-830a-20ae524a6f5e', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:adaf6f4e-033c-413c-a743-a658fab8d4ae'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe5ec879-7d4c-3622-830a-20ae524a6f5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db405926-ded9-458a-8c46-25c2cecec6a2', 3, NULL, '피아노 소나타 D장조', 'Piano Sonata in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db405926-ded9-458a-8c46-25c2cecec6a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6b75a31f-96a1-39b1-8cec-bce7965e2da2', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db405926-ded9-458a-8c46-25c2cecec6a2'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b75a31f-96a1-39b1-8cec-bce7965e2da2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c7b67a0-12f3-3381-a5bc-4e991034456c', 2, 'II', '미뉴에트', 'II. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db405926-ded9-458a-8c46-25c2cecec6a2'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c7b67a0-12f3-3381-a5bc-4e991034456c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:003e9726-a860-3336-ad97-5f84bb471bf8', 3, 'III', 'Scherzando', 'III. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:db405926-ded9-458a-8c46-25c2cecec6a2'
WHERE p.composer_id = 15 AND p.title = '피아노 소나타 WoO 47 "선제후"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:003e9726-a860-3336-ad97-5f84bb471bf8'
);


-- WoO 48 론도 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 C장조', 'Rondo in C major', 'song', 'WoO 48', NULL, NULL, 1783, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac228275-d45d-3ee3-9056-9d6a373da5f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac228275-d45d-3ee3-9056-9d6a373da5f9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '론도 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac228275-d45d-3ee3-9056-9d6a373da5f9'
);


-- WoO 49 론도 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '론도 A장조', 'Rondo in A major', 'song', 'WoO 49', NULL, NULL, 1783, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '론도 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '875d1660-2428-3fe6-9aee-021f8981277e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '875d1660-2428-3fe6-9aee-021f8981277e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '론도 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '875d1660-2428-3fe6-9aee-021f8981277e'
);


-- WoO 50 피아노 소나티나 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나티나 F장조', 'Piano Sonatina in F major', 'album', 'WoO 50', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나티나 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45dc5c68-d70d-4da1-adca-438831890faa'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '45dc5c68-d70d-4da1-adca-438831890faa'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나티나 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45dc5c68-d70d-4da1-adca-438831890faa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3afa81f-cc63-30a7-a662-045b114f486c', 1, 'I', '(빠르기말 없음)', 'I. [no tempo marking]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나티나 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3afa81f-cc63-30a7-a662-045b114f486c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1656757c-94a4-37a4-9b39-02c9fce54aee', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '피아노 소나티나 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1656757c-94a4-37a4-9b39-02c9fce54aee'
);


-- WoO 52 바가텔 C단조 "Presto"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 C단조 "Presto"', 'Bagatelle in C minor "Presto"', 'song', 'WoO 52', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 C단조 "Presto"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c46e7de1-3b3f-3135-bbe0-6987272141d1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c46e7de1-3b3f-3135-bbe0-6987272141d1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 C단조 "Presto"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c46e7de1-3b3f-3135-bbe0-6987272141d1'
);


-- WoO 53 바가텔 C단조 "Allegretto"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 C단조 "Allegretto"', 'Bagatelle in C minor "Allegretto"', 'song', 'WoO 53', NULL, NULL, 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 C단조 "Allegretto"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e272ca3-9238-3bf8-95a6-498546afa4c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1e272ca3-9238-3bf8-95a6-498546afa4c6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 C단조 "Allegretto"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1e272ca3-9238-3bf8-95a6-498546afa4c6'
);


-- WoO 54 바가텔 C장조 "Lustig-Traurig"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 C장조 "Lustig-Traurig"', 'Bagatelle in C major "Lustig-Traurig"', 'song', 'WoO 54', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 C장조 "Lustig-Traurig"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '291eb0df-580f-3615-ace4-e512c207968d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '291eb0df-580f-3615-ace4-e512c207968d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 C장조 "Lustig-Traurig"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '291eb0df-580f-3615-ace4-e512c207968d'
);


-- WoO 55 전주곡 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '전주곡 F단조', 'Prelude in F minor', 'song', 'WoO 55', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '전주곡 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b54984e-0131-3949-a647-24bb62b0b005'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b54984e-0131-3949-a647-24bb62b0b005'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '전주곡 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b54984e-0131-3949-a647-24bb62b0b005'
);


-- WoO 56 바가텔 C장조 "Allegretto"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 C장조 "Allegretto"', 'Bagatelle in C major "Allegretto"', 'song', 'WoO 56', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 C장조 "Allegretto"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '885226f8-dab4-3c26-869a-661fada09364'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '885226f8-dab4-3c26-869a-661fada09364'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 C장조 "Allegretto"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '885226f8-dab4-3c26-869a-661fada09364'
);


-- WoO 57 안단테 F장조 "안단테 파보리"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 F장조 "안단테 파보리"', 'Andante in F major "Andante favori"', 'song', 'WoO 57', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 F장조 "안단테 파보리"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1307d750-c551-3a07-96b9-6d6f75ef1d88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1307d750-c551-3a07-96b9-6d6f75ef1d88'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '안단테 F장조 "안단테 파보리"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1307d750-c551-3a07-96b9-6d6f75ef1d88'
);


-- WoO 58 모차르트 피아노 협주곡 20번을 위한 카덴차

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모차르트 피아노 협주곡 20번을 위한 카덴차', 'Cadenzas for Mozart''s Piano Concerto No. 20, WoO 58', 'album', 'WoO 58', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모차르트 피아노 협주곡 20번을 위한 카덴차'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8cc6412-8328-47a1-a5d1-91d43b90a2cf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a8cc6412-8328-47a1-a5d1-91d43b90a2cf'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '모차르트 피아노 협주곡 20번을 위한 카덴차' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a8cc6412-8328-47a1-a5d1-91d43b90a2cf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1d90e84-aaa4-4f74-97c6-b47bd032a59a', 1, NULL, 'Allegro 악장 카덴차', 'Cadenza for the Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '모차르트 피아노 협주곡 20번을 위한 카덴차' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d90e84-aaa4-4f74-97c6-b47bd032a59a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:147f5af9-286c-4f18-9e9a-fde3525ad606', 2, NULL, 'Rondo 악장 카덴차', 'Cadenza for the Rondo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '모차르트 피아노 협주곡 20번을 위한 카덴차' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:147f5af9-286c-4f18-9e9a-fde3525ad606'
);


-- WoO 60 바가텔 B♭장조 "Ziemlich lebhaft"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 B♭장조 "Ziemlich lebhaft"', 'Bagatelle in B♭ major "Ziemlich lebhaft"', 'song', 'WoO 60', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 B♭장조 "Ziemlich lebhaft"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ef029c1-6f0d-37fd-a913-cea09710b64c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3ef029c1-6f0d-37fd-a913-cea09710b64c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 B♭장조 "Ziemlich lebhaft"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3ef029c1-6f0d-37fd-a913-cea09710b64c'
);


-- WoO 61 알레그레토 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 B단조', 'Allegretto in B minor', 'song', 'WoO 61', NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c56763c-9efe-3719-950d-65744a8e5d85'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c56763c-9efe-3719-950d-65744a8e5d85'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '알레그레토 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c56763c-9efe-3719-950d-65744a8e5d85'
);


-- WoO 61a 알레그레토 콰지 안단테 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알레그레토 콰지 안단테 G단조', 'Allegretto quasi andante in G minor', 'song', 'WoO 61a', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알레그레토 콰지 안단테 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24f1dfb3-18ab-387d-aead-15f54823b4cc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24f1dfb3-18ab-387d-aead-15f54823b4cc'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '알레그레토 콰지 안단테 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24f1dfb3-18ab-387d-aead-15f54823b4cc'
);


-- WoO 63 드레슬러 행진곡 주제에 의한 9개의 변주곡 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '드레슬러 행진곡 주제에 의한 9개의 변주곡 C단조', '9 Variations in C minor on a March by Dressler', 'song', 'WoO 63', NULL, NULL, 1782, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '드레슬러 행진곡 주제에 의한 9개의 변주곡 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57f84422-7989-39ec-8336-ae0115f4602d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '57f84422-7989-39ec-8336-ae0115f4602d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '드레슬러 행진곡 주제에 의한 9개의 변주곡 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57f84422-7989-39ec-8336-ae0115f4602d'
);


-- WoO 64 스위스 노래 주제에 의한 6개의 변주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스위스 노래 주제에 의한 6개의 변주곡 F장조', '6 Variations in F major on a Swiss Song', 'song', 'WoO 64', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스위스 노래 주제에 의한 6개의 변주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd141bae8-9caf-38b6-91fb-678237ae8fc9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd141bae8-9caf-38b6-91fb-678237ae8fc9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '스위스 노래 주제에 의한 6개의 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd141bae8-9caf-38b6-91fb-678237ae8fc9'
);


-- WoO 65 리기니의 "Venni amore" 주제에 의한 24개의 변주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '리기니의 "Venni amore" 주제에 의한 24개의 변주곡 D장조', '24 Variations in D major on Righini''s "Venni amore"', 'song', 'WoO 65', NULL, NULL, 1791, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '리기니의 "Venni amore" 주제에 의한 24개의 변주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d4fe3cd-5a64-3393-92de-b198a60c2641'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d4fe3cd-5a64-3393-92de-b198a60c2641'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '리기니의 "Venni amore" 주제에 의한 24개의 변주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d4fe3cd-5a64-3393-92de-b198a60c2641'
);


-- WoO 66 디터스도르프의 "Es war einmal ein alter Mann" 주제에 의한 13개의 변주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '디터스도르프의 "Es war einmal ein alter Mann" 주제에 의한 13개의 변주곡 A장조', '13 Variations in A major on "Es war einmal ein alter Mann" from Dittersdorf''s Das rote Käppchen', 'song', 'WoO 66', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '디터스도르프의 "Es war einmal ein alter Mann" 주제에 의한 13개의 변주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba377b12-4279-3370-ae2d-5030d428acb1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ba377b12-4279-3370-ae2d-5030d428acb1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '디터스도르프의 "Es war einmal ein alter Mann" 주제에 의한 13개의 변주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ba377b12-4279-3370-ae2d-5030d428acb1'
);


-- WoO 67 발트슈타인 백작 주제에 의한 네 손을 위한 8개의 변주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발트슈타인 백작 주제에 의한 네 손을 위한 8개의 변주곡 C장조', '8 Variations in C major on a Theme by Count Waldstein for Piano Four Hands', 'song', 'WoO 67', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발트슈타인 백작 주제에 의한 네 손을 위한 8개의 변주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '900f0a97-3ede-3700-8788-32fc32332d00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '900f0a97-3ede-3700-8788-32fc32332d00'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '발트슈타인 백작 주제에 의한 네 손을 위한 8개의 변주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '900f0a97-3ede-3700-8788-32fc32332d00'
);


-- WoO 68 "Menuet à la Viganò" 주제에 의한 12개의 변주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"Menuet à la Viganò" 주제에 의한 12개의 변주곡 C장조', '12 Variations in C major on the "Menuet à la Viganò"', 'song', 'WoO 68', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"Menuet à la Viganò" 주제에 의한 12개의 변주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f0319c0-5833-3099-8a94-ba3f6352aaff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f0319c0-5833-3099-8a94-ba3f6352aaff'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '"Menuet à la Viganò" 주제에 의한 12개의 변주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f0319c0-5833-3099-8a94-ba3f6352aaff'
);


-- WoO 69 파이시엘로의 "Quant'è più bello" 주제에 의한 9개의 변주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파이시엘로의 "Quant''è più bello" 주제에 의한 9개의 변주곡 A장조', '9 Variations in A major on Paisiello''s "Quant''è più bello"', 'song', 'WoO 69', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파이시엘로의 "Quant''è più bello" 주제에 의한 9개의 변주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d44e739-a344-3114-855b-d34bbbaa57a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3d44e739-a344-3114-855b-d34bbbaa57a4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '파이시엘로의 "Quant''è più bello" 주제에 의한 9개의 변주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3d44e739-a344-3114-855b-d34bbbaa57a4'
);


-- WoO 70 파이시엘로의 "Nel cor più non mi sento" 주제에 의한 6개의 변주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파이시엘로의 "Nel cor più non mi sento" 주제에 의한 6개의 변주곡 G장조', '6 Variations in G major on Paisiello''s "Nel cor più non mi sento"', 'song', 'WoO 70', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파이시엘로의 "Nel cor più non mi sento" 주제에 의한 6개의 변주곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '991b3aa9-325e-3566-a542-e6c0594cb85b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '991b3aa9-325e-3566-a542-e6c0594cb85b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '파이시엘로의 "Nel cor più non mi sento" 주제에 의한 6개의 변주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '991b3aa9-325e-3566-a542-e6c0594cb85b'
);


-- WoO 71 브라니츠키 <숲의 처녀>의 러시아 춤 주제에 의한 12개의 변주곡 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '브라니츠키 <숲의 처녀>의 러시아 춤 주제에 의한 12개의 변주곡 A장조', '12 Variations in A major on a Russian Dance from Wranitzky''s Das Waldmädchen', 'song', 'WoO 71', NULL, NULL, 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '브라니츠키 <숲의 처녀>의 러시아 춤 주제에 의한 12개의 변주곡 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76486bff-1b97-3800-a1e8-757d83983858'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '76486bff-1b97-3800-a1e8-757d83983858'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '브라니츠키 <숲의 처녀>의 러시아 춤 주제에 의한 12개의 변주곡 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '76486bff-1b97-3800-a1e8-757d83983858'
);


-- WoO 72 그레트리의 "Une fièvre brûlante" 주제에 의한 8개의 변주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '그레트리의 "Une fièvre brûlante" 주제에 의한 8개의 변주곡 C장조', '8 Variations in C major on Grétry''s "Une fièvre brûlante"', 'song', 'WoO 72', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '그레트리의 "Une fièvre brûlante" 주제에 의한 8개의 변주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbd16c6c-1a98-3705-b0ab-a64dd2346f71'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dbd16c6c-1a98-3705-b0ab-a64dd2346f71'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '그레트리의 "Une fièvre brûlante" 주제에 의한 8개의 변주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbd16c6c-1a98-3705-b0ab-a64dd2346f71'
);


-- WoO 73 살리에리의 "La stessa, la stessissima" 주제에 의한 10개의 변주곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '살리에리의 "La stessa, la stessissima" 주제에 의한 10개의 변주곡 B♭장조', '10 Variations in B♭ major on Salieri''s "La stessa, la stessissima"', 'song', 'WoO 73', NULL, NULL, 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '살리에리의 "La stessa, la stessissima" 주제에 의한 10개의 변주곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3822f13c-efad-389e-846f-b5de32acae00'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3822f13c-efad-389e-846f-b5de32acae00'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '살리에리의 "La stessa, la stessissima" 주제에 의한 10개의 변주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3822f13c-efad-389e-846f-b5de32acae00'
);


-- WoO 74 가곡 "Ich denke dein"과 네 손을 위한 6개의 변주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 "Ich denke dein"과 네 손을 위한 6개의 변주곡 D장조', '"Ich denke dein" with 6 Variations in D major for Piano Four Hands', 'song', 'WoO 74', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 "Ich denke dein"과 네 손을 위한 6개의 변주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9af0443a-c4c6-3841-acd1-99e75a60e01a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9af0443a-c4c6-3841-acd1-99e75a60e01a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 "Ich denke dein"과 네 손을 위한 6개의 변주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9af0443a-c4c6-3841-acd1-99e75a60e01a'
);


-- WoO 75 빈터의 "Kind, willst du ruhig schlafen" 주제에 의한 7개의 변주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '빈터의 "Kind, willst du ruhig schlafen" 주제에 의한 7개의 변주곡 F장조', '7 Variations in F major on Winter''s "Kind, willst du ruhig schlafen"', 'song', 'WoO 75', NULL, NULL, 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '빈터의 "Kind, willst du ruhig schlafen" 주제에 의한 7개의 변주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6decec84-2c76-3f1b-ac8a-c8f623072f04'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6decec84-2c76-3f1b-ac8a-c8f623072f04'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '빈터의 "Kind, willst du ruhig schlafen" 주제에 의한 7개의 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6decec84-2c76-3f1b-ac8a-c8f623072f04'
);


-- WoO 76 쥐스마이어의 "Tändeln und Scherzen" 주제에 의한 8개의 변주곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쥐스마이어의 "Tändeln und Scherzen" 주제에 의한 8개의 변주곡 F장조', '8 Variations in F major on Süssmayr''s "Tändeln und Scherzen"', 'song', 'WoO 76', NULL, NULL, 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쥐스마이어의 "Tändeln und Scherzen" 주제에 의한 8개의 변주곡 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46f043d4-30ee-337b-bd57-166fc9977408'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46f043d4-30ee-337b-bd57-166fc9977408'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '쥐스마이어의 "Tändeln und Scherzen" 주제에 의한 8개의 변주곡 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46f043d4-30ee-337b-bd57-166fc9977408'
);


-- WoO 77 창작 주제에 의한 6개의 쉬운 변주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '창작 주제에 의한 6개의 쉬운 변주곡 G장조', '6 Easy Variations on an Original Theme in G major', 'song', 'WoO 77', NULL, NULL, 1800, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '창작 주제에 의한 6개의 쉬운 변주곡 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cd4700a-a0dd-3b33-be27-65ecf3056fae'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7cd4700a-a0dd-3b33-be27-65ecf3056fae'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '창작 주제에 의한 6개의 쉬운 변주곡 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cd4700a-a0dd-3b33-be27-65ecf3056fae'
);


-- WoO 78 "God Save the King" 주제에 의한 7개의 변주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"God Save the King" 주제에 의한 7개의 변주곡 C장조', '7 Variations in C major on "God Save the King"', 'song', 'WoO 78', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"God Save the King" 주제에 의한 7개의 변주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a80cd2c2-aff7-339f-a830-e25c30a7225a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a80cd2c2-aff7-339f-a830-e25c30a7225a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '"God Save the King" 주제에 의한 7개의 변주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a80cd2c2-aff7-339f-a830-e25c30a7225a'
);


-- WoO 79 "Rule, Britannia!" 주제에 의한 5개의 변주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '"Rule, Britannia!" 주제에 의한 5개의 변주곡 D장조', '5 Variations in D major on "Rule, Britannia!"', 'song', 'WoO 79', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '"Rule, Britannia!" 주제에 의한 5개의 변주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03579715-6c71-3297-af3d-e6438d1852e6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03579715-6c71-3297-af3d-e6438d1852e6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '"Rule, Britannia!" 주제에 의한 5개의 변주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03579715-6c71-3297-af3d-e6438d1852e6'
);


-- WoO 80 창작 주제에 의한 32개의 변주곡 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '창작 주제에 의한 32개의 변주곡 C단조', '32 Variations on an Original Theme in C minor', 'song', 'WoO 80', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '창작 주제에 의한 32개의 변주곡 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '508ec4b1-9549-38cd-a61e-1f0d120a6118'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '508ec4b1-9549-38cd-a61e-1f0d120a6118'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '창작 주제에 의한 32개의 변주곡 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '508ec4b1-9549-38cd-a61e-1f0d120a6118'
);


-- WoO 81 알망드 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '알망드 A장조', 'Allemande in A major', 'song', 'WoO 81', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '알망드 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63f4b620-3334-3167-ace9-de51a392b5ad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '63f4b620-3334-3167-ace9-de51a392b5ad'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '알망드 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '63f4b620-3334-3167-ace9-de51a392b5ad'
);


-- WoO 82 미뉴에트 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 E♭장조', 'Minuet in E♭ major', 'song', 'WoO 82', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9fcb2449-d712-3b13-84a1-bf5f8d6d8cd0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9fcb2449-d712-3b13-84a1-bf5f8d6d8cd0'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9fcb2449-d712-3b13-84a1-bf5f8d6d8cd0'
);


-- WoO 83 에코세즈 WoO 83

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에코세즈 WoO 83', '6 Écossaises in E♭ major, WoO 83', 'album', NULL, 'WoO', '83', 1806, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에코세즈 WoO 83'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07e01dbe-a3ba-3dd4-9286-3b4c32cc9626'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07e01dbe-a3ba-3dd4-9286-3b4c32cc9626'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '에코세즈 WoO 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07e01dbe-a3ba-3dd4-9286-3b4c32cc9626'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53871174-abe1-3fb9-93e4-774aa5f081d7', 1, NULL, 'E♭장조', 'No. 1 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '에코세즈 WoO 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53871174-abe1-3fb9-93e4-774aa5f081d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:465418d6-28cb-3871-b4b1-546701e23620', 2, NULL, 'E♭장조', 'No. 2 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '에코세즈 WoO 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:465418d6-28cb-3871-b4b1-546701e23620'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09cb603b-290d-3bd2-80ec-2ab00f2a0ab2', 3, NULL, 'E♭장조', 'No. 3 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '에코세즈 WoO 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09cb603b-290d-3bd2-80ec-2ab00f2a0ab2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8d578bf7-ce4e-3c68-9dc3-01834df83df5', 4, NULL, 'E♭장조', 'No. 4 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '에코세즈 WoO 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d578bf7-ce4e-3c68-9dc3-01834df83df5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b4dd882-3d41-32d6-ba9c-4dbb3ea1ef97', 5, NULL, 'E♭장조', 'No. 5 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '에코세즈 WoO 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b4dd882-3d41-32d6-ba9c-4dbb3ea1ef97'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a4ed5562-868c-3f26-a121-c3d787a376cf', 6, NULL, 'E♭장조', 'No. 6 in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '에코세즈 WoO 83' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4ed5562-868c-3f26-a121-c3d787a376cf'
);


-- WoO 84 왈츠 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 E♭장조', 'Waltz in E♭ major', 'song', 'WoO 84', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab6f7469-72ba-329d-874a-b42b9a27bc2e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab6f7469-72ba-329d-874a-b42b9a27bc2e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '왈츠 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab6f7469-72ba-329d-874a-b42b9a27bc2e'
);


-- WoO 85 왈츠 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 D장조', 'Waltz in D major', 'song', 'WoO 85', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1eaf0f0-24b3-3e58-9b1d-b45f93bfbfde'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1eaf0f0-24b3-3e58-9b1d-b45f93bfbfde'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '왈츠 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1eaf0f0-24b3-3e58-9b1d-b45f93bfbfde'
);


-- WoO 86 에코세즈 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에코세즈 E♭장조', 'Écossaise in E♭ major', 'song', 'WoO 86', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에코세즈 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9cb7bf3-d4c4-3e50-87f7-0d5fc7b6771f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c9cb7bf3-d4c4-3e50-87f7-0d5fc7b6771f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '에코세즈 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c9cb7bf3-d4c4-3e50-87f7-0d5fc7b6771f'
);


-- WoO 87 <황제 요제프 2세의 죽음에 부치는 칸타타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<황제 요제프 2세의 죽음에 부치는 칸타타>', 'Cantata on the Death of Emperor Joseph II', 'song', 'WoO 87', NULL, NULL, 1790, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<황제 요제프 2세의 죽음에 부치는 칸타타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d827611-8573-4167-88a3-cba959b46bd2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8d827611-8573-4167-88a3-cba959b46bd2'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<황제 요제프 2세의 죽음에 부치는 칸타타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8d827611-8573-4167-88a3-cba959b46bd2'
);


-- WoO 88 <황제 레오폴트 2세의 즉위에 부치는 칸타타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<황제 레오폴트 2세의 즉위에 부치는 칸타타>', 'Cantata on the Accession of Emperor Leopold II', 'song', 'WoO 88', NULL, NULL, 1790, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<황제 레오폴트 2세의 즉위에 부치는 칸타타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef8094d2-1256-443c-86ed-adc6ab49b865'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ef8094d2-1256-443c-86ed-adc6ab49b865'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<황제 레오폴트 2세의 즉위에 부치는 칸타타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ef8094d2-1256-443c-86ed-adc6ab49b865'
);


-- WoO 89 베이스 아리아 <Prüfung des Küssens>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베이스 아리아 <Prüfung des Küssens>', '"Prüfung des Küssens", aria for bass', 'song', 'WoO 89', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베이스 아리아 <Prüfung des Küssens>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0541cfe-761e-3531-aa65-859e807d68f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0541cfe-761e-3531-aa65-859e807d68f5'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '베이스 아리아 <Prüfung des Küssens>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0541cfe-761e-3531-aa65-859e807d68f5'
);


-- WoO 90 베이스 아리아 <Mit Mädeln sich vertragen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베이스 아리아 <Mit Mädeln sich vertragen>', '"Mit Mädeln sich vertragen", aria for bass', 'song', 'WoO 90', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베이스 아리아 <Mit Mädeln sich vertragen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22380b3d-0497-32d0-af29-ba0e9b6a3005'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '22380b3d-0497-32d0-af29-ba0e9b6a3005'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '베이스 아리아 <Mit Mädeln sich vertragen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '22380b3d-0497-32d0-af29-ba0e9b6a3005'
);


-- WoO 91 <Die schöne Schusterin>을 위한 아리아 2곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Die schöne Schusterin>을 위한 아리아 2곡', '2 Arias for Umlauf''s Singspiel "Die schöne Schusterin", WoO 91', 'album', 'WoO 91', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Die schöne Schusterin>을 위한 아리아 2곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ad88c39-152f-47a9-b61d-4eee50229901'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ad88c39-152f-47a9-b61d-4eee50229901'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<Die schöne Schusterin>을 위한 아리아 2곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ad88c39-152f-47a9-b61d-4eee50229901'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b50b3810-27f6-4ce0-b77f-7af8f35aa4a6', 1, NULL, 'O welch ein Leben!', 'O welch ein Leben!', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<Die schöne Schusterin>을 위한 아리아 2곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b50b3810-27f6-4ce0-b77f-7af8f35aa4a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:055454ef-8235-4fc7-983d-219ab8a14395', 2, NULL, 'Soll ein Schuh nicht drücken', 'Soll ein Schuh nicht drücken', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<Die schöne Schusterin>을 위한 아리아 2곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:055454ef-8235-4fc7-983d-219ab8a14395'
);


-- WoO 92 장면과 아리아 <Primo amore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '장면과 아리아 <Primo amore>', '"Primo amore", scena and aria for soprano', 'song', 'WoO 92', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '장면과 아리아 <Primo amore>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9c03306-f97f-3dc5-ac7b-e90f90e444a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f9c03306-f97f-3dc5-ac7b-e90f90e444a2'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장면과 아리아 <Primo amore>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f9c03306-f97f-3dc5-ac7b-e90f90e444a2'
);


-- WoO 92a 장면과 아리아 <No, non turbarti>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '장면과 아리아 <No, non turbarti>', '"No, non turbarti", scena and aria for soprano', 'song', 'WoO 92a', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '장면과 아리아 <No, non turbarti>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd689cc45-1322-4af7-ae37-3b5304d0341d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd689cc45-1322-4af7-ae37-3b5304d0341d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '장면과 아리아 <No, non turbarti>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd689cc45-1322-4af7-ae37-3b5304d0341d'
);


-- WoO 93 2중창 <Ne' giorni tuoi felici>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '2중창 <Ne'' giorni tuoi felici>', '"Ne'' giorni tuoi felici", duet for soprano and tenor', 'song', 'WoO 93', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '2중창 <Ne'' giorni tuoi felici>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bac2375-c9ce-3b72-9a5f-2818f010c74d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4bac2375-c9ce-3b72-9a5f-2818f010c74d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '2중창 <Ne'' giorni tuoi felici>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4bac2375-c9ce-3b72-9a5f-2818f010c74d'
);


-- WoO 94 아리아와 합창 <Germania>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아와 합창 <Germania>', '"Germania", aria with chorus', 'song', 'WoO 94', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아와 합창 <Germania>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ae24370-0b4d-3f0f-8d81-3ceff0a4044d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5ae24370-0b4d-3f0f-8d81-3ceff0a4044d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '아리아와 합창 <Germania>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5ae24370-0b4d-3f0f-8d81-3ceff0a4044d'
);


-- WoO 95 연합국 군주들을 위한 합창 <Ihr weisen Gründer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연합국 군주들을 위한 합창 <Ihr weisen Gründer>', 'Chorus for the Allied Princes "Ihr weisen Gründer"', 'song', 'WoO 95', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연합국 군주들을 위한 합창 <Ihr weisen Gründer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cf7d3b9-c6b0-331f-aded-e557de8ad243'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7cf7d3b9-c6b0-331f-aded-e557de8ad243'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '연합국 군주들을 위한 합창 <Ihr weisen Gründer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cf7d3b9-c6b0-331f-aded-e557de8ad243'
);


-- WoO 96 부수음악 <레오노레 프로하스카>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부수음악 <레오노레 프로하스카>', 'Leonore Prohaska, incidental music', 'song', 'WoO 96', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부수음악 <레오노레 프로하스카>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec0378b4-d125-45a8-b1d6-b245f48baf83'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec0378b4-d125-45a8-b1d6-b245f48baf83'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '부수음악 <레오노레 프로하스카>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec0378b4-d125-45a8-b1d6-b245f48baf83'
);


-- WoO 97 <Es ist vollbracht> (<Die Ehrenpforten> 피날레)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Es ist vollbracht> (<Die Ehrenpforten> 피날레)', '"Es ist vollbracht", finale of Die Ehrenpforten', 'song', 'WoO 97', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Es ist vollbracht> (<Die Ehrenpforten> 피날레)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afc8829f-09f1-4b4b-99a7-16c566febd96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'afc8829f-09f1-4b4b-99a7-16c566febd96'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<Es ist vollbracht> (<Die Ehrenpforten> 피날레)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'afc8829f-09f1-4b4b-99a7-16c566febd96'
);


-- WoO 98 <헌당식>을 위한 합창 <Wo sich die Pulse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<헌당식>을 위한 합창 <Wo sich die Pulse>', '"Wo sich die Pulse", chorus for The Consecration of the House', 'song', 'WoO 98', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<헌당식>을 위한 합창 <Wo sich die Pulse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7fa3462-d815-40e5-b1e7-da6749f111e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7fa3462-d815-40e5-b1e7-da6749f111e1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<헌당식>을 위한 합창 <Wo sich die Pulse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7fa3462-d815-40e5-b1e7-da6749f111e1'
);


-- WoO 99 이탈리아어 다성 가곡집

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '이탈리아어 다성 가곡집', 'Italian Part-Songs, WoO 99', 'album', 'WoO 99', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '이탈리아어 다성 가곡집'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbfd4801-e368-4ef2-bdc3-e58474269790'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbfd4801-e368-4ef2-bdc3-e58474269790'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbfd4801-e368-4ef2-bdc3-e58474269790'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d37d4316-a549-3e77-91e7-c4e9e037d2f8', 1, NULL, 'Bei labbri, che Amore', 'No. 1 "Bei labbri, che Amore"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d37d4316-a549-3e77-91e7-c4e9e037d2f8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9890c5d7-c25a-3b1f-bf34-6d2bbb8040c0', 2, NULL, 'Ma tu tremi, o mio tesoro', 'No. 2 "Ma tu tremi, o mio tesoro"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9890c5d7-c25a-3b1f-bf34-6d2bbb8040c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb635d1-d5b4-4873-94fe-0fd146229eec', 3, NULL, 'E pur fra le tempeste', 'No. 3 "E pur fra le tempeste"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb635d1-d5b4-4873-94fe-0fd146229eec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7066372b-b7cb-39ac-ad08-d138b0c71d89', 4, NULL, 'Sei mio ben', 'No. 4 "Sei mio ben"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7066372b-b7cb-39ac-ad08-d138b0c71d89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff2f0061-e3e7-34d1-bdf1-9b960e0abd3c', 5, NULL, 'Giura il nocchier (5a)', 'No. 5a "Giura il nocchier"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff2f0061-e3e7-34d1-bdf1-9b960e0abd3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a10b3af0-13b9-3d84-9e3a-93f25d17c273', 6, NULL, 'Giura il nocchier (5b)', 'No. 5b "Giura il nocchier"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a10b3af0-13b9-3d84-9e3a-93f25d17c273'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc936cb7-a0a9-3def-a01d-398c7552fc01', 7, NULL, 'Giura il nocchier (5c)', 'No. 5c "Giura il nocchier"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc936cb7-a0a9-3def-a01d-398c7552fc01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e210b01e-4ec5-4720-b23a-3aabb30a4891', 8, NULL, 'Ah, rammenta', 'No. 6 "Ah, rammenta"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e210b01e-4ec5-4720-b23a-3aabb30a4891'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:939d97d3-f901-3845-87ee-bfced4157d1e', 9, NULL, 'Chi mai di questo core', 'No. 7 "Chi mai di questo core"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:939d97d3-f901-3845-87ee-bfced4157d1e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:966e1ee3-b086-302d-b92e-76208fafca64', 10, NULL, 'Scrivo in te', 'No. 8 "Scrivo in te"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:966e1ee3-b086-302d-b92e-76208fafca64'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3128e1c6-42c9-33d0-a4c3-4a46e3dcee4f', 11, NULL, 'Per te d''amico aprile', 'No. 9 "Per te d''amico aprile"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3128e1c6-42c9-33d0-a4c3-4a46e3dcee4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5371cca1-e32d-3198-96f2-ac5492580839', 12, NULL, 'Nei campi e nelle selve (10a)', 'No. 10a "Nei campi e nelle selve"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5371cca1-e32d-3198-96f2-ac5492580839'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1475b0a-7f51-3509-a687-4a34799f1f2b', 13, NULL, 'Nei campi e nelle selve (10b)', 'No. 10b "Nei campi e nelle selve"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1475b0a-7f51-3509-a687-4a34799f1f2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fc7aa88c-3f13-3922-9786-d1aa61a60ac3', 14, NULL, 'Fra tutte le pene (11a)', 'No. 11a "Fra tutte le pene"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc7aa88c-3f13-3922-9786-d1aa61a60ac3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82d2c2da-81dc-31b7-8403-b0b83709b034', 15, NULL, 'Fra tutte le pene (11b)', 'No. 11b "Fra tutte le pene"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82d2c2da-81dc-31b7-8403-b0b83709b034'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:806944a2-3b9b-30b9-a672-3e2a087b874c', 16, NULL, 'Fra tutte le pene (11c)', 'No. 11c "Fra tutte le pene"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:806944a2-3b9b-30b9-a672-3e2a087b874c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f9c5293-6ec0-43da-a31b-2f7aa043ddbd', 17, NULL, 'Salvo tu vuoi lo sposo (12a)', 'No. 12a "Salvo tu vuoi lo sposo"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f9c5293-6ec0-43da-a31b-2f7aa043ddbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ac68c0e-69da-33b1-bc80-601c7c493e41', 18, NULL, 'Salvo tu vuoi lo sposo? (12b)', 'No. 12b "Salvo tu vuoi lo sposo?"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ac68c0e-69da-33b1-bc80-601c7c493e41'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:313f2c82-e434-3df3-8292-25a2ba74989c', 19, NULL, 'Quella cetra ah pur tu sei (13a)', 'No. 13a "Quella cetra ah pur tu sei"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313f2c82-e434-3df3-8292-25a2ba74989c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e11bf9eb-b915-3419-97e1-01f2d8c2a650', 20, NULL, 'Quella cetra ah pur tu sei (13b)', 'No. 13b "Quella cetra ah pur tu sei"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e11bf9eb-b915-3419-97e1-01f2d8c2a650'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32c83b17-67c4-3a39-a188-c50e5c5bc3a4', 21, NULL, 'Quella cetra ah pur tu sei (13c)', 'No. 13c "Quella cetra ah pur tu sei"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c83b17-67c4-3a39-a188-c50e5c5bc3a4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7e7ed673-de7b-34ae-8333-df9e6bdb38d7', 22, NULL, 'Già la notte s''avvicina (14a)', 'No. 14a "Già la notte s''avvicina"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7e7ed673-de7b-34ae-8333-df9e6bdb38d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c3cb1eff-a18f-34b4-a653-f25f57189758', 23, NULL, 'Già la notte s''avvicina (14b)', 'No. 14b "Già la notte s''avvicina"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '이탈리아어 다성 가곡집' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3cb1eff-a18f-34b4-a653-f25f57189758'
);


-- WoO 100 음악적 농담 <Lob auf den Dicken>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악적 농담 <Lob auf den Dicken>', 'Musical joke "Lob auf den Dicken" ("Schuppanzigh ist ein Lump")', 'song', 'WoO 100', NULL, NULL, 1801, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악적 농담 <Lob auf den Dicken>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1202185-264d-3874-9767-156851466d1f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1202185-264d-3874-9767-156851466d1f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 농담 <Lob auf den Dicken>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1202185-264d-3874-9767-156851466d1f'
);


-- WoO 101 음악적 농담 <Graf, Graf, liebster Graf>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악적 농담 <Graf, Graf, liebster Graf>', 'Musical joke "Graf, Graf, liebster Graf"', 'song', 'WoO 101', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악적 농담 <Graf, Graf, liebster Graf>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89b184ed-a821-32ec-86da-0db2a3dbc132'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '89b184ed-a821-32ec-86da-0db2a3dbc132'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 농담 <Graf, Graf, liebster Graf>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89b184ed-a821-32ec-86da-0db2a3dbc132'
);


-- WoO 102 남성 합창 <Abschiedsgesang>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '남성 합창 <Abschiedsgesang>', '"Abschiedsgesang" for male voices', 'song', 'WoO 102', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '남성 합창 <Abschiedsgesang>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc388ec6-fada-3a01-8c02-c0bfa39bbd6f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cc388ec6-fada-3a01-8c02-c0bfa39bbd6f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '남성 합창 <Abschiedsgesang>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cc388ec6-fada-3a01-8c02-c0bfa39bbd6f'
);


-- WoO 103 칸타타 <Un lieto brindisi>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Un lieto brindisi>', 'Cantata campestre "Un lieto brindisi"', 'song', 'WoO 103', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Un lieto brindisi>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e220fe5-dcad-3fb3-8cf3-d967d9aaa9a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e220fe5-dcad-3fb3-8cf3-d967d9aaa9a3'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '칸타타 <Un lieto brindisi>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e220fe5-dcad-3fb3-8cf3-d967d9aaa9a3'
);


-- WoO 104 <Gesang der Mönche>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Gesang der Mönche>', '"Gesang der Mönche" from Schiller''s Wilhelm Tell', 'song', 'WoO 104', NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Gesang der Mönche>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '041d9634-fe8d-3bab-8b51-64aa7a1c30eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '041d9634-fe8d-3bab-8b51-64aa7a1c30eb'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<Gesang der Mönche>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '041d9634-fe8d-3bab-8b51-64aa7a1c30eb'
);


-- WoO 105 <Hochzeitslied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Hochzeitslied>', '"Hochzeitslied" for voice, chorus and piano', 'song', 'WoO 105', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Hochzeitslied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b49be8c-1352-42bf-8635-5dea80144689'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b49be8c-1352-42bf-8635-5dea80144689'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<Hochzeitslied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b49be8c-1352-42bf-8635-5dea80144689'
);


-- WoO 106 <로브코비츠 공 생일 칸타타>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<로브코비츠 공 생일 칸타타>', 'Birthday Cantata for Prince Lobkowitz', 'song', 'WoO 106', NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<로브코비츠 공 생일 칸타타>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41152aea-61d7-3b1f-9144-3fd89d6e7252'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '41152aea-61d7-3b1f-9144-3fd89d6e7252'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '<로브코비츠 공 생일 칸타타>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '41152aea-61d7-3b1f-9144-3fd89d6e7252'
);


-- WoO 107 가곡 <Schilderung eines Mädchens>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Schilderung eines Mädchens>', '"Schilderung eines Mädchens"', 'song', 'WoO 107', NULL, NULL, 1783, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Schilderung eines Mädchens>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90a1e9dc-4fe1-33c2-a320-7e0446c1ecf2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90a1e9dc-4fe1-33c2-a320-7e0446c1ecf2'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Schilderung eines Mädchens>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90a1e9dc-4fe1-33c2-a320-7e0446c1ecf2'
);


-- WoO 108 가곡 <An einen Säugling>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <An einen Säugling>', '"An einen Säugling"', 'song', 'WoO 108', NULL, NULL, 1784, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <An einen Säugling>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3dfb7f57-8d15-486f-97ed-216857f945f6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3dfb7f57-8d15-486f-97ed-216857f945f6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <An einen Säugling>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3dfb7f57-8d15-486f-97ed-216857f945f6'
);


-- WoO 109 가곡 <Trinklied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Trinklied>', '"Trinklied"', 'song', 'WoO 109', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Trinklied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58f1e5ec-77a8-3ea5-a965-9a7341a8809b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '58f1e5ec-77a8-3ea5-a965-9a7341a8809b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Trinklied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '58f1e5ec-77a8-3ea5-a965-9a7341a8809b'
);


-- WoO 110 가곡 <Elegie auf den Tod eines Pudels>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Elegie auf den Tod eines Pudels>', '"Elegie auf den Tod eines Pudels"', 'song', 'WoO 110', NULL, NULL, 1790, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Elegie auf den Tod eines Pudels>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3aec15e-ed00-3bf4-9307-2d52bb14f24b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3aec15e-ed00-3bf4-9307-2d52bb14f24b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Elegie auf den Tod eines Pudels>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3aec15e-ed00-3bf4-9307-2d52bb14f24b'
);


-- WoO 111 가곡 <Punschlied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Punschlied>', '"Punschlied"', 'song', 'WoO 111', NULL, NULL, 1791, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Punschlied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c991ea69-d0bb-30b7-aaa5-4eb59a2cd85d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c991ea69-d0bb-30b7-aaa5-4eb59a2cd85d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Punschlied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c991ea69-d0bb-30b7-aaa5-4eb59a2cd85d'
);


-- WoO 112 가곡 <An Laura>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <An Laura>', '"An Laura"', 'song', 'WoO 112', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <An Laura>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d08029f-18c7-38a5-9844-712ddf838d9c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d08029f-18c7-38a5-9844-712ddf838d9c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <An Laura>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d08029f-18c7-38a5-9844-712ddf838d9c'
);


-- WoO 113 가곡 <Klage>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Klage>', '"Klage"', 'song', 'WoO 113', NULL, NULL, 1790, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Klage>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc013bf5-7910-39f2-925e-d567dfbd4a78'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc013bf5-7910-39f2-925e-d567dfbd4a78'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Klage>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc013bf5-7910-39f2-925e-d567dfbd4a78'
);


-- WoO 114 가곡 <Selbstgespräch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Selbstgespräch>', '"Selbstgespräch"', 'song', 'WoO 114', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Selbstgespräch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '557a3b0b-db2d-3d60-801c-be8259d28248'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '557a3b0b-db2d-3d60-801c-be8259d28248'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Selbstgespräch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '557a3b0b-db2d-3d60-801c-be8259d28248'
);


-- WoO 115 가곡 <An Minna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <An Minna>', '"An Minna"', 'song', 'WoO 115', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <An Minna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43e20037-8148-3216-8970-b5bc8d24068b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43e20037-8148-3216-8970-b5bc8d24068b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <An Minna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43e20037-8148-3216-8970-b5bc8d24068b'
);


-- WoO 116 가곡 <Que le temps me dure>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Que le temps me dure>', '"Que le temps me dure"', 'song', 'WoO 116', NULL, NULL, 1794, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Que le temps me dure>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd1ac1a0-1eeb-3a95-bbc9-be58c765a7dd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd1ac1a0-1eeb-3a95-bbc9-be58c765a7dd'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Que le temps me dure>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd1ac1a0-1eeb-3a95-bbc9-be58c765a7dd'
);


-- WoO 117 가곡 <Der freie Mann>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der freie Mann>', '"Der freie Mann"', 'song', 'WoO 117', NULL, NULL, 1794, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der freie Mann>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf439bda-cd79-370e-a550-c5cffe5f41d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf439bda-cd79-370e-a550-c5cffe5f41d8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Der freie Mann>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf439bda-cd79-370e-a550-c5cffe5f41d8'
);


-- WoO 118 가곡 <Seufzer eines Ungeliebten – Gegenliebe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Seufzer eines Ungeliebten – Gegenliebe>', '2 Songs "Seufzer eines Ungeliebten" and "Gegenliebe", WoO 118', 'album', 'WoO 118', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Seufzer eines Ungeliebten – Gegenliebe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f5eb8c1-00ad-35a4-b68e-da8b7e66cfb4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f5eb8c1-00ad-35a4-b68e-da8b7e66cfb4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Seufzer eines Ungeliebten – Gegenliebe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f5eb8c1-00ad-35a4-b68e-da8b7e66cfb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:beethoven:beethoven-woo118:1', 1, NULL, 'Seufzer eines Ungeliebten', 'Seufzer eines Ungeliebten', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Seufzer eines Ungeliebten – Gegenliebe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:beethoven:beethoven-woo118:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:beethoven:beethoven-woo118:2', 2, NULL, 'Gegenliebe', 'Gegenliebe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Seufzer eines Ungeliebten – Gegenliebe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:beethoven:beethoven-woo118:2'
);


-- WoO 119 가곡 <O care selve>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <O care selve>', '"O care selve"', 'song', 'WoO 119', NULL, NULL, 1794, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <O care selve>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa89ddbb-5c9d-335e-824b-e82f0fae2ae6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fa89ddbb-5c9d-335e-824b-e82f0fae2ae6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <O care selve>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fa89ddbb-5c9d-335e-824b-e82f0fae2ae6'
);


-- WoO 120 가곡 <Man strebt die Flamme zu verhehlen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Man strebt die Flamme zu verhehlen>', '"Man strebt die Flamme zu verhehlen"', 'song', 'WoO 120', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Man strebt die Flamme zu verhehlen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc390395-fb7f-31c9-8bd9-83d701b46603'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc390395-fb7f-31c9-8bd9-83d701b46603'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Man strebt die Flamme zu verhehlen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc390395-fb7f-31c9-8bd9-83d701b46603'
);


-- WoO 121 가곡 <Abschiedsgesang an Wiens Bürger>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Abschiedsgesang an Wiens Bürger>', '"Abschiedsgesang an Wiens Bürger"', 'song', 'WoO 121', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Abschiedsgesang an Wiens Bürger>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1f310f1-7220-4d17-a30f-140bd201e6c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1f310f1-7220-4d17-a30f-140bd201e6c8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Abschiedsgesang an Wiens Bürger>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1f310f1-7220-4d17-a30f-140bd201e6c8'
);


-- WoO 122 가곡 <Kriegslied der Österreicher>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Kriegslied der Österreicher>', '"Kriegslied der Österreicher"', 'song', 'WoO 122', NULL, NULL, 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Kriegslied der Österreicher>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f10d5329-756d-43be-aa7c-e4aad46d3890'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f10d5329-756d-43be-aa7c-e4aad46d3890'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Kriegslied der Österreicher>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f10d5329-756d-43be-aa7c-e4aad46d3890'
);


-- WoO 123 가곡 <그대를 사랑해>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <그대를 사랑해>', '"Zärtliche Liebe" ("Ich liebe dich")', 'song', 'WoO 123', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <그대를 사랑해>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19c3772e-be6f-3302-a7e0-59c5cda97dfb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19c3772e-be6f-3302-a7e0-59c5cda97dfb'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <그대를 사랑해>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19c3772e-be6f-3302-a7e0-59c5cda97dfb'
);


-- WoO 124 가곡 <La partenza>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La partenza>', '"La partenza"', 'song', 'WoO 124', NULL, NULL, 1796, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La partenza>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '835b8f96-1d4e-3e92-becd-a5d031446032'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '835b8f96-1d4e-3e92-becd-a5d031446032'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <La partenza>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '835b8f96-1d4e-3e92-becd-a5d031446032'
);


-- WoO 125 가곡 <La tiranna>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <La tiranna>', '"La tiranna"', 'song', 'WoO 125', NULL, NULL, 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <La tiranna>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '182a3b63-bf7a-3c8b-b5b4-5c8d0cf5bc96'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '182a3b63-bf7a-3c8b-b5b4-5c8d0cf5bc96'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <La tiranna>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '182a3b63-bf7a-3c8b-b5b4-5c8d0cf5bc96'
);


-- WoO 126 가곡 <Opferlied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Opferlied>', '"Opferlied"', 'song', 'WoO 126', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Opferlied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ae4f262-bb32-301d-8a13-f2bbdc10d3b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4ae4f262-bb32-301d-8a13-f2bbdc10d3b8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Opferlied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4ae4f262-bb32-301d-8a13-f2bbdc10d3b8'
);


-- WoO 127 가곡 <Neue Liebe, neues Leben>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Neue Liebe, neues Leben>', '"Neue Liebe, neues Leben"', 'song', 'WoO 127', NULL, NULL, 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Neue Liebe, neues Leben>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e02408e9-d21c-3490-b200-0877b9194530'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e02408e9-d21c-3490-b200-0877b9194530'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Neue Liebe, neues Leben>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e02408e9-d21c-3490-b200-0877b9194530'
);


-- WoO 128 가곡 <Plaisir d'aimer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Plaisir d''aimer>', '"Plaisir d''aimer"', 'song', 'WoO 128', NULL, NULL, 1799, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Plaisir d''aimer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec13e018-64c5-3b1d-b8ca-e758959b45a0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ec13e018-64c5-3b1d-b8ca-e758959b45a0'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Plaisir d''aimer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ec13e018-64c5-3b1d-b8ca-e758959b45a0'
);


-- WoO 129 가곡 <Der Wachtelschlag>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Wachtelschlag>', '"Der Wachtelschlag"', 'song', 'WoO 129', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Wachtelschlag>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10ceb6ca-ecbc-396b-9b0c-b235d48a498b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '10ceb6ca-ecbc-396b-9b0c-b235d48a498b'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Der Wachtelschlag>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '10ceb6ca-ecbc-396b-9b0c-b235d48a498b'
);


-- WoO 130 가곡 <Gedenke mein!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Gedenke mein!>', '"Gedenke mein!"', 'song', 'WoO 130', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Gedenke mein!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '073c6443-7bbc-3a63-8e41-d5f51dfc61f5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '073c6443-7bbc-3a63-8e41-d5f51dfc61f5'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Gedenke mein!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '073c6443-7bbc-3a63-8e41-d5f51dfc61f5'
);


-- WoO 132 가곡 <Als die Geliebte sich trennen wollte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Als die Geliebte sich trennen wollte>', '"Als die Geliebte sich trennen wollte"', 'song', 'WoO 132', NULL, NULL, 1806, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Als die Geliebte sich trennen wollte>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e089771-213a-38e5-b1f5-e683d94f6555'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e089771-213a-38e5-b1f5-e683d94f6555'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Als die Geliebte sich trennen wollte>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e089771-213a-38e5-b1f5-e683d94f6555'
);


-- WoO 133 가곡 <In questa tomba oscura>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <In questa tomba oscura>', '"In questa tomba oscura"', 'song', 'WoO 133', NULL, NULL, 1807, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <In questa tomba oscura>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a7c6191-a7da-3cbd-a56b-33b4d8c239e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6a7c6191-a7da-3cbd-a56b-33b4d8c239e5'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <In questa tomba oscura>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6a7c6191-a7da-3cbd-a56b-33b4d8c239e5'
);


-- WoO 134 가곡 <Sehnsucht> (네 가지 작곡)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sehnsucht> (네 가지 작곡)', '"Sehnsucht" ("Nur wer die Sehnsucht kennt"), 4 settings, WoO 134', 'album', 'WoO 134', NULL, NULL, 1808, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sehnsucht> (네 가지 작곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d7d510b-b3a0-3e48-acc2-bb8ee5cd02d3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d7d510b-b3a0-3e48-acc2-bb8ee5cd02d3'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Sehnsucht> (네 가지 작곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d7d510b-b3a0-3e48-acc2-bb8ee5cd02d3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7df0333-f8e9-4150-9b4e-1e039b58f864', 1, NULL, '첫째 작곡', '1st setting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Sehnsucht> (네 가지 작곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7df0333-f8e9-4150-9b4e-1e039b58f864'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee3d1c40-a545-4da0-bc08-e6630d61cfab', 2, NULL, '둘째 작곡', '2nd setting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Sehnsucht> (네 가지 작곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee3d1c40-a545-4da0-bc08-e6630d61cfab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:249bda01-7675-4f17-8995-a165c6b46dc6', 3, NULL, '셋째 작곡', '3rd setting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Sehnsucht> (네 가지 작곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:249bda01-7675-4f17-8995-a165c6b46dc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0da241ec-a9db-4343-a027-8b5fce43905f', 4, NULL, '넷째 작곡', '4th setting', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Sehnsucht> (네 가지 작곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0da241ec-a9db-4343-a027-8b5fce43905f'
);


-- WoO 135 가곡 <Die laute Klage>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Die laute Klage>', '"Die laute Klage"', 'song', 'WoO 135', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Die laute Klage>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb2b835f-799d-3a81-9d34-96e9c3088a25'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bb2b835f-799d-3a81-9d34-96e9c3088a25'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Die laute Klage>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bb2b835f-799d-3a81-9d34-96e9c3088a25'
);


-- WoO 136 가곡 <Andenken>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Andenken>', '"Andenken"', 'song', 'WoO 136', NULL, NULL, 1805, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Andenken>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c34ba573-3f96-3dfa-bcc4-e7bb2608ca57'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c34ba573-3f96-3dfa-bcc4-e7bb2608ca57'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Andenken>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c34ba573-3f96-3dfa-bcc4-e7bb2608ca57'
);


-- WoO 137 가곡 <Lied aus der Ferne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lied aus der Ferne>', '"Lied aus der Ferne"', 'song', 'WoO 137', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lied aus der Ferne>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1e60487-f982-33a8-81ad-f2e548d32182'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd1e60487-f982-33a8-81ad-f2e548d32182'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Lied aus der Ferne>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd1e60487-f982-33a8-81ad-f2e548d32182'
);


-- WoO 138 가곡 <Der Jüngling in der Fremde>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Jüngling in der Fremde>', '"Der Jüngling in der Fremde"', 'song', 'WoO 138', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Jüngling in der Fremde>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5b0c541-aed9-307a-8b1c-7a60c3b946e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a5b0c541-aed9-307a-8b1c-7a60c3b946e4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Der Jüngling in der Fremde>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a5b0c541-aed9-307a-8b1c-7a60c3b946e4'
);


-- WoO 139 가곡 <Der Liebende>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Liebende>', '"Der Liebende"', 'song', 'WoO 139', NULL, NULL, 1809, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Liebende>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ac2b61b-c682-3e65-9e25-07c3e7e6ce82'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8ac2b61b-c682-3e65-9e25-07c3e7e6ce82'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Der Liebende>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8ac2b61b-c682-3e65-9e25-07c3e7e6ce82'
);


-- WoO 140 가곡 <An die Geliebte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <An die Geliebte>', '"An die Geliebte"', 'song', 'WoO 140', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <An die Geliebte>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b55673fa-141c-3bda-b566-74fb3051645c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b55673fa-141c-3bda-b566-74fb3051645c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <An die Geliebte>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b55673fa-141c-3bda-b566-74fb3051645c'
);


-- WoO 141 가곡 <Der Gesang der Nachtigall>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Gesang der Nachtigall>', '"Der Gesang der Nachtigall"', 'song', 'WoO 141', NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Gesang der Nachtigall>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff5a6a13-b56c-3483-aae2-ad9eea8e46a2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ff5a6a13-b56c-3483-aae2-ad9eea8e46a2'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Der Gesang der Nachtigall>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ff5a6a13-b56c-3483-aae2-ad9eea8e46a2'
);


-- WoO 142 가곡 <Der Bardengeist>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Bardengeist>', '"Der Bardengeist"', 'song', 'WoO 142', NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Bardengeist>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db37f1a3-5c81-3c2c-bd83-f1e7769de8f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db37f1a3-5c81-3c2c-bd83-f1e7769de8f1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Der Bardengeist>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db37f1a3-5c81-3c2c-bd83-f1e7769de8f1'
);


-- WoO 143 가곡 <Des Kriegers Abschied>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Des Kriegers Abschied>', '"Des Kriegers Abschied"', 'song', 'WoO 143', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Des Kriegers Abschied>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8172d3de-9540-3d06-add8-89ba18c34ba4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8172d3de-9540-3d06-add8-89ba18c34ba4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Des Kriegers Abschied>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8172d3de-9540-3d06-add8-89ba18c34ba4'
);


-- WoO 144 가곡 <Merkenstein>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Merkenstein>', '"Merkenstein"', 'song', 'WoO 144', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Merkenstein>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32d909ba-1841-3a11-ae0a-9d7ace8f07c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32d909ba-1841-3a11-ae0a-9d7ace8f07c0'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Merkenstein>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32d909ba-1841-3a11-ae0a-9d7ace8f07c0'
);


-- WoO 145 가곡 <Das Geheimnis>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Das Geheimnis>', '"Das Geheimnis"', 'song', 'WoO 145', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Das Geheimnis>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ae71f6c-b2ee-3ef4-91aa-c0e8937c3ce1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1ae71f6c-b2ee-3ef4-91aa-c0e8937c3ce1'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Das Geheimnis>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1ae71f6c-b2ee-3ef4-91aa-c0e8937c3ce1'
);


-- WoO 146 가곡 <Sehnsucht>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Sehnsucht>', '"Sehnsucht"', 'song', 'WoO 146', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Sehnsucht>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01837268-7eaf-3c09-b655-1fd55a991e7e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '01837268-7eaf-3c09-b655-1fd55a991e7e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Sehnsucht>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01837268-7eaf-3c09-b655-1fd55a991e7e'
);


-- WoO 147 가곡 <Ruf vom Berge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ruf vom Berge>', '"Ruf vom Berge"', 'song', 'WoO 147', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ruf vom Berge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06a1f61d-f766-3915-b6f2-23d541728ade'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06a1f61d-f766-3915-b6f2-23d541728ade'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Ruf vom Berge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06a1f61d-f766-3915-b6f2-23d541728ade'
);


-- WoO 148 가곡 <So oder so>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <So oder so>', '"So oder so"', 'song', 'WoO 148', NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <So oder so>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2885851-41c3-3dc8-a84c-19006f5ebf95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f2885851-41c3-3dc8-a84c-19006f5ebf95'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <So oder so>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f2885851-41c3-3dc8-a84c-19006f5ebf95'
);


-- WoO 149 가곡 <Resignation>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Resignation>', '"Resignation"', 'song', 'WoO 149', NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Resignation>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c3a28ee-fd3d-3c3c-b18d-660f9b22eedf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c3a28ee-fd3d-3c3c-b18d-660f9b22eedf'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Resignation>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c3a28ee-fd3d-3c3c-b18d-660f9b22eedf'
);


-- WoO 150 가곡 <Abendlied unterm gestirnten Himmel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Abendlied unterm gestirnten Himmel>', '"Abendlied unterm gestirnten Himmel"', 'song', 'WoO 150', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Abendlied unterm gestirnten Himmel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89141e2f-70fa-3973-8097-03b792a62198'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '89141e2f-70fa-3973-8097-03b792a62198'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Abendlied unterm gestirnten Himmel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89141e2f-70fa-3973-8097-03b792a62198'
);


-- WoO 151 가곡 <Der edle Mensch sei hülfreich und gut>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der edle Mensch sei hülfreich und gut>', '"Der edle Mensch sei hülfreich und gut"', 'song', 'WoO 151', NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der edle Mensch sei hülfreich und gut>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13b73cb8-27b6-31e8-9619-3ba0529b5326'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '13b73cb8-27b6-31e8-9619-3ba0529b5326'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '가곡 <Der edle Mensch sei hülfreich und gut>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '13b73cb8-27b6-31e8-9619-3ba0529b5326'
);


-- WoO 159 카논 <Im Arm der Liebe ruht sich's wohl>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Im Arm der Liebe ruht sich''s wohl>', 'Canon "Im Arm der Liebe ruht sich''s wohl"', 'song', 'WoO 159', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Im Arm der Liebe ruht sich''s wohl>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae41a96f-8fe8-353f-a3a8-77a09a746f85'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae41a96f-8fe8-353f-a3a8-77a09a746f85'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Im Arm der Liebe ruht sich''s wohl>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae41a96f-8fe8-353f-a3a8-77a09a746f85'
);


-- WoO 160 카논 WoO 160

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 WoO 160', '2 Canons, WoO 160', 'album', NULL, 'WoO', '160', 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 WoO 160'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b8deca5-f1fe-394a-8798-88f37d43ec67', 1, NULL, 'O care selve', 'O care selve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 WoO 160' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b8deca5-f1fe-394a-8798-88f37d43ec67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07c73725-356e-39cc-b94d-3b8b60700a79', 2, NULL, 'C장조', 'Canon in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 WoO 160' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07c73725-356e-39cc-b94d-3b8b60700a79'
);


-- WoO 161 카논 <Ewig dein>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Ewig dein>', 'Canon "Ewig dein"', 'song', 'WoO 161', NULL, NULL, 1811, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Ewig dein>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f335c51-4864-3edf-824f-59b44e582d08'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7f335c51-4864-3edf-824f-59b44e582d08'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Ewig dein>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7f335c51-4864-3edf-824f-59b44e582d08'
);


-- WoO 163 카논 <Kurz ist der Schmerz> F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Kurz ist der Schmerz> F단조', 'Canon "Kurz ist der Schmerz" in F minor', 'song', 'WoO 163', NULL, NULL, 1813, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Kurz ist der Schmerz> F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '747fab5d-42dc-3f59-9cf4-8dfd055e3920'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '747fab5d-42dc-3f59-9cf4-8dfd055e3920'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Kurz ist der Schmerz> F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '747fab5d-42dc-3f59-9cf4-8dfd055e3920'
);


-- WoO 164 카논 <Freundschaft ist die Quelle wahrer Glückseligkeit>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Freundschaft ist die Quelle wahrer Glückseligkeit>', 'Canon "Freundschaft ist die Quelle wahrer Glückseligkeit"', 'song', 'WoO 164', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Freundschaft ist die Quelle wahrer Glückseligkeit>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c377a2c-4f8a-3bf2-b1e7-63773ea66020'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5c377a2c-4f8a-3bf2-b1e7-63773ea66020'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Freundschaft ist die Quelle wahrer Glückseligkeit>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5c377a2c-4f8a-3bf2-b1e7-63773ea66020'
);


-- WoO 165 카논 <Glück zum neuen Jahr!> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Glück zum neuen Jahr!> E♭장조', 'Canon "Glück zum neuen Jahr!" in E♭ major', 'song', 'WoO 165', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Glück zum neuen Jahr!> E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '524ac318-839a-3847-bffe-8a396cda49c8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '524ac318-839a-3847-bffe-8a396cda49c8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Glück zum neuen Jahr!> E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '524ac318-839a-3847-bffe-8a396cda49c8'
);


-- WoO 166 카논 <Kurz ist der Schmerz> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Kurz ist der Schmerz> F장조', 'Canon "Kurz ist der Schmerz" in F major', 'song', 'WoO 166', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Kurz ist der Schmerz> F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3db08af3-402d-3bae-908a-8af382bf48c5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3db08af3-402d-3bae-908a-8af382bf48c5'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Kurz ist der Schmerz> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3db08af3-402d-3bae-908a-8af382bf48c5'
);


-- WoO 167 카논 <Brauchle, Linke>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Brauchle, Linke>', 'Canon "Brauchle, Linke"', 'song', 'WoO 167', NULL, NULL, 1815, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Brauchle, Linke>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99f6f461-0484-3f0e-bc4f-aadb5a278417'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '99f6f461-0484-3f0e-bc4f-aadb5a278417'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Brauchle, Linke>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '99f6f461-0484-3f0e-bc4f-aadb5a278417'
);


-- WoO 168 수수께끼 카논 WoO 168

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '수수께끼 카논 WoO 168', '2 Riddle Canons, WoO 168', 'album', NULL, 'WoO', '168', 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '수수께끼 카논 WoO 168'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5ecc0b1-4fba-3fb6-831f-e6e0bf5b37c9', 1, NULL, 'Das Schweigen (Lerne schweigen, o Freund)', 'Das Schweigen (Lerne schweigen, o Freund)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '수수께끼 카논 WoO 168' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5ecc0b1-4fba-3fb6-831f-e6e0bf5b37c9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af2a1bd3-ea80-3227-9d00-bb54e71f2037', 2, NULL, 'Das Reden (Rede, rede)', 'Das Reden (Rede, rede)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '수수께끼 카논 WoO 168' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af2a1bd3-ea80-3227-9d00-bb54e71f2037'
);


-- WoO 169 카논 <Ich küsse Sie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Ich küsse Sie>', 'Canon "Ich küsse Sie"', 'song', 'WoO 169', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Ich küsse Sie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a68c2b24-6cf0-3037-9c94-4cb9238357af'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a68c2b24-6cf0-3037-9c94-4cb9238357af'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Ich küsse Sie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a68c2b24-6cf0-3037-9c94-4cb9238357af'
);


-- WoO 170 카논 <Ars longa, vita brevis> C장조 (1816)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Ars longa, vita brevis> C장조 (1816)', 'Canon "Ars longa, vita brevis" in C major (1816)', 'song', 'WoO 170', NULL, NULL, 1816, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Ars longa, vita brevis> C장조 (1816)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78015f12-4005-3ab3-8629-e7493fe19009'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '78015f12-4005-3ab3-8629-e7493fe19009'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Ars longa, vita brevis> C장조 (1816)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '78015f12-4005-3ab3-8629-e7493fe19009'
);


-- WoO 171 카논 <Glück fehl' dir vor allem>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Glück fehl'' dir vor allem>', 'Canon "Glück fehl'' dir vor allem"', 'song', 'WoO 171', NULL, NULL, 1817, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Glück fehl'' dir vor allem>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8a02c6e-c340-35c5-b15f-194003b43180'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8a02c6e-c340-35c5-b15f-194003b43180'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Glück fehl'' dir vor allem>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8a02c6e-c340-35c5-b15f-194003b43180'
);


-- WoO 172 카논 <Ich bitt' dich, schreib' mir die Es-Scala auf>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Ich bitt'' dich, schreib'' mir die Es-Scala auf>', 'Canon "Ich bitt'' dich, schreib'' mir die Es-Scala auf"', 'song', 'WoO 172', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Ich bitt'' dich, schreib'' mir die Es-Scala auf>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0efad4b2-42ed-3acd-b0c6-eb962e5b98bc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0efad4b2-42ed-3acd-b0c6-eb962e5b98bc'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Ich bitt'' dich, schreib'' mir die Es-Scala auf>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0efad4b2-42ed-3acd-b0c6-eb962e5b98bc'
);


-- WoO 173 카논 <Hol' euch der Teufel! B'hüt' euch Gott!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Hol'' euch der Teufel! B''hüt'' euch Gott!>', 'Canon "Hol'' euch der Teufel! B''hüt'' euch Gott!"', 'song', 'WoO 173', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Hol'' euch der Teufel! B''hüt'' euch Gott!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07b4d79d-bb3e-3780-ac06-a92aabf2c038'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07b4d79d-bb3e-3780-ac06-a92aabf2c038'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Hol'' euch der Teufel! B''hüt'' euch Gott!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07b4d79d-bb3e-3780-ac06-a92aabf2c038'
);


-- WoO 174 카논 <Glaube und hoffe!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Glaube und hoffe!>', 'Canon "Glaube und hoffe!"', 'song', 'WoO 174', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Glaube und hoffe!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8265073-4720-3a7e-a16a-d3f41ec1b6c7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c8265073-4720-3a7e-a16a-d3f41ec1b6c7'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Glaube und hoffe!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8265073-4720-3a7e-a16a-d3f41ec1b6c7'
);


-- WoO 175 카논 <Sankt Petrus war ein Fels>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Sankt Petrus war ein Fels>', 'Canon "Sankt Petrus war ein Fels"', 'song', 'WoO 175', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Sankt Petrus war ein Fels>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1547a3b-9792-3a06-a7a2-b4dbdcdf4766'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f1547a3b-9792-3a06-a7a2-b4dbdcdf4766'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Sankt Petrus war ein Fels>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f1547a3b-9792-3a06-a7a2-b4dbdcdf4766'
);


-- WoO 176 카논 <Glück zum neuen Jahr!> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Glück zum neuen Jahr!> F장조', 'Canon "Glück zum neuen Jahr!" in F major', 'song', 'WoO 176', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Glück zum neuen Jahr!> F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8845169c-79be-33ea-b805-5727a6f42085'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8845169c-79be-33ea-b805-5727a6f42085'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Glück zum neuen Jahr!> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8845169c-79be-33ea-b805-5727a6f42085'
);


-- WoO 177 카논 <Bester Magistrat, Ihr friert>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Bester Magistrat, Ihr friert>', 'Canon "Bester Magistrat, Ihr friert"', 'song', 'WoO 177', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Bester Magistrat, Ihr friert>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb8bb97f-a07c-3aeb-adf4-6683ce6f2002'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb8bb97f-a07c-3aeb-adf4-6683ce6f2002'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Bester Magistrat, Ihr friert>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb8bb97f-a07c-3aeb-adf4-6683ce6f2002'
);


-- WoO 178 카논 <Signor Abate!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Signor Abate!>', 'Canon "Signor Abate!"', 'song', 'WoO 178', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Signor Abate!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95ac0739-34b8-3fb1-8ca0-e40f4972a430'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '95ac0739-34b8-3fb1-8ca0-e40f4972a430'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Signor Abate!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95ac0739-34b8-3fb1-8ca0-e40f4972a430'
);


-- WoO 179 카논 <Alles Gute! alles Schöne!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Alles Gute! alles Schöne!>', 'Canon "Alles Gute! alles Schöne!"', 'song', 'WoO 179', NULL, NULL, 1819, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Alles Gute! alles Schöne!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64226778-41b8-35ca-a6cf-bc4b6d4e86c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64226778-41b8-35ca-a6cf-bc4b6d4e86c6'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Alles Gute! alles Schöne!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64226778-41b8-35ca-a6cf-bc4b6d4e86c6'
);


-- WoO 180 카논 <Hoffmann, sei ja kein Hofmann>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Hoffmann, sei ja kein Hofmann>', 'Canon "Hoffmann, sei ja kein Hofmann"', 'song', 'WoO 180', NULL, NULL, 1820, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Hoffmann, sei ja kein Hofmann>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24ea141e-8715-3aa2-bd61-0120e47ef56f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24ea141e-8715-3aa2-bd61-0120e47ef56f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Hoffmann, sei ja kein Hofmann>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24ea141e-8715-3aa2-bd61-0120e47ef56f'
);


-- WoO 181 카논 WoO 181

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 WoO 181', '3 Canons, WoO 181', 'album', NULL, 'WoO', '181', 1820, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 WoO 181'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2832cbcc-f9ba-3774-be76-cfbdebee9e24', 1, NULL, 'Gedenket heute an Baden', 'Gedenket heute an Baden', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 WoO 181' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2832cbcc-f9ba-3774-be76-cfbdebee9e24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:078f8b52-51ea-3ee4-ae56-8e1ac83e47eb', 2, NULL, 'Gehabt euch wohl', 'Gehabt euch wohl', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 WoO 181' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:078f8b52-51ea-3ee4-ae56-8e1ac83e47eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d565b168-d1a2-3bb6-b540-29edd4f7794a', 3, NULL, 'Tugend ist kein leerer Name', 'Tugend ist kein leerer Name', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 WoO 181' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d565b168-d1a2-3bb6-b540-29edd4f7794a'
);


-- WoO 182 카논 <O Tobias!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <O Tobias!>', 'Canon "O Tobias!"', 'song', 'WoO 182', NULL, NULL, 1821, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <O Tobias!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24a49599-3972-3af8-8b70-ab2cbd8ff3a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24a49599-3972-3af8-8b70-ab2cbd8ff3a8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <O Tobias!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24a49599-3972-3af8-8b70-ab2cbd8ff3a8'
);


-- WoO 183 카논 <Bester Herr Graf, Sie sind ein Schaf!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Bester Herr Graf, Sie sind ein Schaf!>', 'Canon "Bester Herr Graf, Sie sind ein Schaf!"', 'song', 'WoO 183', NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Bester Herr Graf, Sie sind ein Schaf!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9153cd43-e580-34a7-ad78-338b0183319f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9153cd43-e580-34a7-ad78-338b0183319f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Bester Herr Graf, Sie sind ein Schaf!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9153cd43-e580-34a7-ad78-338b0183319f'
);


-- WoO 184 카논 <Falstafferel, lass' dich sehen!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Falstafferel, lass'' dich sehen!>', 'Canon "Falstafferel, lass'' dich sehen!"', 'song', 'WoO 184', NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Falstafferel, lass'' dich sehen!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3f9a66f-fc9a-3dfb-b7e9-656fef3a0b42'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3f9a66f-fc9a-3dfb-b7e9-656fef3a0b42'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Falstafferel, lass'' dich sehen!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3f9a66f-fc9a-3dfb-b7e9-656fef3a0b42'
);


-- WoO 185 카논 <Edel sei der Mensch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Edel sei der Mensch>', 'Canon "Edel sei der Mensch"', 'song', 'WoO 185', NULL, NULL, 1823, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Edel sei der Mensch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f9e9f81-4d8d-43ff-ba64-82471ec13f9a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3f9e9f81-4d8d-43ff-ba64-82471ec13f9a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Edel sei der Mensch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3f9e9f81-4d8d-43ff-ba64-82471ec13f9a'
);


-- WoO 186 카논 <Te solo adoro>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Te solo adoro>', 'Canon "Te solo adoro"', 'song', 'WoO 186', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Te solo adoro>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20044d74-21cd-3322-92c1-615cb092be53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '20044d74-21cd-3322-92c1-615cb092be53'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Te solo adoro>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '20044d74-21cd-3322-92c1-615cb092be53'
);


-- WoO 187 카논 <Schwenke dich ohne Schwänke!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Schwenke dich ohne Schwänke!>', 'Canon "Schwenke dich ohne Schwänke!"', 'song', 'WoO 187', NULL, NULL, 1824, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Schwenke dich ohne Schwänke!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af71bea6-0174-3596-a4ff-b9fbe3a82b86'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af71bea6-0174-3596-a4ff-b9fbe3a82b86'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Schwenke dich ohne Schwänke!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af71bea6-0174-3596-a4ff-b9fbe3a82b86'
);


-- WoO 188 카논 <Gott ist eine feste Burg>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Gott ist eine feste Burg>', 'Canon "Gott ist eine feste Burg"', 'song', 'WoO 188', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Gott ist eine feste Burg>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19d0dbd4-7af7-3e32-9f1f-67f3f0064dd2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '19d0dbd4-7af7-3e32-9f1f-67f3f0064dd2'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Gott ist eine feste Burg>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '19d0dbd4-7af7-3e32-9f1f-67f3f0064dd2'
);


-- WoO 189 카논 <Doktor, sperrt das Tor dem Tod>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Doktor, sperrt das Tor dem Tod>', 'Canon "Doktor, sperrt das Tor dem Tod"', 'song', 'WoO 189', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Doktor, sperrt das Tor dem Tod>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f1d903e-476d-38b0-9b12-ff7018ff72e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f1d903e-476d-38b0-9b12-ff7018ff72e9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Doktor, sperrt das Tor dem Tod>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f1d903e-476d-38b0-9b12-ff7018ff72e9'
);


-- WoO 190 카논 <Ich war hier, Doktor, ich war hier>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Ich war hier, Doktor, ich war hier>', 'Canon "Ich war hier, Doktor, ich war hier"', 'song', 'WoO 190', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Ich war hier, Doktor, ich war hier>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bfb19f14-6103-3433-aaf4-10012fd1eaa8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bfb19f14-6103-3433-aaf4-10012fd1eaa8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Ich war hier, Doktor, ich war hier>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bfb19f14-6103-3433-aaf4-10012fd1eaa8'
);


-- WoO 191 카논 <Kühl, nicht lau>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Kühl, nicht lau>', 'Canon "Kühl, nicht lau"', 'song', 'WoO 191', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Kühl, nicht lau>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50774055-9f91-3618-b4e6-42cbb0ce6493'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '50774055-9f91-3618-b4e6-42cbb0ce6493'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Kühl, nicht lau>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '50774055-9f91-3618-b4e6-42cbb0ce6493'
);


-- WoO 192 카논 <Ars longa, vita brevis> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Ars longa, vita brevis> F장조', 'Canon "Ars longa, vita brevis" in F major', 'song', 'WoO 192', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Ars longa, vita brevis> F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9205ade1-1fbf-330e-b44c-378a03932bf4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9205ade1-1fbf-330e-b44c-378a03932bf4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Ars longa, vita brevis> F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9205ade1-1fbf-330e-b44c-378a03932bf4'
);


-- WoO 193 카논 <Ars longa, vita brevis> C장조 (1825)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Ars longa, vita brevis> C장조 (1825)', 'Canon "Ars longa, vita brevis" in C major (1825)', 'song', 'WoO 193', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Ars longa, vita brevis> C장조 (1825)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06e853f1-450a-3eb4-9272-73f5a30d0d41'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '06e853f1-450a-3eb4-9272-73f5a30d0d41'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Ars longa, vita brevis> C장조 (1825)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '06e853f1-450a-3eb4-9272-73f5a30d0d41'
);


-- WoO 194 카논 <Si non per portas, per muros>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Si non per portas, per muros>', 'Canon "Si non per portas, per muros"', 'song', 'WoO 194', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Si non per portas, per muros>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae98768d-bf0f-32b5-b0d8-8f5ad039bae8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ae98768d-bf0f-32b5-b0d8-8f5ad039bae8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Si non per portas, per muros>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ae98768d-bf0f-32b5-b0d8-8f5ad039bae8'
);


-- WoO 195 카논 <Freu' dich des Lebens!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Freu'' dich des Lebens!>', 'Canon "Freu'' dich des Lebens!"', 'song', 'WoO 195', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Freu'' dich des Lebens!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8dd68f98-7f65-3afe-b561-6166f4139e67'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8dd68f98-7f65-3afe-b561-6166f4139e67'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Freu'' dich des Lebens!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8dd68f98-7f65-3afe-b561-6166f4139e67'
);


-- WoO 196 카논 <Es muss sein!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Es muss sein!>', 'Canon "Es muss sein!"', 'song', 'WoO 196', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Es muss sein!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e3e9a6b-c02b-36cb-8744-86d196d447e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9e3e9a6b-c02b-36cb-8744-86d196d447e9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Es muss sein!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9e3e9a6b-c02b-36cb-8744-86d196d447e9'
);


-- WoO 197 카논 <Da ist das Werk>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Da ist das Werk>', 'Canon "Da ist das Werk"', 'song', 'WoO 197', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Da ist das Werk>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a62bfdc7-bbb2-3b72-8ab5-04c84c45c4ed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a62bfdc7-bbb2-3b72-8ab5-04c84c45c4ed'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Da ist das Werk>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a62bfdc7-bbb2-3b72-8ab5-04c84c45c4ed'
);


-- WoO 198 카논 <Wir irren allesamt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Wir irren allesamt>', 'Canon "Wir irren allesamt"', 'song', 'WoO 198', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Wir irren allesamt>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb45d291-5410-36c9-a6c7-b94700c645ac'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb45d291-5410-36c9-a6c7-b94700c645ac'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Wir irren allesamt>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb45d291-5410-36c9-a6c7-b94700c645ac'
);


-- WoO 199 음악적 농담 <Ich bin der Herr von zu>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악적 농담 <Ich bin der Herr von zu>', 'Musical joke "Ich bin der Herr von zu"', 'song', 'WoO 199', NULL, NULL, 1814, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악적 농담 <Ich bin der Herr von zu>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45f49537-3df2-4230-ad7f-72c2d9393f13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '45f49537-3df2-4230-ad7f-72c2d9393f13'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 농담 <Ich bin der Herr von zu>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '45f49537-3df2-4230-ad7f-72c2d9393f13'
);


-- WoO 200 루돌프 대공의 변주곡을 위한 주제 "O Hoffnung" G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '루돌프 대공의 변주곡을 위한 주제 "O Hoffnung" G장조', 'Theme for variations by Archduke Rudolph "O Hoffnung" in G major', 'song', 'WoO 200', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '루돌프 대공의 변주곡을 위한 주제 "O Hoffnung" G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2a06986-a2d4-4f24-bc33-9fbf22c7a0df'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2a06986-a2d4-4f24-bc33-9fbf22c7a0df'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '루돌프 대공의 변주곡을 위한 주제 "O Hoffnung" G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2a06986-a2d4-4f24-bc33-9fbf22c7a0df'
);


-- WoO 201 음악적 농담 <Ich bin bereit! Amen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악적 농담 <Ich bin bereit! Amen>', 'Musical joke "Ich bin bereit! Amen"', 'song', 'WoO 201', NULL, NULL, 1818, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악적 농담 <Ich bin bereit! Amen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b449e1f8-7bfa-4b20-b5fa-13c7f0b3ea19'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b449e1f8-7bfa-4b20-b5fa-13c7f0b3ea19'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 농담 <Ich bin bereit! Amen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b449e1f8-7bfa-4b20-b5fa-13c7f0b3ea19'
);


-- WoO 203 수수께끼 카논 <Das Schöne zu dem Guten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '수수께끼 카논 <Das Schöne zu dem Guten>', 'Riddle canon "Das Schöne zu dem Guten"', 'song', 'WoO 203', NULL, NULL, 1825, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '수수께끼 카논 <Das Schöne zu dem Guten>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44e65dea-6f28-380a-84d3-a0d8d3e2c530'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44e65dea-6f28-380a-84d3-a0d8d3e2c530'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '수수께끼 카논 <Das Schöne zu dem Guten>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44e65dea-6f28-380a-84d3-a0d8d3e2c530'
);


-- WoO 205 음악적 인사 WoO 205

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악적 인사 WoO 205', '10 Musical Quips, WoO 205', 'album', NULL, 'WoO', '205', NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악적 인사 WoO 205'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '530e427e-a86d-44f7-96e5-d9d821e6be37'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '530e427e-a86d-44f7-96e5-d9d821e6be37'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '530e427e-a86d-44f7-96e5-d9d821e6be37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e963383d-64ce-4947-bc1f-9a337ccc1417', 1, NULL, 'Baron, Baron, Baron', 'Baron, Baron, Baron', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e963383d-64ce-4947-bc1f-9a337ccc1417'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0bbefce4-1d57-462c-8e12-4de3ec1c3743', 2, NULL, 'Allein, allein, allein, jedoch Silentium', 'Allein, allein, allein, jedoch Silentium', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0bbefce4-1d57-462c-8e12-4de3ec1c3743'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ba05139-6c33-47d7-a320-d04c631b03bb', 3, NULL, 'O Adjutant', 'O Adjutant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ba05139-6c33-47d7-a320-d04c631b03bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa21d015-214e-4291-b8c3-7acac61372d1', 4, NULL, 'Wo? Wo?', 'Wo? Wo?', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa21d015-214e-4291-b8c3-7acac61372d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a8e02b8-1217-4980-a6ee-4b5bc56c3fd8', 5, NULL, 'Erfüllung, Erfüllung', 'Erfüllung, Erfüllung', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a8e02b8-1217-4980-a6ee-4b5bc56c3fd8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3731750f-3f75-4af2-877c-de435d439f4f', 6, NULL, 'Scheut euch nicht', 'Scheut euch nicht', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3731750f-3f75-4af2-877c-de435d439f4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd931357-97b6-4377-a87b-ef6106447157', 7, NULL, 'Tobias paternostergässler', 'Tobias paternostergässler', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd931357-97b6-4377-a87b-ef6106447157'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0915ac46-016a-4ae4-b3dc-2908aad40002', 8, NULL, 'Tobias, Tobias', 'Tobias, Tobias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0915ac46-016a-4ae4-b3dc-2908aad40002'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ad76f5c-c908-44d2-b95e-d99174d3c33c', 9, NULL, 'Bester Tobias', 'Bester Tobias', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ad76f5c-c908-44d2-b95e-d99174d3c33c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:261ecac4-dcf0-4d37-bc28-cd42ec8ef6e9', 10, NULL, 'Erster aller Tobiasse', 'Erster aller Tobiasse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 인사 WoO 205' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:261ecac4-dcf0-4d37-bc28-cd42ec8ef6e9'
);


-- WoO 209 현악 4중주를 위한 미뉴에트 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 미뉴에트 A♭장조', 'Minuet for String Quartet in A♭ major', 'song', 'WoO 209', NULL, NULL, 1792, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 미뉴에트 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc801244-d267-30a1-84e7-8d9a8c824eba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc801244-d267-30a1-84e7-8d9a8c824eba'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주를 위한 미뉴에트 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc801244-d267-30a1-84e7-8d9a8c824eba'
);


-- WoO 210 현악 4중주를 위한 알레그레토 B단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 알레그레토 B단조', 'Allegretto for String Quartet in B minor', 'song', 'WoO 210', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 알레그레토 B단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bbd6aa0-4611-4c95-bb17-bc2f7571d1c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7bbd6aa0-4611-4c95-bb17-bc2f7571d1c0'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주를 위한 알레그레토 B단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7bbd6aa0-4611-4c95-bb17-bc2f7571d1c0'
);


-- WoO 211 안단테 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '안단테 C장조', 'Andante in C major', 'song', 'WoO 211', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '안단테 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0ce1af5-54eb-47ad-82fe-23c6c1e26033'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd0ce1af5-54eb-47ad-82fe-23c6c1e26033'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '안단테 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd0ce1af5-54eb-47ad-82fe-23c6c1e26033'
);


-- WoO 212 앙글레즈 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앙글레즈 D장조', 'Anglaise in D major', 'song', 'WoO 212', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앙글레즈 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd35d9984-45fc-38ab-8b67-91b33ad906a4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd35d9984-45fc-38ab-8b67-91b33ad906a4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '앙글레즈 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd35d9984-45fc-38ab-8b67-91b33ad906a4'
);


-- WoO 213a 바가텔 D♭장조 "Andante"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 D♭장조 "Andante"', 'Bagatelle in D♭ major "Andante"', 'song', 'WoO 213a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 D♭장조 "Andante"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1d8feda-c761-4be0-8458-6fe2458ec9c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1d8feda-c761-4be0-8458-6fe2458ec9c0'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 D♭장조 "Andante"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1d8feda-c761-4be0-8458-6fe2458ec9c0'
);


-- WoO 213b 바가텔 G장조 "Finale"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 G장조 "Finale"', 'Bagatelle in G major "Finale"', 'song', 'WoO 213b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 G장조 "Finale"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f18cd72b-3a8c-4e34-a7be-e54ae6646539'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f18cd72b-3a8c-4e34-a7be-e54ae6646539'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 G장조 "Finale"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f18cd72b-3a8c-4e34-a7be-e54ae6646539'
);


-- WoO 213c 바가텔 A장조 "Allegro"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 A장조 "Allegro"', 'Bagatelle in A major "Allegro"', 'song', 'WoO 213c', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 A장조 "Allegro"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d21baa9-be1e-4114-896d-7311ce550f0d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9d21baa9-be1e-4114-896d-7311ce550f0d'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 A장조 "Allegro"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9d21baa9-be1e-4114-896d-7311ce550f0d'
);


-- WoO 213d 바가텔 A장조 "Rondo"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 A장조 "Rondo"', 'Bagatelle in A major "Rondo"', 'song', 'WoO 213d', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 A장조 "Rondo"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59c8ac44-10cb-48ea-bc63-41c530760c2e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '59c8ac44-10cb-48ea-bc63-41c530760c2e'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 A장조 "Rondo"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '59c8ac44-10cb-48ea-bc63-41c530760c2e'
);


-- WoO 214 바가텔 C단조 "Allegretto" (1795–96)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 C단조 "Allegretto" (1795–96)', 'Bagatelle in C minor "Allegretto" (1795–96)', 'song', 'WoO 214', NULL, NULL, 1822, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 C단조 "Allegretto" (1795–96)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5458109-b7f3-30a6-8431-d634325ef274'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5458109-b7f3-30a6-8431-d634325ef274'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 C단조 "Allegretto" (1795–96)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5458109-b7f3-30a6-8431-d634325ef274'
);


-- WoO 215 푸가 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '푸가 C장조', 'Fugue in C major', 'song', 'WoO 215', NULL, NULL, 1795, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '푸가 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c6240dc-2bc8-3c41-a2c9-8d1d412b8940'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c6240dc-2bc8-3c41-a2c9-8d1d412b8940'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '푸가 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c6240dc-2bc8-3c41-a2c9-8d1d412b8940'
);


-- WoO 216a 바가텔 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 C장조', 'Bagatelle in C major', 'song', 'WoO 216a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '917d3de1-e58b-48f0-aa36-cbd4c28bf71a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '917d3de1-e58b-48f0-aa36-cbd4c28bf71a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '917d3de1-e58b-48f0-aa36-cbd4c28bf71a'
);


-- WoO 216b 바가텔 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바가텔 E♭장조', 'Bagatelle in E♭ major', 'song', 'WoO 216b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바가텔 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1345d722-c7dc-49cb-b55b-be0877cfaae5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1345d722-c7dc-49cb-b55b-be0877cfaae5'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '바가텔 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1345d722-c7dc-49cb-b55b-be0877cfaae5'
);


-- WoO 217 미뉴에트 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 F장조', 'Minuet in F major', 'song', 'WoO 217', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2bba849-1571-4b78-815f-d054ef30113a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b2bba849-1571-4b78-815f-d054ef30113a'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b2bba849-1571-4b78-815f-d054ef30113a'
);


-- WoO 218 미뉴에트 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 C장조', 'Minuet in C major', 'song', 'WoO 218', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f80ca6cd-bb62-45b9-9b0a-c45c5033a8a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f80ca6cd-bb62-45b9-9b0a-c45c5033a8a9'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '미뉴에트 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f80ca6cd-bb62-45b9-9b0a-c45c5033a8a9'
);


-- WoO 219 렌틀러 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '렌틀러 C단조', 'Ländler in C minor', 'song', 'WoO 219', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '렌틀러 C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61f7cb6b-675e-4917-8a67-f1d10eafffb4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '61f7cb6b-675e-4917-8a67-f1d10eafffb4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '렌틀러 C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '61f7cb6b-675e-4917-8a67-f1d10eafffb4'
);


-- WoO 221 카논 <Herr Graf, ich komme zu fragen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Herr Graf, ich komme zu fragen>', 'Canon "Herr Graf, ich komme zu fragen"', 'song', 'WoO 221', NULL, NULL, 1797, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Herr Graf, ich komme zu fragen>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '423d5f7b-dc44-36f6-a2e0-551b4ea44691'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '423d5f7b-dc44-36f6-a2e0-551b4ea44691'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Herr Graf, ich komme zu fragen>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '423d5f7b-dc44-36f6-a2e0-551b4ea44691'
);


-- WoO 222 카논 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 A♭장조', 'Canon in A♭ major', 'song', 'WoO 222', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 A♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88fc9b69-ad15-3068-bf85-cadffdd1afba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88fc9b69-ad15-3068-bf85-cadffdd1afba'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 A♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88fc9b69-ad15-3068-bf85-cadffdd1afba'
);


-- WoO 223 카논 <Thut auf>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Thut auf>', 'Canon "Thut auf"', 'song', 'WoO 223', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Thut auf>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '553d39ef-3259-4126-8c76-abbab141247f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '553d39ef-3259-4126-8c76-abbab141247f'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Thut auf>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '553d39ef-3259-4126-8c76-abbab141247f'
);


-- WoO 224 카논 <Cacatum non est pictum>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Cacatum non est pictum>', 'Canon "Cacatum non est pictum"', 'song', 'WoO 224', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Cacatum non est pictum>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '771721b8-4521-4844-86d0-8747b72f44d7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '771721b8-4521-4844-86d0-8747b72f44d7'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Cacatum non est pictum>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '771721b8-4521-4844-86d0-8747b72f44d7'
);


-- WoO 225 카논 <Grossen Dank für solche Gnade>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Grossen Dank für solche Gnade>', 'Canon "Grossen Dank für solche Gnade"', 'song', 'WoO 225', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Grossen Dank für solche Gnade>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7726bbc1-6549-4993-b65e-5ab4d319127c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7726bbc1-6549-4993-b65e-5ab4d319127c'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 <Grossen Dank für solche Gnade>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7726bbc1-6549-4993-b65e-5ab4d319127c'
);


-- WoO 226 카논 <Fettlümerl und Bankert haben triumphirt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 <Fettlümerl und Bankert haben triumphirt>', 'Canon "Fettlümerl und Bankert haben triumphirt"', 'song', 'WoO 226', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 <Fettlümerl und Bankert haben triumphirt>'
);


-- WoO 227 음악적 농담 <Esel aller Esel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악적 농담 <Esel aller Esel>', 'Musical joke "Esel aller Esel"', 'song', 'WoO 227', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악적 농담 <Esel aller Esel>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb60048c-0bdd-3c1f-83d1-0157216bc626'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb60048c-0bdd-3c1f-83d1-0157216bc626'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '음악적 농담 <Esel aller Esel>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb60048c-0bdd-3c1f-83d1-0157216bc626'
);


-- WoO 228a 음악적 농담 <Ah, Tobias>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악적 농담 <Ah, Tobias>', 'Musical joke "Ah, Tobias"', 'song', 'WoO 228a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악적 농담 <Ah, Tobias>'
);


-- WoO 228b 음악적 농담 <Tobias>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악적 농담 <Tobias>', 'Musical joke "Tobias"', 'song', 'WoO 228b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악적 농담 <Tobias>'
);


-- Hess 34 현악 4중주 F장조 (피아노 소나타 9번 편곡)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주 F장조 (피아노 소나타 9번 편곡)', 'String Quartet in F major (after Piano Sonata No. 9)', 'album', 'Hess 34', NULL, NULL, 1802, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주 F장조 (피아노 소나타 9번 편곡)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79242f41-ae90-4af1-9639-d06f119911b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '79242f41-ae90-4af1-9639-d06f119911b8'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 F장조 (피아노 소나타 9번 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '79242f41-ae90-4af1-9639-d06f119911b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:696ae146-08eb-3a90-af07-8d0e6cefa718', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 F장조 (피아노 소나타 9번 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:696ae146-08eb-3a90-af07-8d0e6cefa718'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7600e041-33d7-3d94-9d79-2a5d61c2d97e', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 F장조 (피아노 소나타 9번 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7600e041-33d7-3d94-9d79-2a5d61c2d97e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b22a680-68aa-3222-ba19-7de9d5816ff9', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '현악 4중주 F장조 (피아노 소나타 9번 편곡)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b22a680-68aa-3222-ba19-7de9d5816ff9'
);


-- Hess 229 수수께끼 카논 <Languisco e moro>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '수수께끼 카논 <Languisco e moro>', 'Riddle canon "Languisco e moro"', 'song', 'Hess 229', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '수수께끼 카논 <Languisco e moro>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1502910a-e092-3a1d-b064-717c3fd20374'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1502910a-e092-3a1d-b064-717c3fd20374'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '수수께끼 카논 <Languisco e moro>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1502910a-e092-3a1d-b064-717c3fd20374'
);


-- Hess 274 카논 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카논 G장조', 'Canon in G major', 'song', 'Hess 274', NULL, NULL, 1803, 'manual', 1
FROM composers c
WHERE c.id = 15
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카논 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac468219-0ee6-3baf-a147-1310121e03e4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac468219-0ee6-3baf-a147-1310121e03e4'
FROM pieces p
WHERE p.composer_id = 15 AND p.title = '카논 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac468219-0ee6-3baf-a147-1310121e03e4'
);

