-- J.C. 바흐 작품을 출판 단위로 채운다(카탈로그: 워버턴 W). 작품 184개(묶음 22, 다악장 25, 낱곡 137),
-- 새 작품 183개, 기존 작품 1개, part 189개, 그 아래 149개, 기존 낱곡 연결 1개.
--
-- 정한 것
--   같은 Op. 로 함께 출판된 세트는 묶음(Op. 번호가 출판사마다 겹치면 갈래별로 나눈다). 107 은 Op. 18 신포니아 2번 part 로 잇는다.
--   108 의 작품번호는 MBID·편성이 W.C 43 이라 맨 끝에서 W.C 34 → W.C 43 으로 고친다. 위작 109 는 그대로 둔다. 킹스 극장 파스티초 서곡·아리아는 뺀다.
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

-- Op. 1 건반 협주곡 Op. 1

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 협주곡 Op. 1', '6 Keyboard Concertos, Op. 1', 'album', NULL, 'Op.', '1', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 협주곡 Op. 1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op1:1', 1, NULL, '건반 협주곡 B♭장조', 'No. 1: Keyboard Concerto in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op1:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op1:2', 2, NULL, '건반 협주곡 A장조', 'No. 2: Keyboard Concerto in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op1:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op1:3', 3, NULL, '건반 협주곡 F장조', 'No. 3: Keyboard Concerto in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op1:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op1:4', 4, NULL, '건반 협주곡 G장조', 'No. 4: Keyboard Concerto in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op1:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op1:5', 5, NULL, '건반 협주곡 C장조', 'No. 5: Keyboard Concerto in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op1:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:591d920d-adeb-4b65-8d8e-130e073ffb49', 6, NULL, '건반 협주곡 D장조', 'No. 6: Keyboard Concerto in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:591d920d-adeb-4b65-8d8e-130e073ffb49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:85015e83-57f2-45d5-8c24-80eb2c71f9f4', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:591d920d-adeb-4b65-8d8e-130e073ffb49'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:85015e83-57f2-45d5-8c24-80eb2c71f9f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:262bc136-c835-4643-8a0f-a34fe4abdbaf', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:591d920d-adeb-4b65-8d8e-130e073ffb49'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:262bc136-c835-4643-8a0f-a34fe4abdbaf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a4fcd49-ea53-4630-8da6-7156653a9071', 3, 'III', 'Allegro moderato', 'III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:591d920d-adeb-4b65-8d8e-130e073ffb49'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 1' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a4fcd49-ea53-4630-8da6-7156653a9071'
);


-- Op. 2 건반 3중주 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 3중주 Op. 2', '6 Keyboard Trios, Op. 2', 'album', NULL, 'Op.', '2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 3중주 Op. 2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trios:1', 1, NULL, '건반 3중주 F장조', 'No. 1: Keyboard Trio in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 3중주 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trios:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trios:2', 2, NULL, '건반 3중주 G장조', 'No. 2: Keyboard Trio in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 3중주 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trios:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trios:3', 3, NULL, '건반 3중주 D장조', 'No. 3: Keyboard Trio in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 3중주 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trios:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trios:4', 4, NULL, '건반 3중주 C장조', 'No. 4: Keyboard Trio in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 3중주 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trios:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trios:5', 5, NULL, '건반 3중주 A장조', 'No. 5: Keyboard Trio in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 3중주 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trios:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trios:6', 6, NULL, '건반 3중주 E♭장조', 'No. 6: Keyboard Trio in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 3중주 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trios:6'
);


-- Op. 2 트리오 소나타 Op. 2

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 Op. 2', '6 Trio Sonatas, Op. 2', 'album', NULL, 'Op.', '2', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 Op. 2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:1', 1, NULL, '트리오 소나타 B♭장조', 'No. 1: Trio Sonata in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:2', 2, NULL, '트리오 소나타 A장조', 'No. 2: Trio Sonata in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:3', 3, NULL, '트리오 소나타 E♭장조', 'No. 3: Trio Sonata in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:4', 4, NULL, '트리오 소나타 G장조', 'No. 4: Trio Sonata in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:5', 5, NULL, '트리오 소나타 D장조', 'No. 5: Trio Sonata in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:6', 6, NULL, '트리오 소나타 C장조', 'No. 6: Trio Sonata in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 2' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op2-trio-sonatas:6'
);


-- Op. 3 신포니아 Op. 3

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 Op. 3', '6 Symphonies, Op. 3', 'album', NULL, 'Op.', '3', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 Op. 3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00aa4421-7dd1-47f4-817e-e836d6fba094', 1, NULL, '신포니아 D장조', 'No. 1: Symphony in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00aa4421-7dd1-47f4-817e-e836d6fba094'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed665331-c30d-4cb6-aac7-53804191d53a', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00aa4421-7dd1-47f4-817e-e836d6fba094'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed665331-c30d-4cb6-aac7-53804191d53a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55824ab3-72aa-4ce8-b67e-fc7cc955ea73', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00aa4421-7dd1-47f4-817e-e836d6fba094'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55824ab3-72aa-4ce8-b67e-fc7cc955ea73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:726f81b3-0779-4cf0-8f08-74917ae0d572', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:00aa4421-7dd1-47f4-817e-e836d6fba094'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:726f81b3-0779-4cf0-8f08-74917ae0d572'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeba7f64-d19f-45c4-ab84-0837e91a2030', 2, NULL, '신포니아 C장조', 'No. 2: Symphony in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeba7f64-d19f-45c4-ab84-0837e91a2030'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:443893f5-58a5-4511-abc2-fe0feb6f7257', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeba7f64-d19f-45c4-ab84-0837e91a2030'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:443893f5-58a5-4511-abc2-fe0feb6f7257'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:df01d1c4-05ad-48cf-95b6-e27c99677435', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeba7f64-d19f-45c4-ab84-0837e91a2030'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df01d1c4-05ad-48cf-95b6-e27c99677435'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:736c7295-1800-4777-aa56-20e1c3272e8a', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:eeba7f64-d19f-45c4-ab84-0837e91a2030'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:736c7295-1800-4777-aa56-20e1c3272e8a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da54fc7b-4181-4ade-be3b-7292d887c64d', 3, NULL, '신포니아 E♭장조', 'No. 3: Symphony in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da54fc7b-4181-4ade-be3b-7292d887c64d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0d776d33-abe9-4ef3-b6bd-59175fbae32b', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:da54fc7b-4181-4ade-be3b-7292d887c64d'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d776d33-abe9-4ef3-b6bd-59175fbae32b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:136b8375-e99f-4078-8577-d5a55e7ad0e5', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:da54fc7b-4181-4ade-be3b-7292d887c64d'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:136b8375-e99f-4078-8577-d5a55e7ad0e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d0d89099-fc06-4621-926e-29bcf545b196', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:da54fc7b-4181-4ade-be3b-7292d887c64d'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0d89099-fc06-4621-926e-29bcf545b196'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59d3d03c-4b1f-4552-bbf8-0a0d26b0e240', 4, NULL, '신포니아 B♭장조', 'No. 4: Symphony in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59d3d03c-4b1f-4552-bbf8-0a0d26b0e240'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f480296f-820b-4366-9754-77ca6a2fe6ca', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:59d3d03c-4b1f-4552-bbf8-0a0d26b0e240'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f480296f-820b-4366-9754-77ca6a2fe6ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71ec8422-0ae7-4704-a19a-9a4b0309a09f', 2, 'II', 'Andantino, sempre piano', 'II. Andantino, sempre piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:59d3d03c-4b1f-4552-bbf8-0a0d26b0e240'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71ec8422-0ae7-4704-a19a-9a4b0309a09f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c8a38e2-65fc-41e4-8669-4f8488fbf9e1', 3, 'III', 'Tempo di menuetto, più tosto allegro', 'III. Tempo di menuetto, più tosto allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:59d3d03c-4b1f-4552-bbf8-0a0d26b0e240'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c8a38e2-65fc-41e4-8669-4f8488fbf9e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1a95aa4-57f4-4152-b93d-51f2e600d327', 5, NULL, '신포니아 F장조', 'No. 5: Symphony in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1a95aa4-57f4-4152-b93d-51f2e600d327'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68681b6f-778d-49eb-ba1e-dacbbcf16aa3', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1a95aa4-57f4-4152-b93d-51f2e600d327'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68681b6f-778d-49eb-ba1e-dacbbcf16aa3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9d7d35f5-3e35-43fa-9584-fcea15f56036', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1a95aa4-57f4-4152-b93d-51f2e600d327'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d7d35f5-3e35-43fa-9584-fcea15f56036'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:831d5926-0111-4af6-9177-b0f44f2b4d16', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1a95aa4-57f4-4152-b93d-51f2e600d327'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:831d5926-0111-4af6-9177-b0f44f2b4d16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5546fb89-ced3-489d-89cb-00b7ccbfeb9a', 6, NULL, '신포니아 G장조', 'No. 6: Symphony in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5546fb89-ced3-489d-89cb-00b7ccbfeb9a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7f7d1760-9d3c-4e44-b489-7b89da5aeacc', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5546fb89-ced3-489d-89cb-00b7ccbfeb9a'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f7d1760-9d3c-4e44-b489-7b89da5aeacc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e16c021d-5ff2-4599-8e24-60be443b9159', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5546fb89-ced3-489d-89cb-00b7ccbfeb9a'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e16c021d-5ff2-4599-8e24-60be443b9159'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b4f371b-7ee3-4341-a8e3-3b6d22daac88', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5546fb89-ced3-489d-89cb-00b7ccbfeb9a'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 3' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b4f371b-7ee3-4341-a8e3-3b6d22daac88'
);


-- Op. 4 칸초네타 Op. 4

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 Op. 4', '6 Canzonettas for 2 voices, Op. 4', 'album', NULL, 'Op.', '4', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 Op. 4'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6cf7af9d-39af-4523-a5a9-6ed5a553e25e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6cf7af9d-39af-4523-a5a9-6ed5a553e25e'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6cf7af9d-39af-4523-a5a9-6ed5a553e25e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a49351d-1aab-4c21-acaa-1583e80422f6', 1, NULL, 'Già la notte s''avvicina', 'No. 1: Già la notte s''avvicina', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a49351d-1aab-4c21-acaa-1583e80422f6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e9a50e1-b935-4a4e-bced-5c668852ac43', 2, NULL, 'Ah rammenta, o bella Irene', 'No. 2: Ah rammenta, o bella Irene', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e9a50e1-b935-4a4e-bced-5c668852ac43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc21cb0d-9acd-4e69-989a-f4cae061fe81', 3, NULL, 'Pur nel sonno almen talora', 'No. 3: Pur nel sonno almen talora', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc21cb0d-9acd-4e69-989a-f4cae061fe81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1101a59-fca9-4f5d-ab1c-c969ac34bd8b', 4, NULL, 'T''intendo si, mio cor', 'No. 4: T''intendo si, mio cor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1101a59-fca9-4f5d-ab1c-c969ac34bd8b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddec7582-4b5f-494b-b356-e5373e031b36', 5, NULL, 'Che ciascun per te sospiri', 'No. 5: Che ciascun per te sospiri', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddec7582-4b5f-494b-b356-e5373e031b36'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:295b0b0b-6ab7-4a26-85c8-f701b2c1e605', 6, NULL, 'Ascoltami, o Clori', 'No. 6: Ascoltami, o Clori', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 4' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:295b0b0b-6ab7-4a26-85c8-f701b2c1e605'
);


-- Op. 5 건반 소나타 Op. 5

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 Op. 5', '6 Keyboard Sonatas, Op. 5', 'album', NULL, 'Op.', '5', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 Op. 5'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b973d3d-fd2c-4d9e-a181-e3e0c5e0969f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2b973d3d-fd2c-4d9e-a181-e3e0c5e0969f'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2b973d3d-fd2c-4d9e-a181-e3e0c5e0969f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:367723f9-aa27-4ce7-a4fe-07670894b3e5', 1, NULL, '건반 소나타 B♭장조', 'No. 1: Keyboard Sonata in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:367723f9-aa27-4ce7-a4fe-07670894b3e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:89edcc1a-3519-40d1-a49d-42b82435fff5', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:367723f9-aa27-4ce7-a4fe-07670894b3e5'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:89edcc1a-3519-40d1-a49d-42b82435fff5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:52888da6-abdd-4696-bb8a-37d38a113d37', 2, 'II', 'Tempo di minuetto', 'II. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:367723f9-aa27-4ce7-a4fe-07670894b3e5'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52888da6-abdd-4696-bb8a-37d38a113d37'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d4c5501-b88a-49ad-8dd6-f03066449838', 2, NULL, '건반 소나타 D장조', 'No. 2: Keyboard Sonata in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d4c5501-b88a-49ad-8dd6-f03066449838'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8b4b4a8c-8463-3ce6-8851-db10cf0501a2', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d4c5501-b88a-49ad-8dd6-f03066449838'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b4b4a8c-8463-3ce6-8851-db10cf0501a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:abeecfd0-129a-3889-89f3-9049e646d59c', 2, 'II', 'Andante di molto', 'II. Andante di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d4c5501-b88a-49ad-8dd6-f03066449838'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:abeecfd0-129a-3889-89f3-9049e646d59c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd70cb27-30a6-3edf-a03c-2fbbae96d85f', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7d4c5501-b88a-49ad-8dd6-f03066449838'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd70cb27-30a6-3edf-a03c-2fbbae96d85f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3333d604-4427-4e47-9cf2-7c04bd25a37a', 3, NULL, '건반 소나타 G장조', 'No. 3: Keyboard Sonata in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3333d604-4427-4e47-9cf2-7c04bd25a37a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5c32db9e-a26a-3672-af0a-3af943fa09a6', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3333d604-4427-4e47-9cf2-7c04bd25a37a'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c32db9e-a26a-3672-af0a-3af943fa09a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6c3f763-9340-3628-8c7e-cea508c78317', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3333d604-4427-4e47-9cf2-7c04bd25a37a'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6c3f763-9340-3628-8c7e-cea508c78317'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:416a1a3f-deff-4e8f-96ed-0abe8b59265d', 4, NULL, '건반 소나타 E♭장조', 'No. 4: Keyboard Sonata in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:416a1a3f-deff-4e8f-96ed-0abe8b59265d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c30f0740-f172-3338-b1bc-6efbdcc09b39', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:416a1a3f-deff-4e8f-96ed-0abe8b59265d'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c30f0740-f172-3338-b1bc-6efbdcc09b39'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:341b752e-a999-3346-ba0d-88aeb6812234', 2, 'II', '론도. Allegretto', 'II. Rondeau. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:416a1a3f-deff-4e8f-96ed-0abe8b59265d'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:341b752e-a999-3346-ba0d-88aeb6812234'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a28cbea-2f2a-47d6-8964-0f7c316ededc', 5, NULL, '건반 소나타 E장조', 'No. 5: Keyboard Sonata in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a28cbea-2f2a-47d6-8964-0f7c316ededc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c366e5d-9d98-40a4-bb6f-cd96a760b268', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a28cbea-2f2a-47d6-8964-0f7c316ededc'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c366e5d-9d98-40a4-bb6f-cd96a760b268'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e68e8946-704b-4f55-b27c-7406a963c117', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a28cbea-2f2a-47d6-8964-0f7c316ededc'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e68e8946-704b-4f55-b27c-7406a963c117'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e284e901-4255-4d38-a4db-df5d5341c503', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:7a28cbea-2f2a-47d6-8964-0f7c316ededc'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e284e901-4255-4d38-a4db-df5d5341c503'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88bb53c6-d5cd-46cd-8512-a2066e8daffb', 6, NULL, '건반 소나타 C단조', 'No. 6: Keyboard Sonata in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88bb53c6-d5cd-46cd-8512-a2066e8daffb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bd4ca65a-ed09-48fe-9107-d4f974e5e6d1', 1, 'I', 'Grave', 'I. Grave', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88bb53c6-d5cd-46cd-8512-a2066e8daffb'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd4ca65a-ed09-48fe-9107-d4f974e5e6d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a6cd0c31-22e5-43cf-8c3a-6fec49b9ad8f', 2, 'II', 'Allegro moderato', 'II. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88bb53c6-d5cd-46cd-8512-a2066e8daffb'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a6cd0c31-22e5-43cf-8c3a-6fec49b9ad8f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b3606a40-f3ff-46cc-a81b-4fea694cb9ef', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:88bb53c6-d5cd-46cd-8512-a2066e8daffb'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 5' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3606a40-f3ff-46cc-a81b-4fea694cb9ef'
);


-- Op. 6 신포니아 Op. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 Op. 6', '6 Symphonies, Op. 6', 'album', NULL, 'Op.', '6', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 Op. 6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a2423b9-99e8-4397-813d-528545e91da5', 1, NULL, '신포니아 G장조', 'No. 1: Symphony in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a2423b9-99e8-4397-813d-528545e91da5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4bbf9d66-7b3d-42f3-8ef7-4aa0852c90d4', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4a2423b9-99e8-4397-813d-528545e91da5'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4bbf9d66-7b3d-42f3-8ef7-4aa0852c90d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d2ac502e-0fe7-4cb0-8b6c-960ae281b368', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4a2423b9-99e8-4397-813d-528545e91da5'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2ac502e-0fe7-4cb0-8b6c-960ae281b368'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a435d0b-359e-4f11-9769-e70963d2719c', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4a2423b9-99e8-4397-813d-528545e91da5'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a435d0b-359e-4f11-9769-e70963d2719c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f906ded5-4913-4f2e-bb99-34af589da54b', 2, NULL, '신포니아 D장조', 'No. 2: Symphony in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f906ded5-4913-4f2e-bb99-34af589da54b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fe94625a-c15d-4071-9dc7-ca68d90aea4f', 1, 'I', 'Allegro spiritoso', 'I. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f906ded5-4913-4f2e-bb99-34af589da54b'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe94625a-c15d-4071-9dc7-ca68d90aea4f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:90622d7d-ef99-41ee-b5ce-20f199d37440', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f906ded5-4913-4f2e-bb99-34af589da54b'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90622d7d-ef99-41ee-b5ce-20f199d37440'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ac9efbe-5789-453b-8ac0-8e348bf6f43f', 3, 'III', 'Allegro spiritoso', 'III. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f906ded5-4913-4f2e-bb99-34af589da54b'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac9efbe-5789-453b-8ac0-8e348bf6f43f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d8d72e06-4850-4378-944f-82546a1063ff', 3, NULL, '신포니아 E♭장조', 'No. 3: Symphony in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d8d72e06-4850-4378-944f-82546a1063ff'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3c2fc4db-63a0-48ff-878b-31aae451af47', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8d72e06-4850-4378-944f-82546a1063ff'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c2fc4db-63a0-48ff-878b-31aae451af47'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:acab86b2-c881-4fa0-83b6-9a1c120206eb', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8d72e06-4850-4378-944f-82546a1063ff'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acab86b2-c881-4fa0-83b6-9a1c120206eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4af3bc8-8c36-4173-967a-8303b07dc3b1', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d8d72e06-4850-4378-944f-82546a1063ff'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4af3bc8-8c36-4173-967a-8303b07dc3b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:16de0b4e-b841-4dd9-91d2-f25f24129420', 4, NULL, '신포니아 B♭장조', 'No. 4: Symphony in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:16de0b4e-b841-4dd9-91d2-f25f24129420'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2e73ec7e-ef9a-4964-a079-bbcc688f9a57', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:16de0b4e-b841-4dd9-91d2-f25f24129420'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e73ec7e-ef9a-4964-a079-bbcc688f9a57'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d7f48888-ad29-427a-8fdf-2ad04302f04b', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:16de0b4e-b841-4dd9-91d2-f25f24129420'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7f48888-ad29-427a-8fdf-2ad04302f04b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d474ac62-1792-4e50-9929-8ada3d338ef3', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:16de0b4e-b841-4dd9-91d2-f25f24129420'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d474ac62-1792-4e50-9929-8ada3d338ef3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa712ace-a64f-4983-9c8f-d883baa5bd59', 5, NULL, '신포니아 E♭장조', 'No. 5: Symphony in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa712ace-a64f-4983-9c8f-d883baa5bd59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:200fe72d-323f-44ad-be7b-cb649fdef2f0', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fa712ace-a64f-4983-9c8f-d883baa5bd59'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:200fe72d-323f-44ad-be7b-cb649fdef2f0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a86d4c5b-7eeb-422d-b75f-4a47fe9abdc6', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fa712ace-a64f-4983-9c8f-d883baa5bd59'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a86d4c5b-7eeb-422d-b75f-4a47fe9abdc6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ac7ff0d8-7fda-464d-889c-5dd419e6cc91', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:fa712ace-a64f-4983-9c8f-d883baa5bd59'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ac7ff0d8-7fda-464d-889c-5dd419e6cc91'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05e37a20-c997-4ecd-b4d7-3d3be0824100', 6, NULL, '신포니아 G단조', 'No. 6: Symphony in G minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05e37a20-c997-4ecd-b4d7-3d3be0824100'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:22eaebad-ff6f-42fd-9570-7a2a8a68d9de', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:05e37a20-c997-4ecd-b4d7-3d3be0824100'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22eaebad-ff6f-42fd-9570-7a2a8a68d9de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e737e7d-9a40-4a74-a573-17edac51a542', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:05e37a20-c997-4ecd-b4d7-3d3be0824100'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e737e7d-9a40-4a74-a573-17edac51a542'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0afd778f-1385-4e83-81c3-f682c895014a', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:05e37a20-c997-4ecd-b4d7-3d3be0824100'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0afd778f-1385-4e83-81c3-f682c895014a'
);


-- Op. 6 칸초네타 Op. 6

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 Op. 6', '6 Canzonettas for 2 voices, Op. 6', 'album', NULL, 'Op.', '6', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 Op. 6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op6-canzonettas:1', 1, NULL, 'Torna in quell''onda chiara', 'No. 1: Torna in quell''onda chiara', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op6-canzonettas:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op6-canzonettas:2', 2, NULL, 'Io lo so, che il bel sembiante', 'No. 2: Io lo so, che il bel sembiante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op6-canzonettas:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op6-canzonettas:3', 3, NULL, 'E pur fra le tempeste', 'No. 3: E pur fra le tempeste', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op6-canzonettas:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op6-canzonettas:4', 4, NULL, 'Trova un sol, mia bella Clori', 'No. 4: Trova un sol, mia bella Clori', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op6-canzonettas:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op6-canzonettas:5', 5, NULL, 'Chi mai di questo core', 'No. 5: Chi mai di questo core', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op6-canzonettas:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op6-canzonettas:6', 6, NULL, 'Se infida tu mi chiami', 'No. 6: Se infida tu mi chiami', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '칸초네타 Op. 6' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op6-canzonettas:6'
);


-- Op. 7 건반 협주곡 Op. 7

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 협주곡 Op. 7', '6 Keyboard Concertos, Op. 7', 'album', NULL, 'Op.', '7', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 협주곡 Op. 7'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57edd533-9053-4fa8-9336-f562a202e7eb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '57edd533-9053-4fa8-9336-f562a202e7eb'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57edd533-9053-4fa8-9336-f562a202e7eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c218d9f-e1fd-41e8-93ac-b380aa8ed39c', 1, NULL, '건반 협주곡 C장조', 'No. 1: Keyboard Concerto in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c218d9f-e1fd-41e8-93ac-b380aa8ed39c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:11a7ce76-b594-497c-b387-5cab49bf25ba', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c218d9f-e1fd-41e8-93ac-b380aa8ed39c'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11a7ce76-b594-497c-b387-5cab49bf25ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:174b4775-99de-4608-b4b0-03f38adee298', 2, 'II', '미뉴에트', 'II. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9c218d9f-e1fd-41e8-93ac-b380aa8ed39c'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:174b4775-99de-4608-b4b0-03f38adee298'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:250f655d-0c89-4d3c-83fe-a0eaf3c20c93', 2, NULL, '건반 협주곡 F장조', 'No. 2: Keyboard Concerto in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:250f655d-0c89-4d3c-83fe-a0eaf3c20c93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:841c57cb-1657-4e08-9905-6ba9df375578', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:250f655d-0c89-4d3c-83fe-a0eaf3c20c93'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:841c57cb-1657-4e08-9905-6ba9df375578'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5627b179-a300-4600-816b-7648a4ebd17c', 2, 'II', 'Tempo di menuetto', 'II. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:250f655d-0c89-4d3c-83fe-a0eaf3c20c93'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5627b179-a300-4600-816b-7648a4ebd17c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d6c8905-7537-47c1-9887-46a82253aadd', 3, NULL, '건반 협주곡 D장조', 'No. 3: Keyboard Concerto in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d6c8905-7537-47c1-9887-46a82253aadd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d296afa6-1319-40e5-9c77-8cc8b88aa012', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0d6c8905-7537-47c1-9887-46a82253aadd'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d296afa6-1319-40e5-9c77-8cc8b88aa012'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f8e3bfe9-ae2a-4fa8-aa88-caecfaa7b481', 2, 'II', '론도. Allegretto', 'II. Rondeau. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0d6c8905-7537-47c1-9887-46a82253aadd'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8e3bfe9-ae2a-4fa8-aa88-caecfaa7b481'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1faed98b-3e4a-4c09-8df6-24bf5eed3053', 4, NULL, '건반 협주곡 B♭장조', 'No. 4: Keyboard Concerto in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1faed98b-3e4a-4c09-8df6-24bf5eed3053'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3bd2b838-656f-4c13-92f9-6e8b86d691cb', 1, 'I', 'Allegro giusto', 'I. Allegro giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1faed98b-3e4a-4c09-8df6-24bf5eed3053'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3bd2b838-656f-4c13-92f9-6e8b86d691cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f3def0f-4a56-41d6-9708-866e4d90fdc9', 2, 'II', 'Allegro di molto', 'II. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1faed98b-3e4a-4c09-8df6-24bf5eed3053'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f3def0f-4a56-41d6-9708-866e4d90fdc9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8afb16a-6c57-4dc0-a657-1fe98cc628a2', 5, NULL, '건반 협주곡 E♭장조', 'No. 5: Keyboard Concerto in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8afb16a-6c57-4dc0-a657-1fe98cc628a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:297d11b9-58a8-4415-bf85-924b157e02a5', 1, 'I', 'Allegro di molto', 'I. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f8afb16a-6c57-4dc0-a657-1fe98cc628a2'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:297d11b9-58a8-4415-bf85-924b157e02a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ed5d39fe-4bb8-4768-92e6-8f1b7d14c59e', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f8afb16a-6c57-4dc0-a657-1fe98cc628a2'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed5d39fe-4bb8-4768-92e6-8f1b7d14c59e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6697cf93-32d1-44c0-8484-6ccf09f664e6', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f8afb16a-6c57-4dc0-a657-1fe98cc628a2'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6697cf93-32d1-44c0-8484-6ccf09f664e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3b4fcf0-b320-44c3-ace0-40b3893795ab', 6, NULL, '건반 협주곡 G장조', 'No. 6: Keyboard Concerto in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3b4fcf0-b320-44c3-ace0-40b3893795ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e6f34f4e-c5bb-4e77-a819-d896870a57a6', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b3b4fcf0-b320-44c3-ace0-40b3893795ab'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6f34f4e-c5bb-4e77-a819-d896870a57a6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:da4b1174-a97c-4d2d-85a4-b07fe3f6e74d', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b3b4fcf0-b320-44c3-ace0-40b3893795ab'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da4b1174-a97c-4d2d-85a4-b07fe3f6e74d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a562a871-e15a-4e6b-ad6a-5bf5a744b70c', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b3b4fcf0-b320-44c3-ace0-40b3893795ab'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 7' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a562a871-e15a-4e6b-ad6a-5bf5a744b70c'
);


-- Op. 8 트리오 소나타 Op. 8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 Op. 8', '6 Trio Sonatas, Op. 8', 'album', NULL, 'Op.', '8', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 Op. 8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:1', 1, NULL, '트리오 소나타 G장조', 'No. 1: Trio Sonata in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:2', 2, NULL, '트리오 소나타 E♭장조', 'No. 2: Trio Sonata in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:3', 3, NULL, '트리오 소나타 D장조', 'No. 3: Trio Sonata in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:4', 4, NULL, '트리오 소나타 E장조', 'No. 4: Trio Sonata in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:5', 5, NULL, '트리오 소나타 B♭장조', 'No. 5: Trio Sonata in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-trio-sonatas:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ccd403d0-4718-40f7-8569-f52c6a67ffa8', 6, NULL, '트리오 소나타 F장조', 'No. 6: Trio Sonata in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ccd403d0-4718-40f7-8569-f52c6a67ffa8'
);


-- Op. 8 4중주 Op. 8

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4중주 Op. 8', '6 Quartets, Op. 8', 'album', NULL, 'Op.', '8', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4중주 Op. 8'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '879d8c9e-88ae-4513-b050-248cd24d7cbf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '879d8c9e-88ae-4513-b050-248cd24d7cbf'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '879d8c9e-88ae-4513-b050-248cd24d7cbf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-quartets:1', 1, NULL, '4중주 C장조', 'No. 1: Quartet in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-quartets:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c424e60a-8d25-40b5-89e5-09c04e13ebf2', 2, NULL, '4중주 D장조', 'No. 2: Quartet in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c424e60a-8d25-40b5-89e5-09c04e13ebf2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b8f2b6c-0ea4-4a8e-9b4c-a111ceddbe73', 1, 'I', 'Largo', 'I. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c424e60a-8d25-40b5-89e5-09c04e13ebf2'
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b8f2b6c-0ea4-4a8e-9b4c-a111ceddbe73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2b215897-0197-432b-8281-18b53ec3facc', 2, 'II', 'Allegro con spirito', 'II. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:c424e60a-8d25-40b5-89e5-09c04e13ebf2'
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b215897-0197-432b-8281-18b53ec3facc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-quartets:3', 3, NULL, '4중주 E♭장조', 'No. 3: Quartet in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-quartets:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-quartets:4', 4, NULL, '4중주 F장조', 'No. 4: Quartet in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-quartets:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op8-quartets:5', 5, NULL, '4중주 G장조', 'No. 5: Quartet in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op8-quartets:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:482a067a-080e-4286-b010-3ebbcffce33a', 6, NULL, '4중주 B♭장조', 'No. 6: Quartet in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:482a067a-080e-4286-b010-3ebbcffce33a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:dcf710b8-21a3-4b02-8938-d123f39a43e1', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:482a067a-080e-4286-b010-3ebbcffce33a'
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcf710b8-21a3-4b02-8938-d123f39a43e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:27c3c4e8-9b11-4445-be5e-840a4478b110', 2, 'II', '론도. Tempo di minuetto', 'II. Rondo. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:482a067a-080e-4286-b010-3ebbcffce33a'
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 8' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:27c3c4e8-9b11-4445-be5e-840a4478b110'
);


-- Op. 9 신포니아 Op. 9

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 Op. 9', '3 Symphonies, Op. 9', 'album', NULL, 'Op.', '9', 1773, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 Op. 9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80d518a6-ca00-4859-aa2c-06fcfdc2be7e', 1, NULL, '신포니아 B♭장조', 'No. 1: Symphony in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80d518a6-ca00-4859-aa2c-06fcfdc2be7e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:37349a89-2c2a-4aee-95fb-12a047f72f04', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80d518a6-ca00-4859-aa2c-06fcfdc2be7e'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:37349a89-2c2a-4aee-95fb-12a047f72f04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fc25b3fb-f34e-4b06-ab3d-9410ce860472', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80d518a6-ca00-4859-aa2c-06fcfdc2be7e'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fc25b3fb-f34e-4b06-ab3d-9410ce860472'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:eb1f64d7-a3e4-4c3e-9ccf-dd878f4f7952', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:80d518a6-ca00-4859-aa2c-06fcfdc2be7e'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb1f64d7-a3e4-4c3e-9ccf-dd878f4f7952'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b68b7e4c-fc51-480b-86a1-22dda28414e7', 2, NULL, '신포니아 E♭장조', 'No. 2: Symphony in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b68b7e4c-fc51-480b-86a1-22dda28414e7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cee7b8b2-5154-43d1-a6d2-5a31b327a518', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b68b7e4c-fc51-480b-86a1-22dda28414e7'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cee7b8b2-5154-43d1-a6d2-5a31b327a518'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2750bf9d-e0b3-466d-ad4a-549dddb57cbb', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b68b7e4c-fc51-480b-86a1-22dda28414e7'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2750bf9d-e0b3-466d-ad4a-549dddb57cbb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aed1c80a-fb11-4b12-a36e-f63a67b77b0a', 3, 'III', 'Tempo di Menuetto', 'III. Tempo di Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b68b7e4c-fc51-480b-86a1-22dda28414e7'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aed1c80a-fb11-4b12-a36e-f63a67b77b0a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6457fd66-4e62-4761-83fd-27abc4c6260c', 3, NULL, '신포니아 B♭장조', 'No. 3: Symphony in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6457fd66-4e62-4761-83fd-27abc4c6260c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7b30c8da-e2af-47d6-a111-b38b643e59e5', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6457fd66-4e62-4761-83fd-27abc4c6260c'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b30c8da-e2af-47d6-a111-b38b643e59e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d6f2c65-9e67-4032-b9e6-9f9b7060cb8e', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6457fd66-4e62-4761-83fd-27abc4c6260c'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d6f2c65-9e67-4032-b9e6-9f9b7060cb8e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:86d80937-d6bf-4b83-a5e2-660e0b4ebbef', 3, 'III', 'Allegro di molto', 'III. Allegro di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6457fd66-4e62-4761-83fd-27abc4c6260c'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 9' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:86d80937-d6bf-4b83-a5e2-660e0b4ebbef'
);


-- Op. 10 바이올린 소나타 Op. 10

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 Op. 10', '6 Sonatas for keyboard and violin, Op. 10', 'album', NULL, 'Op.', '10', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 Op. 10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op10:1', 1, NULL, '바이올린 소나타 B♭장조', 'No. 1: Sonata for keyboard and violin in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op10:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op10:2', 2, NULL, '바이올린 소나타 C장조', 'No. 2: Sonata for keyboard and violin in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op10:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op10:3', 3, NULL, '바이올린 소나타 G장조', 'No. 3: Sonata for keyboard and violin in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op10:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op10:4', 4, NULL, '바이올린 소나타 A장조', 'No. 4: Sonata for keyboard and violin in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op10:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op10:5', 5, NULL, '바이올린 소나타 F장조', 'No. 5: Sonata for keyboard and violin in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op10:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op10:6', 6, NULL, '바이올린 소나타 D장조', 'No. 6: Sonata for keyboard and violin in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 10' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op10:6'
);


-- Op. 11 5중주 Op. 11

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '5중주 Op. 11', '6 Quintets, Op. 11', 'album', NULL, 'Op.', '11', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '5중주 Op. 11'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:def5b4ca-a2fa-480e-be5b-7d576dc603ef', 1, NULL, '5중주 C장조', 'No. 1: Quintet in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:def5b4ca-a2fa-480e-be5b-7d576dc603ef'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c6a892ee-937b-47a1-8024-743a2238a302', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:def5b4ca-a2fa-480e-be5b-7d576dc603ef'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6a892ee-937b-47a1-8024-743a2238a302'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a29e6d8-084f-4ebf-87b6-db0c8f70f3f4', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:def5b4ca-a2fa-480e-be5b-7d576dc603ef'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a29e6d8-084f-4ebf-87b6-db0c8f70f3f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ae0b13ce-f0e1-4554-8c0c-18e3abc0d643', 3, 'III', '미뉴에트 con variatione', 'III. Menuetto con variatione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:def5b4ca-a2fa-480e-be5b-7d576dc603ef'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae0b13ce-f0e1-4554-8c0c-18e3abc0d643'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6522940e-7b61-4df3-be79-d6ab9b99f834', 2, NULL, '5중주 G장조', 'No. 2: Quintet in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6522940e-7b61-4df3-be79-d6ab9b99f834'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7ac043db-a4bb-4aed-b4b9-cbcfdd53a0b1', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6522940e-7b61-4df3-be79-d6ab9b99f834'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7ac043db-a4bb-4aed-b4b9-cbcfdd53a0b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:14bf43ad-a0ea-4ade-a12d-703763fa62f1', 2, 'II', 'Allegro assai', 'II. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6522940e-7b61-4df3-be79-d6ab9b99f834'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14bf43ad-a0ea-4ade-a12d-703763fa62f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e07abb4-32c2-4245-b511-a2a833533214', 3, NULL, '5중주 F장조', 'No. 3: Quintet in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e07abb4-32c2-4245-b511-a2a833533214'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9db43bde-98d1-4d10-bfc7-862bc826e75c', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e07abb4-32c2-4245-b511-a2a833533214'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9db43bde-98d1-4d10-bfc7-862bc826e75c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e0781df-e55f-4887-9331-74e53a49673a', 2, 'II', '론도-Allegretto', 'II. Rondo-Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:6e07abb4-32c2-4245-b511-a2a833533214'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e0781df-e55f-4887-9331-74e53a49673a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:527cfd2a-83e0-44fb-9ba5-899b6f92b569', 4, NULL, '5중주 E♭장조', 'No. 4: Quintet in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:527cfd2a-83e0-44fb-9ba5-899b6f92b569'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6584f504-594f-41b2-a27a-e5e3dceae653', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:527cfd2a-83e0-44fb-9ba5-899b6f92b569'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6584f504-594f-41b2-a27a-e5e3dceae653'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:94f5d995-4d2d-4097-8247-456c89b07706', 2, 'II', '미뉴에트', 'II. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:527cfd2a-83e0-44fb-9ba5-899b6f92b569'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94f5d995-4d2d-4097-8247-456c89b07706'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d26d00b6-c819-43d6-81b0-00c63a7308e6', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:527cfd2a-83e0-44fb-9ba5-899b6f92b569'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d26d00b6-c819-43d6-81b0-00c63a7308e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b89db333-7d65-4a6a-9c4b-376e255df15d', 5, NULL, '5중주 A장조', 'No. 5: Quintet in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b89db333-7d65-4a6a-9c4b-376e255df15d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:05d59668-698a-4557-bdb1-41dcabbb979b', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b89db333-7d65-4a6a-9c4b-376e255df15d'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05d59668-698a-4557-bdb1-41dcabbb979b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:80a49d64-7baa-420d-aefc-80474fadef0f', 2, 'II', 'Tempo di Menuetto', 'II. Tempo di Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b89db333-7d65-4a6a-9c4b-376e255df15d'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80a49d64-7baa-420d-aefc-80474fadef0f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5b4ceea-2a3d-4334-9b06-1b46ae62ce43', 6, NULL, '5중주 D장조', 'No. 6: Quintet in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5b4ceea-2a3d-4334-9b06-1b46ae62ce43'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6a288fcb-54cf-42ef-a588-412f9cfce08c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5b4ceea-2a3d-4334-9b06-1b46ae62ce43'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a288fcb-54cf-42ef-a588-412f9cfce08c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f69eae1c-9f29-4a45-a66d-ae5ab0e5a0e0', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5b4ceea-2a3d-4334-9b06-1b46ae62ce43'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f69eae1c-9f29-4a45-a66d-ae5ab0e5a0e0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8964e696-900c-4569-8a05-05709df4c0a7', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d5b4ceea-2a3d-4334-9b06-1b46ae62ce43'
WHERE p.composer_id = 23 AND p.title = '5중주 Op. 11' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8964e696-900c-4569-8a05-05709df4c0a7'
);


-- Op. 13 건반 협주곡 Op. 13

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 협주곡 Op. 13', '6 Keyboard Concertos, Op. 13', 'album', NULL, 'Op.', '13', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 협주곡 Op. 13'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c1cda9b-46ef-4224-a08e-a257c52d3bea'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3c1cda9b-46ef-4224-a08e-a257c52d3bea'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3c1cda9b-46ef-4224-a08e-a257c52d3bea'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98b7e040-47d1-4f25-805e-31dd0270a741', 1, NULL, '건반 협주곡 C장조', 'No. 1: Keyboard Concerto in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98b7e040-47d1-4f25-805e-31dd0270a741'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c4c80a45-67de-4902-a863-5824f0d7e965', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98b7e040-47d1-4f25-805e-31dd0270a741'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4c80a45-67de-4902-a863-5824f0d7e965'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e416f45e-3ebb-4109-a000-dfa3a8deea92', 2, 'II', '론도. Allegretto', 'II. Rondeau. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:98b7e040-47d1-4f25-805e-31dd0270a741'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e416f45e-3ebb-4109-a000-dfa3a8deea92'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ae1c380-50fd-4e94-b013-e3a5f4f11b66', 2, NULL, '건반 협주곡 D장조', 'No. 2: Keyboard Concerto in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ae1c380-50fd-4e94-b013-e3a5f4f11b66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5cd84394-8245-4a45-8150-f542c5feb2b2', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ae1c380-50fd-4e94-b013-e3a5f4f11b66'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cd84394-8245-4a45-8150-f542c5feb2b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bc481e7d-69d4-4e21-85d3-b350174f9ecb', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ae1c380-50fd-4e94-b013-e3a5f4f11b66'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc481e7d-69d4-4e21-85d3-b350174f9ecb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2fe2754f-1931-4d71-ac90-c0d418dd7897', 3, 'III', 'Allegro non tanto', 'III. Allegro non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:2ae1c380-50fd-4e94-b013-e3a5f4f11b66'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2fe2754f-1931-4d71-ac90-c0d418dd7897'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b507ca4-0e63-48ff-9467-ea5bfce52ef1', 3, NULL, '건반 협주곡 F장조', 'No. 3: Keyboard Concerto in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b507ca4-0e63-48ff-9467-ea5bfce52ef1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b4439bdd-d259-4748-b938-3d08b8e504ca', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0b507ca4-0e63-48ff-9467-ea5bfce52ef1'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4439bdd-d259-4748-b938-3d08b8e504ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c87b1174-3315-448c-925e-de05397d7c98', 2, 'II', '론도. Allegro', 'II. Rondeau. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0b507ca4-0e63-48ff-9467-ea5bfce52ef1'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c87b1174-3315-448c-925e-de05397d7c98'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97bfdd63-98be-4d2e-afcc-2f064da5877a', 4, NULL, '건반 협주곡 B♭장조', 'No. 4: Keyboard Concerto in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97bfdd63-98be-4d2e-afcc-2f064da5877a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0285b345-f008-4f16-aefa-488dcbcd253f', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97bfdd63-98be-4d2e-afcc-2f064da5877a'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0285b345-f008-4f16-aefa-488dcbcd253f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a4fea1f9-4bf8-4308-a888-c1626a2767a2', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97bfdd63-98be-4d2e-afcc-2f064da5877a'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a4fea1f9-4bf8-4308-a888-c1626a2767a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea0cc74f-b0d2-4032-b8f1-3a87aa3c8efa', 3, 'III', 'Andante con moto', 'III. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:97bfdd63-98be-4d2e-afcc-2f064da5877a'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea0cc74f-b0d2-4032-b8f1-3a87aa3c8efa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84c6d284-0ad4-4cda-93c5-c05cd78fc3fa', 5, NULL, '건반 협주곡 G장조', 'No. 5: Keyboard Concerto in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84c6d284-0ad4-4cda-93c5-c05cd78fc3fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6049878a-4961-473e-b2dd-868eaa0de1d9', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84c6d284-0ad4-4cda-93c5-c05cd78fc3fa'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6049878a-4961-473e-b2dd-868eaa0de1d9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a0bef2b-abe0-4ea4-9548-642b2832d37c', 2, 'II', 'Tempo di menuetto', 'II. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:84c6d284-0ad4-4cda-93c5-c05cd78fc3fa'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a0bef2b-abe0-4ea4-9548-642b2832d37c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60b25f4c-2c55-4fc5-8d79-363a38e3b344', 6, NULL, '건반 협주곡 E♭장조', 'No. 6: Keyboard Concerto in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60b25f4c-2c55-4fc5-8d79-363a38e3b344'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:67acbf4f-c421-42ce-9841-aa140255b226', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:60b25f4c-2c55-4fc5-8d79-363a38e3b344'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67acbf4f-c421-42ce-9841-aa140255b226'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff9ef0f4-99d2-4f7a-87bf-73a925b190a4', 2, 'II', 'Andante. Tempo di menuetto', 'II. Andante. Tempo di menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:60b25f4c-2c55-4fc5-8d79-363a38e3b344'
WHERE p.composer_id = 23 AND p.title = '건반 협주곡 Op. 13' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff9ef0f4-99d2-4f7a-87bf-73a925b190a4'
);


-- Op. 15 4개의 소나타와 2개의 2중주 Op. 15

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 소나타와 2개의 2중주 Op. 15', '4 Sonatas and 2 Duets, Op. 15', 'album', NULL, 'Op.', '15', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 소나타와 2개의 2중주 Op. 15'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2bccaa77-b4d8-4191-a7d6-443919a1ba05'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2bccaa77-b4d8-4191-a7d6-443919a1ba05'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2bccaa77-b4d8-4191-a7d6-443919a1ba05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op15:1', 1, NULL, '건반 3중주 C장조', 'No. 1: Keyboard Trio in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op15:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op15:2', 2, NULL, '건반 3중주 A장조', 'No. 2: Keyboard Trio in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op15:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op15:3', 3, NULL, '바이올린 소나타 D장조', 'No. 3: Sonata for keyboard and violin in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op15:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op15:4', 4, NULL, '바이올린 소나타 B♭장조', 'No. 4: Sonata for keyboard and violin in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op15:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d62496a-f33f-4c58-a297-58aad8ecdf1b', 5, NULL, '두 대의 건반을 위한 소나타 G장조', 'No. 5: Sonata for 2 keyboards in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d62496a-f33f-4c58-a297-58aad8ecdf1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:846c7e92-5a3a-424e-a005-afa87bbe8920', 6, NULL, '네 손을 위한 소나타 C장조', 'No. 6: Sonata for keyboard 4-hands in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 15' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:846c7e92-5a3a-424e-a005-afa87bbe8920'
);


-- Op. 16 바이올린 소나타 Op. 16

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 Op. 16', '6 Sonatas for keyboard and violin (or flute), Op. 16', 'album', NULL, 'Op.', '16', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 Op. 16'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd4dd135-3573-4549-ba40-373f2e1d6358', 1, NULL, '바이올린 소나타 D장조', 'No. 1: Sonata for keyboard and violin in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd4dd135-3573-4549-ba40-373f2e1d6358'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2cb34648-6429-3737-849e-f8598561dc14', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd4dd135-3573-4549-ba40-373f2e1d6358'
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2cb34648-6429-3737-849e-f8598561dc14'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:79c4faaa-2cfd-337d-ae04-7b390fb5900f', 2, 'II', 'Andante grazioso', 'II. Andante grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd4dd135-3573-4549-ba40-373f2e1d6358'
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79c4faaa-2cfd-337d-ae04-7b390fb5900f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c3b6ba2d-0872-3010-9d72-bd710f7d746e', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dd4dd135-3573-4549-ba40-373f2e1d6358'
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c3b6ba2d-0872-3010-9d72-bd710f7d746e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op16:2', 2, NULL, '바이올린 소나타 G장조', 'No. 2: Sonata for keyboard and violin in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op16:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op16:3', 3, NULL, '바이올린 소나타 C장조', 'No. 3: Sonata for keyboard and violin in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op16:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op16:4', 4, NULL, '바이올린 소나타 A장조', 'No. 4: Sonata for keyboard and violin in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op16:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op16:5', 5, NULL, '바이올린 소나타 D장조', 'No. 5: Sonata for keyboard and violin in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op16:5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op16:6', 6, NULL, '바이올린 소나타 F장조', 'No. 6: Sonata for keyboard and violin in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 소나타 Op. 16' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op16:6'
);


-- Op. 17 건반 소나타 Op. 17

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 Op. 17', '6 Keyboard Sonatas, Op. 17', 'album', NULL, 'Op.', '17', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 Op. 17'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42a36fb5-201a-4fb1-943c-76b0c13de43f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '42a36fb5-201a-4fb1-943c-76b0c13de43f'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42a36fb5-201a-4fb1-943c-76b0c13de43f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75103fe0-9bac-4977-a812-e701418d20fa', 1, NULL, '건반 소나타 G장조', 'No. 1: Keyboard Sonata in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75103fe0-9bac-4977-a812-e701418d20fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:30b3900d-964c-42e9-ae1f-c0d191bdfe35', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:75103fe0-9bac-4977-a812-e701418d20fa'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:30b3900d-964c-42e9-ae1f-c0d191bdfe35'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b18b88a2-75cb-4f93-8681-d72b28621078', 2, 'II', '미뉴에트 con variatione', 'II. Minuetto con variatione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:75103fe0-9bac-4977-a812-e701418d20fa'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b18b88a2-75cb-4f93-8681-d72b28621078'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8032b32-f736-4418-8eb5-3aec05dc1f5c', 2, NULL, '건반 소나타 C단조', 'No. 2: Keyboard Sonata in C minor', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8032b32-f736-4418-8eb5-3aec05dc1f5c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1469ebf9-65d8-4ea2-a735-35e98ebe5cf9', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e8032b32-f736-4418-8eb5-3aec05dc1f5c'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1469ebf9-65d8-4ea2-a735-35e98ebe5cf9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4603d18a-b17d-427f-876a-7d6cd6d3a550', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e8032b32-f736-4418-8eb5-3aec05dc1f5c'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4603d18a-b17d-427f-876a-7d6cd6d3a550'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a88e1148-b3bb-4cf0-ba26-478ba51676cb', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e8032b32-f736-4418-8eb5-3aec05dc1f5c'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a88e1148-b3bb-4cf0-ba26-478ba51676cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1511df41-eaef-4cc8-8425-72bdc86c2ca3', 3, NULL, '건반 소나타 E♭장조', 'No. 3: Keyboard Sonata in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1511df41-eaef-4cc8-8425-72bdc86c2ca3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8c533700-fb52-4bba-b6d1-fe9658890f77', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1511df41-eaef-4cc8-8425-72bdc86c2ca3'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8c533700-fb52-4bba-b6d1-fe9658890f77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:719c80a9-55c3-41ec-bed6-7aaa184fbd09', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:1511df41-eaef-4cc8-8425-72bdc86c2ca3'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:719c80a9-55c3-41ec-bed6-7aaa184fbd09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1d700a6-2ac8-4133-bb60-6ad325f982e5', 4, NULL, '건반 소나타 G장조', 'No. 4: Keyboard Sonata in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1d700a6-2ac8-4133-bb60-6ad325f982e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5965b2e7-f390-433c-ac18-70b1afaf1eb4', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a1d700a6-2ac8-4133-bb60-6ad325f982e5'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5965b2e7-f390-433c-ac18-70b1afaf1eb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f96180c8-8a0f-4cff-8583-14fda78b6db4', 2, 'II', 'Presto', 'II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a1d700a6-2ac8-4133-bb60-6ad325f982e5'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f96180c8-8a0f-4cff-8583-14fda78b6db4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca80228a-1392-44c4-8961-9667b2af09f4', 5, NULL, '건반 소나타 A장조', 'No. 5: Keyboard Sonata in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca80228a-1392-44c4-8961-9667b2af09f4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8183198c-d5ac-4e19-a6a3-720605bd6823', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ca80228a-1392-44c4-8961-9667b2af09f4'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8183198c-d5ac-4e19-a6a3-720605bd6823'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3af0eddd-8802-4aa1-8139-92cf4b0294a8', 2, 'II', 'Presto', 'II. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ca80228a-1392-44c4-8961-9667b2af09f4'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3af0eddd-8802-4aa1-8139-92cf4b0294a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c64a51-a7b4-4215-98e0-d903abb15138', 6, NULL, '건반 소나타 B♭장조', 'No. 6: Keyboard Sonata in B♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c64a51-a7b4-4215-98e0-d903abb15138'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8d146bbb-9463-45b9-9d25-d1fa60396dd2', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c64a51-a7b4-4215-98e0-d903abb15138'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8d146bbb-9463-45b9-9d25-d1fa60396dd2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6ce18418-a1fd-48dd-ae95-1af3bd129fda', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c64a51-a7b4-4215-98e0-d903abb15138'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ce18418-a1fd-48dd-ae95-1af3bd129fda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fdfebf17-18f5-4a67-b90a-218d72e31ace', 3, 'III', 'Prestissimo', 'III. Prestissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c64a51-a7b4-4215-98e0-d903abb15138'
WHERE p.composer_id = 23 AND p.title = '건반 소나타 Op. 17' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdfebf17-18f5-4a67-b90a-218d72e31ace'
);


-- Op. 18 4개의 소나타와 2개의 2중주 Op. 18

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 소나타와 2개의 2중주 Op. 18', '4 Sonatas and 2 Duets, Op. 18', 'album', NULL, 'Op.', '18', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 소나타와 2개의 2중주 Op. 18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op18-sonatas:1', 1, NULL, '바이올린 소나타 C장조', 'No. 1: Sonata for keyboard and violin in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op18-sonatas:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op18-sonatas:2', 2, NULL, '바이올린 소나타 D장조', 'No. 2: Sonata for keyboard and violin in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op18-sonatas:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op18-sonatas:3', 3, NULL, '바이올린 소나타 E♭장조', 'No. 3: Sonata for keyboard and violin in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op18-sonatas:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op18-sonatas:4', 4, NULL, '바이올린 소나타 G장조', 'No. 4: Sonata for keyboard and violin in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op18-sonatas:4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:847df147-b3bd-4949-be97-1321e2a40405', 5, NULL, '네 손을 위한 소나타 A장조', 'No. 5: Sonata for keyboard 4-hands in A major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:847df147-b3bd-4949-be97-1321e2a40405'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9960f24c-5235-4e7a-84f6-d32e78e9f7a7', 1, 'I', 'Allegretto', 'I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:847df147-b3bd-4949-be97-1321e2a40405'
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9960f24c-5235-4e7a-84f6-d32e78e9f7a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c841196-b9db-41a8-9e59-50d1bb602448', 2, 'II', 'Tempo di Menuetto', 'II. Tempo di Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:847df147-b3bd-4949-be97-1321e2a40405'
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c841196-b9db-41a8-9e59-50d1bb602448'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc19ff67-694e-44b8-90f8-be3d04fb8f15', 6, NULL, '네 손을 위한 소나타 F장조', 'No. 6: Sonata for keyboard 4-hands in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc19ff67-694e-44b8-90f8-be3d04fb8f15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:57bd14ca-590c-40ce-ab0f-8cc782c7a219', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cc19ff67-694e-44b8-90f8-be3d04fb8f15'
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57bd14ca-590c-40ce-ab0f-8cc782c7a219'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e60dd87-cf51-460e-8634-f509215127ea', 2, 'II', '론도', 'II. Rondeau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:cc19ff67-694e-44b8-90f8-be3d04fb8f15'
WHERE p.composer_id = 23 AND p.title = '4개의 소나타와 2개의 2중주 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e60dd87-cf51-460e-8634-f509215127ea'
);


-- Op. 18 신포니아 Op. 18

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 Op. 18', 'Grand Overtures, Op. 18', 'album', NULL, 'Op.', '18', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 Op. 18'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d34710a-2142-450f-a4b8-e58a49f04d0e', 1, NULL, '신포니아 E♭장조', 'No. 1: Symphony in E♭ major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d34710a-2142-450f-a4b8-e58a49f04d0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e29aa7ad-c090-3588-bb18-7149a48e1e5e', 1, 'I', 'Allegro spiritoso', 'I. Allegro spiritoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d34710a-2142-450f-a4b8-e58a49f04d0e'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e29aa7ad-c090-3588-bb18-7149a48e1e5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4e3e1433-042b-3280-94c3-aa301965b81c', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d34710a-2142-450f-a4b8-e58a49f04d0e'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e3e1433-042b-3280-94c3-aa301965b81c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:59d99ab9-1377-3bfd-a46a-066574e547d4', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9d34710a-2142-450f-a4b8-e58a49f04d0e'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59d99ab9-1377-3bfd-a46a-066574e547d4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, (SELECT linked.id FROM pieces linked WHERE linked.id = 107 AND linked.composer_id = 23), 'musicbrainz:3a700d83-b704-4d6b-9a31-5953178d9553', 2, NULL, '신포니아 B♭장조 (<Lucio Silla> 서곡)', 'No. 2: Symphony in B♭ major (Overture to "Lucio Silla")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3a700d83-b704-4d6b-9a31-5953178d9553'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1b01d30-6d16-4cc5-812f-4f9ba58a10bb', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a700d83-b704-4d6b-9a31-5953178d9553'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1b01d30-6d16-4cc5-812f-4f9ba58a10bb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c271c066-fcbe-4be8-a2db-45ac6b6dee46', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a700d83-b704-4d6b-9a31-5953178d9553'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c271c066-fcbe-4be8-a2db-45ac6b6dee46'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e93394ab-abf6-4af7-aec9-a99e0cce1c82', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3a700d83-b704-4d6b-9a31-5953178d9553'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e93394ab-abf6-4af7-aec9-a99e0cce1c82'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce7c82d3-17de-41b0-9f4a-0b471d07833b', 3, NULL, '신포니아 D장조 (<Endimione> 서곡)', 'No. 3: Symphony in D major (Overture to "Endimione")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce7c82d3-17de-41b0-9f4a-0b471d07833b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cfa1587e-3fce-347d-8e8d-2f562cdc1d48', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce7c82d3-17de-41b0-9f4a-0b471d07833b'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cfa1587e-3fce-347d-8e8d-2f562cdc1d48'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9b2343db-9884-3cab-b6b6-f41fc3643831', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce7c82d3-17de-41b0-9f4a-0b471d07833b'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b2343db-9884-3cab-b6b6-f41fc3643831'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0919a3c6-a3d8-36e8-97e6-4a56ce072cda', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ce7c82d3-17de-41b0-9f4a-0b471d07833b'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0919a3c6-a3d8-36e8-97e6-4a56ce072cda'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc5611ac-7a0a-49a7-a920-7c32e2c0b9fb', 4, NULL, '신포니아 D장조', 'No. 4: Symphony in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc5611ac-7a0a-49a7-a920-7c32e2c0b9fb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7a3e2568-daec-43de-9bff-5ce140087cc7', 1, 'I', 'Allegro con spirito', 'I. Allegro con spirito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc5611ac-7a0a-49a7-a920-7c32e2c0b9fb'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a3e2568-daec-43de-9bff-5ce140087cc7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:68023355-096f-4113-8f8d-fb2980660595', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc5611ac-7a0a-49a7-a920-7c32e2c0b9fb'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68023355-096f-4113-8f8d-fb2980660595'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8636e7e7-5b93-4a7a-b2cc-5cefe4825557', 3, 'III', '론도. Presto', 'III. Rondo: Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dc5611ac-7a0a-49a7-a920-7c32e2c0b9fb'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8636e7e7-5b93-4a7a-b2cc-5cefe4825557'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:912f52bb-9967-415d-9551-2476a13761a5', 5, NULL, '신포니아 E장조', 'No. 5: Symphony in E major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:912f52bb-9967-415d-9551-2476a13761a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4b937b9c-d4fe-44a7-9e06-44ccd285016c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:912f52bb-9967-415d-9551-2476a13761a5'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b937b9c-d4fe-44a7-9e06-44ccd285016c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d094cdc0-44fc-4277-a01f-f01cb71434b0', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:912f52bb-9967-415d-9551-2476a13761a5'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d094cdc0-44fc-4277-a01f-f01cb71434b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8090849d-5c6d-48c9-8fcc-0bfe569b4554', 3, 'III', 'Tempo di Minuetto', 'III. Tempo di Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:912f52bb-9967-415d-9551-2476a13761a5'
WHERE p.composer_id = 23 AND p.title = '신포니아 Op. 18' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8090849d-5c6d-48c9-8fcc-0bfe569b4554'
);


-- Op. 19 4중주 Op. 19

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4중주 Op. 19', '4 Quartets with 2 flutes, Op. 19', 'album', NULL, 'Op.', '19', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4중주 Op. 19'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op19:1', 1, NULL, '4중주 C장조', 'No. 1: Quartet in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op19:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op19:2', 2, NULL, '4중주 D장조', 'No. 2: Quartet in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op19:2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op19:3', 3, NULL, '4중주 G장조', 'No. 3: Quartet in G major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op19:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op19:4', 4, NULL, '4중주 C장조', 'No. 4: Quartet in C major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 Op. 19' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op19:4'
);


-- Op. 22 건반 5중주 Op. 22

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 5중주 Op. 22', '2 Keyboard Quintets, Op. 22', 'album', NULL, 'Op.', '22', NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 5중주 Op. 22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d32e46fd-881e-4a38-9874-be53ac299de3', 1, NULL, '건반 5중주 D장조', 'No. 1: Keyboard Quintet in D major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 5중주 Op. 22' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d32e46fd-881e-4a38-9874-be53ac299de3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0111e196-8ddc-47a3-ab4d-930b10dda5a8', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d32e46fd-881e-4a38-9874-be53ac299de3'
WHERE p.composer_id = 23 AND p.title = '건반 5중주 Op. 22' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0111e196-8ddc-47a3-ab4d-930b10dda5a8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96171313-4a08-4c0f-9ad8-4d09a30a8945', 2, 'II', 'Andantino', 'II. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d32e46fd-881e-4a38-9874-be53ac299de3'
WHERE p.composer_id = 23 AND p.title = '건반 5중주 Op. 22' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96171313-4a08-4c0f-9ad8-4d09a30a8945'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aa9a1393-76af-4e48-af53-9d2519b17169', 3, 'III', 'Allegro assai', 'III. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d32e46fd-881e-4a38-9874-be53ac299de3'
WHERE p.composer_id = 23 AND p.title = '건반 5중주 Op. 22' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa9a1393-76af-4e48-af53-9d2519b17169'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:jc-bach:jc-bach-op22:2', 2, NULL, '건반 5중주 F장조', 'No. 2: Keyboard Quintet in F major', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '건반 5중주 Op. 22' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:jc-bach:jc-bach-op22:2'
);


-- W.A 13 건반 소나타 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A단조', 'Keyboard Sonata in A minor', 'song', 'W.A 13', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A단조'
);


-- W.A 14 건반 소나타 A♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 A♭장조', 'Keyboard Sonata in A♭ major', 'song', 'W.A 14', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 A♭장조'
);


-- W.A 15 토카타 B♭단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '토카타 B♭단조', 'Toccata in B♭ minor', 'song', 'W.A 15', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '토카타 B♭단조'
);


-- W.A 16 건반 소나타 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 소나타 B♭장조', 'Keyboard Sonata in B♭ major', 'song', 'W.A 16', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 소나타 B♭장조'
);


-- W.A 22 행진곡 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 F장조', 'March in F major', 'song', 'W.A 22', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 F장조'
);


-- W.A 23 폴로네즈 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 B♭장조', 'Polonaise in B♭ major', 'song', 'W.A 23', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 B♭장조'
);


-- W.A 24 미뉴에트 C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 C단조', 'Minuet in C minor', 'song', 'W.A 24', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 C단조'
);


-- W.A 25 미뉴에트 C장조 (W.A 25)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 C장조 (W.A 25)', 'Minuet in C major', 'song', 'W.A 25', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 C장조 (W.A 25)'
);


-- W.A 26 폴로네즈 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 E♭장조', 'Polonaise in E♭ major', 'song', 'W.A 26', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 E♭장조'
);


-- W.A 27 아리아 A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 A단조', 'Aria in A minor', 'song', 'W.A 27', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 A단조'
);


-- W.A 28 미뉴에트 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 D단조', 'Minuet in D minor', 'song', 'W.A 28', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 D단조'
);


-- W.A 29 미뉴에트와 트리오 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트와 트리오 G단조', 'Minuet and Trio in G minor', 'song', 'W.A 29', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트와 트리오 G단조'
);


-- W.A 30 미뉴에트와 트리오 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트와 트리오 C장조', 'Minuet and Trio in C major', 'song', 'W.A 30', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트와 트리오 C장조'
);


-- W.A 31 미뉴에트 C장조 (W.A 31)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미뉴에트 C장조 (W.A 31)', 'Minuet in C major', 'song', 'W.A 31', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미뉴에트 C장조 (W.A 31)'
);


-- W.I 1 폴로네즈 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴로네즈 D단조', 'Polonaise in D minor', 'song', 'W.I 1', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴로네즈 D단조'
);


-- W.B 20 바이올린 소나타 1번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 1번 F장조', 'Sonata for keyboard and violin No. 1 in F major', 'song', 'W.B 20', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 1번 F장조'
);


-- W.B 21 바이올린 소나타 2번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 2번 D장조', 'Sonata for keyboard and violin No. 2 in D major', 'song', 'W.B 21', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 2번 D장조'
);


-- W.B 22 바이올린 소나타 3번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 3번 G장조', 'Sonata for keyboard and violin No. 3 in G major', 'song', 'W.B 22', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 3번 G장조'
);


-- W.B 23 바이올린 소나타 4번 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 4번 A장조', 'Sonata for keyboard and violin No. 4 in A major', 'song', 'W.B 23', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 4번 A장조'
);


-- W.B 24 바이올린 소나타 5번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 5번 G장조', 'Sonata for keyboard and violin No. 5 in G major', 'song', 'W.B 24', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 5번 G장조'
);


-- W.B 25 바이올린 소나타 6번 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 6번 D장조', 'Sonata for keyboard and violin No. 6 in D major', 'song', 'W.B 25', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 6번 D장조'
);


-- W.B 26 바이올린 소나타 7번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 7번 F장조', 'Sonata for keyboard and violin No. 7 in F major', 'song', 'W.B 26', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 7번 F장조'
);


-- W.B 27 바이올린 소나타 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 소나타 A장조', 'Sonata for keyboard and violin in A major', 'song', 'W.B 27', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 소나타 A장조'
);


-- W.B 42 트리오 소나타 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트리오 소나타 B♭장조', 'Trio for 2 violins and cello in B♭ major', 'album', 'W.B 42', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트리오 소나타 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '581e667e-6688-4281-b190-70b79633c28e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '581e667e-6688-4281-b190-70b79633c28e'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '581e667e-6688-4281-b190-70b79633c28e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15f89c48-29fb-4a58-95bd-ed2555f2cbe1', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15f89c48-29fb-4a58-95bd-ed2555f2cbe1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c0995558-9669-49cd-9e46-a902922c3bfd', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c0995558-9669-49cd-9e46-a902922c3bfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1a47f323-fa20-4b34-ba74-a9ef21bbe5b3', 3, 'III', 'Vivace', 'III. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '트리오 소나타 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1a47f323-fa20-4b34-ba74-a9ef21bbe5b3'
);


-- W.B 57 플루트 4중주 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 4중주 D장조', 'Flute Quartet in D major', 'song', 'W.B 57', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 4중주 D장조'
);


-- W.B 58 플루트 4중주 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 4중주 C장조', 'Flute Quartet in C major', 'song', 'W.B 58', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 4중주 C장조'
);


-- W.B 59 플루트 4중주 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 4중주 A장조', 'Flute Quartet in A major', 'album', 'W.B 59', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 4중주 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9ae64ed-65e4-447c-85f9-b94da1d1c150'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a9ae64ed-65e4-447c-85f9-b94da1d1c150'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트 4중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a9ae64ed-65e4-447c-85f9-b94da1d1c150'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8c4b7b9-db7c-45c9-9b56-39a0531bb60a', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트 4중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8c4b7b9-db7c-45c9-9b56-39a0531bb60a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58f22b6b-7ec1-43bf-a5b9-e9ed2cb13bf6', 2, 'II', 'Grazioso', 'II. Grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트 4중주 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58f22b6b-7ec1-43bf-a5b9-e9ed2cb13bf6'
);


-- W.B 60 4중주 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4중주 B♭장조', 'Quartet in B♭ major', 'album', 'W.B 60', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4중주 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fd20c74-4b95-47de-8144-f236e0995156'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6fd20c74-4b95-47de-8144-f236e0995156'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fd20c74-4b95-47de-8144-f236e0995156'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4189e74d-48ea-44bd-b0dc-40ea0f100562', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4189e74d-48ea-44bd-b0dc-40ea0f100562'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fed1bd28-fbf7-4387-a41c-365f93d91567', 2, 'II', '론도. Tempo di minuetto', 'II. Rondo. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '4중주 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fed1bd28-fbf7-4387-a41c-365f93d91567'
);


-- W.B 66 건반 4중주 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 4중주 G장조', 'Keyboard Quartet in G major', 'song', 'W.B 66', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 4중주 G장조'
);


-- W.B 78 6중주 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '6중주 C장조', 'Sextet in C major for winds, strings and keyboard', 'album', 'W.B 78', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '6중주 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b3364ee-6dbf-4012-8277-336d58529e1b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b3364ee-6dbf-4012-8277-336d58529e1b'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '6중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b3364ee-6dbf-4012-8277-336d58529e1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bc1d77b-7b41-4c7e-81b3-b072f6a9ee13', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '6중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bc1d77b-7b41-4c7e-81b3-b072f6a9ee13'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a885730e-3c78-41ec-b5e5-36183f9002a7', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '6중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a885730e-3c78-41ec-b5e5-36183f9002a7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0b630d7-c9d8-44ad-a77d-88cb992ce343', 3, 'III', '론도 Allegro', 'III. Rondo Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '6중주 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0b630d7-c9d8-44ad-a77d-88cb992ce343'
);


-- W.B 79 군악 5중주 1번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 5중주 1번 E♭장조', 'Military Quintet No. 1 in E♭ major', 'song', 'W.B 79', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 5중주 1번 E♭장조'
);


-- W.B 80 군악 5중주 2번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 5중주 2번 E♭장조', 'Military Quintet No. 2 in E♭ major', 'song', 'W.B 80', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 5중주 2번 E♭장조'
);


-- W.B 81 군악 5중주 3번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 5중주 3번 B♭장조', 'Military Quintet No. 3 in B♭ major', 'song', 'W.B 81', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 5중주 3번 B♭장조'
);


-- W.B 82 군악 5중주 4번 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '군악 5중주 4번 E♭장조', 'Military Quintet No. 4 in E♭ major', 'song', 'W.B 82', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '군악 5중주 4번 E♭장조'
);


-- W.B 83 행진곡 E♭장조 "프린츠 에른스트 연대"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 "프린츠 에른스트 연대"', 'March of the regiment "Prinz von Ernst" in E♭ major', 'song', 'W.B 83', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 "프린츠 에른스트 연대"'
);


-- W.B 84 행진곡 E♭장조 "브라운슈바이크 연대"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 "브라운슈바이크 연대"', 'March of the regiment "Braunschweig" in E♭ major', 'song', 'W.B 84', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 "브라운슈바이크 연대"'
);


-- W.B 85 행진곡 E♭장조 "뷔르템베르크 연대"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 "뷔르템베르크 연대"', 'March of the regiment "Württemberg" in E♭ major', 'song', 'W.B 85', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 "뷔르템베르크 연대"'
);


-- W.B 86 행진곡 E♭장조 "기마"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 "기마"', 'March in E♭ major "zu Pferde"', 'song', 'W.B 86', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 "기마"'
);


-- W.B 87 행진곡 E♭장조 "보병"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 "보병"', 'March in E♭ major "zu Fuß"', 'song', 'W.B 87', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 "보병"'
);


-- W.B 88 하노버 근위연대 1대대 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하노버 근위연대 1대대 행진곡', 'March "vom ersten Bataillon Garde-Regiments in Hannover"', 'song', 'W.B 88', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하노버 근위연대 1대대 행진곡'
);


-- W.B 89 하노버 근위연대 2대대 행진곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '하노버 근위연대 2대대 행진곡', 'March "vom zweiten Bataillon Garde-Regiments in Hannover"', 'song', 'W.B 89', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '하노버 근위연대 2대대 행진곡'
);


-- W.B 90 행진곡 E♭장조 (W.B 90)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 (W.B 90)', 'March in E♭ major, W. B90', 'song', 'W.B 90', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 (W.B 90)'
);


-- W.B 91 행진곡 E♭장조 (W.B 91)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 (W.B 91)', 'March in E♭ major, W. B91', 'song', 'W.B 91', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 (W.B 91)'
);


-- W.B 92 행진곡 E♭장조 (W.B 92)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 E♭장조 (W.B 92)', 'March in E♭ major, W. B92', 'song', 'W.B 92', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 E♭장조 (W.B 92)'
);


-- W.B 93 행진곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 B♭장조', 'March in B♭ major', 'song', 'W.B 93', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 B♭장조'
);


-- W.C 13 신포니아 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 G장조', 'Symphony in G major, Op. 8 No. 2', 'song', 'W.C 13', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 G장조'
);


-- W.C 14 신포니아 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 D장조', 'Symphony in D major, Op. 8 No. 3', 'song', 'W.C 14', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 D장조'
);


-- W.C 15 신포니아 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 F장조', 'Symphony in F major, Op. 8 No. 4', 'song', 'W.C 15', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 F장조'
);


-- W.C 16a 신포니아 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 C장조', 'Symphony in C major (Venier No. 46)', 'song', 'W.C 16a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 C장조'
);


-- W.C 19 신포니아 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '신포니아 E♭장조', 'Symphonie périodique in E♭ major', 'song', 'W.C 19', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '신포니아 E♭장조'
);


-- W.C 32 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 G장조', 'Sinfonia concertante in G major for 2 violins and cello', 'album', 'W.C 32', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 G장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f546f6fb-aeb2-4563-88c4-061330cd0678'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f546f6fb-aeb2-4563-88c4-061330cd0678'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f546f6fb-aeb2-4563-88c4-061330cd0678'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32cf7199-f02b-432a-a705-e3e33d46f76d', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32cf7199-f02b-432a-a705-e3e33d46f76d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aac986e4-c8ac-4416-a1ca-5b0474222f01', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aac986e4-c8ac-4416-a1ca-5b0474222f01'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:371d0dba-c34d-46cd-9aa9-eb6035ece38e', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 G장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:371d0dba-c34d-46cd-9aa9-eb6035ece38e'
);


-- W.C 33 두 대의 바이올린과 오보에를 위한 신포니아 콘체르탄테 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바이올린과 오보에를 위한 신포니아 콘체르탄테 E♭장조', 'Sinfonia concertante in E♭ major for 2 violins and oboe', 'album', 'W.C 33', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바이올린과 오보에를 위한 신포니아 콘체르탄테 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf85304a-ced4-4691-b430-1f366e12472e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cf85304a-ced4-4691-b430-1f366e12472e'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 오보에를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cf85304a-ced4-4691-b430-1f366e12472e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:59cf528f-80b6-4c5e-9117-21bc0d7b6e78', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 오보에를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:59cf528f-80b6-4c5e-9117-21bc0d7b6e78'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba90a062-cfd5-4a75-98b5-723031a3b15e', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 오보에를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba90a062-cfd5-4a75-98b5-723031a3b15e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:99e449e2-c93f-4d9a-b501-b8e78ce358e0', 3, 'III', 'Tempo de Menuetto', 'III. Tempo de Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 오보에를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:99e449e2-c93f-4d9a-b501-b8e78ce358e0'
);


-- W.C 34 바이올린과 첼로를 위한 신포니아 콘체르탄테 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 첼로를 위한 신포니아 콘체르탄테 A장조', 'Sinfonia concertante in A major for violin and cello', 'album', 'W.C 34', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90c55064-8b77-425d-95bd-6f41e8668432'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90c55064-8b77-425d-95bd-6f41e8668432'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90c55064-8b77-425d-95bd-6f41e8668432'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7d52644-2d8d-4440-891f-f28f93740820', 1, 'I', 'Andante di molto', 'I. Andante di molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7d52644-2d8d-4440-891f-f28f93740820'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f4f0327-3f7a-415c-bdb7-3d6d3aae5b84', 2, 'II', '론도. Allegro assai', 'II. Rondeau. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f4f0327-3f7a-415c-bdb7-3d6d3aae5b84'
);


-- W.C 35 두 대의 바이올린을 위한 신포니아 콘체르탄테 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바이올린을 위한 신포니아 콘체르탄테 D장조', 'Sinfonia concertante in D major for 2 violins', 'album', 'W.C 35', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바이올린을 위한 신포니아 콘체르탄테 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '417f15fe-64f6-4ccb-b974-4d9cc9a21f2b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '417f15fe-64f6-4ccb-b974-4d9cc9a21f2b'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린을 위한 신포니아 콘체르탄테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '417f15fe-64f6-4ccb-b974-4d9cc9a21f2b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51235991-ee23-4e42-8bfe-16b8cfe055b2', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린을 위한 신포니아 콘체르탄테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51235991-ee23-4e42-8bfe-16b8cfe055b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7f35cde-dda9-4cd8-bf1b-1c9a8ca7f6b4', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린을 위한 신포니아 콘체르탄테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7f35cde-dda9-4cd8-bf1b-1c9a8ca7f6b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea15e6e2-fcf3-4e6b-8ac2-78bdcfb7c073', 3, 'III', '미뉴에트', 'III. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린을 위한 신포니아 콘체르탄테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea15e6e2-fcf3-4e6b-8ac2-78bdcfb7c073'
);


-- W.C 36a 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 C장조', 'Sinfonia concertante in C major for 2 violins and cello', 'album', 'W.C 36a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d2d9abe-28d0-46bb-aa59-fcff3fcb78b0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7d2d9abe-28d0-46bb-aa59-fcff3fcb78b0'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7d2d9abe-28d0-46bb-aa59-fcff3fcb78b0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38c1d7aa-30d3-48fd-a541-6a2c048feb7b', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38c1d7aa-30d3-48fd-a541-6a2c048feb7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6967b83f-6c69-4002-b77c-85f61af7eb22', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6967b83f-6c69-4002-b77c-85f61af7eb22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b06dd119-f753-411e-8995-2ed131d2a9a8', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b06dd119-f753-411e-8995-2ed131d2a9a8'
);


-- W.C 37 플루트, 오보에, 바순을 위한 신포니아 콘체르탄테 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 오보에, 바순을 위한 신포니아 콘체르탄테 E♭장조', 'Sinfonia concertante in E♭ major for flute, oboe and bassoon', 'album', 'W.C 37', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 오보에, 바순을 위한 신포니아 콘체르탄테 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c75db62-8fc1-4e66-bff3-6cb5d9554642'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c75db62-8fc1-4e66-bff3-6cb5d9554642'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 오보에, 바순을 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c75db62-8fc1-4e66-bff3-6cb5d9554642'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8a8939d-4176-4f3b-9913-2286b1c9f13f', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 오보에, 바순을 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8a8939d-4176-4f3b-9913-2286b1c9f13f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ee85c94-dd97-4e18-9dd6-83832a42b44f', 2, 'II', 'Allegro', 'II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 오보에, 바순을 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ee85c94-dd97-4e18-9dd6-83832a42b44f'
);


-- W.C 38 오보에와 바순을 위한 신포니아 콘체르탄테 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에와 바순을 위한 신포니아 콘체르탄테 F장조', 'Sinfonia concertante in F major for oboe and bassoon', 'album', 'W.C 38', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에와 바순을 위한 신포니아 콘체르탄테 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38ab87c0-a962-4d0f-be5c-16c4efd2ee03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '38ab87c0-a962-4d0f-be5c-16c4efd2ee03'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에와 바순을 위한 신포니아 콘체르탄테 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '38ab87c0-a962-4d0f-be5c-16c4efd2ee03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6800e837-e9b5-4b68-9789-8c6d60b006ce', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에와 바순을 위한 신포니아 콘체르탄테 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6800e837-e9b5-4b68-9789-8c6d60b006ce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03a8dea0-9671-4c2e-b5c4-2298255c4645', 2, 'II', 'Tempo di minuetto', 'II. Tempo di minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에와 바순을 위한 신포니아 콘체르탄테 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03a8dea0-9671-4c2e-b5c4-2298255c4645'
);


-- W.C 39 두 대의 플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 D장조', 'Sinfonia concertante in D major for 2 flutes, 2 violins and cello', 'album', 'W.C 39', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2ba7127-d702-4d4f-8e67-94ace0ec3542'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c2ba7127-d702-4d4f-8e67-94ace0ec3542'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c2ba7127-d702-4d4f-8e67-94ace0ec3542'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c24ee523-763a-41e3-a9f9-1c14cf5d4aed', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c24ee523-763a-41e3-a9f9-1c14cf5d4aed'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:71dbe36e-0087-4c8b-88b4-c9a578b92052', 2, 'II', 'Tempo di Minuetto', 'II. Tempo di Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71dbe36e-0087-4c8b-88b4-c9a578b92052'
);


-- W.C 40 두 대의 오보에, 두 대의 호른과 현악 5부를 위한 신포니아 콘체르탄테 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 오보에, 두 대의 호른과 현악 5부를 위한 신포니아 콘체르탄테 E♭장조', 'Sinfonia concertante in E♭ major for 2 oboes, 2 horns and string quintet', 'album', 'W.C 40', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 오보에, 두 대의 호른과 현악 5부를 위한 신포니아 콘체르탄테 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d916d63-dd11-4c03-b79e-181898052e22'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5d916d63-dd11-4c03-b79e-181898052e22'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 오보에, 두 대의 호른과 현악 5부를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5d916d63-dd11-4c03-b79e-181898052e22'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80a79b78-1671-4406-a77b-1382ce239b21', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 오보에, 두 대의 호른과 현악 5부를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80a79b78-1671-4406-a77b-1382ce239b21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9690a3c9-9a12-4391-8298-16d92ef6faeb', 2, 'II', '미뉴에트', 'II. Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 오보에, 두 대의 호른과 현악 5부를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9690a3c9-9a12-4391-8298-16d92ef6faeb'
);


-- W.C 41 플루트, 두 대의 클라리넷, 두 대의 호른과 바순을 위한 신포니아 콘체르탄테 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 두 대의 클라리넷, 두 대의 호른과 바순을 위한 신포니아 콘체르탄테 E♭장조', 'Sinfonia concertante in E♭ major for flute, 2 clarinets, 2 horns and bassoon', 'album', 'W.C 41', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 두 대의 클라리넷, 두 대의 호른과 바순을 위한 신포니아 콘체르탄테 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e947857-af2b-487e-8516-7490927ad630'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e947857-af2b-487e-8516-7490927ad630'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 두 대의 클라리넷, 두 대의 호른과 바순을 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e947857-af2b-487e-8516-7490927ad630'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74371e3e-768b-4ad9-8f11-8a513602ccb4', 1, 'I', 'Allegro assai', 'I. Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 두 대의 클라리넷, 두 대의 호른과 바순을 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74371e3e-768b-4ad9-8f11-8a513602ccb4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b4cac054-b3a5-4a29-ad80-a93346c71017', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 두 대의 클라리넷, 두 대의 호른과 바순을 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b4cac054-b3a5-4a29-ad80-a93346c71017'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96158561-3d04-4fc2-a1bb-0eb697a5cd92', 3, 'III', '미뉴에트', 'III. Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 두 대의 클라리넷, 두 대의 호른과 바순을 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96158561-3d04-4fc2-a1bb-0eb697a5cd92'
);


-- W.C 42 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E♭장조', 'Sinfonia concertante in E♭ major for 2 violins and cello', 'album', 'W.C 42', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '032421ec-dbee-473f-96c1-6349a03db81d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '032421ec-dbee-473f-96c1-6349a03db81d'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '032421ec-dbee-473f-96c1-6349a03db81d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:96c31577-a4a2-46d1-a9c8-38d9e5a97a0c', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96c31577-a4a2-46d1-a9c8-38d9e5a97a0c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6520893a-f2ff-43f8-8cd8-df612c8df516', 2, 'II', 'Largo ma non tanto', 'II. Largo ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6520893a-f2ff-43f8-8cd8-df612c8df516'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88b6ff1b-114b-46e5-aca7-3a2b92bdab7e', 3, 'III', 'Tempo di Menuetto', 'III. Tempo di Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88b6ff1b-114b-46e5-aca7-3a2b92bdab7e'
);


-- W.C 44 플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E장조', 'Sinfonia concertante in E major for flute, 2 violins and cello', 'album', 'W.C 44', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '870ce54c-e029-42aa-b367-3c3e46156d90'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '870ce54c-e029-42aa-b367-3c3e46156d90'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '870ce54c-e029-42aa-b367-3c3e46156d90'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ce1c30b-0165-4342-997c-05baefad5a04', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ce1c30b-0165-4342-997c-05baefad5a04'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c26ee724-ef72-4c28-ae91-34cceacb3562', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c26ee724-ef72-4c28-ae91-34cceacb3562'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bba85e1b-866f-4251-b909-88b7bfba9a5c', 3, 'III', 'Allegro molto', 'III. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트, 두 대의 바이올린과 첼로를 위한 신포니아 콘체르탄테 E장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bba85e1b-866f-4251-b909-88b7bfba9a5c'
);


-- W.C 45 오보에와 현악 3부를 위한 신포니아 콘체르탄테 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에와 현악 3부를 위한 신포니아 콘체르탄테 G장조', 'Sinfonia concertante in G major for oboe and string trio', 'song', 'W.C 45', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에와 현악 3부를 위한 신포니아 콘체르탄테 G장조'
);


-- W.C 46 바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조', 'Sinfonia concertante in B♭ major for violin and cello', 'album', 'W.C 46', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f102ff3b-2848-4770-a28e-5c7aabd89ea5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f102ff3b-2848-4770-a28e-5c7aabd89ea5'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f102ff3b-2848-4770-a28e-5c7aabd89ea5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26bbe27a-c8fa-4626-8137-a2c3c858ab9b', 1, 'I', 'Allegro maestoso', 'I. Allegro maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26bbe27a-c8fa-4626-8137-a2c3c858ab9b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b3448e5-d2d8-4eec-a743-ccee5d631491', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b3448e5-d2d8-4eec-a743-ccee5d631491'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:76d3c75a-f06c-4b88-86ec-3446cd2e5a56', 3, 'III', 'Allegro', 'III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:76d3c75a-f06c-4b88-86ec-3446cd2e5a56'
);


-- W.C 48 피아노, 오보에, 바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노, 오보에, 바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조', 'Sinfonia concertante in B♭ major for piano, oboe, violin and cello', 'album', 'W.C 48', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노, 오보에, 바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac719587-4c52-4528-a994-2c1a781cac15'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ac719587-4c52-4528-a994-2c1a781cac15'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '피아노, 오보에, 바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ac719587-4c52-4528-a994-2c1a781cac15'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9285d4f-2efd-4b57-84c7-a58021b4d608', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '피아노, 오보에, 바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9285d4f-2efd-4b57-84c7-a58021b4d608'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87102140-22cd-44a8-b60e-283de0b524c1', 2, 'II', 'Adagio sostenuto', 'II. Adagio sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '피아노, 오보에, 바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87102140-22cd-44a8-b60e-283de0b524c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8a9ac37-1737-4a10-9bdb-92e4e1aab34e', 3, 'III', '론도. Allegretto', 'III. Rondo: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '피아노, 오보에, 바이올린과 첼로를 위한 신포니아 콘체르탄테 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8a9ac37-1737-4a10-9bdb-92e4e1aab34e'
);


-- W.C 43 신포니아 콘체르탄테 C장조

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8fcb1284-bf74-4d3a-a236-dbd3223a2230', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 108 AND p.composer_id = 23
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8fcb1284-bf74-4d3a-a236-dbd3223a2230'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b951e145-3d98-4651-8a43-d4c6202c8305', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 108 AND p.composer_id = 23
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b951e145-3d98-4651-8a43-d4c6202c8305'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5dcd6f3-865d-48da-a830-e3d24985cc8d', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 108 AND p.composer_id = 23
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5dcd6f3-865d-48da-a830-e3d24985cc8d'
);


-- Op. 14 건반 협주곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '건반 협주곡 E♭장조', 'Keyboard Concerto in E♭ major, Op. 14', 'song', 'Op. 14', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '건반 협주곡 E♭장조'
);


-- W.C 68 쳄발로 협주곡 1번 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쳄발로 협주곡 1번 B♭장조', 'Harpsichord Concerto No. 1 in B♭ major', 'song', 'W.C 68', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쳄발로 협주곡 1번 B♭장조'
);


-- W.C 69 쳄발로 협주곡 2번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쳄발로 협주곡 2번 F단조', 'Harpsichord Concerto No. 2 in F minor', 'song', 'W.C 69', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쳄발로 협주곡 2번 F단조'
);


-- W.C 70 쳄발로 협주곡 3번 D단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쳄발로 협주곡 3번 D단조', 'Harpsichord Concerto No. 3 in D minor', 'song', 'W.C 70', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쳄발로 협주곡 3번 D단조'
);


-- W.C 71 쳄발로 협주곡 4번 E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쳄발로 협주곡 4번 E장조', 'Harpsichord Concerto No. 4 in E major', 'song', 'W.C 71', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쳄발로 협주곡 4번 E장조'
);


-- W.C 72 쳄발로 협주곡 5번 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쳄발로 협주곡 5번 G장조', 'Harpsichord Concerto No. 5 in G major', 'song', 'W.C 72', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쳄발로 협주곡 5번 G장조'
);


-- W.C 73 쳄발로 협주곡 6번 F단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '쳄발로 협주곡 6번 F단조', 'Harpsichord Concerto No. 6 in F minor', 'song', 'W.C 73', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '쳄발로 협주곡 6번 F단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b359bd7-b307-402b-8e0f-f27c92bac8ff'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b359bd7-b307-402b-8e0f-f27c92bac8ff'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '쳄발로 협주곡 6번 F단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b359bd7-b307-402b-8e0f-f27c92bac8ff'
);


-- W.C 75 피아노 협주곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 협주곡 E♭장조', 'Piano Concerto in E♭ major', 'song', 'W.C 75', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 협주곡 E♭장조'
);


-- W.C 76 바이올린 협주곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 C장조', 'Violin Concerto in C major', 'album', 'W.C 76', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a26af817-f63d-4ded-a0d7-b1ea0614a8b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a26af817-f63d-4ded-a0d7-b1ea0614a8b7'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a26af817-f63d-4ded-a0d7-b1ea0614a8b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a57e6c3-cf4b-4b67-a1f0-0220a5ffebce', 1, 'I', 'Allegro vivace', 'I. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a57e6c3-cf4b-4b67-a1f0-0220a5ffebce'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:012cfa6a-1e06-4249-95db-b4e1a8ab1b6a', 2, 'II', 'Largo', 'II. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:012cfa6a-1e06-4249-95db-b4e1a8ab1b6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df33a0c6-6611-4cb9-b672-8841b4ecc264', 3, 'III', '론도 – Allegro assai', 'III. Rondo – Allegro assai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바이올린 협주곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df33a0c6-6611-4cb9-b672-8841b4ecc264'
);


-- W.C 78 플루트 협주곡 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 협주곡 G장조', 'Flute Concerto in G major', 'song', 'W.C 78', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 협주곡 G장조'
);


-- W.C 79 플루트 협주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '플루트 협주곡 D장조', 'Flute Concerto in D major', 'album', 'W.C 79', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '플루트 협주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9abf7e1-7bd7-48ae-960c-c7da5d45b847'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e9abf7e1-7bd7-48ae-960c-c7da5d45b847'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e9abf7e1-7bd7-48ae-960c-c7da5d45b847'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2b101289-a851-4514-b651-ab6d27d3c128', 1, 'I', 'Allegro con brio', 'I. Allegro con brio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2b101289-a851-4514-b651-ab6d27d3c128'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09f3e8de-3df6-4fca-aee8-5a877c35413c', 2, 'II', '론도. Allegretto', 'II. Rondeaux: Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '플루트 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09f3e8de-3df6-4fca-aee8-5a877c35413c'
);


-- W.C 80 오보에 협주곡 1번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 1번 F장조', 'Oboe Concerto No. 1 in F major', 'album', 'W.C 80', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 1번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8152d145-3bfe-4a73-9398-487f40d3448b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8152d145-3bfe-4a73-9398-487f40d3448b'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에 협주곡 1번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8152d145-3bfe-4a73-9398-487f40d3448b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e7d811f-cb2a-442e-b243-18f6d9077598', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에 협주곡 1번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e7d811f-cb2a-442e-b243-18f6d9077598'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:626caf6a-cf4c-4b1b-8f83-636c71e4dc70', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에 협주곡 1번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:626caf6a-cf4c-4b1b-8f83-636c71e4dc70'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4709eef-ef11-44d1-b71e-089ef3d4e649', 3, 'III', 'Tempo di Minuetto', 'III. Tempo di Minuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에 협주곡 1번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4709eef-ef11-44d1-b71e-089ef3d4e649'
);


-- W.C 81 오보에 협주곡 2번 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오보에 협주곡 2번 F장조', 'Oboe Concerto No. 2 in F major', 'album', 'W.C 81', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오보에 협주곡 2번 F장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8755aea5-bdca-4460-a448-716caa3f8df0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8755aea5-bdca-4460-a448-716caa3f8df0'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8755aea5-bdca-4460-a448-716caa3f8df0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bb380d3-502f-42ab-b021-35f578bcd747', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bb380d3-502f-42ab-b021-35f578bcd747'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7a35ad8-98b7-4a02-895c-73bb2d9b6245', 2, 'II', 'Larghetto', 'II. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7a35ad8-98b7-4a02-895c-73bb2d9b6245'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:671d6b32-b4da-46f7-ae16-2f9e86d735f8', 3, 'III', '론도. Allegretto', 'III. Rondeau. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오보에 협주곡 2번 F장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:671d6b32-b4da-46f7-ae16-2f9e86d735f8'
);


-- W.C 82 바순 협주곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바순 협주곡 E♭장조', 'Bassoon Concerto in E♭ major', 'album', 'W.C 82', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바순 협주곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93f8ee7c-e143-4c67-a5da-fb0607256693'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '93f8ee7c-e143-4c67-a5da-fb0607256693'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바순 협주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '93f8ee7c-e143-4c67-a5da-fb0607256693'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21d68d90-5439-4b8b-96d8-6ec974d0d36f', 1, 'I', 'Allegro spirituoso', 'I. Allegro spirituoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바순 협주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21d68d90-5439-4b8b-96d8-6ec974d0d36f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcfc3397-d0cd-41b3-a424-e579b5852806', 2, 'II', 'Largo ma non tanto', 'II. Largo ma non tanto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바순 협주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcfc3397-d0cd-41b3-a424-e579b5852806'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9bf16ab-bab0-4dfb-963d-9b0e53e91e60', 3, 'III', 'Tempo di Menuetto', 'III. Tempo di Menuetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바순 협주곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9bf16ab-bab0-4dfb-963d-9b0e53e91e60'
);


-- W.C 83 바순 협주곡 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바순 협주곡 B♭장조', 'Bassoon Concerto in B♭ major', 'album', 'W.C 83', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바순 협주곡 B♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c96bfd09-d082-4b98-8c2c-5165328f7107'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c96bfd09-d082-4b98-8c2c-5165328f7107'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바순 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c96bfd09-d082-4b98-8c2c-5165328f7107'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e59e3a7-ba0d-499a-9519-0c378ab4ce3f', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바순 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e59e3a7-ba0d-499a-9519-0c378ab4ce3f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:698dbf43-308d-436f-87e5-eb192d5d52cb', 2, 'II', 'Adagio', 'II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바순 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:698dbf43-308d-436f-87e5-eb192d5d52cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f489e4c6-413c-4ead-88b8-9bfd55dc8259', 3, 'III', 'Presto', 'III. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '바순 협주곡 B♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f489e4c6-413c-4ead-88b8-9bfd55dc8259'
);


-- W.C 84 왕비 탄신일 미뉴에트 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왕비 탄신일 미뉴에트 F장조', 'Minuet for Her Majesty''s Birthday in F major', 'song', 'W.C 84', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왕비 탄신일 미뉴에트 F장조'
);


-- W.C 85 왕비 탄신일 미뉴에트 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왕비 탄신일 미뉴에트 C장조', 'Minuet for Her Majesty''s Birthday in C major', 'song', 'W.C 85', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왕비 탄신일 미뉴에트 C장조'
);


-- W.D 1 오라토리오 <Gioas, re di Giuda>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오라토리오 <Gioas, re di Giuda>', 'Gioas, re di Giuda', 'song', 'W.D 1', NULL, NULL, 1770, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오라토리오 <Gioas, re di Giuda>'
);


-- W.E 2 키리에 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '키리에 D장조', 'Kyrie in D major', 'song', 'W.E 2', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '키리에 D장조'
);


-- W.E 3 글로리아 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '글로리아 D장조', 'Gloria in D major', 'song', 'W.E 3', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '글로리아 D장조'
);


-- W.E 4 글로리아 G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '글로리아 G장조', 'Gloria in G major', 'song', 'W.E 4', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '글로리아 G장조'
);


-- W.E 5 크레도 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '크레도 C장조', 'Credo in C major', 'song', 'W.E 5', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '크레도 C장조'
);


-- W.E 6 <Invitatorium> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Invitatorium> F장조', 'Invitatorium in F major', 'song', 'W.E 6', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Invitatorium> F장조'
);


-- W.E 10 미제레레 B♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미제레레 B♭장조', 'Miserere in B♭ major', 'song', 'W.E 10', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미제레레 B♭장조'
);


-- W.E 11 <Ingresso e Kyrie della Messa de' morti> C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Ingresso e Kyrie della Messa de'' morti> C단조', 'Ingresso e Kyrie della Messa de'' morti in C minor', 'song', 'W.E 11', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Ingresso e Kyrie della Messa de'' morti> C단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6abddd47-cbfa-411c-8690-947c608d893c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6abddd47-cbfa-411c-8690-947c608d893c'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '<Ingresso e Kyrie della Messa de'' morti> C단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6abddd47-cbfa-411c-8690-947c608d893c'
);


-- W.E 12 <Dies irae> C단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Dies irae> C단조', 'Dies irae in C minor', 'song', 'W.E 12', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Dies irae> C단조'
);


-- W.E 13 <Domine ad adjuvandum> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Domine ad adjuvandum> D장조', 'Domine ad adjuvandum in D major', 'song', 'W.E 13', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Domine ad adjuvandum> D장조'
);


-- W.E 14 <Domine ad adjuvandum> G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Domine ad adjuvandum> G장조', 'Domine ad adjuvandum in G major', 'song', 'W.E 14', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Domine ad adjuvandum> G장조'
);


-- W.E 15 <Dixit Dominus> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Dixit Dominus> D장조', 'Dixit Dominus in D major', 'song', 'W.E 15', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Dixit Dominus> D장조'
);


-- W.E 16 <Confitebor tibi Domine> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Confitebor tibi Domine> E♭장조', 'Confitebor tibi Domine in E♭ major', 'song', 'W.E 16', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Confitebor tibi Domine> E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7ccfbb5-4f23-4632-8538-2d6ddf9daa68'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b7ccfbb5-4f23-4632-8538-2d6ddf9daa68'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '<Confitebor tibi Domine> E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7ccfbb5-4f23-4632-8538-2d6ddf9daa68'
);


-- W.E 17 <Beatus vir> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Beatus vir> F장조', 'Beatus vir in F major', 'song', 'W.E 17', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Beatus vir> F장조'
);


-- W.E 18 <Laudate pueri> E장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Laudate pueri> E장조', 'Laudate pueri in E major', 'song', 'W.E 18', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Laudate pueri> E장조'
);


-- W.E 19 <Laudate pueri> G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Laudate pueri> G장조', 'Laudate pueri in G major', 'song', 'W.E 19', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Laudate pueri> G장조'
);


-- W.E 21 8성부 마니피캇 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8성부 마니피캇 C장조', 'Magnificat a 8 in C major', 'song', 'W.E 21', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8성부 마니피캇 C장조'
);


-- W.E 22 4성부 마니피캇 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4성부 마니피캇 C장조', 'Magnificat a 4 in C major', 'song', 'W.E 22', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4성부 마니피캇 C장조'
);


-- W.E 23 살베 레지나 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '살베 레지나 E♭장조', 'Salve Regina in E♭ major', 'song', 'W.E 23', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '살베 레지나 E♭장조'
);


-- W.E 24 살베 레지나 F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '살베 레지나 F장조', 'Salve Regina in F major', 'song', 'W.E 24', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '살베 레지나 F장조'
);


-- W.E 25 <Tantum ergo> F장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Tantum ergo> F장조', 'Tantum ergo in F major', 'song', 'W.E 25', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Tantum ergo> F장조'
);


-- W.E 26 <Tantum ergo> G장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Tantum ergo> G장조', 'Tantum ergo in G major', 'song', 'W.E 26', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Tantum ergo> G장조'
);


-- W.E 28 4성부 테 데움 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4성부 테 데움 D장조', 'Te Deum a 4 in D major', 'song', 'W.E 28', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4성부 테 데움 D장조'
);


-- W.E 7 <Lectio del officio per gli morti> 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Lectio del officio per gli morti> 1번', 'Lectio del officio per gli morti I', 'song', 'W.E 7', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Lectio del officio per gli morti> 1번'
);


-- W.E 8 <Lectio del officio per gli morti> 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Lectio del officio per gli morti> 2번', 'Lectio del officio per gli morti II', 'song', 'W.E 8', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Lectio del officio per gli morti> 2번'
);


-- W.E 9 <Lectio del officio per gli morti> 3번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Lectio del officio per gli morti> 3번', 'Lectio del officio per gli morti III', 'song', 'W.E 9', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Lectio del officio per gli morti> 3번'
);


-- W.F 2 모테트 <Attendite mortales> A단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Attendite mortales> A단조', 'Attendite mortales in A minor', 'song', 'W.F 2', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Attendite mortales> A단조'
);


-- W.F 3 모테트 <Larvae tremendae> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Larvae tremendae> D장조', 'Larvae tremendae in D major', 'song', 'W.F 3', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Larvae tremendae> D장조'
);


-- W.F 4a 모테트 <Si nocte tenebrosa> G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '모테트 <Si nocte tenebrosa> G단조', 'Si nocte tenebrosa in G minor (for Raaf)', 'song', 'W.F 4a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '모테트 <Si nocte tenebrosa> G단조'
);


-- W.F 5 <Let the solemn organs blow> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<Let the solemn organs blow> D장조', 'Let the solemn organs blow in D major', 'song', 'W.F 5', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<Let the solemn organs blow> D장조'
);


-- W.G 1 오페라 <Artaserse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Artaserse>', 'Artaserse', 'song', 'W.G 1', NULL, NULL, 1760, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Artaserse>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03bf6ee3-2621-4fca-980e-14077c01d45e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '03bf6ee3-2621-4fca-980e-14077c01d45e'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <Artaserse>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '03bf6ee3-2621-4fca-980e-14077c01d45e'
);


-- W.G 2 오페라 <Catone in Utica>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Catone in Utica>', 'Catone in Utica', 'song', 'W.G 2', NULL, NULL, 1761, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Catone in Utica>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1513f8a-7449-4814-9d7d-522b0ebb8d5b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c1513f8a-7449-4814-9d7d-522b0ebb8d5b'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <Catone in Utica>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c1513f8a-7449-4814-9d7d-522b0ebb8d5b'
);


-- W.G 3 오페라 <Alessandro nell'Indie>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Alessandro nell''Indie>', 'Alessandro nell''Indie', 'song', 'W.G 3', NULL, NULL, 1762, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Alessandro nell''Indie>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7896c6c-6604-4458-9757-cf896bdde51c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f7896c6c-6604-4458-9757-cf896bdde51c'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <Alessandro nell''Indie>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f7896c6c-6604-4458-9757-cf896bdde51c'
);


-- W.G 4 오페라 <Orione>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Orione>', 'Orione, ossia Diana vendicata', 'song', 'W.G 4', NULL, NULL, 1763, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Orione>'
);


-- W.G 5 오페라 <Zanaida>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Zanaida>', 'Zanaida', 'song', 'W.G 5', NULL, NULL, 1763, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Zanaida>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1bd98cf-263e-4b3d-8d3a-3a24e63eaa95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e1bd98cf-263e-4b3d-8d3a-3a24e63eaa95'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <Zanaida>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e1bd98cf-263e-4b3d-8d3a-3a24e63eaa95'
);


-- W.G 6 오페라 <Adriano in Siria>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Adriano in Siria>', 'Adriano in Siria', 'song', 'W.G 6', NULL, NULL, 1765, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Adriano in Siria>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90b43f84-44ce-45d0-b0e3-31a0e33bcba4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '90b43f84-44ce-45d0-b0e3-31a0e33bcba4'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <Adriano in Siria>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '90b43f84-44ce-45d0-b0e3-31a0e33bcba4'
);


-- W.G 7 오페라 <Carattaco>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Carattaco>', 'Carattaco', 'song', 'W.G 7', NULL, NULL, 1767, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Carattaco>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccbd20ad-8849-4adc-a7c3-1f5c45b932e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ccbd20ad-8849-4adc-a7c3-1f5c45b932e5'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <Carattaco>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ccbd20ad-8849-4adc-a7c3-1f5c45b932e5'
);


-- W.G 8 오페라 <Temistocle>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Temistocle>', 'Temistocle', 'song', 'W.G 8', NULL, NULL, 1772, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Temistocle>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '829fd1b9-e034-4a86-b68f-2f806a32d491'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '829fd1b9-e034-4a86-b68f-2f806a32d491'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <Temistocle>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '829fd1b9-e034-4a86-b68f-2f806a32d491'
);


-- W.G 9 오페라 <Lucio Silla>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Lucio Silla>', 'Lucio Silla', 'song', 'W.G 9', NULL, NULL, 1775, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Lucio Silla>'
);


-- W.G 10 오페라 <La clemenza di Scipione>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <La clemenza di Scipione>', 'La clemenza di Scipione', 'song', 'W.G 10', NULL, NULL, 1778, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <La clemenza di Scipione>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b70d4770-a0ca-449b-aa55-0cdb1db90e7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b70d4770-a0ca-449b-aa55-0cdb1db90e7f'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <La clemenza di Scipione>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b70d4770-a0ca-449b-aa55-0cdb1db90e7f'
);


-- W.G 39 오페라 <Amadis de Gaule>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <Amadis de Gaule>', 'Amadis de Gaule', 'song', 'W.G 39', NULL, NULL, 1779, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <Amadis de Gaule>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e34bf7c0-9d6b-4a5e-887c-2cd4c95d15a3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e34bf7c0-9d6b-4a5e-887c-2cd4c95d15a3'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '오페라 <Amadis de Gaule>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e34bf7c0-9d6b-4a5e-887c-2cd4c95d15a3'
);


-- W.G 11 3성부 칸타타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3성부 칸타타', 'Cantata a tre voci', 'song', 'W.G 11', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3성부 칸타타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af264371-58cf-47be-952b-7826bdff0c50'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af264371-58cf-47be-952b-7826bdff0c50'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '3성부 칸타타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af264371-58cf-47be-952b-7826bdff0c50'
);


-- W.G 15 세레나타 <Endimione>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나타 <Endimione>', 'Endimione', 'song', 'W.G 15', NULL, NULL, 1772, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나타 <Endimione>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '314414db-ef17-445d-959e-fdda87a50b56'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '314414db-ef17-445d-959e-fdda87a50b56'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '세레나타 <Endimione>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '314414db-ef17-445d-959e-fdda87a50b56'
);


-- W.G 16 칸타타 <La tempesta>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <La tempesta>', 'La tempesta', 'song', 'W.G 16', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <La tempesta>'
);


-- W.G 17 칸타타 <O Venere vezzosa>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <O Venere vezzosa>', 'O Venere vezzosa', 'song', 'W.G 17', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <O Venere vezzosa>'
);


-- W.G 18 칸타타 <Amor vincitore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Amor vincitore>', 'Amor vincitore', 'song', 'W.G 18', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Amor vincitore>'
);


-- W.G 19 칸타타 <Cefalo e Procri>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <Cefalo e Procri>', 'Cefalo e Procri', 'song', 'W.G 19', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <Cefalo e Procri>'
);


-- W.G 34 아리아 <Vo solcando un mar crudele> D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Vo solcando un mar crudele> D장조', 'Vo solcando un mar crudele in D major', 'song', 'W.G 34', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Vo solcando un mar crudele> D장조'
);


-- W.G 35 아리아 <Sventurata in van mi lagno> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Sventurata in van mi lagno> E♭장조', 'Sventurata in van mi lagno in E♭ major', 'song', 'W.G 35', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Sventurata in van mi lagno> E♭장조'
);


-- W.G 36a 아리아 <Perchè si ingrata, oh Dio!> E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아리아 <Perchè si ingrata, oh Dio!> E♭장조', 'Perchè si ingrata, oh Dio! in E♭ major', 'song', 'W.G 36a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아리아 <Perchè si ingrata, oh Dio!> E♭장조'
);


-- W.G 36b 레치타티보와 아리아 <Ah che gli stessi numi... Cara ti lascio>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레치타티보와 아리아 <Ah che gli stessi numi... Cara ti lascio>', 'Ah che gli stessi numi... Cara ti lascio', 'song', 'W.G 36b', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레치타티보와 아리아 <Ah che gli stessi numi... Cara ti lascio>'
);


-- W.G 37 레치타티보와 아리아 <A si barbaro colpo... Morte, vieni>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레치타티보와 아리아 <A si barbaro colpo... Morte, vieni>', 'A si barbaro colpo... Morte, vieni', 'song', 'W.G 37', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레치타티보와 아리아 <A si barbaro colpo... Morte, vieni>'
);


-- W.G 41 송가 <Happy Morn, auspicious rise>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '송가 <Happy Morn, auspicious rise>', 'Happy Morn, auspicious rise', 'song', 'W.G 41', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '송가 <Happy Morn, auspicious rise>'
);


-- W.H 1 가곡 <Mezendore>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Mezendore>', 'Mezendore', 'song', 'W.H 1', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Mezendore>'
);


-- W.H 2 가곡 <Der Weise auf dem Lande>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Der Weise auf dem Lande>', 'Der Weise auf dem Lande', 'song', 'W.H 2', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Der Weise auf dem Lande>'
);


-- W.H 4 칸초네타 <Io lo so, che il bel sembiante>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 <Io lo so, che il bel sembiante>', 'Canzonetta: Io lo so, che il bel sembiante', 'song', 'W.H 4', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 <Io lo so, che il bel sembiante>'
);


-- W.H 5 칸초네타 <Trova un sol, mia bella Clori>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 <Trova un sol, mia bella Clori>', 'Canzonetta: Trova un sol, mia bella Clori', 'song', 'W.H 5', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 <Trova un sol, mia bella Clori>'
);


-- W.H 6 칸초네타 <Che ciascun per te sospiri>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 <Che ciascun per te sospiri>', 'Canzonetta: Che ciascun per te sospiri', 'song', 'W.H 6', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 <Che ciascun per te sospiri>'
);


-- W.H 7 칸초네타 <Chi mai di questo core>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 <Chi mai di questo core>', 'Canzonetta: Chi mai di questo core', 'song', 'W.H 7', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 <Chi mai di questo core>'
);


-- W.H 8 칸초네타 <Ascoltami, o Clori>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 <Ascoltami, o Clori>', 'Canzonetta: Ascoltami, o Clori', 'song', 'W.H 8', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 <Ascoltami, o Clori>'
);


-- W.H 9 칸초네타 <Lascia ch'io possa, o Nice>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 <Lascia ch''io possa, o Nice>', 'Canzonetta: Lascia ch''io possa, o Nice', 'song', 'W.H 9', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 <Lascia ch''io possa, o Nice>'
);


-- W.H 10 칸초네타 <Parlami pur sincera>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 <Parlami pur sincera>', 'Canzonetta: Parlami pur sincera', 'song', 'W.H 10', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 <Parlami pur sincera>'
);


-- W.H 11 칸초네타 <Eccomi alfin disciolto>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸초네타 <Eccomi alfin disciolto>', 'Canzonetta: Eccomi alfin disciolto', 'song', 'W.H 11', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸초네타 <Eccomi alfin disciolto>'
);


-- W.H 24 가곡 <By my sighs you may discover>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <By my sighs you may discover>', 'Vauxhall Song: By my sighs you may discover', 'song', 'W.H 24', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <By my sighs you may discover>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '142b4259-f373-48ed-8df8-ff59e9997ce1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '142b4259-f373-48ed-8df8-ff59e9997ce1'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <By my sighs you may discover>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '142b4259-f373-48ed-8df8-ff59e9997ce1'
);


-- W.H 25 가곡 <Cruel Strephon, will you leave me>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Cruel Strephon, will you leave me>', 'Vauxhall Song: Cruel Strephon, will you leave me', 'song', 'W.H 25', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Cruel Strephon, will you leave me>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '412cc80c-1769-4b4e-ac20-3acd4c2708d2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '412cc80c-1769-4b4e-ac20-3acd4c2708d2'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Cruel Strephon, will you leave me>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '412cc80c-1769-4b4e-ac20-3acd4c2708d2'
);


-- W.H 26 가곡 <Come Colin, pride of rural swains>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Come Colin, pride of rural swains>', 'Vauxhall Song: Come Colin, pride of rural swains', 'song', 'W.H 26', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Come Colin, pride of rural swains>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '620bbfe6-1f63-4ece-b277-d079a040e576'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '620bbfe6-1f63-4ece-b277-d079a040e576'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Come Colin, pride of rural swains>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '620bbfe6-1f63-4ece-b277-d079a040e576'
);


-- W.H 27 가곡 <Ah, why shou'd love with tyrant sway>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ah, why shou''d love with tyrant sway>', 'Vauxhall Song: Ah, why shou''d love with tyrant sway', 'song', 'W.H 27', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ah, why shou''d love with tyrant sway>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7769855-7714-476a-8fc0-d8d3fb366fc7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b7769855-7714-476a-8fc0-d8d3fb366fc7'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Ah, why shou''d love with tyrant sway>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b7769855-7714-476a-8fc0-d8d3fb366fc7'
);


-- W.H 28 가곡 <In this shady blest retreat>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <In this shady blest retreat>', 'Vauxhall Song: In this shady blest retreat', 'song', 'W.H 28', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <In this shady blest retreat>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb42d7d1-56f6-411d-8afd-03cd425dce4d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fb42d7d1-56f6-411d-8afd-03cd425dce4d'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <In this shady blest retreat>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fb42d7d1-56f6-411d-8afd-03cd425dce4d'
);


-- W.H 29 가곡 <Smiling Venus, Goddess dear>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Smiling Venus, Goddess dear>', 'Vauxhall Song: Smiling Venus, Goddess dear', 'song', 'W.H 29', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Smiling Venus, Goddess dear>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a669059a-b562-4d40-9c75-dc6b518a0a52'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a669059a-b562-4d40-9c75-dc6b518a0a52'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Smiling Venus, Goddess dear>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a669059a-b562-4d40-9c75-dc6b518a0a52'
);


-- W.H 30 가곡 <Tender Virgins, shun deceivers>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tender Virgins, shun deceivers>', 'Vauxhall Song: Tender Virgins, shun deceivers', 'song', 'W.H 30', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tender Virgins, shun deceivers>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '581e1860-339b-498b-b398-13b27e6eabf2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '581e1860-339b-498b-b398-13b27e6eabf2'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Tender Virgins, shun deceivers>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '581e1860-339b-498b-b398-13b27e6eabf2'
);


-- W.H 31 가곡 <Lovely yet ungrateful swain>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Lovely yet ungrateful swain>', 'Vauxhall Song: Lovely yet ungrateful swain', 'song', 'W.H 31', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Lovely yet ungrateful swain>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '331bf235-9d5a-466f-863d-527f57b44f20'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '331bf235-9d5a-466f-863d-527f57b44f20'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Lovely yet ungrateful swain>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '331bf235-9d5a-466f-863d-527f57b44f20'
);


-- W.H 33 가곡 <Midst silent shades and purling streams>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Midst silent shades and purling streams>', 'Vauxhall Song: Midst silent shades and purling streams', 'song', 'W.H 33', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Midst silent shades and purling streams>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd534b44-8a99-4ab3-a647-d3083374650e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cd534b44-8a99-4ab3-a647-d3083374650e'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Midst silent shades and purling streams>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cd534b44-8a99-4ab3-a647-d3083374650e'
);


-- W.H 34 가곡 <Ah seek to know what place detains>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Ah seek to know what place detains>', 'Vauxhall Song: Ah seek to know what place detains', 'song', 'W.H 34', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Ah seek to know what place detains>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf7e2a90-00c1-4d6a-8099-eea0a252ed17'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf7e2a90-00c1-4d6a-8099-eea0a252ed17'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Ah seek to know what place detains>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf7e2a90-00c1-4d6a-8099-eea0a252ed17'
);


-- W.H 35 가곡 <Would you a female heart inspire>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Would you a female heart inspire>', 'Vauxhall Song: Would you a female heart inspire', 'song', 'W.H 35', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Would you a female heart inspire>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f119d01-45f6-4e79-9c60-d2d9635c768b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4f119d01-45f6-4e79-9c60-d2d9635c768b'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Would you a female heart inspire>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4f119d01-45f6-4e79-9c60-d2d9635c768b'
);


-- W.H 36 가곡 <Cease a while ye winds to blow>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Cease a while ye winds to blow>', 'Vauxhall Song: Cease a while ye winds to blow', 'song', 'W.H 36', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Cease a while ye winds to blow>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df3ed95b-0e1a-4fdf-b28e-253766071acc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'df3ed95b-0e1a-4fdf-b28e-253766071acc'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Cease a while ye winds to blow>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'df3ed95b-0e1a-4fdf-b28e-253766071acc'
);


-- W.H 37 가곡 <See the kind indulgent gales>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <See the kind indulgent gales>', 'Vauxhall Song: See the kind indulgent gales', 'song', 'W.H 37', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <See the kind indulgent gales>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb82b2a9-8261-417b-ab1c-f64945f94245'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cb82b2a9-8261-417b-ab1c-f64945f94245'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <See the kind indulgent gales>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cb82b2a9-8261-417b-ab1c-f64945f94245'
);


-- W.H 38 가곡 <Oh how blest is the condition>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Oh how blest is the condition>', 'Vauxhall Song: Oh how blest is the condition', 'song', 'W.H 38', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Oh how blest is the condition>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '915528ce-670c-4c3d-bf26-3aaa0aab8771'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '915528ce-670c-4c3d-bf26-3aaa0aab8771'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Oh how blest is the condition>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '915528ce-670c-4c3d-bf26-3aaa0aab8771'
);


-- W.H 39 가곡 <Hither turn thy wand'ring eyes>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Hither turn thy wand''ring eyes>', 'Vauxhall Song: Hither turn thy wand''ring eyes', 'song', 'W.H 39', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Hither turn thy wand''ring eyes>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b23ea3d-d6e1-4b22-8f40-0af76eeafdcc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7b23ea3d-d6e1-4b22-8f40-0af76eeafdcc'
FROM pieces p
WHERE p.composer_id = 23 AND p.title = '가곡 <Hither turn thy wand''ring eyes>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7b23ea3d-d6e1-4b22-8f40-0af76eeafdcc'
);


-- W.H 43 가곡 <Neptune>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Neptune>', 'Neptune', 'song', 'W.H 43', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 23
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Neptune>'
);


-- 108 「신포니아 콘체르탄테 C장조」는 MBID·편성(플루트·오보에·바이올린·첼로)이 W.C 43 이다. W.C 34 는 이번에 따로 들어가는 A장조 곡이다.
UPDATE pieces piece
SET piece.opus_number = 'W.C 43'
WHERE piece.id = 108 AND piece.composer_id = 23 AND piece.opus_number = 'W.C 34';
