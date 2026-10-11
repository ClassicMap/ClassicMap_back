-- 요한 슈트라우스 1세 작품을 출판 단위로 채운다(카탈로그: Op.). 작품 246개(묶음 2, 다악장 0, 낱곡 244),
-- 새 작품 244개, 기존 작품 2개, part 4개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   작품번호가 곡 단위라 대부분 낱곡이다. 남의 오페라 선율로 엮은 곡과 포푸리는 뺀다.
--   제목은 앞에 우리말 갈래를 두고 원제를 꺾쇠 안에 그대로 둔다(「왈츠 <…>」, 「갤럽 <…>」).
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

-- Op. 1 왈츠 <Täuberln-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Täuberln-Walzer>', 'Waltz <Täuberln-Walzer>', 'song', 'Op. 1', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Täuberln-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6647e3d9-502a-472b-a87b-3409739798a8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6647e3d9-502a-472b-a87b-3409739798a8'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Täuberln-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6647e3d9-502a-472b-a87b-3409739798a8'
);


-- Op. 2 왈츠 <Döblinger Réunion-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Döblinger Réunion-Walzer>', 'Waltz <Döblinger Réunion-Walzer>', 'song', 'Op. 2', NULL, NULL, 1826, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Döblinger Réunion-Walzer>'
);


-- Op. 3 왈츠 <Wiener Carneval-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wiener Carneval-Walzer>', 'Waltz <Wiener Carneval-Walzer>', 'song', 'Op. 3', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wiener Carneval-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f328ef83-0758-4d5c-8a90-a8f8a9db4671'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f328ef83-0758-4d5c-8a90-a8f8a9db4671'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Wiener Carneval-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f328ef83-0758-4d5c-8a90-a8f8a9db4671'
);


-- Op. 4 왈츠 <Kettenbrücke-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Kettenbrücke-Walzer>', 'Waltz <Kettenbrücke-Walzer>', 'song', 'Op. 4', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Kettenbrücke-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e044166-2bd7-4e7c-949b-79299fb8e1be'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2e044166-2bd7-4e7c-949b-79299fb8e1be'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Kettenbrücke-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2e044166-2bd7-4e7c-949b-79299fb8e1be'
);


-- Op. 5 왈츠 <Gesellschafts-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gesellschafts-Walzer>', 'Waltz <Gesellschafts-Walzer>', 'song', 'Op. 5', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gesellschafts-Walzer>'
);


-- Op. 6 왈츠 <Wiener Launen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wiener Launen-Walzer>', 'Waltz <Wiener Launen-Walzer>', 'song', 'Op. 6', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wiener Launen-Walzer>'
);


-- Op. 7 갤럽 <Alpenkönig-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Alpenkönig-Galoppe>', 'Galop <Alpenkönig-Galoppe>', 'album', 'Op. 7', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Alpenkönig-Galoppe>'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:strauss1:strauss1-op7:1', 1, NULL, 'Alpenkönig-Galopp', 'No. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Alpenkönig-Galoppe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:strauss1:strauss1-op7:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:strauss1:strauss1-op7:2', 2, NULL, 'Alpenkönig-Galopp', 'No. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Alpenkönig-Galoppe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:strauss1:strauss1-op7:2'
);


-- Op. 8 갤럽 <Champagner-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Champagner-Galoppe>', 'Galop <Champagner-Galoppe>', 'song', 'Op. 8', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Champagner-Galoppe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21e51d5d-879a-409a-a8e8-8168814b4981'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21e51d5d-879a-409a-a8e8-8168814b4981'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Champagner-Galoppe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21e51d5d-879a-409a-a8e8-8168814b4981'
);


-- Op. 9 갤럽 <Seufzer-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Seufzer-Galoppe>', 'Galop <Seufzer-Galoppe>', 'song', 'Op. 9', NULL, NULL, 1827, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Seufzer-Galoppe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00766de6-2175-48d6-8c22-ed85a4bc28df'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '00766de6-2175-48d6-8c22-ed85a4bc28df'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Seufzer-Galoppe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '00766de6-2175-48d6-8c22-ed85a4bc28df'
);


-- Op. 10 무곡 <Alte und neue Tempête, Polstertanz und Galoppade>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무곡 <Alte und neue Tempête, Polstertanz und Galoppade>', 'Dance <Alte und neue Tempête, Polstertanz und Galoppade>', 'song', 'Op. 10', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무곡 <Alte und neue Tempête, Polstertanz und Galoppade>'
);


-- Op. 11 왈츠 <Walzer à la Paganini>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Walzer à la Paganini>', 'Waltz <Walzer à la Paganini>', 'song', 'Op. 11', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Walzer à la Paganini>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab109dec-5d48-4fba-b196-c40804db7f29'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab109dec-5d48-4fba-b196-c40804db7f29'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Walzer à la Paganini>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab109dec-5d48-4fba-b196-c40804db7f29'
);


-- Op. 12 왈츠 <Krapfen-Waldel-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Krapfen-Waldel-Walzer>', 'Waltz <Krapfen-Waldel-Walzer>', 'song', 'Op. 12', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Krapfen-Waldel-Walzer>'
);


-- Op. 13 왈츠 <Die beliebten Trompetenwalzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die beliebten Trompetenwalzer>', 'Waltz <Die beliebten Trompetenwalzer>', 'song', 'Op. 13', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die beliebten Trompetenwalzer>'
);


-- Op. 14 왈츠 <Champagner-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Champagner-Walzer>', 'Waltz <Champagner-Walzer>', 'song', 'Op. 14', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Champagner-Walzer>'
);


-- Op. 15 렌틀러 <Die so sehr beliebten Erinnerungs-Ländler>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '렌틀러 <Die so sehr beliebten Erinnerungs-Ländler>', 'Ländler <Die so sehr beliebten Erinnerungs-Ländler>', 'song', 'Op. 15', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '렌틀러 <Die so sehr beliebten Erinnerungs-Ländler>'
);


-- Op. 16 왈츠 <Fort nacheinander!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Fort nacheinander!>', 'Waltz <Fort nacheinander!>', 'song', 'Op. 16', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Fort nacheinander!>'
);


-- Op. 17 갤럽 <Gesellschafts-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Gesellschafts-Galoppe>', 'Galop <Gesellschafts-Galoppe>', 'song', 'Op. 17', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Gesellschafts-Galoppe>'
);


-- Op. 18 왈츠 <Lustlager-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Lustlager-Walzer>', 'Waltz <Lustlager-Walzer>', 'song', 'Op. 18', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Lustlager-Walzer>'
);


-- Op. 19 왈츠 <Kettenbrücke-Walzer (2. Lieferung)>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Kettenbrücke-Walzer (2. Lieferung)>', 'Waltz <Kettenbrücke-Walzer (2. Lieferung)>', 'song', 'Op. 19', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Kettenbrücke-Walzer (2. Lieferung)>'
);


-- Op. 20 갤럽 <Chineser-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Chineser-Galoppe>', 'Galop <Chineser-Galoppe>', 'song', 'Op. 20', NULL, NULL, 1828, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Chineser-Galoppe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a6842f1-dcb3-434d-a84b-42c09d3693b0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8a6842f1-dcb3-434d-a84b-42c09d3693b0'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Chineser-Galoppe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8a6842f1-dcb3-434d-a84b-42c09d3693b0'
);


-- Op. 21 갤럽 <Carolinen-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Carolinen-Galoppe>', 'Galop <Carolinen-Galoppe>', 'song', 'Op. 21', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Carolinen-Galoppe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '520c2b07-16ca-4762-9d06-722860ea7bcb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '520c2b07-16ca-4762-9d06-722860ea7bcb'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Carolinen-Galoppe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '520c2b07-16ca-4762-9d06-722860ea7bcb'
);


-- Op. 21a 갤럽 <Kettenbrücke-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Kettenbrücke-Galoppe>', 'Galop <Kettenbrücke-Galoppe>', 'song', 'Op. 21a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Kettenbrücke-Galoppe>'
);


-- Op. 22 왈츠 <Es ist nur ein Wien!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Es ist nur ein Wien!>', 'Waltz <Es ist nur ein Wien!>', 'song', 'Op. 22', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Es ist nur ein Wien!>'
);


-- Op. 23 왈츠 <Josefstädter Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Josefstädter Tänze>', 'Waltz <Josefstädter Tänze>', 'song', 'Op. 23', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Josefstädter Tänze>'
);


-- Op. 24 왈츠 <Hietzinger Reunion>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Hietzinger Reunion>', 'Waltz <Hietzinger Reunion>', 'song', 'Op. 24', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Hietzinger Reunion>'
);


-- Op. 26 왈츠 <Frohsinn im Gebirge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Frohsinn im Gebirge>', 'Waltz <Frohsinn im Gebirge>', 'song', 'Op. 26', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Frohsinn im Gebirge>'
);


-- Op. 27 갤럽 <Erinnerungs-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Erinnerungs-Galoppe>', 'Galop <Erinnerungs-Galoppe>', 'song', 'Op. 27', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Erinnerungs-Galoppe>'
);


-- Op. 28 갤럽 <Hirten-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Hirten-Galoppe>', 'Galop <Hirten-Galoppe>', 'song', 'Op. 28', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Hirten-Galoppe>'
);


-- Op. 29a 갤럽 <Wettrennen-Galoppe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Wettrennen-Galoppe>', 'Galop <Wettrennen-Galoppe>', 'song', 'Op. 29a', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Wettrennen-Galoppe>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2e8f919-409f-4797-b308-c4955c211fb9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a2e8f919-409f-4797-b308-c4955c211fb9'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Wettrennen-Galoppe>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2e8f919-409f-4797-b308-c4955c211fb9'
);


-- Op. 30 왈츠 <Sperls Festwalzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sperls Festwalzer>', 'Waltz <Sperls Festwalzer>', 'song', 'Op. 30', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sperls Festwalzer>'
);


-- Op. 31 왈츠 <Des Verfassers beste Laune>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Des Verfassers beste Laune>', 'Waltz <Des Verfassers beste Laune>', 'song', 'Op. 31', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Des Verfassers beste Laune>'
);


-- Op. 32 왈츠 <Schwarz'sche Ball-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Schwarz''sche Ball-Tänze>', 'Waltz <Schwarz''sche Ball-Tänze>', 'song', 'Op. 32', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Schwarz''sche Ball-Tänze>'
);


-- Op. 33 왈츠 <Benefice-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Benefice-Walzer>', 'Waltz <Benefice-Walzer>', 'song', 'Op. 33', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Benefice-Walzer>'
);


-- Op. 34 왈츠 <Gute Meinung für die Tanzlust>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gute Meinung für die Tanzlust>', 'Waltz <Gute Meinung für die Tanzlust>', 'song', 'Op. 34', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gute Meinung für die Tanzlust>'
);


-- Op. 35 갤럽 <Einzugs-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Einzugs-Galopp>', 'Galop <Einzugs-Galopp>', 'song', 'Op. 35', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Einzugs-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6854280d-6672-4074-a5a0-04d2f75a2cb9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6854280d-6672-4074-a5a0-04d2f75a2cb9'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Einzugs-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6854280d-6672-4074-a5a0-04d2f75a2cb9'
);


-- Op. 36a 갤럽 <Ungarischer Galopp Nr. 1>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Ungarischer Galopp Nr. 1>', 'Galop <Ungarischer Galopp Nr. 1>', 'song', 'Op. 36a', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Ungarischer Galopp Nr. 1>'
);


-- Op. 36b 갤럽 <Ungarischer Galopp Nr. 2>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Ungarischer Galopp Nr. 2>', 'Galop <Ungarischer Galopp Nr. 2>', 'song', 'Op. 36b', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Ungarischer Galopp Nr. 2>'
);


-- Op. 36c 갤럽 <Ungarischer Galopp Nr. 3>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Ungarischer Galopp Nr. 3>', 'Galop <Ungarischer Galopp Nr. 3>', 'song', 'Op. 36c', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Ungarischer Galopp Nr. 3>'
);


-- Op. 38 왈츠 <Souvenir de Baden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Souvenir de Baden>', 'Waltz <Souvenir de Baden>', 'song', 'Op. 38', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Souvenir de Baden>'
);


-- Op. 39 왈츠 <Tivoli-Rutsch-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Tivoli-Rutsch-Walzer>', 'Waltz <Tivoli-Rutsch-Walzer>', 'song', 'Op. 39', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Tivoli-Rutsch-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0589d65-6c52-441c-886a-ddedc25c1097'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e0589d65-6c52-441c-886a-ddedc25c1097'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Tivoli-Rutsch-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e0589d65-6c52-441c-886a-ddedc25c1097'
);


-- Op. 40 왈츠 <Wiener Damen Toiletten-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wiener Damen Toiletten-Walzer>', 'Waltz <Wiener Damen Toiletten-Walzer>', 'song', 'Op. 40', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wiener Damen Toiletten-Walzer>'
);


-- Op. 42 갤럽 <Sperl-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Sperl-Galopp>', 'Galop <Sperl-Galopp>', 'song', 'Op. 42', NULL, NULL, 1829, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Sperl-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca5b20fc-217a-465e-9f53-e2f96287c5e1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca5b20fc-217a-465e-9f53-e2f96287c5e1'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Sperl-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca5b20fc-217a-465e-9f53-e2f96287c5e1'
);


-- Op. 43 관현악곡 <Der Raub der Sabinerinnen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악곡 <Der Raub der Sabinerinnen>', 'Orchestral piece <Der Raub der Sabinerinnen>', 'song', 'Op. 43', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악곡 <Der Raub der Sabinerinnen>'
);


-- Op. 44 콩트르당스 Op. 44

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콩트르당스 Op. 44', 'Contredanses, Op. 44', 'song', NULL, 'Op.', '44', NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콩트르당스 Op. 44'
);


-- Op. 45 왈츠 <Tivoli-Freudenfest-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Tivoli-Freudenfest-Tänze>', 'Waltz <Tivoli-Freudenfest-Tänze>', 'song', 'Op. 45', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Tivoli-Freudenfest-Tänze>'
);


-- Op. 47 왈츠 <Vive la Danse!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Vive la Danse!>', 'Waltz <Vive la Danse!>', 'song', 'Op. 47', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Vive la Danse!>'
);


-- Op. 48 왈츠 <Heiter auch in ernster Zeit>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Heiter auch in ernster Zeit>', 'Waltz <Heiter auch in ernster Zeit>', 'song', 'Op. 48', NULL, NULL, 1831, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Heiter auch in ernster Zeit>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3bca183f-8a68-4310-918e-b1281c247796'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3bca183f-8a68-4310-918e-b1281c247796'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Heiter auch in ernster Zeit>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3bca183f-8a68-4310-918e-b1281c247796'
);


-- Op. 49 왈츠 <Das Leben ein Tanz, oder Der Tanz ein Leben!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Das Leben ein Tanz, oder Der Tanz ein Leben!>', 'Waltz <Das Leben ein Tanz, oder Der Tanz ein Leben!>', 'song', 'Op. 49', NULL, NULL, 1832, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Das Leben ein Tanz, oder Der Tanz ein Leben!>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '396a8ea2-413b-4cf1-99d2-eab4e20d5b7f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '396a8ea2-413b-4cf1-99d2-eab4e20d5b7f'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Das Leben ein Tanz, oder Der Tanz ein Leben!>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '396a8ea2-413b-4cf1-99d2-eab4e20d5b7f'
);


-- Op. 51 왈츠 <Hofball-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Hofball-Tänze>', 'Waltz <Hofball-Tänze>', 'song', 'Op. 51', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Hofball-Tänze>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32b07341-ba1f-48b6-b369-8b06f9d69aed'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32b07341-ba1f-48b6-b369-8b06f9d69aed'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Hofball-Tänze>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32b07341-ba1f-48b6-b369-8b06f9d69aed'
);


-- Op. 52 갤럽 <Bayaderen-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Bayaderen-Galopp>', 'Galop <Bayaderen-Galopp>', 'song', 'Op. 52', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Bayaderen-Galopp>'
);


-- Op. 53 왈츠 <Bajaderen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Bajaderen-Walzer>', 'Waltz <Bajaderen-Walzer>', 'song', 'Op. 53', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Bajaderen-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c0300d0-0738-45e9-8c55-f47d8d1ef6a7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8c0300d0-0738-45e9-8c55-f47d8d1ef6a7'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Bajaderen-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8c0300d0-0738-45e9-8c55-f47d8d1ef6a7'
);


-- Op. 54 콩트르당스 Op. 54

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '콩트르당스 Op. 54', 'Contredanses, Op. 54', 'song', NULL, 'Op.', '54', NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '콩트르당스 Op. 54'
);


-- Op. 56 왈츠 <Alexandra-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Alexandra-Walzer>', 'Waltz <Alexandra-Walzer>', 'song', 'Op. 56', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Alexandra-Walzer>'
);


-- Op. 58 왈츠 <Mein schönster Tag in Baden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Mein schönster Tag in Baden>', 'Waltz <Mein schönster Tag in Baden>', 'song', 'Op. 58', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Mein schönster Tag in Baden>'
);


-- Op. 59 왈츠 <Die vier Temperamente>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die vier Temperamente>', 'Waltz <Die vier Temperamente>', 'song', 'Op. 59', NULL, NULL, 1830, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die vier Temperamente>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a72f2480-43ac-4af8-b5c9-ffecef7e6a13'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a72f2480-43ac-4af8-b5c9-ffecef7e6a13'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Die vier Temperamente>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a72f2480-43ac-4af8-b5c9-ffecef7e6a13'
);


-- Op. 60 왈츠 <Carnevals-Spende>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Carnevals-Spende>', 'Waltz <Carnevals-Spende>', 'song', 'Op. 60', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Carnevals-Spende>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '345e77af-5463-4fda-98b4-f6188725449d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '345e77af-5463-4fda-98b4-f6188725449d'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Carnevals-Spende>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '345e77af-5463-4fda-98b4-f6188725449d'
);


-- Op. 61 왈츠 <Tausendsapperment-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Tausendsapperment-Walzer>', 'Waltz <Tausendsapperment-Walzer>', 'song', 'Op. 61', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Tausendsapperment-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a36536cf-b07f-4e0a-abdc-15f2c2bc2763'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a36536cf-b07f-4e0a-abdc-15f2c2bc2763'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Tausendsapperment-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a36536cf-b07f-4e0a-abdc-15f2c2bc2763'
);


-- Op. 63 왈츠 <Der Frohsinn, mein Ziel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Der Frohsinn, mein Ziel>', 'Waltz <Der Frohsinn, mein Ziel>', 'song', 'Op. 63', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Der Frohsinn, mein Ziel>'
);


-- Op. 65 왈츠 <Mittel gegen den Schlaf>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Mittel gegen den Schlaf>', 'Waltz <Mittel gegen den Schlaf>', 'song', 'Op. 65', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Mittel gegen den Schlaf>'
);


-- Op. 66 왈츠 <Erinnerung an Pesth>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Erinnerung an Pesth>', 'Waltz <Erinnerung an Pesth>', 'song', 'Op. 66', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Erinnerung an Pesth>'
);


-- Op. 67 왈츠 <Erste Walzer-Guirlande>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Erste Walzer-Guirlande>', 'Waltz <Erste Walzer-Guirlande>', 'song', 'Op. 67', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Erste Walzer-Guirlande>'
);


-- Op. 68 왈츠 <Gabrielen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gabrielen-Walzer>', 'Waltz <Gabrielen-Walzer>', 'song', 'Op. 68', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gabrielen-Walzer>'
);


-- Op. 69 갤럽 <Fortuna-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Fortuna-Galopp>', 'Galop <Fortuna-Galopp>', 'song', 'Op. 69', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Fortuna-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '465d0184-d4fb-45d2-814d-5a238ad6e952'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '465d0184-d4fb-45d2-814d-5a238ad6e952'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Fortuna-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '465d0184-d4fb-45d2-814d-5a238ad6e952'
);


-- Op. 70 왈츠 <Pfennig-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Pfennig-Walzer>', 'Waltz <Pfennig-Walzer>', 'song', 'Op. 70', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Pfennig-Walzer>'
);


-- Op. 71 왈츠 <Elisabethen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Elisabethen-Walzer>', 'Waltz <Elisabethen-Walzer>', 'song', 'Op. 71', NULL, NULL, 1833, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Elisabethen-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07b029c5-defc-4153-a3b5-d99d5229837f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07b029c5-defc-4153-a3b5-d99d5229837f'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Elisabethen-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07b029c5-defc-4153-a3b5-d99d5229837f'
);


-- Op. 73 행진곡 <Original-Parade-Marsch> Op. 73

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Original-Parade-Marsch> Op. 73', 'March <Original-Parade-Marsch>, Op. 73', 'song', NULL, 'Op.', '73', 1834, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Original-Parade-Marsch> Op. 73'
);


-- Op. 74 갤럽 <Venetianer-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Venetianer-Galopp>', 'Galop <Venetianer-Galopp>', 'song', 'Op. 74', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Venetianer-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c5a4981-f5a0-4861-864d-3e1a9ab45cec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c5a4981-f5a0-4861-864d-3e1a9ab45cec'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Venetianer-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c5a4981-f5a0-4861-864d-3e1a9ab45cec'
);


-- Op. 75 왈츠 <Iris-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Iris-Walzer>', 'Waltz <Iris-Walzer>', 'song', 'Op. 75', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Iris-Walzer>'
);


-- Op. 76 왈츠 <Rosa-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Rosa-Walzer>', 'Waltz <Rosa-Walzer>', 'song', 'Op. 76', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Rosa-Walzer>'
);


-- Op. 77 왈츠 <Walzer-Guirlande Nr. 2>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Walzer-Guirlande Nr. 2>', 'Waltz <Walzer-Guirlande Nr. 2>', 'song', 'Op. 77', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Walzer-Guirlande Nr. 2>'
);


-- Op. 78 왈츠 <Erinnerung an Berlin>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Erinnerung an Berlin>', 'Waltz <Erinnerung an Berlin>', 'song', 'Op. 78', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Erinnerung an Berlin>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f37bb9ac-bf7e-42fd-b89f-afb16af5b401'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f37bb9ac-bf7e-42fd-b89f-afb16af5b401'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Erinnerung an Berlin>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f37bb9ac-bf7e-42fd-b89f-afb16af5b401'
);


-- Op. 79 왈츠 <Gedankenstriche>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Gedankenstriche>', 'Waltz <Gedankenstriche>', 'song', 'Op. 79', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Gedankenstriche>'
);


-- Op. 80 왈츠 <Huldigungs-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Huldigungs-Walzer>', 'Waltz <Huldigungs-Walzer>', 'song', 'Op. 80', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Huldigungs-Walzer>'
);


-- Op. 81 왈츠 <Grazien-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Grazien-Tänze>', 'Waltz <Grazien-Tänze>', 'song', 'Op. 81', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Grazien-Tänze>'
);


-- Op. 82 왈츠 <Philomelen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Philomelen-Walzer>', 'Waltz <Philomelen-Walzer>', 'song', 'Op. 82', NULL, NULL, 1835, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Philomelen-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8ed2829-0a7e-417c-adb9-d6c1093d036a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e8ed2829-0a7e-417c-adb9-d6c1093d036a'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Philomelen-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e8ed2829-0a7e-417c-adb9-d6c1093d036a'
);


-- Op. 83 왈츠 <Merkurs Flügel>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Merkurs Flügel>', 'Waltz <Merkurs Flügel>', 'song', 'Op. 83', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Merkurs Flügel>'
);


-- Op. 84 왈츠 <Heimath-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Heimath-Klänge>', 'Waltz <Heimath-Klänge>', 'song', 'Op. 84', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Heimath-Klänge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c9ae8c7-22c4-4482-a52d-239b8658ebe2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7c9ae8c7-22c4-4482-a52d-239b8658ebe2'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Heimath-Klänge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7c9ae8c7-22c4-4482-a52d-239b8658ebe2'
);


-- Op. 85 갤럽 <Reise-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Reise-Galopp>', 'Galop <Reise-Galopp>', 'song', 'Op. 85', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Reise-Galopp>'
);


-- Op. 86 갤럽 <Ballnacht-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Ballnacht-Galopp>', 'Galop <Ballnacht-Galopp>', 'song', 'Op. 86', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Ballnacht-Galopp>'
);


-- Op. 87 왈츠 <Erinnerung an Deutschland>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Erinnerung an Deutschland>', 'Waltz <Erinnerung an Deutschland>', 'song', 'Op. 87', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Erinnerung an Deutschland>'
);


-- Op. 88 왈츠 <Die Nachtwandler>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Nachtwandler>', 'Waltz <Die Nachtwandler>', 'song', 'Op. 88', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Nachtwandler>'
);


-- Op. 89 왈츠 <Eisenbahn-Lust-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Eisenbahn-Lust-Walzer>', 'Waltz <Eisenbahn-Lust-Walzer>', 'song', 'Op. 89', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Eisenbahn-Lust-Walzer>'
);


-- Op. 90 갤럽 <Jugendfeuer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Jugendfeuer>', 'Galop <Jugendfeuer>', 'song', 'Op. 90', NULL, NULL, 1836, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Jugendfeuer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad70bdb0-2f15-4451-b0d0-89e38d9b0ea8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad70bdb0-2f15-4451-b0d0-89e38d9b0ea8'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Jugendfeuer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad70bdb0-2f15-4451-b0d0-89e38d9b0ea8'
);


-- Op. 91 왈츠 <Krönungs-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Krönungs-Walzer>', 'Waltz <Krönungs-Walzer>', 'song', 'Op. 91', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Krönungs-Walzer>'
);


-- Op. 94 왈츠 <Künstler-Ball-Tänze> Op. 94

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Künstler-Ball-Tänze> Op. 94', 'Waltz <Künstler-Ball-Tänze>, Op. 94', 'song', NULL, 'Op.', '94', NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Künstler-Ball-Tänze> Op. 94'
);


-- Op. 95 왈츠 <Brüssler Spitzen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Brüssler Spitzen>', 'Waltz <Brüssler Spitzen>', 'song', 'Op. 95', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Brüssler Spitzen>'
);


-- Op. 96 왈츠 <Ball-Racketen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Ball-Racketen>', 'Waltz <Ball-Racketen>', 'song', 'Op. 96', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Ball-Racketen>'
);


-- Op. 97 갤럽 <Cachucha-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Cachucha-Galopp>', 'Galop <Cachucha-Galopp>', 'song', 'Op. 97', NULL, NULL, 1837, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Cachucha-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c4848f8-4902-4b0b-af13-39b4639f55a1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c4848f8-4902-4b0b-af13-39b4639f55a1'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Cachucha-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c4848f8-4902-4b0b-af13-39b4639f55a1'
);


-- Op. 98 왈츠 <Pilger am Rhein>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Pilger am Rhein>', 'Waltz <Pilger am Rhein>', 'song', 'Op. 98', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Pilger am Rhein>'
);


-- Op. 99 왈츠 <Bankett-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Bankett-Tänze>', 'Waltz <Bankett-Tänze>', 'song', 'Op. 99', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Bankett-Tänze>'
);


-- Op. 100 갤럽 <Der Carneval in Paris>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Der Carneval in Paris>', 'Galop <Der Carneval in Paris>', 'song', 'Op. 100', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Der Carneval in Paris>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b657653f-dd87-40b2-9634-ab234ab85f95'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b657653f-dd87-40b2-9634-ab234ab85f95'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Der Carneval in Paris>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b657653f-dd87-40b2-9634-ab234ab85f95'
);


-- Op. 101 왈츠 <Paris>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Paris>', 'Waltz <Paris>', 'song', 'Op. 101', NULL, NULL, 1838, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Paris>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3672124-477f-4fb2-a466-6668740e877c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e3672124-477f-4fb2-a466-6668740e877c'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Paris>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e3672124-477f-4fb2-a466-6668740e877c'
);


-- Op. 102 행진곡 <Original-Parade-Marsch> Op. 102

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Original-Parade-Marsch> Op. 102', 'March <Original-Parade-Marsch>, Op. 102', 'song', NULL, 'Op.', '102', 1838, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Original-Parade-Marsch> Op. 102'
);


-- Op. 103 왈츠 <Huldigung der Königin Victoria von Grossbritannien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Huldigung der Königin Victoria von Grossbritannien>', 'Waltz <Huldigung der Königin Victoria von Grossbritannien>', 'song', 'Op. 103', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Huldigung der Königin Victoria von Grossbritannien>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ae4752f-4131-4266-b0eb-08bf489e8f64'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0ae4752f-4131-4266-b0eb-08bf489e8f64'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Huldigung der Königin Victoria von Grossbritannien>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0ae4752f-4131-4266-b0eb-08bf489e8f64'
);


-- Op. 105 왈츠 <Freuden-Grüsse>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Freuden-Grüsse>', 'Waltz <Freuden-Grüsse>', 'song', 'Op. 105', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Freuden-Grüsse>'
);


-- Op. 107 갤럽 <Versailler Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Versailler Galopp>', 'Galop <Versailler Galopp>', 'song', 'Op. 107', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Versailler Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'adaefb6a-4b9c-4d43-b4f7-8e6f6750680f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'adaefb6a-4b9c-4d43-b4f7-8e6f6750680f'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Versailler Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'adaefb6a-4b9c-4d43-b4f7-8e6f6750680f'
);


-- Op. 108 갤럽 <Gitana-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Gitana-Galopp>', 'Galop <Gitana-Galopp>', 'song', 'Op. 108', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Gitana-Galopp>'
);


-- Op. 109 왈츠 <Exotische Pflanzen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Exotische Pflanzen>', 'Waltz <Exotische Pflanzen>', 'song', 'Op. 109', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Exotische Pflanzen>'
);


-- Op. 110 왈츠 <Taglioni-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Taglioni-Walzer>', 'Waltz <Taglioni-Walzer>', 'song', 'Op. 110', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Taglioni-Walzer>'
);


-- Op. 111 갤럽 <Indianer-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Indianer-Galopp>', 'Galop <Indianer-Galopp>', 'song', 'Op. 111', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Indianer-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81656fb1-edba-488b-b03f-d26fa6322458'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '81656fb1-edba-488b-b03f-d26fa6322458'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Indianer-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '81656fb1-edba-488b-b03f-d26fa6322458'
);


-- Op. 112 왈츠 <Londoner-Saison-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Londoner-Saison-Walzer>', 'Waltz <Londoner-Saison-Walzer>', 'song', 'Op. 112', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Londoner-Saison-Walzer>'
);


-- Op. 113 왈츠 <Die Berggeister>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Berggeister>', 'Waltz <Die Berggeister>', 'song', 'Op. 113', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Berggeister>'
);


-- Op. 115 왈츠 <Rosen-Blätter>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Rosen-Blätter>', 'Waltz <Rosen-Blätter>', 'song', 'Op. 115', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Rosen-Blätter>'
);


-- Op. 116 왈츠 <Wiener-Gemüths-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wiener-Gemüths-Walzer>', 'Waltz <Wiener-Gemüths-Walzer>', 'song', 'Op. 116', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wiener-Gemüths-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07cfb4d7-f590-4491-8cb0-2ebe1fe8c522'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '07cfb4d7-f590-4491-8cb0-2ebe1fe8c522'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Wiener-Gemüths-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '07cfb4d7-f590-4491-8cb0-2ebe1fe8c522'
);


-- Op. 117 갤럽 <Gibellinen-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Gibellinen-Galopp>', 'Galop <Gibellinen-Galopp>', 'song', 'Op. 117', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Gibellinen-Galopp>'
);


-- Op. 118 왈츠 <Myrthen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Myrthen>', 'Waltz <Myrthen>', 'song', 'Op. 118', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Myrthen>'
);


-- Op. 119 왈츠 <Tanz-Recepte>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Tanz-Recepte>', 'Waltz <Tanz-Recepte>', 'song', 'Op. 119', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Tanz-Recepte>'
);


-- Op. 120 왈츠 <Cäcilien-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Cäcilien-Walzer>', 'Waltz <Cäcilien-Walzer>', 'song', 'Op. 120', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Cäcilien-Walzer>'
);


-- Op. 121 왈츠 <Dritte Walzer-Guirlande>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Dritte Walzer-Guirlande>', 'Waltz <Dritte Walzer-Guirlande>', 'song', 'Op. 121', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Dritte Walzer-Guirlande>'
);


-- Op. 122 왈츠 <Palm-Zweige>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Palm-Zweige>', 'Waltz <Palm-Zweige>', 'song', 'Op. 122', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Palm-Zweige>'
);


-- Op. 123 왈츠 <Amors-Pfeile>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Amors-Pfeile>', 'Waltz <Amors-Pfeile>', 'song', 'Op. 123', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Amors-Pfeile>'
);


-- Op. 124 카드리유 <Wiener Carnevals-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Wiener Carnevals-Quadrille>', 'Quadrille <Wiener Carnevals-Quadrille>', 'song', 'Op. 124', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Wiener Carnevals-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd30d2a62-b6ca-4584-840d-b18fdad00dd1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd30d2a62-b6ca-4584-840d-b18fdad00dd1'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '카드리유 <Wiener Carnevals-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd30d2a62-b6ca-4584-840d-b18fdad00dd1'
);


-- Op. 125 왈츠 <Elektrische Funken>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Elektrische Funken>', 'Waltz <Elektrische Funken>', 'song', 'Op. 125', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Elektrische Funken>'
);


-- Op. 126 환상곡 <Erinnerung an Ernst oder Der Carneval in Venedig>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 <Erinnerung an Ernst oder Der Carneval in Venedig>', 'Fantasy <Erinnerung an Ernst oder Der Carneval in Venedig>', 'song', 'Op. 126', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 <Erinnerung an Ernst oder Der Carneval in Venedig>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3bdffcd3-6232-4e13-862b-efdd78d079e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3bdffcd3-6232-4e13-862b-efdd78d079e9'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '환상곡 <Erinnerung an Ernst oder Der Carneval in Venedig>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3bdffcd3-6232-4e13-862b-efdd78d079e9'
);


-- Op. 127 왈츠 <Deutsche Lust oder Donaulieder ohne Text>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Deutsche Lust oder Donaulieder ohne Text>', 'Waltz <Deutsche Lust oder Donaulieder ohne Text>', 'song', 'Op. 127', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Deutsche Lust oder Donaulieder ohne Text>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c40c0b1-af7c-465b-abbb-a8c79abe5dbb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1c40c0b1-af7c-465b-abbb-a8c79abe5dbb'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Deutsche Lust oder Donaulieder ohne Text>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1c40c0b1-af7c-465b-abbb-a8c79abe5dbb'
);


-- Op. 128 왈츠 <Apollo-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Apollo-Walzer>', 'Waltz <Apollo-Walzer>', 'song', 'Op. 128', NULL, NULL, 1839, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Apollo-Walzer>'
);


-- Op. 129 왈츠 <Adelaiden-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Adelaiden-Walzer>', 'Waltz <Adelaiden-Walzer>', 'song', 'Op. 129', NULL, NULL, 1841, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Adelaiden-Walzer>'
);


-- Op. 130 카드리유 <Jubel-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Jubel-Quadrille>', 'Quadrille <Jubel-Quadrille>', 'song', 'Op. 130', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Jubel-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af062f29-20b2-4479-8d61-b8bc6716b543'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'af062f29-20b2-4479-8d61-b8bc6716b543'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '카드리유 <Jubel-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'af062f29-20b2-4479-8d61-b8bc6716b543'
);


-- Op. 131 왈츠 <Die Wettrenner>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Wettrenner>', 'Waltz <Die Wettrenner>', 'song', 'Op. 131', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Wettrenner>'
);


-- Op. 132 왈츠 <Die Deputanten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Deputanten>', 'Waltz <Die Deputanten>', 'song', 'Op. 132', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Deputanten>'
);


-- Op. 133 폴카 <Beliebte Sperl-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Beliebte Sperl-Polka>', 'Polka <Beliebte Sperl-Polka>', 'song', 'Op. 133', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Beliebte Sperl-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29ea5e42-43d8-4e70-b438-f40207c9ec33'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29ea5e42-43d8-4e70-b438-f40207c9ec33'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Beliebte Sperl-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29ea5e42-43d8-4e70-b438-f40207c9ec33'
);


-- Op. 134 왈츠 <Egerien-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Egerien-Tänze>', 'Waltz <Egerien-Tänze>', 'song', 'Op. 134', NULL, NULL, 1842, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Egerien-Tänze>'
);


-- Op. 135 왈츠 <Die Tanzmeister>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Tanzmeister>', 'Waltz <Die Tanzmeister>', 'song', 'Op. 135', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Tanzmeister>'
);


-- Op. 136 왈츠 <Stadt und Landleben>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Stadt und Landleben>', 'Waltz <Stadt und Landleben>', 'song', 'Op. 136', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Stadt und Landleben>'
);


-- Op. 137 폴카 <Beliebte Annen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Beliebte Annen-Polka>', 'Polka <Beliebte Annen-Polka>', 'song', 'Op. 137', NULL, NULL, 1840, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Beliebte Annen-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a71f2d9b-15cc-3a73-84ab-5374e2327dcc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a71f2d9b-15cc-3a73-84ab-5374e2327dcc'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Beliebte Annen-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a71f2d9b-15cc-3a73-84ab-5374e2327dcc'
);


-- Op. 138 카드리유 <Mode-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Mode-Quadrille>', 'Quadrille <Mode-Quadrille>', 'song', 'Op. 138', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Mode-Quadrille>'
);


-- Op. 139 왈츠 <Die Fantasten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Fantasten>', 'Waltz <Die Fantasten>', 'song', 'Op. 139', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Fantasten>'
);


-- Op. 140 왈츠 <Musik-Verein-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Musik-Verein-Tänze>', 'Waltz <Musik-Verein-Tänze>', 'song', 'Op. 140', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Musik-Verein-Tänze>'
);


-- Op. 141 왈츠 <Minnesänger>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Minnesänger>', 'Waltz <Minnesänger>', 'song', 'Op. 141', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Minnesänger>'
);


-- Op. 142 카드리유 <Haute-Volée-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Haute-Volée-Quadrille>', 'Quadrille <Haute-Volée-Quadrille>', 'song', 'Op. 142', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Haute-Volée-Quadrille>'
);


-- Op. 143 왈츠 <Latonen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Latonen-Walzer>', 'Waltz <Latonen-Walzer>', 'song', 'Op. 143', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Latonen-Walzer>'
);


-- Op. 144 행진곡 <Parade-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Parade-Marsch>', 'March <Parade-Marsch>', 'song', 'Op. 144', NULL, NULL, 1843, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Parade-Marsch>'
);


-- Op. 145 왈츠 <Minos-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Minos-Klänge>', 'Waltz <Minos-Klänge>', 'song', 'Op. 145', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Minos-Klänge>'
);


-- Op. 146 왈츠 <Die Lustwandler>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Lustwandler>', 'Waltz <Die Lustwandler>', 'song', 'Op. 146', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Lustwandler>'
);


-- Op. 147 왈츠 <Walhalla-Toaste>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Walhalla-Toaste>', 'Waltz <Walhalla-Toaste>', 'song', 'Op. 147', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Walhalla-Toaste>'
);


-- Op. 148 카드리유 <Saison-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Saison-Quadrille>', 'Quadrille <Saison-Quadrille>', 'song', 'Op. 148', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Saison-Quadrille>'
);


-- Op. 149 왈츠 <Die Dämonen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Dämonen>', 'Waltz <Die Dämonen>', 'song', 'Op. 149', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Dämonen>'
);


-- Op. 150 왈츠 <Künstler-Ball-Tänze> Op. 150

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Künstler-Ball-Tänze> Op. 150', 'Waltz <Künstler-Ball-Tänze>, Op. 150', 'song', NULL, 'Op.', '150', NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Künstler-Ball-Tänze> Op. 150'
);


-- Op. 151 카드리유 <Ferdinand-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Ferdinand-Quadrille>', 'Quadrille <Ferdinand-Quadrille>', 'song', 'Op. 151', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Ferdinand-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a37e767c-0134-411e-a715-9d5ad26bf636'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a37e767c-0134-411e-a715-9d5ad26bf636'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '카드리유 <Ferdinand-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a37e767c-0134-411e-a715-9d5ad26bf636'
);


-- Op. 152 왈츠 <Tanz-Capricen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Tanz-Capricen>', 'Waltz <Tanz-Capricen>', 'song', 'Op. 152', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Tanz-Capricen>'
);


-- Op. 153 카드리유 <Anna-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Anna-Quadrille>', 'Quadrille <Anna-Quadrille>', 'song', 'Op. 153', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Anna-Quadrille>'
);


-- Op. 154 로렐라이 라인강의 메아리 (왈츠)

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9c27d6e4-1a0d-4333-8e24-4f570dc35a54'
FROM pieces p
WHERE p.id = 239 AND p.composer_id = 54
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9c27d6e4-1a0d-4333-8e24-4f570dc35a54'
);


-- Op. 155 왈츠 <Brüder Lustig>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Brüder Lustig>', 'Waltz <Brüder Lustig>', 'song', 'Op. 155', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Brüder Lustig>'
);


-- Op. 156 왈츠 <Asträa-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Asträa-Tänze>', 'Waltz <Asträa-Tänze>', 'song', 'Op. 156', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Asträa-Tänze>'
);


-- Op. 157 카드리유 <Volksgarten-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Volksgarten-Quadrille>', 'Quadrille <Volksgarten-Quadrille>', 'song', 'Op. 157', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Volksgarten-Quadrille>'
);


-- Op. 158 카드리유 <Redoute-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Redoute-Quadrille>', 'Quadrille <Redoute-Quadrille>', 'song', 'Op. 158', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Redoute-Quadrille>'
);


-- Op. 159 왈츠 <Nur Leben!>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Nur Leben!>', 'Waltz <Nur Leben!>', 'song', 'Op. 159', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Nur Leben!>'
);


-- Op. 160 왈츠 <Waldfräuleins Hochzeits-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Waldfräuleins Hochzeits-Tänze>', 'Waltz <Waldfräuleins Hochzeits-Tänze>', 'song', 'Op. 160', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Waldfräuleins Hochzeits-Tänze>'
);


-- Op. 161 폴카 <Salon-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Salon-Polka>', 'Polka <Salon-Polka>', 'song', 'Op. 161', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Salon-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3640f63-edc6-4ddf-bab7-ea6025339134'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd3640f63-edc6-4ddf-bab7-ea6025339134'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Salon-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd3640f63-edc6-4ddf-bab7-ea6025339134'
);


-- Op. 162 카드리유 <Orpheus-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Orpheus-Quadrille>', 'Quadrille <Orpheus-Quadrille>', 'song', 'Op. 162', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Orpheus-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5ad5451-2b01-4ecb-8b91-8b521593f49e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5ad5451-2b01-4ecb-8b91-8b521593f49e'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '카드리유 <Orpheus-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5ad5451-2b01-4ecb-8b91-8b521593f49e'
);


-- Op. 163 왈츠 <Frohsinns-Salven>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Frohsinns-Salven>', 'Waltz <Frohsinns-Salven>', 'song', 'Op. 163', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Frohsinns-Salven>'
);


-- Op. 164 왈츠 <Aurora-Festklänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Aurora-Festklänge>', 'Waltz <Aurora-Festklänge>', 'song', 'Op. 164', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Aurora-Festklänge>'
);


-- Op. 165 카드리유 <Fest-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Fest-Quadrille>', 'Quadrille <Fest-Quadrille>', 'song', 'Op. 165', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Fest-Quadrille>'
);


-- Op. 166 왈츠 <Rosen ohne Dornen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Rosen ohne Dornen>', 'Waltz <Rosen ohne Dornen>', 'song', 'Op. 166', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Rosen ohne Dornen>'
);


-- Op. 167 왈츠 <Wiener Früchteln>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Wiener Früchteln>', 'Waltz <Wiener Früchteln>', 'song', 'Op. 167', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Wiener Früchteln>'
);


-- Op. 168 왈츠 <Willkommen-Rufe>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Willkommen-Rufe>', 'Waltz <Willkommen-Rufe>', 'song', 'Op. 168', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Willkommen-Rufe>'
);


-- Op. 170 왈츠 <Maskenlieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Maskenlieder>', 'Waltz <Maskenlieder>', 'song', 'Op. 170', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Maskenlieder>'
);


-- Op. 171 왈츠 <Eunomien-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Eunomien-Tänze>', 'Waltz <Eunomien-Tänze>', 'song', 'Op. 171', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Eunomien-Tänze>'
);


-- Op. 172 왈츠 <Odeon-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Odeon-Tänze>', 'Waltz <Odeon-Tänze>', 'song', 'Op. 172', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Odeon-Tänze>'
);


-- Op. 173 폴카 <Marianka-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Marianka-Polka>', 'Polka <Marianka-Polka>', 'song', 'Op. 173', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Marianka-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a42d41d0-2da5-4731-a179-8726240d9127'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a42d41d0-2da5-4731-a179-8726240d9127'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Marianka-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a42d41d0-2da5-4731-a179-8726240d9127'
);


-- Op. 174 카드리유 <Musen-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Musen-Quadrille>', 'Quadrille <Musen-Quadrille>', 'song', 'Op. 174', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Musen-Quadrille>'
);


-- Op. 175 왈츠 <Faschings-Possen>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Faschings-Possen>', 'Waltz <Faschings-Possen>', 'song', 'Op. 175', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Faschings-Possen>'
);


-- Op. 176 왈츠 <Geheimnisse aus der Wiener Tanzwelt>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Geheimnisse aus der Wiener Tanzwelt>', 'Waltz <Geheimnisse aus der Wiener Tanzwelt>', 'song', 'Op. 176', NULL, NULL, 1845, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Geheimnisse aus der Wiener Tanzwelt>'
);


-- Op. 177 카드리유 <Flora-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Flora-Quadrille>', 'Quadrille <Flora-Quadrille>', 'song', 'Op. 177', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Flora-Quadrille>'
);


-- Op. 179 왈츠 <Österreichische Jubelklänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Österreichische Jubelklänge>', 'Waltz <Österreichische Jubelklänge>', 'song', 'Op. 179', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Österreichische Jubelklänge>'
);


-- Op. 180 왈츠 <Sommernachts-Träume>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sommernachts-Träume>', 'Waltz <Sommernachts-Träume>', 'song', 'Op. 180', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sommernachts-Träume>'
);


-- Op. 181 왈츠 <Heitere Lebensbilder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Heitere Lebensbilder>', 'Waltz <Heitere Lebensbilder>', 'song', 'Op. 181', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Heitere Lebensbilder>'
);


-- Op. 182 왈츠 <Die Landjunker>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Landjunker>', 'Waltz <Die Landjunker>', 'song', 'Op. 182', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Landjunker>'
);


-- Op. 183 카드리유 <Amoretten-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Amoretten-Quadrille>', 'Quadrille <Amoretten-Quadrille>', 'song', 'Op. 183', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Amoretten-Quadrille>'
);


-- Op. 184 왈츠 <Concordia-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Concordia-Tänze>', 'Waltz <Concordia-Tänze>', 'song', 'Op. 184', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Concordia-Tänze>'
);


-- Op. 185 왈츠 <Sofien-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sofien-Tänze>', 'Waltz <Sofien-Tänze>', 'song', 'Op. 185', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sofien-Tänze>'
);


-- Op. 186 왈츠 <Moldau-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Moldau-Klänge>', 'Waltz <Moldau-Klänge>', 'song', 'Op. 186', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Moldau-Klänge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7f4d6cf-adcb-4662-84d8-078588666998'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a7f4d6cf-adcb-4662-84d8-078588666998'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Moldau-Klänge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a7f4d6cf-adcb-4662-84d8-078588666998'
);


-- Op. 187 카드리유 <Concert-Souvenir-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Concert-Souvenir-Quadrille>', 'Quadrille <Concert-Souvenir-Quadrille>', 'song', 'Op. 187', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Concert-Souvenir-Quadrille>'
);


-- Op. 188 행진곡 <Österreichischer Fest-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Österreichischer Fest-Marsch>', 'March <Österreichischer Fest-Marsch>', 'song', 'Op. 188', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Österreichischer Fest-Marsch>'
);


-- Op. 189 왈츠 <Die Vortänzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Vortänzer>', 'Waltz <Die Vortänzer>', 'song', 'Op. 189', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Vortänzer>'
);


-- Op. 190 왈츠 <Epionen-Tänze>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Epionen-Tänze>', 'Waltz <Epionen-Tänze>', 'song', 'Op. 190', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Epionen-Tänze>'
);


-- Op. 192 행진곡 <Esmeralda-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Esmeralda-Marsch>', 'March <Esmeralda-Marsch>', 'song', 'Op. 192', NULL, NULL, 1846, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Esmeralda-Marsch>'
);


-- Op. 193 왈츠 <Festlieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Festlieder>', 'Waltz <Festlieder>', 'song', 'Op. 193', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Festlieder>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01eaf403-62c3-4df5-a11f-bed95d46b541'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '01eaf403-62c3-4df5-a11f-bed95d46b541'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Festlieder>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '01eaf403-62c3-4df5-a11f-bed95d46b541'
);


-- Op. 194 카드리유 <Eldorado-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Eldorado-Quadrille>', 'Quadrille <Eldorado-Quadrille>', 'song', 'Op. 194', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Eldorado-Quadrille>'
);


-- Op. 195 왈츠 <Die Unbedeutenden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Unbedeutenden>', 'Waltz <Die Unbedeutenden>', 'song', 'Op. 195', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Unbedeutenden>'
);


-- Op. 196 카드리유 <Charivari-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Charivari-Quadrille>', 'Quadrille <Charivari-Quadrille>', 'song', 'Op. 196', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Charivari-Quadrille>'
);


-- Op. 197 왈츠 <Bouquets>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Bouquets>', 'Waltz <Bouquets>', 'song', 'Op. 197', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Bouquets>'
);


-- Op. 198 왈츠 <Ländlich, sittlich>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Ländlich, sittlich>', 'Waltz <Ländlich, sittlich>', 'song', 'Op. 198', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Ländlich, sittlich>'
);


-- Op. 199 폴카 <Neujahrs-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Neujahrs-Polka>', 'Polka <Neujahrs-Polka>', 'song', 'Op. 199', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Neujahrs-Polka>'
);


-- Op. 200 카드리유 <Souvenir de Carneval 1847>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Souvenir de Carneval 1847>', 'Quadrille <Souvenir de Carneval 1847>', 'song', 'Op. 200', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Souvenir de Carneval 1847>'
);


-- Op. 201 왈츠 <Themis-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Themis-Klänge>', 'Waltz <Themis-Klänge>', 'song', 'Op. 201', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Themis-Klänge>'
);


-- Op. 202 폴카 <Eisele- und Beisele-Sprünge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Eisele- und Beisele-Sprünge>', 'Polka <Eisele- und Beisele-Sprünge>', 'song', 'Op. 202', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Eisele- und Beisele-Sprünge>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54dba8d1-7609-4ae3-ba22-b8205c1063da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '54dba8d1-7609-4ae3-ba22-b8205c1063da'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Eisele- und Beisele-Sprünge>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '54dba8d1-7609-4ae3-ba22-b8205c1063da'
);


-- Op. 203 왈츠 <Herz-Töne>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Herz-Töne>', 'Waltz <Herz-Töne>', 'song', 'Op. 203', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Herz-Töne>'
);


-- Op. 204 왈츠 <Helenen-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Helenen-Walzer>', 'Waltz <Helenen-Walzer>', 'song', 'Op. 204', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Helenen-Walzer>'
);


-- Op. 205 카드리유 <Triumph-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Triumph-Quadrille>', 'Quadrille <Triumph-Quadrille>', 'song', 'Op. 205', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Triumph-Quadrille>'
);


-- Op. 206 카드리유 <Najaden-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Najaden-Quadrille>', 'Quadrille <Najaden-Quadrille>', 'song', 'Op. 206', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Najaden-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35c601f9-1181-4ada-ac0e-35b6405bbe3c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '35c601f9-1181-4ada-ac0e-35b6405bbe3c'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '카드리유 <Najaden-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '35c601f9-1181-4ada-ac0e-35b6405bbe3c'
);


-- Op. 207 왈츠 <Schwedische-Lieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Schwedische-Lieder>', 'Waltz <Schwedische-Lieder>', 'song', 'Op. 207', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Schwedische-Lieder>'
);


-- Op. 208 왈츠 <Die Schwalben>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Schwalben>', 'Waltz <Die Schwalben>', 'song', 'Op. 208', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Schwalben>'
);


-- Op. 209 행진곡 <Österreichischer Defilier-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Österreichischer Defilier-Marsch>', 'March <Österreichischer Defilier-Marsch>', 'song', 'Op. 209', NULL, NULL, 1847, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Österreichischer Defilier-Marsch>'
);


-- Op. 210 폴카 <Beliebte Kathinka-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Beliebte Kathinka-Polka>', 'Polka <Beliebte Kathinka-Polka>', 'song', 'Op. 210', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Beliebte Kathinka-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c73ea28-ec94-4e5e-97e7-cbdeab7891e5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2c73ea28-ec94-4e5e-97e7-cbdeab7891e5'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Beliebte Kathinka-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2c73ea28-ec94-4e5e-97e7-cbdeab7891e5'
);


-- Op. 212 왈츠 <Marien-Walzer>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Marien-Walzer>', 'Waltz <Marien-Walzer>', 'song', 'Op. 212', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Marien-Walzer>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32ab3350-65db-4092-963e-e0b5f6fdda3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32ab3350-65db-4092-963e-e0b5f6fdda3f'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Marien-Walzer>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32ab3350-65db-4092-963e-e0b5f6fdda3f'
);


-- Op. 213 왈츠 <Feldbleamel'n>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Feldbleamel''n>', 'Waltz <Feldbleamel''n>', 'song', 'Op. 213', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Feldbleamel''n>'
);


-- Op. 214 무곡 <Nádor Kör>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무곡 <Nádor Kör>', 'Dance <Nádor Kör>', 'song', 'Op. 214', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무곡 <Nádor Kör>'
);


-- Op. 216 왈츠 <Die Adepten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Adepten>', 'Waltz <Die Adepten>', 'song', 'Op. 216', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Adepten>'
);


-- Op. 217 카드리유 <Schäfer-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Schäfer-Quadrille>', 'Quadrille <Schäfer-Quadrille>', 'song', 'Op. 217', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Schäfer-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25b3dad6-cd25-443b-853a-b677fac0480f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '25b3dad6-cd25-443b-853a-b677fac0480f'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '카드리유 <Schäfer-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '25b3dad6-cd25-443b-853a-b677fac0480f'
);


-- Op. 218 왈츠 <Tanz-Signale>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Tanz-Signale>', 'Waltz <Tanz-Signale>', 'song', 'Op. 218', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Tanz-Signale>'
);


-- Op. 219 폴카 <Fortuna-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Fortuna-Polka>', 'Polka <Fortuna-Polka>', 'song', 'Op. 219', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Fortuna-Polka>'
);


-- Op. 220 폴카 <Wiener Kreuzer-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Wiener Kreuzer-Polka>', 'Polka <Wiener Kreuzer-Polka>', 'song', 'Op. 220', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Wiener Kreuzer-Polka>'
);


-- Op. 221 행진곡 <Österreichischer National-Garde-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Österreichischer National-Garde-Marsch>', 'March <Österreichischer National-Garde-Marsch>', 'song', 'Op. 221', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Österreichischer National-Garde-Marsch>'
);


-- Op. 222 왈츠 <Aeaciden>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Aeaciden>', 'Waltz <Aeaciden>', 'song', 'Op. 222', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Aeaciden>'
);


-- Op. 223 행진곡 <Marsch der Studenten-Legion>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Marsch der Studenten-Legion>', 'March <Marsch der Studenten-Legion>', 'song', 'Op. 223', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Marsch der Studenten-Legion>'
);


-- Op. 224 왈츠 <Amphion-Klänge>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Amphion-Klänge>', 'Waltz <Amphion-Klänge>', 'song', 'Op. 224', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Amphion-Klänge>'
);


-- Op. 225 왈츠 <Aether-Träume>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Aether-Träume>', 'Waltz <Aether-Träume>', 'song', 'Op. 225', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Aether-Träume>'
);


-- Op. 226 행진곡 <Freiheits-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Freiheits-Marsch>', 'March <Freiheits-Marsch>', 'song', 'Op. 226', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Freiheits-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebfdd606-7022-4c71-8116-705e2be41062'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ebfdd606-7022-4c71-8116-705e2be41062'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '행진곡 <Freiheits-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ebfdd606-7022-4c71-8116-705e2be41062'
);


-- Op. 227 행진곡 <Marsch des einigen Deutschlands>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Marsch des einigen Deutschlands>', 'March <Marsch des einigen Deutschlands>', 'song', 'Op. 227', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Marsch des einigen Deutschlands>'
);


-- Op. 228 라데츠키 행진곡

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '64e7a2e2-dc44-3488-9322-4fd2ff39153f'
FROM pieces p
WHERE p.id = 238 AND p.composer_id = 54
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '64e7a2e2-dc44-3488-9322-4fd2ff39153f'
);


-- Op. 229 카드리유 <Quadrille im militärischen Style>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Quadrille im militärischen Style>', 'Quadrille <Quadrille im militärischen Style>', 'song', 'Op. 229', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Quadrille im militärischen Style>'
);


-- Op. 230 왈츠 <Sorgenbrecher>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sorgenbrecher>', 'Waltz <Sorgenbrecher>', 'song', 'Op. 230', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sorgenbrecher>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bfde3a94-3a52-42e8-a7ad-3866bafe9ae6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bfde3a94-3a52-42e8-a7ad-3866bafe9ae6'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '왈츠 <Sorgenbrecher>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bfde3a94-3a52-42e8-a7ad-3866bafe9ae6'
);


-- Op. 231 행진곡 <Brünner National-Garde-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Brünner National-Garde-Marsch>', 'March <Brünner National-Garde-Marsch>', 'song', 'Op. 231', NULL, NULL, 1848, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Brünner National-Garde-Marsch>'
);


-- Op. 232 왈츠 <Landesfarben>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Landesfarben>', 'Waltz <Landesfarben>', 'song', 'Op. 232', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Landesfarben>'
);


-- Op. 233 카드리유 <Huldigungs-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Huldigungs-Quadrille>', 'Quadrille <Huldigungs-Quadrille>', 'song', 'Op. 233', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Huldigungs-Quadrille>'
);


-- Op. 234 카드리유 <Louisen-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Louisen-Quadrille>', 'Quadrille <Louisen-Quadrille>', 'song', 'Op. 234', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Louisen-Quadrille>'
);


-- Op. 235 폴카 <Piefke und Pufke-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Piefke und Pufke-Polka>', 'Polka <Piefke und Pufke-Polka>', 'song', 'Op. 235', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Piefke und Pufke-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2193d8c6-789d-494d-8f0c-581f05b3cb66'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2193d8c6-789d-494d-8f0c-581f05b3cb66'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Piefke und Pufke-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2193d8c6-789d-494d-8f0c-581f05b3cb66'
);


-- Op. 236 폴카 <Damen-Souvenir-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Damen-Souvenir-Polka>', 'Polka <Damen-Souvenir-Polka>', 'song', 'Op. 236', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Damen-Souvenir-Polka>'
);


-- Op. 237 왈츠 <Des Wanderers Lebewohl>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Des Wanderers Lebewohl>', 'Waltz <Des Wanderers Lebewohl>', 'song', 'Op. 237', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Des Wanderers Lebewohl>'
);


-- Op. 238 폴카 <Alice-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Alice-Polka>', 'Polka <Alice-Polka>', 'song', 'Op. 238', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Alice-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e618e92c-e80d-4dde-b950-5373aedf1053'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e618e92c-e80d-4dde-b950-5373aedf1053'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Alice-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e618e92c-e80d-4dde-b950-5373aedf1053'
);


-- Op. 239 폴카 <Frederica-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Frederica-Polka>', 'Polka <Frederica-Polka>', 'song', 'Op. 239', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Frederica-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c692af9-1d68-4c5f-b90f-97bef2137ed8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c692af9-1d68-4c5f-b90f-97bef2137ed8'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Frederica-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c692af9-1d68-4c5f-b90f-97bef2137ed8'
);


-- Op. 240 행진곡 Op. 240

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 Op. 240', '2 Marches for the Royal Spanish Noble Guard, Op. 240', 'album', NULL, 'Op.', '240', 1849, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 Op. 240'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:strauss1:strauss1-op240:1', 1, NULL, 'Triumph-Marsch', 'No. 1: Triumph-Marsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '행진곡 Op. 240' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:strauss1:strauss1-op240:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:strauss1:strauss1-op240:2', 2, NULL, 'Manövrir-Marsch', 'No. 2: Manövrir-Marsch', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '행진곡 Op. 240' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:strauss1:strauss1-op240:2'
);


-- Op. 241 왈츠 <Die Friedensboten>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Die Friedensboten>', 'Waltz <Die Friedensboten>', 'song', 'Op. 241', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Die Friedensboten>'
);


-- Op. 242 왈츠 <Soldaten-Lieder>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Soldaten-Lieder>', 'Waltz <Soldaten-Lieder>', 'song', 'Op. 242', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Soldaten-Lieder>'
);


-- Op. 243 카드리유 <Almacks-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Almacks-Quadrille>', 'Quadrille <Almacks-Quadrille>', 'song', 'Op. 243', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Almacks-Quadrille>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '516dad8b-ce63-49c4-8c38-bf99579b722c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '516dad8b-ce63-49c4-8c38-bf99579b722c'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '카드리유 <Almacks-Quadrille>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '516dad8b-ce63-49c4-8c38-bf99579b722c'
);


-- Op. 244 행진곡 <Jelačić-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Jelačić-Marsch>', 'March <Jelačić-Marsch>', 'song', 'Op. 244', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Jelačić-Marsch>'
);


-- Op. 245 행진곡 <Wiener Jubel-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Wiener Jubel-Marsch>', 'March <Wiener Jubel-Marsch>', 'song', 'Op. 245', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Wiener Jubel-Marsch>'
);


-- Op. 246 행진곡 <Wiener Stadt-Garde-Marsch>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Wiener Stadt-Garde-Marsch>', 'March <Wiener Stadt-Garde-Marsch>', 'song', 'Op. 246', NULL, NULL, 1849, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Wiener Stadt-Garde-Marsch>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed2b8089-105c-4de4-9392-601f2d1809f2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed2b8089-105c-4de4-9392-601f2d1809f2'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '행진곡 <Wiener Stadt-Garde-Marsch>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed2b8089-105c-4de4-9392-601f2d1809f2'
);


-- Op. 247 왈츠 <Deutsche Jubellaute>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Deutsche Jubellaute>', 'Waltz <Deutsche Jubellaute>', 'song', 'Op. 247', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Deutsche Jubellaute>'
);


-- Op. 248 카드리유 Op. 248

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 Op. 248', 'Quadrille, Op. 248', 'song', NULL, 'Op.', '248', NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 Op. 248'
);


-- Op. 249 폴카 <Exeter-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Exeter-Polka>', 'Polka <Exeter-Polka>', 'song', 'Op. 249', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Exeter-Polka>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ad932f4-c884-4bd8-b903-7deb43a7d082'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ad932f4-c884-4bd8-b903-7deb43a7d082'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '폴카 <Exeter-Polka>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ad932f4-c884-4bd8-b903-7deb43a7d082'
);


-- Op. 251 환상곡 <Melodische Tändeleien>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상곡 <Melodische Tändeleien>', 'Fantasy <Melodische Tändeleien>', 'song', 'Op. 251', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상곡 <Melodische Tändeleien>'
);


-- None 왈츠 <Walzer mit Coda in F>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Walzer mit Coda in F>', 'Waltz <Walzer mit Coda in F>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Walzer mit Coda in F>'
);


-- None 왈츠 <Walzer für den Carneval 1820>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Walzer für den Carneval 1820>', 'Waltz <Walzer für den Carneval 1820>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Walzer für den Carneval 1820>'
);


-- None 왈츠 <Sieben Walzer in F>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '왈츠 <Sieben Walzer in F>', 'Waltz <Sieben Walzer in F>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '왈츠 <Sieben Walzer in F>'
);


-- None 행진곡 <Original-Parade-Marsch (Wiener Bürger-Marsch Nr. 1)>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '행진곡 <Original-Parade-Marsch (Wiener Bürger-Marsch Nr. 1)>', 'March <Original-Parade-Marsch (Wiener Bürger-Marsch Nr. 1)>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '행진곡 <Original-Parade-Marsch (Wiener Bürger-Marsch Nr. 1)>'
);


-- None 갤럽 <Schauer-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Schauer-Galopp>', 'Galop <Schauer-Galopp>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Schauer-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdab2375-1e5f-4cd1-8e65-b5755f957751'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'fdab2375-1e5f-4cd1-8e65-b5755f957751'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Schauer-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'fdab2375-1e5f-4cd1-8e65-b5755f957751'
);


-- None 갤럽 <Stelldichein-Galopp>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Stelldichein-Galopp>', 'Galop <Stelldichein-Galopp>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Stelldichein-Galopp>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c5ebcd2-57df-4b60-b6d8-565b9fad0e43'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0c5ebcd2-57df-4b60-b6d8-565b9fad0e43'
FROM pieces p
WHERE p.composer_id = 54 AND p.title = '갤럽 <Stelldichein-Galopp>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0c5ebcd2-57df-4b60-b6d8-565b9fad0e43'
);


-- None 폴카 <Charmant-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Charmant-Polka>', 'Polka <Charmant-Polka>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Charmant-Polka>'
);


-- None 폴카 <Launen-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Launen-Polka>', 'Polka <Launen-Polka>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Launen-Polka>'
);


-- None 갤럽 <Das Fest der Handwerker>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '갤럽 <Das Fest der Handwerker>', 'Galop <Das Fest der Handwerker>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '갤럽 <Das Fest der Handwerker>'
);


-- None 폴카 <Polka in Es>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Polka in Es>', 'Polka <Polka in Es>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Polka in Es>'
);


-- None 폴카 <Jäger-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Jäger-Polka>', 'Polka <Jäger-Polka>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Jäger-Polka>'
);


-- None 폴카 <Pariser-Polka>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '폴카 <Pariser-Polka>', 'Polka <Pariser-Polka>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '폴카 <Pariser-Polka>'
);


-- None 카드리유 <Militär-Quadrille>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '카드리유 <Militär-Quadrille>', 'Quadrille <Militär-Quadrille>', 'song', NULL, NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 54
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '카드리유 <Militär-Quadrille>'
);

