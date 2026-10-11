-- 스트라빈스키 작품을 출판 단위로 채운다(카탈로그: K.(키르히마이어)). 작품 124개(묶음 21, 다악장 37, 낱곡 66),
-- 새 작품 120개, 기존 작품 4개, part 241개, 그 아래 0개, 기존 낱곡 연결 0개.
--
-- 정한 것
--   무대 작품은 part 없이 둔다. <불새> 모음곡 1911·1919·1945 는 발레와 따로, 자기 편곡 모음곡도 따로 둔다.
--   312 「시편 교향곡」의 작품번호는 위키백과 K 표대로 맨 끝에서 K. 51 → K. 52 로 고친다(K. 51 은 관현악을 위한 4개의 연습곡).
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

-- KN 1 타란텔라

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '타란텔라', 'Tarantella', 'song', 'KN 1', NULL, NULL, 1898, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '타란텔라'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbe74ced-010c-4fd5-ae70-bab09986d563'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dbe74ced-010c-4fd5-ae70-bab09986d563'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '타란텔라' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dbe74ced-010c-4fd5-ae70-bab09986d563'
);


-- KN 2 스케르초 G단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '스케르초 G단조', 'Scherzo in G minor', 'song', 'KN 2', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '스케르초 G단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7d4ea44-2321-478c-bf68-8b454958d13b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd7d4ea44-2321-478c-bf68-8b454958d13b'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '스케르초 G단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd7d4ea44-2321-478c-bf68-8b454958d13b'
);


-- KN 3 가곡 <Tucha>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Tucha>', 'The Storm Cloud (Tucha)', 'song', 'KN 3', NULL, NULL, 1902, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Tucha>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17fecb4e-26df-4a0e-a371-0b5e054f430f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '17fecb4e-26df-4a0e-a371-0b5e054f430f'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '가곡 <Tucha>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '17fecb4e-26df-4a0e-a371-0b5e054f430f'
);


-- K. 1 피아노 소나타 F#단조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타 F#단조', 'Piano Sonata in F♯ minor', 'album', 'K. 1', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타 F#단조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8822e66e-de20-4e1c-a290-e82c6b66cd66'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8822e66e-de20-4e1c-a290-e82c6b66cd66'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8822e66e-de20-4e1c-a290-e82c6b66cd66'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:22032738-a303-4ab5-9e88-84725c561875', 1, 'I', 'Allegro', 'I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:22032738-a303-4ab5-9e88-84725c561875'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c33376b-626d-4972-9f6f-25fcc4866752', 2, 'II', 'Vivo', 'II. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c33376b-626d-4972-9f6f-25fcc4866752'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06c91341-07ec-4e58-949e-f7b3987d09c0', 3, 'III', 'Andante', 'III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06c91341-07ec-4e58-949e-f7b3987d09c0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd6e59d5-276c-458b-9354-b236ed54ae45', 4, 'IV', 'Allegro – Andante', 'IV. Allegro – Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타 F#단조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd6e59d5-276c-458b-9354-b236ed54ae45'
);


-- KN 5 가곡 <Kak griby na voynu sobiralis'>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <Kak griby na voynu sobiralis''>', 'How the Mushrooms Prepared for War', 'song', 'KN 5', NULL, NULL, 1904, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <Kak griby na voynu sobiralis''>'
);


-- K. 3 교향곡 E♭장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 E♭장조', 'Symphony in E♭ major, Op. 1', 'album', 'K. 3', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 E♭장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9013a921-9e7a-4c11-9dda-adfb37e7a9f1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9013a921-9e7a-4c11-9dda-adfb37e7a9f1'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9013a921-9e7a-4c11-9dda-adfb37e7a9f1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3c552b67-4dee-305b-8c49-bec41e3bffe8', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3c552b67-4dee-305b-8c49-bec41e3bffe8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b48eb65-3c6b-3701-9199-65a794a528f2', 2, 'II', '스케르초. Allegretto', 'II. Scherzo. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b48eb65-3c6b-3701-9199-65a794a528f2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:187f922b-8f22-39bd-8b0d-ed0184922234', 3, 'III', 'Largo', 'III. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:187f922b-8f22-39bd-8b0d-ed0184922234'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9865ebcc-367c-318e-8338-cdc5c7a19668', 4, 'IV', '피날레. Allegro molto', 'IV. Finale. Allegro molto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 E♭장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9865ebcc-367c-318e-8338-cdc5c7a19668'
);


-- K. 2 연가곡 <목신과 양치기 소녀>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡 <목신과 양치기 소녀>', 'Faun and Shepherdess, Op. 2', 'album', 'K. 2', NULL, NULL, 1906, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡 <목신과 양치기 소녀>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'baabee6a-1011-4791-a4ea-b26d82e850ec'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'baabee6a-1011-4791-a4ea-b26d82e850ec'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <목신과 양치기 소녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'baabee6a-1011-4791-a4ea-b26d82e850ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ba82d554-f25c-3d66-9637-5baa5cbe1e65', 1, NULL, 'Pastushka', 'Pastushka (The Shepherdess)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <목신과 양치기 소녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ba82d554-f25c-3d66-9637-5baa5cbe1e65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a11b06f0-b2c3-397b-ad35-c89ba7601ffa', 2, NULL, 'Favn', 'Favn (The Faun)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <목신과 양치기 소녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a11b06f0-b2c3-397b-ad35-c89ba7601ffa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1dae7f00-7663-30ba-ab4e-5460ae13d7a7', 3, NULL, 'Reka', 'Reka (The Torrent)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <목신과 양치기 소녀>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dae7f00-7663-30ba-ab4e-5460ae13d7a7'
);


-- K. 6 파스토랄

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파스토랄', 'Pastorale', 'song', 'K. 6', NULL, NULL, 1907, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파스토랄'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '503dc69c-a07c-355b-bae5-e83ee71c625d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '503dc69c-a07c-355b-bae5-e83ee71c625d'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '파스토랄' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '503dc69c-a07c-355b-bae5-e83ee71c625d'
);


-- K. 4 고로데츠키의 시에 의한 2개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '고로데츠키의 시에 의한 2개의 가곡', 'Two Melodies, Op. 6 (Gorodetsky)', 'album', 'K. 4', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '고로데츠키의 시에 의한 2개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89f863ab-a19a-4ef4-abc5-e9a42fec5b1b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '89f863ab-a19a-4ef4-abc5-e9a42fec5b1b'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '고로데츠키의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '89f863ab-a19a-4ef4-abc5-e9a42fec5b1b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1f648b0-8c6f-43a2-a0e9-afdb18e714ca', 1, NULL, 'Vesna (Monastyrskaya)', 'Vesna (Spring: The Cloister)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '고로데츠키의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1f648b0-8c6f-43a2-a0e9-afdb18e714ca'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57c0b7df-39aa-443c-91bf-ef20fd945fb1', 2, NULL, 'Rosyanka (Khlystovskaya)', 'Rosyanka (Dew: Mystic Song of the Khlysty)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '고로데츠키의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57c0b7df-39aa-443c-91bf-ef20fd945fb1'
);


-- K. 5 환상적 스케르초

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '환상적 스케르초', 'Scherzo fantastique, Op. 3', 'song', 'K. 5', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '환상적 스케르초'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d1b6b4c-f0c8-3fa1-9002-ba30fb22a094'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2d1b6b4c-f0c8-3fa1-9002-ba30fb22a094'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '환상적 스케르초' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2d1b6b4c-f0c8-3fa1-9002-ba30fb22a094'
);


-- K. 7 불꽃놀이

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '불꽃놀이', 'Fireworks (Feu d''artifice), Op. 4', 'song', 'K. 7', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '불꽃놀이'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57fd89e6-0915-47a4-817b-181ec4ff7517'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '57fd89e6-0915-47a4-817b-181ec4ff7517'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '불꽃놀이' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '57fd89e6-0915-47a4-817b-181ec4ff7517'
);


-- K. 8 장송가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '장송가', 'Funeral Song (Pogrebal''naya pesnya), Op. 5', 'song', 'K. 8', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '장송가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2dc2ed2-ff9a-495b-ba25-ba435ecc5872'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a2dc2ed2-ff9a-495b-ba25-ba435ecc5872'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '장송가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a2dc2ed2-ff9a-495b-ba25-ba435ecc5872'
);


-- K. 9 피아노를 위한 4개의 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노를 위한 4개의 연습곡', 'Four Studies, Op. 7', 'album', 'K. 9', NULL, NULL, 1908, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노를 위한 4개의 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65d2f922-74d7-4e79-b23b-d2d6e6e98382'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65d2f922-74d7-4e79-b23b-d2d6e6e98382'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노를 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65d2f922-74d7-4e79-b23b-d2d6e6e98382'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17a095f4-cd53-48a4-a318-c68d9c9dddb2', 1, NULL, 'C단조', 'No. 1 in C minor. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노를 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17a095f4-cd53-48a4-a318-c68d9c9dddb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42f22b2d-c8b1-425a-bae9-c33fd58f3f93', 2, NULL, 'D장조', 'No. 2 in D major. Allegro brillante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노를 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42f22b2d-c8b1-425a-bae9-c33fd58f3f93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6636e16-f560-416d-9497-e1b75f8eba06', 3, NULL, 'E단조', 'No. 3 in E minor. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노를 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6636e16-f560-416d-9497-e1b75f8eba06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:41aaa405-b735-4d65-bc0a-345bbed66fef', 4, NULL, 'F#장조', 'No. 4 in F♯ major. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노를 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:41aaa405-b735-4d65-bc0a-345bbed66fef'
);


-- K. 10 발레 모음곡 <불새> (1911)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <불새> (1911)', 'The Firebird, Suite No. 1 (1911)', 'album', 'K. 10', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <불새> (1911)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab20538f-9088-4102-bea9-d394703f67e2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ab20538f-9088-4102-bea9-d394703f67e2'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1911)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ab20538f-9088-4102-bea9-d394703f67e2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:08afc946-c503-45ea-91eb-2523a24ee0f9', 1, 'I', '서주 – Jardin enchanté de Kachtcheï – Danse de l''oiseau de feu', 'I. Introduction – Kashchei''s Enchanted Garden – Dance of the Firebird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1911)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:08afc946-c503-45ea-91eb-2523a24ee0f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1ce009a-1b19-4598-85b9-1ba700f50eb2', 2, 'II', 'Supplications de l''oiseau de feu', 'II. Supplication of the Firebird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1911)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1ce009a-1b19-4598-85b9-1ba700f50eb2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7b28b45f-d747-4221-a9c9-64a93d20b2cd', 3, 'III', 'Jeu des princesses avec les pommes d''or', 'III. The Princesses'' Game with the Golden Apples', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1911)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7b28b45f-d747-4221-a9c9-64a93d20b2cd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1ca372e-f694-42ca-b424-e1d325f92227', 4, 'IV', 'Ronde des princesses (Khorovode)', 'IV. The Princesses'' Khorovod', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1911)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1ca372e-f694-42ca-b424-e1d325f92227'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48c2c161-ad84-42f4-8986-bc0008f10e4e', 5, 'V', 'Danse infernale de tous les sujets de Kachtcheï', 'V. Infernal Dance of All Kashchei''s Subjects', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1911)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48c2c161-ad84-42f4-8986-bc0008f10e4e'
);


-- K. 10 발레 모음곡 <불새> (1919)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <불새> (1919)', 'The Firebird, Suite No. 2 (1919)', 'album', 'K. 10', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <불새> (1919)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a00a184-8e67-4b01-a496-81b1b6df9a88'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1a00a184-8e67-4b01-a496-81b1b6df9a88'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1919)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1a00a184-8e67-4b01-a496-81b1b6df9a88'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5e780df-3693-40a5-9dc0-0623033a8ae0', 1, 'I', '서주', 'I. Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1919)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5e780df-3693-40a5-9dc0-0623033a8ae0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:123a4c09-3bde-4624-ae15-ef55ee7f95e1', 2, 'II', 'L''oiseau de feu et sa danse', 'II. The Firebird and its Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1919)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:123a4c09-3bde-4624-ae15-ef55ee7f95e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a594bc7b-2436-4b00-815e-13ab2e02c92e', 3, 'III', 'Variation de l''oiseau de feu', 'III. Variation of the Firebird', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1919)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a594bc7b-2436-4b00-815e-13ab2e02c92e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe91c939-f74f-42b8-908c-e212d26b705a', 4, 'IV', 'Ronde des princesses (Khorovode)', 'IV. The Princesses'' Khorovod (Rondo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1919)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe91c939-f74f-42b8-908c-e212d26b705a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a06c71e7-e293-4206-a40b-a4cf89b34cb0', 5, 'V', 'Danse infernale du roi Kachtcheï', 'V. Infernal Dance of King Kashchei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1919)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a06c71e7-e293-4206-a40b-a4cf89b34cb0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:223dae8d-badc-42a8-a94e-86cf9adf9338', 6, 'VI', '자장가 (Berceuse)', 'VI. Lullaby (Berceuse)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1919)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:223dae8d-badc-42a8-a94e-86cf9adf9338'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0eb658ac-cab3-4008-a4fa-ab0565f99dc8', 7, 'VII', '피날레', 'VII. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1919)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0eb658ac-cab3-4008-a4fa-ab0565f99dc8'
);


-- K. 10 발레 모음곡 <불새> (1945)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <불새> (1945)', 'The Firebird, Suite No. 3 (1945)', 'album', 'K. 10', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <불새> (1945)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e58d3dd-97c3-484f-ae0f-972bcfbaec54'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4e58d3dd-97c3-484f-ae0f-972bcfbaec54'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4e58d3dd-97c3-484f-ae0f-972bcfbaec54'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:stravinsky:stravinsky-k010-suite1945:1', 1, 'I', '서주 – Prélude et danse de l''oiseau de feu – Variations', 'I. Introduction – Prelude and Dance of the Firebird – Variations (Firebird)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:stravinsky:stravinsky-k010-suite1945:1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d69a95b4-2160-454d-9528-d318fe74015d', 2, 'II', 'Pantomime I', 'II. Pantomime I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d69a95b4-2160-454d-9528-d318fe74015d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab517907-3038-4039-b11f-5c673d5ddd52', 3, 'III', 'Pas de deux: l''oiseau de feu et Ivan Tsarévitch', 'III. Pas de deux: Firebird and Ivan Tsarevich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab517907-3038-4039-b11f-5c673d5ddd52'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d596a5b0-a980-4d6b-b4eb-8ba82263c281', 4, 'IV', 'Pantomime II', 'IV. Pantomime II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d596a5b0-a980-4d6b-b4eb-8ba82263c281'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07b7f16f-b0c5-4f80-9681-a587cc7a0690', 5, 'V', '스케르초: danse des princesses', 'V. Scherzo: Dance of the Princesses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07b7f16f-b0c5-4f80-9681-a587cc7a0690'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1efc4d9f-0566-4452-8991-70799baf8f7f', 6, 'VI', 'Pantomime III', 'VI. Pantomime III', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1efc4d9f-0566-4452-8991-70799baf8f7f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c61e690-f667-41b0-9ce7-34b39551eb0e', 7, 'VII', '론도 (Khorovode)', 'VII. Rondo (Khorovod)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c61e690-f667-41b0-9ce7-34b39551eb0e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fdc6e5ef-e66c-43a5-a83c-ebd634f9bea7', 8, 'VIII', 'Danse infernale', 'VIII. Infernal Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fdc6e5ef-e66c-43a5-a83c-ebd634f9bea7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:18163966-eb17-4060-9762-975cd29ac4d1', 9, 'IX', '자장가 (Berceuse)', 'IX. Lullaby (Firebird)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:18163966-eb17-4060-9762-975cd29ac4d1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6009a712-855d-43c0-b1b5-c1900345669b', 10, 'X', '피날레 찬가', 'X. Final Hymn', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <불새> (1945)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6009a712-855d-43c0-b1b5-c1900345669b'
);


-- K. 11 베를렌의 시에 의한 2개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '베를렌의 시에 의한 2개의 가곡', 'Two Poems of Paul Verlaine, Op. 9', 'album', 'K. 11', NULL, NULL, 1910, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '베를렌의 시에 의한 2개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4cfa5ab-2476-49a8-9ac0-91bfee02cbcf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f4cfa5ab-2476-49a8-9ac0-91bfee02cbcf'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '베를렌의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f4cfa5ab-2476-49a8-9ac0-91bfee02cbcf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f365ad4f-a534-3292-9ce2-5e9cb83402dc', 1, NULL, 'La lune blanche', 'La lune blanche luit dans les bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '베를렌의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f365ad4f-a534-3292-9ce2-5e9cb83402dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d584934c-7bff-362d-823f-40f66742720b', 2, NULL, 'Un grand sommeil noir', 'Un grand sommeil noir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '베를렌의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d584934c-7bff-362d-823f-40f66742720b'
);


-- K. 12 <페트루슈카>에서 3개의 악장

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '<페트루슈카>에서 3개의 악장', 'Three Movements from Petrushka', 'album', 'K. 12', NULL, NULL, 1921, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '<페트루슈카>에서 3개의 악장'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b685bd07-b0b4-4f1e-b8eb-cbfdf5b95093'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b685bd07-b0b4-4f1e-b8eb-cbfdf5b95093'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '<페트루슈카>에서 3개의 악장' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b685bd07-b0b4-4f1e-b8eb-cbfdf5b95093'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6c4a25b-062b-43b2-8771-8e5ec26f8e81', 1, 'I', 'Danse russe', 'I. Danse russe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '<페트루슈카>에서 3개의 악장' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6c4a25b-062b-43b2-8771-8e5ec26f8e81'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec1888c0-94e7-4fdd-b3a8-6b8f6ca248aa', 2, 'II', 'Chez Pétrouchka', 'II. Chez Pétrouchka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '<페트루슈카>에서 3개의 악장' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec1888c0-94e7-4fdd-b3a8-6b8f6ca248aa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:26e77f21-3700-47bd-81cb-003a377e5be0', 3, 'III', 'La semaine grasse', 'III. La semaine grasse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '<페트루슈카>에서 3개의 악장' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:26e77f21-3700-47bd-81cb-003a377e5be0'
);


-- K. 13 발몬트의 시에 의한 2개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발몬트의 시에 의한 2개의 가곡', 'Two Poems of Konstantin Balmont', 'album', 'K. 13', NULL, NULL, 1911, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발몬트의 시에 의한 2개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26fc958e-37c6-42ac-bd7d-1c473d872dfc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '26fc958e-37c6-42ac-bd7d-1c473d872dfc'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발몬트의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '26fc958e-37c6-42ac-bd7d-1c473d872dfc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09fe494c-9f6b-3cd1-b2b7-591aa9ac2215', 1, NULL, 'Nezabudochka-tsvetochek', 'Nezabudochka-tsvetochek (The Forget-me-not)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발몬트의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09fe494c-9f6b-3cd1-b2b7-591aa9ac2215'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d615900e-14a1-3e04-bcea-e32cad60c471', 2, NULL, 'Golub''', 'Golub'' (The Dove)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발몬트의 시에 의한 2개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d615900e-14a1-3e04-bcea-e32cad60c471'
);


-- K. 14 칸타타 <즈베즈돌리키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <즈베즈돌리키>', 'Zvezdoliki (The King of the Stars)', 'song', 'K. 14', NULL, NULL, 1912, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <즈베즈돌리키>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b2a812b-0b3a-4a28-b991-2c15c99ffd44'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1b2a812b-0b3a-4a28-b991-2c15c99ffd44'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '칸타타 <즈베즈돌리키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1b2a812b-0b3a-4a28-b991-2c15c99ffd44'
);


-- K. 16 3개의 일본 서정시

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 일본 서정시', 'Three Japanese Lyrics', 'album', 'K. 16', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 일본 서정시'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29144960-0156-4a7f-93ef-7a24d435a5ee'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29144960-0156-4a7f-93ef-7a24d435a5ee'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3개의 일본 서정시' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29144960-0156-4a7f-93ef-7a24d435a5ee'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02fac7f8-6099-3744-a911-a3446c245ade', 1, NULL, 'Akahito', 'Akahito', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3개의 일본 서정시' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02fac7f8-6099-3744-a911-a3446c245ade'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cf63c41a-9dc9-38f4-8612-80e00f301c05', 2, NULL, 'Mazatsumi', 'Mazatsumi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3개의 일본 서정시' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cf63c41a-9dc9-38f4-8612-80e00f301c05'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a84eed5-a3ea-3512-9e52-a0b8528938a7', 3, NULL, 'Tsaraiuki', 'Tsaraiuki', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3개의 일본 서정시' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a84eed5-a3ea-3512-9e52-a0b8528938a7'
);


-- K. 17 3개의 작은 노래 "어린 시절의 추억"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3개의 작은 노래 "어린 시절의 추억"', 'Three Little Songs "Recollections of My Childhood"', 'album', 'K. 17', NULL, NULL, 1913, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3개의 작은 노래 "어린 시절의 추억"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55dcd5a6-5b31-48dd-bcc7-9206c980f1ba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55dcd5a6-5b31-48dd-bcc7-9206c980f1ba'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3개의 작은 노래 "어린 시절의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55dcd5a6-5b31-48dd-bcc7-9206c980f1ba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd469ba3-fb82-38e3-9188-57dabf721086', 1, NULL, 'Soroka', 'Soroka (The Magpie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3개의 작은 노래 "어린 시절의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd469ba3-fb82-38e3-9188-57dabf721086'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d7a8a4fe-4602-3512-bc02-5944c3a31620', 2, NULL, 'Vorona', 'Vorona (The Rook)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3개의 작은 노래 "어린 시절의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d7a8a4fe-4602-3512-bc02-5944c3a31620'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7840dfde-778f-30f7-aa9b-ee21f19e276b', 3, NULL, 'Chicher-Yacher', 'Chicher-Yacher (The Jackdaw)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3개의 작은 노래 "어린 시절의 추억"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7840dfde-778f-30f7-aa9b-ee21f19e276b'
);


-- K. 18 오페라 <나이팅게일>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <나이팅게일>', 'The Nightingale (Le Rossignol)', 'song', 'K. 18', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <나이팅게일>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56f9527e-e9f6-43fc-a996-9bdbd8b494df'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '56f9527e-e9f6-43fc-a996-9bdbd8b494df'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '오페라 <나이팅게일>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '56f9527e-e9f6-43fc-a996-9bdbd8b494df'
);


-- K. 19 현악 4중주를 위한 3개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 3개의 소품', 'Three Pieces for String Quartet', 'album', 'K. 19', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 3개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '083ad482-31be-4f13-84c2-69a18f40eed1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '083ad482-31be-4f13-84c2-69a18f40eed1'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 4중주를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '083ad482-31be-4f13-84c2-69a18f40eed1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:271d5b0a-452f-4a9d-a8c7-0f535d09c1a5', 1, NULL, 'Danse', 'Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 4중주를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:271d5b0a-452f-4a9d-a8c7-0f535d09c1a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:82141dc3-e8cd-44fa-97f8-82e490e869c4', 2, NULL, 'Excentrique', 'Excentrique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 4중주를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:82141dc3-e8cd-44fa-97f8-82e490e869c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:db53666c-81f3-48bc-ae29-50be08a9c083', 3, NULL, 'Cantique', 'Cantique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 4중주를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:db53666c-81f3-48bc-ae29-50be08a9c083'
);


-- K. 20 연가곡 <프리바우트키>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡 <프리바우트키>', 'Pribaoutki', 'album', 'K. 20', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡 <프리바우트키>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf68e33b-fd29-48fc-a3e6-ac6ef8abcbdf'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bf68e33b-fd29-48fc-a3e6-ac6ef8abcbdf'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <프리바우트키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bf68e33b-fd29-48fc-a3e6-ac6ef8abcbdf'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8c11807-6e4e-38b6-bb7c-0a592176fc6a', 1, NULL, 'Kornilo', 'Kornilo (Uncle Kornilo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <프리바우트키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8c11807-6e4e-38b6-bb7c-0a592176fc6a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:662fbe52-a9d0-3e58-8bc6-7561623b00bd', 2, NULL, 'Natashka', 'Natashka (Little Natalie)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <프리바우트키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:662fbe52-a9d0-3e58-8bc6-7561623b00bd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc23f65b-9dd5-38a4-94dc-6c183041497d', 3, NULL, 'Polkovnik', 'Polkovnik (The Colonel)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <프리바우트키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc23f65b-9dd5-38a4-94dc-6c183041497d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80814f2d-806b-3f11-938f-3ad10eaf35a5', 4, NULL, 'Starets i zayats', 'Starets i zayats (The Old Man and the Hare)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <프리바우트키>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80814f2d-806b-3f11-938f-3ad10eaf35a5'
);


-- KN 12 꽃의 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '꽃의 왈츠', 'Valse des fleurs', 'song', 'KN 12', NULL, NULL, 1914, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '꽃의 왈츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46de2c79-0fac-4e1d-8a23-e48e4be125f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '46de2c79-0fac-4e1d-8a23-e48e4be125f9'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '꽃의 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '46de2c79-0fac-4e1d-8a23-e48e4be125f9'
);


-- K. 21 피아노 연탄을 위한 3개의 쉬운 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄을 위한 3개의 쉬운 소품', 'Three Easy Pieces', 'album', 'K. 21', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄을 위한 3개의 쉬운 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb81e72d-0978-42bc-ae37-76353b648251'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'eb81e72d-0978-42bc-ae37-76353b648251'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 3개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'eb81e72d-0978-42bc-ae37-76353b648251'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d53becc1-737a-4fab-b609-635978c603ac', 1, NULL, '행진곡', 'Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 3개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d53becc1-737a-4fab-b609-635978c603ac'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdb71e9c-11cf-4373-8f4c-5768a2ee5727', 2, NULL, '왈츠', 'Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 3개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdb71e9c-11cf-4373-8f4c-5768a2ee5727'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5b84d7c-17a8-4a08-813e-5be444b939c6', 3, NULL, '폴카', 'Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 3개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5b84d7c-17a8-4a08-813e-5be444b939c6'
);


-- KN 14 독일 행진곡의 추억

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '독일 행진곡의 추억', 'Souvenir d''une marche boche', 'song', 'KN 14', NULL, NULL, 1915, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '독일 행진곡의 추억'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '701f5874-a9e4-4a4b-a27d-1c62300dd4fd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '701f5874-a9e4-4a4b-a27d-1c62300dd4fd'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '독일 행진곡의 추억' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '701f5874-a9e4-4a4b-a27d-1c62300dd4fd'
);


-- K. 22 연가곡 <고양이의 자장가>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '연가곡 <고양이의 자장가>', 'Berceuses du chat', 'album', 'K. 22', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '연가곡 <고양이의 자장가>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a49e5ff7-eba4-49b1-9afb-5461c55ce0f9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a49e5ff7-eba4-49b1-9afb-5461c55ce0f9'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <고양이의 자장가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a49e5ff7-eba4-49b1-9afb-5461c55ce0f9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f43bc21a-88c0-4095-b79c-9958ad67dfbd', 1, NULL, 'Sur le poêle', 'Sur le poêle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <고양이의 자장가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f43bc21a-88c0-4095-b79c-9958ad67dfbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98fde4c1-7839-4391-8d2c-6cee45acb7df', 2, NULL, 'Intérieur', 'Intérieur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <고양이의 자장가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98fde4c1-7839-4391-8d2c-6cee45acb7df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c63189d2-e483-4ec5-8909-26b32c6f2c31', 3, NULL, 'Dodo', 'Dodo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <고양이의 자장가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c63189d2-e483-4ec5-8909-26b32c6f2c31'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:688a9d22-20f6-41da-8915-30a056254405', 4, NULL, 'Ce qu''il a, le chat', 'Ce qu''il a, le chat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '연가곡 <고양이의 자장가>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:688a9d22-20f6-41da-8915-30a056254405'
);


-- K. 23 부를레스크 <여우>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '부를레스크 <여우>', 'Renard', 'song', 'K. 23', NULL, NULL, 1916, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '부를레스크 <여우>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65a8ab94-97bb-4528-bba8-32159c8b21a6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '65a8ab94-97bb-4528-bba8-32159c8b21a6'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '부를레스크 <여우>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '65a8ab94-97bb-4528-bba8-32159c8b21a6'
);


-- K. 24 어린이를 위한 3개의 이야기

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '어린이를 위한 3개의 이야기', 'Three Tales for Children', 'album', 'K. 24', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '어린이를 위한 3개의 이야기'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db80ca4a-1f47-44de-a6e9-ad499aaf589e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'db80ca4a-1f47-44de-a6e9-ad499aaf589e'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '어린이를 위한 3개의 이야기' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'db80ca4a-1f47-44de-a6e9-ad499aaf589e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9252ba1-bee5-4374-b6de-fc69fb1636ae', 1, NULL, 'Tilim-bom', 'Tilim-bom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '어린이를 위한 3개의 이야기' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9252ba1-bee5-4374-b6de-fc69fb1636ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:508d0259-7abc-4791-93dd-160f0caed52c', 2, NULL, 'Gusi, lebedi', 'Gusi, lebedi (Geese, Swans)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '어린이를 위한 3개의 이야기' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:508d0259-7abc-4791-93dd-160f0caed52c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d946cac4-5721-4a1a-9fcc-fa468082856d', 3, NULL, 'Pesenka medvedya', 'Pesenka medvedya (The Bear''s Little Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '어린이를 위한 3개의 이야기' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d946cac4-5721-4a1a-9fcc-fa468082856d'
);


-- K. 25 피아노 연탄을 위한 5개의 쉬운 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 연탄을 위한 5개의 쉬운 소품', 'Five Easy Pieces', 'album', 'K. 25', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 연탄을 위한 5개의 쉬운 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '725d01fe-2a2c-4eda-a17e-45f6f15602c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '725d01fe-2a2c-4eda-a17e-45f6f15602c1'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 5개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '725d01fe-2a2c-4eda-a17e-45f6f15602c1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9f5c80c5-411d-40ac-9c07-005fb415c69e', 1, NULL, 'Andante', 'Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 5개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9f5c80c5-411d-40ac-9c07-005fb415c69e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c0f97f0-a82a-4afe-99a6-822e981939dd', 2, NULL, 'Española', 'Española', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 5개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c0f97f0-a82a-4afe-99a6-822e981939dd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bf3fbd1-e7db-40f4-8522-e081806f928f', 3, NULL, 'Balalaika', 'Balalaika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 5개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bf3fbd1-e7db-40f4-8522-e081806f928f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32b7405f-0c78-4ef3-94bb-95b56cd6c401', 4, NULL, 'Napolitana', 'Napolitana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 5개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32b7405f-0c78-4ef3-94bb-95b56cd6c401'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7431836f-97d3-46a6-af85-3926ff62079d', 5, NULL, '갤럽', 'Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 연탄을 위한 5개의 쉬운 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7431836f-97d3-46a6-af85-3926ff62079d'
);


-- KN 16 어린이를 위한 왈츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '어린이를 위한 왈츠', 'Valse pour les enfants', 'song', 'KN 16', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '어린이를 위한 왈츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca95bf83-9be9-48f4-90e7-83c34ec18dad'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ca95bf83-9be9-48f4-90e7-83c34ec18dad'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '어린이를 위한 왈츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ca95bf83-9be9-48f4-90e7-83c34ec18dad'
);


-- K. 26 교향시 <나이팅게일의 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향시 <나이팅게일의 노래>', 'Song of the Nightingale (Le Chant du rossignol)', 'song', 'K. 26', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향시 <나이팅게일의 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a79fb213-970d-428b-8982-cbde96ba060e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a79fb213-970d-428b-8982-cbde96ba060e'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향시 <나이팅게일의 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a79fb213-970d-428b-8982-cbde96ba060e'
);


-- K. 27 피아놀라를 위한 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아놀라를 위한 연습곡', 'Étude pour pianola', 'song', 'K. 27', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아놀라를 위한 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5a1d09c-054b-40e8-949f-1afd08899a03'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd5a1d09c-054b-40e8-949f-1afd08899a03'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아놀라를 위한 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd5a1d09c-054b-40e8-949f-1afd08899a03'
);


-- K. 28 4개의 러시아 농민 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 러시아 농민 노래', 'Four Russian Peasant Songs (Podblyudnye)', 'album', 'K. 28', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 러시아 농민 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fd7245b-6e02-4088-9447-a9cf0d36b7b7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6fd7245b-6e02-4088-9447-a9cf0d36b7b7'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 농민 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6fd7245b-6e02-4088-9447-a9cf0d36b7b7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3baacc00-d77d-44e4-a648-9c3cdc8fb027', 1, NULL, 'U Spasa v Chigisakh', 'U Spasa v Chigisakh (On Saints'' Days in Chigisakh)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 농민 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3baacc00-d77d-44e4-a648-9c3cdc8fb027'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c046473-d090-4171-a4e8-6a59c7466af7', 2, NULL, 'Ovsen''', 'Ovsen''', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 농민 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c046473-d090-4171-a4e8-6a59c7466af7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ac796c1-818b-4250-ad21-84a449a2a567', 3, NULL, 'Shchuka', 'Shchuka (The Pike)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 농민 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ac796c1-818b-4250-ad21-84a449a2a567'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13d9cccf-a171-45c4-b187-ed4846afb6c4', 4, NULL, 'Puzishche', 'Puzishche (Master Portly)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 농민 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13d9cccf-a171-45c4-b187-ed4846afb6c4'
);


-- KN 17 두 대의 호른을 위한 카논

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 호른을 위한 카논', 'Canon for Two Horns', 'song', 'KN 17', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 호른을 위한 카논'
);


-- K. 40 무용 칸타타 <결혼>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '무용 칸타타 <결혼>', 'Les Noces (The Wedding)', 'song', 'K. 40', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '무용 칸타타 <결혼>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1eebbe93-77ac-4501-8b58-122b676bb088'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1eebbe93-77ac-4501-8b58-122b676bb088'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '무용 칸타타 <결혼>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1eebbe93-77ac-4501-8b58-122b676bb088'
);


-- K. 97 자장가

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '자장가', 'Berceuse', 'song', 'K. 97', NULL, NULL, 1917, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '자장가'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1ec2df4-0e13-4618-86d1-98556c9df575'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b1ec2df4-0e13-4618-86d1-98556c9df575'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '자장가' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b1ec2df4-0e13-4618-86d1-98556c9df575'
);


-- KN 19 두 대의 바순을 위한 <이름 없는 노래>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 바순을 위한 <이름 없는 노래>', 'Lied ohne Name (Duet for Two Bassoons)', 'song', 'KN 19', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 바순을 위한 <이름 없는 노래>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4b4e8c7-c4b3-4b28-b5ba-58cd55fc04c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b4b4e8c7-c4b3-4b28-b5ba-58cd55fc04c0'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 바순을 위한 <이름 없는 노래>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b4b4e8c7-c4b3-4b28-b5ba-58cd55fc04c0'
);


-- K. 29 음악극 <병사의 이야기>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악극 <병사의 이야기>', 'L''Histoire du soldat (The Soldier''s Tale)', 'song', 'K. 29', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악극 <병사의 이야기>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86154e21-c69d-4019-ad62-19d058b6be53'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '86154e21-c69d-4019-ad62-19d058b6be53'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '음악극 <병사의 이야기>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '86154e21-c69d-4019-ad62-19d058b6be53'
);


-- K. 29 클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡', 'Suite from L''Histoire du soldat for Violin, Clarinet and Piano', 'album', 'K. 29', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cee558f2-065f-483f-b0c7-08d49fc7ef12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'cee558f2-065f-483f-b0c7-08d49fc7ef12'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'cee558f2-065f-483f-b0c7-08d49fc7ef12'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cf25a2a-24b8-4c92-b3e8-b32b3420aa7b', 1, 'I', 'Marche du soldat', 'I. Marche du soldat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cf25a2a-24b8-4c92-b3e8-b32b3420aa7b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:967e6850-a7ff-4557-97ac-fa0defaa22eb', 2, 'II', 'Le violon du soldat', 'II. Le violon du soldat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:967e6850-a7ff-4557-97ac-fa0defaa22eb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed32c66a-8a61-450c-8748-5e827da17509', 3, 'III', 'Petit concert', 'III. Petit concert', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed32c66a-8a61-450c-8748-5e827da17509'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dbb6aca6-3092-40e7-a467-83ef14f5fcfd', 4, 'IV', '탱고 – 왈츠 – 래그타임', 'IV. Tango – Valse – Ragtime', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dbb6aca6-3092-40e7-a467-83ef14f5fcfd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31038268-2dba-4c03-b7fd-d040e08ea5bf', 5, 'V', 'Danse du diable', 'V. Danse du diable', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷, 바이올린, 피아노를 위한 <병사의 이야기> 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31038268-2dba-4c03-b7fd-d040e08ea5bf'
);


-- K. 30 11개 악기를 위한 래그타임

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '11개 악기를 위한 래그타임', 'Ragtime for Eleven Instruments', 'song', 'K. 30', NULL, NULL, 1918, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '11개 악기를 위한 래그타임'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24760792-6fc2-30e5-86e6-f1f71b4b3afb'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '24760792-6fc2-30e5-86e6-f1f71b4b3afb'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '11개 악기를 위한 래그타임' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '24760792-6fc2-30e5-86e6-f1f71b4b3afb'
);


-- K. 31 4개의 러시아 노래

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 러시아 노래', 'Quatre chants russes', 'album', 'K. 31', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 러시아 노래'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5cea31a-a113-4e4d-ab7d-e048c94d1749'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'e5cea31a-a113-4e4d-ab7d-e048c94d1749'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'e5cea31a-a113-4e4d-ab7d-e048c94d1749'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6cfa20d-92d0-4d11-87b4-54103eea6c2e', 1, NULL, 'Selezen''', 'Selezen'' (The Drake)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6cfa20d-92d0-4d11-87b4-54103eea6c2e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79a7033c-85b0-4f25-8603-4f34d899ea07', 2, NULL, 'Zapevnaya', 'Zapevnaya (Counting Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79a7033c-85b0-4f25-8603-4f34d899ea07'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94287ffd-211c-494c-a414-dbaf05123648', 3, NULL, 'Podblyudnaya', 'Podblyudnaya (Dish-Divination Song)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94287ffd-211c-494c-a414-dbaf05123648'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29fc91c8-a560-4845-aa9c-8188873f3aee', 4, NULL, 'Sektantskaya', 'Sektantskaya (Song of the Sectarian)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 러시아 노래' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29fc91c8-a560-4845-aa9c-8188873f3aee'
);


-- K. 32 피아노 래그 뮤직

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 래그 뮤직', 'Piano-Rag-Music', 'song', 'K. 32', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 래그 뮤직'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc0b686c-d903-3b3f-8c9e-6726dd127d10'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc0b686c-d903-3b3f-8c9e-6726dd127d10'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 래그 뮤직' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc0b686c-d903-3b3f-8c9e-6726dd127d10'
);


-- K. 33 클라리넷 독주를 위한 3개의 소품

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '클라리넷 독주를 위한 3개의 소품', 'Three Pieces for Clarinet Solo', 'album', 'K. 33', NULL, NULL, 1919, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '클라리넷 독주를 위한 3개의 소품'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4175222b-8675-4468-82f7-a5be8c48a049'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '4175222b-8675-4468-82f7-a5be8c48a049'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷 독주를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '4175222b-8675-4468-82f7-a5be8c48a049'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4fb4fc8c-b4d4-4231-a83e-74ec476b2219', 1, NULL, 'Sempre piano e molto tranquillo (♩ = 52)', 'Sempre piano e molto tranquillo (♩ = 52)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷 독주를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4fb4fc8c-b4d4-4231-a83e-74ec476b2219'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:387b617e-a875-4e0c-aca7-19f2a7c65b87', 2, NULL, '♪ = 168', '♪ = 168', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷 독주를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:387b617e-a875-4e0c-aca7-19f2a7c65b87'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bfbb8de-70f5-48f4-9899-8e46f3d0286d', 3, NULL, '♪ = 160', '♪ = 160', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '클라리넷 독주를 위한 3개의 소품' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bfbb8de-70f5-48f4-9899-8e46f3d0286d'
);


-- K. 34 발레 <풀치넬라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <풀치넬라>', 'Pulcinella', 'song', 'K. 34', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <풀치넬라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a80ecea-095d-4050-9a94-a5928530b8c1'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3a80ecea-095d-4050-9a94-a5928530b8c1'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3a80ecea-095d-4050-9a94-a5928530b8c1'
);


-- K. 34 발레 모음곡 <풀치넬라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 모음곡 <풀치넬라>', 'Pulcinella Suite', 'album', 'K. 34', NULL, NULL, 1922, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 모음곡 <풀치넬라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8acf6c28-7db3-42f3-8c79-d761fdb0ab89'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8acf6c28-7db3-42f3-8c79-d761fdb0ab89'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8acf6c28-7db3-42f3-8c79-d761fdb0ab89'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fe892b92-e503-3c0c-88b7-e6de86497bae', 1, 'I', '신포니아', 'I. Sinfonia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fe892b92-e503-3c0c-88b7-e6de86497bae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:678a0f2e-d804-375d-952f-ed73dc9b06d6', 2, 'II', '세레나타', 'II. Serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:678a0f2e-d804-375d-952f-ed73dc9b06d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:stravinsky:stravinsky-k034-suite:3', 3, 'III', 'Scherzino – Allegro – Andantino', 'III. Scherzino – Allegro – Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:stravinsky:stravinsky-k034-suite:3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f41f52ac-d2db-366e-8117-44a5b54b7846', 4, 'IV', '타란텔라', 'IV. Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f41f52ac-d2db-366e-8117-44a5b54b7846'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dcfa5bc-bcaa-3674-a8a8-6abee7623b4a', 5, 'V', '토카타', 'V. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dcfa5bc-bcaa-3674-a8a8-6abee7623b4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b61800a4-765a-3ff4-973a-293eb23c6f9d', 6, 'VI', '가보트와 2개의 변주', 'VI. Gavotta con due variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b61800a4-765a-3ff4-973a-293eb23c6f9d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8d16039-0a52-3135-81b5-f19173fd155b', 7, 'VII', 'Vivo', 'VII. Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8d16039-0a52-3135-81b5-f19173fd155b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'classicmap:stravinsky:stravinsky-k034-suite:8', 8, 'VIII', '미뉴에트 – 피날레', 'VIII. Minuetto – Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 모음곡 <풀치넬라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'classicmap:stravinsky:stravinsky-k034-suite:8'
);


-- K. 34 바이올린과 피아노를 위한 페르골레시 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 페르골레시 모음곡', 'Suite after Themes, Fragments and Pieces by Giambattista Pergolesi', 'album', 'K. 34', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 페르골레시 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9eb7bf66-78c5-481d-84d8-b486c192bae9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9eb7bf66-78c5-481d-84d8-b486c192bae9'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 페르골레시 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9eb7bf66-78c5-481d-84d8-b486c192bae9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5a074f9f-40a9-4bdd-92b4-10ff65f6d623', 1, 'I', '서주', 'I. Introduzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 페르골레시 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a074f9f-40a9-4bdd-92b4-10ff65f6d623'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02b6ced6-dd7e-49e0-bde2-7f716040e3d7', 2, 'II', '세레나타', 'II. Serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 페르골레시 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02b6ced6-dd7e-49e0-bde2-7f716040e3d7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34681603-fbe8-4ba6-8084-9816b358475c', 3, 'III', '타란텔라', 'III. Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 페르골레시 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34681603-fbe8-4ba6-8084-9816b358475c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b5fe940-78f8-4cb8-88b7-a2c8db7bcd4c', 4, 'IV', '가보트와 2개의 변주', 'IV. Gavotta con due variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 페르골레시 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b5fe940-78f8-4cb8-88b7-a2c8db7bcd4c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60412213-6d01-4386-bad9-2048b2280114', 5, 'V', '미뉴에트와 피날레', 'V. Minuetto e Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 페르골레시 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60412213-6d01-4386-bad9-2048b2280114'
);


-- K. 34 첼로와 피아노를 위한 이탈리아 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '첼로와 피아노를 위한 이탈리아 모음곡', 'Suite italienne for Cello and Piano', 'album', 'K. 34', NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '첼로와 피아노를 위한 이탈리아 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1424df4e-93dd-4d55-9fb5-d0e8e1d460a5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '1424df4e-93dd-4d55-9fb5-d0e8e1d460a5'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '첼로와 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '1424df4e-93dd-4d55-9fb5-d0e8e1d460a5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a368259e-7129-3729-968d-7b00d2096c67', 1, 'I', '서주. Allegro moderato', 'I. Introduzione. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '첼로와 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a368259e-7129-3729-968d-7b00d2096c67'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0828b304-e6fb-3301-9aa6-6375881d316d', 2, 'II', '세레나타. Larghetto', 'II. Serenata. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '첼로와 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0828b304-e6fb-3301-9aa6-6375881d316d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a1eb4d3-fdf4-3281-b458-4b106df30ef2', 3, 'III', '아리아', 'III. Aria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '첼로와 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a1eb4d3-fdf4-3281-b458-4b106df30ef2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fc14dba-d482-3649-8875-a3980b9a54b1', 4, 'IV', '타란텔라. Vivace', 'IV. Tarantella. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '첼로와 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fc14dba-d482-3649-8875-a3980b9a54b1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7c2748f-7645-3df8-81a0-9ab15ffe26a5', 5, 'V', '미뉴에트와 피날레', 'V. Minuetto e Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '첼로와 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7c2748f-7645-3df8-81a0-9ab15ffe26a5'
);


-- K. 34 바이올린과 피아노를 위한 이탈리아 모음곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린과 피아노를 위한 이탈리아 모음곡', 'Suite italienne for Violin and Piano', 'album', 'K. 34', NULL, NULL, 1933, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린과 피아노를 위한 이탈리아 모음곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b850c7e7-afb7-4690-93ad-8d4758d0bb5e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b850c7e7-afb7-4690-93ad-8d4758d0bb5e'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b850c7e7-afb7-4690-93ad-8d4758d0bb5e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1946f353-d6a2-3ea1-82b8-f49b324b58e6', 1, 'I', '서주', 'I. Introduzione', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1946f353-d6a2-3ea1-82b8-f49b324b58e6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6fba6263-3517-3d33-93d4-c88b638d40fa', 2, 'II', '세레나타', 'II. Serenata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6fba6263-3517-3d33-93d4-c88b638d40fa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e91bd958-4de2-3e15-9dd5-77d5ee108d0d', 3, 'III', '타란텔라', 'III. Tarantella', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e91bd958-4de2-3e15-9dd5-77d5ee108d0d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:997b847a-95e9-3010-8cdb-ed2b675e45c2', 4, 'IV', '가보트와 2개의 변주', 'IV. Gavotta con due variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:997b847a-95e9-3010-8cdb-ed2b675e45c2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f671940-0da2-3301-a32a-166630331fdc', 5, 'V', 'Scherzino', 'V. Scherzino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f671940-0da2-3301-a32a-166630331fdc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d828fca6-d6fc-385d-a640-02047f1f9abe', 6, 'VI', '미뉴에트와 피날레', 'VI. Minuetto e Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린과 피아노를 위한 이탈리아 모음곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d828fca6-d6fc-385d-a640-02047f1f9abe'
);


-- K. 35 현악 4중주를 위한 콘체르티노

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 4중주를 위한 콘체르티노', 'Concertino for String Quartet', 'song', 'K. 35', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 4중주를 위한 콘체르티노'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee4ce484-ef31-44b7-a379-34fe218516f0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ee4ce484-ef31-44b7-a379-34fe218516f0'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 4중주를 위한 콘체르티노' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ee4ce484-ef31-44b7-a379-34fe218516f0'
);


-- K. 36 관악기를 위한 교향곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악기를 위한 교향곡', 'Symphonies of Wind Instruments', 'song', 'K. 36', NULL, NULL, 1920, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악기를 위한 교향곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0872503-8d36-3eba-a192-e7ec3099fada'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a0872503-8d36-3eba-a192-e7ec3099fada'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관악기를 위한 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a0872503-8d36-3eba-a192-e7ec3099fada'
);


-- K. 38 소관현악을 위한 모음곡 2번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소관현악을 위한 모음곡 2번', 'Suite No. 2 for Small Orchestra', 'album', 'K. 38', NULL, NULL, 1921, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소관현악을 위한 모음곡 2번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ef42c5d-082d-432b-ad0d-1ad793f0e7d0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2ef42c5d-082d-432b-ad0d-1ad793f0e7d0'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2ef42c5d-082d-432b-ad0d-1ad793f0e7d0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32c62826-a897-3a23-ae26-4b7171135d5a', 1, 'I', '행진곡', 'I. Marche', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32c62826-a897-3a23-ae26-4b7171135d5a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7a4abee0-40be-3d21-9a34-bde27c99c7c6', 2, 'II', '왈츠', 'II. Valse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7a4abee0-40be-3d21-9a34-bde27c99c7c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:20227348-8aff-37d6-a750-4b97149fbb96', 3, 'III', '폴카', 'III. Polka', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:20227348-8aff-37d6-a750-4b97149fbb96'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:469b49e4-f482-36ee-8747-42126b729774', 4, 'IV', '갤럽', 'IV. Galop', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 2번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:469b49e4-f482-36ee-8747-42126b729774'
);


-- K. 37 피아노 모음곡 <다섯 손가락>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 모음곡 <다섯 손가락>', 'Les cinq doigts', 'album', 'K. 37', NULL, NULL, 1921, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 모음곡 <다섯 손가락>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3af124df-a766-4578-b296-5f8efd7fd437'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3af124df-a766-4578-b296-5f8efd7fd437'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3af124df-a766-4578-b296-5f8efd7fd437'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8c6e59b-7084-433a-918c-8b88a13b4620', 1, NULL, 'Andantino', 'Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8c6e59b-7084-433a-918c-8b88a13b4620'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d42f8eb1-8e44-419f-b594-f4cb8d90b2e1', 2, NULL, 'Allegro', 'Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d42f8eb1-8e44-419f-b594-f4cb8d90b2e1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3f027c5-757e-44f8-89e4-a22322feb50c', 3, NULL, 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3f027c5-757e-44f8-89e4-a22322feb50c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:792c9dee-5a87-4147-bc87-82edb407355a', 4, NULL, 'Larghetto', 'Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:792c9dee-5a87-4147-bc87-82edb407355a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af5f6a9c-0f10-43a4-abb1-020fbc3722ec', 5, NULL, 'Moderato', 'Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af5f6a9c-0f10-43a4-abb1-020fbc3722ec'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24c86c45-3e86-4225-9eb0-68cfcc39dd4e', 6, NULL, 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24c86c45-3e86-4225-9eb0-68cfcc39dd4e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0c76d7d-4abc-480e-bf1d-2975fe856ecc', 7, NULL, 'Vivo', 'Vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0c76d7d-4abc-480e-bf1d-2975fe856ecc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d0c901a-b82a-4404-87b0-20619040e056', 8, NULL, 'Pesante', 'Pesante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 모음곡 <다섯 손가락>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d0c901a-b82a-4404-87b0-20619040e056'
);


-- K. 39 오페라 <마브라>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <마브라>', 'Mavra', 'song', 'K. 39', NULL, NULL, 1922, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <마브라>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37521976-5a02-3175-b33a-a92771507eb4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '37521976-5a02-3175-b33a-a92771507eb4'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '오페라 <마브라>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '37521976-5a02-3175-b33a-a92771507eb4'
);


-- K. 41 관악 8중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관악 8중주', 'Octet for Wind Instruments', 'album', 'K. 41', NULL, NULL, 1923, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관악 8중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b3a726b-e0da-4c5e-a7ce-1a59755925dc'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6b3a726b-e0da-4c5e-a7ce-1a59755925dc'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관악 8중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6b3a726b-e0da-4c5e-a7ce-1a59755925dc'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:177a2f4b-6a64-33db-81fd-0141e07e6f49', 1, 'I', '신포니아. Lento – Allegro moderato', 'I. Sinfonia. Lento – Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관악 8중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:177a2f4b-6a64-33db-81fd-0141e07e6f49'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:77a43491-aae4-30aa-92b0-99a975b96f34', 2, 'II', '주제와 변주. Andantino', 'II. Tema con variazioni. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관악 8중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:77a43491-aae4-30aa-92b0-99a975b96f34'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f0e539d-2dd1-37a0-925c-74f7f7220c39', 3, 'III', '피날레. Tempo giusto', 'III. Finale. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관악 8중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f0e539d-2dd1-37a0-925c-74f7f7220c39'
);


-- K. 42 피아노와 관악기를 위한 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관악기를 위한 협주곡', 'Concerto for Piano and Wind Instruments', 'album', 'K. 42', NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관악기를 위한 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f520bca-cb21-4d05-9701-6277281c1bbd'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2f520bca-cb21-4d05-9701-6277281c1bbd'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관악기를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2f520bca-cb21-4d05-9701-6277281c1bbd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25768f9f-fc8d-4cc3-86aa-7d3682d6ff93', 1, 'I', 'Largo – Allegro – Più mosso – Maestoso', 'I. Largo – Allegro – Più mosso – Maestoso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관악기를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25768f9f-fc8d-4cc3-86aa-7d3682d6ff93'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1c525a6b-36cf-42da-91e9-e1f3fd49b1ab', 2, 'II', 'Largo – L''istesso tempo ma poco rubato', 'II. Largo – L''istesso tempo ma poco rubato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관악기를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1c525a6b-36cf-42da-91e9-e1f3fd49b1ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e84559e7-aa16-4a70-a13c-610a535c3156', 3, 'III', 'Allegro – Tempo I – Agitato', 'III. Allegro – Tempo I – Agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관악기를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e84559e7-aa16-4a70-a13c-610a535c3156'
);


-- K. 43 피아노 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노 소나타', 'Piano Sonata', 'album', 'K. 43', NULL, NULL, 1924, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f127fe3c-4e3f-457a-9d32-13960995866e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f127fe3c-4e3f-457a-9d32-13960995866e'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f127fe3c-4e3f-457a-9d32-13960995866e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5031f532-5114-3768-802b-10c9d57af119', 1, 'I', '♩ = 112', 'I. ♩ = 112', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5031f532-5114-3768-802b-10c9d57af119'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c03f30c-733d-31a5-9740-6d5feac69396', 2, 'II', 'Adagietto', 'II. Adagietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c03f30c-733d-31a5-9740-6d5feac69396'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:261b664d-c625-33db-9396-e6d0b8170573', 3, 'III', '♩ = 112', 'III. ♩ = 112', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:261b664d-c625-33db-9396-e6d0b8170573'
);


-- K. 44 세레나데 A장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '세레나데 A장조', 'Serenade in A', 'album', 'K. 44', NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '세레나데 A장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21f107f8-a641-41bc-a6df-8b32dcb9edc5'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '21f107f8-a641-41bc-a6df-8b32dcb9edc5'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '세레나데 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '21f107f8-a641-41bc-a6df-8b32dcb9edc5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:48805c6c-976d-3fca-9f68-60414953b6df', 1, 'I', '찬가', 'I. Hymne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '세레나데 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:48805c6c-976d-3fca-9f68-60414953b6df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:02873ad8-5d3c-35b1-825f-7934eb1c5051', 2, 'II', '로망스', 'II. Romanza', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '세레나데 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:02873ad8-5d3c-35b1-825f-7934eb1c5051'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0497e10-908f-3d5a-a217-f28bc936dda2', 3, 'III', '론돌레토', 'III. Rondoletto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '세레나데 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0497e10-908f-3d5a-a217-f28bc936dda2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c1a8f2ea-803b-3d25-a3b6-0a11ad27d490', 4, 'IV', '카덴차 피날레', 'IV. Cadenza finala', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '세레나데 A장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1a8f2ea-803b-3d25-a3b6-0a11ad27d490'
);


-- None 소관현악을 위한 모음곡 1번

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '소관현악을 위한 모음곡 1번', 'Suite No. 1 for Small Orchestra', 'album', NULL, NULL, NULL, 1925, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '소관현악을 위한 모음곡 1번'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b28af63-3714-4e83-874c-c473c2eb2ef3'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '0b28af63-3714-4e83-874c-c473c2eb2ef3'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '0b28af63-3714-4e83-874c-c473c2eb2ef3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b1e9474-c52f-3ef7-bfba-825b455cc70b', 1, 'I', 'Andante', 'I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b1e9474-c52f-3ef7-bfba-825b455cc70b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f038e1be-3e17-3079-8477-148351cb1fad', 2, 'II', 'Napolitana', 'II. Napolitana', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f038e1be-3e17-3079-8477-148351cb1fad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:94df8f35-b057-384e-a3e2-0003cc764be8', 3, 'III', 'Española', 'III. Española', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:94df8f35-b057-384e-a3e2-0003cc764be8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2b02a51-b60d-3ec2-9afc-bc76495af533', 4, 'IV', 'Balalaika', 'IV. Balalaika', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '소관현악을 위한 모음곡 1번' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2b02a51-b60d-3ec2-9afc-bc76495af533'
);


-- K. 46 파테르 노스테르 (주기도문)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '파테르 노스테르 (주기도문)', 'Pater Noster', 'song', 'K. 46', NULL, NULL, 1926, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '파테르 노스테르 (주기도문)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '490cdf96-c02c-3e7f-975f-8ceb3cbdbbb7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '490cdf96-c02c-3e7f-975f-8ceb3cbdbbb7'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '파테르 노스테르 (주기도문)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '490cdf96-c02c-3e7f-975f-8ceb3cbdbbb7'
);


-- K. 47 오페라-오라토리오 <오이디푸스 왕>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라-오라토리오 <오이디푸스 왕>', 'Oedipus rex', 'song', 'K. 47', NULL, NULL, 1927, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라-오라토리오 <오이디푸스 왕>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '557a8887-1466-4c0c-95fb-0c7f5217779a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '557a8887-1466-4c0c-95fb-0c7f5217779a'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '오페라-오라토리오 <오이디푸스 왕>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '557a8887-1466-4c0c-95fb-0c7f5217779a'
);


-- K. 48 발레 <뮤즈를 이끄는 아폴론>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <뮤즈를 이끄는 아폴론>', 'Apollon musagète (Apollo)', 'song', 'K. 48', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <뮤즈를 이끄는 아폴론>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5778e65f-8177-415e-9fc8-7c7cede6e84c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5778e65f-8177-415e-9fc8-7c7cede6e84c'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 <뮤즈를 이끄는 아폴론>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5778e65f-8177-415e-9fc8-7c7cede6e84c'
);


-- K. 49 발레 <요정의 입맞춤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <요정의 입맞춤>', 'Le Baiser de la fée', 'song', 'K. 49', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <요정의 입맞춤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28144d53-bec4-43e9-84b5-a35914dcc941'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '28144d53-bec4-43e9-84b5-a35914dcc941'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 <요정의 입맞춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28144d53-bec4-43e9-84b5-a35914dcc941'
);


-- K. 49 디베르티멘토 <요정의 입맞춤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '디베르티멘토 <요정의 입맞춤>', 'Divertimento from Le Baiser de la fée', 'album', 'K. 49', NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '디베르티멘토 <요정의 입맞춤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '347cfbc1-6349-4fe7-9c04-eb224bf8d411'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '347cfbc1-6349-4fe7-9c04-eb224bf8d411'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '디베르티멘토 <요정의 입맞춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '347cfbc1-6349-4fe7-9c04-eb224bf8d411'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12ba10e7-a30c-4afd-8b47-dee91075a3be', 1, 'I', '신포니아. Andante – Vivace agitato', 'I. Sinfonia. Andante – Vivace agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '디베르티멘토 <요정의 입맞춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12ba10e7-a30c-4afd-8b47-dee91075a3be'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb0c55c4-19f5-438d-8bb0-b3e19920ed84', 2, 'II', 'Danses suisses. Tempo giusto – Valse – Poco più lento', 'II. Danses suisses. Tempo giusto – Valse – Poco più lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '디베르티멘토 <요정의 입맞춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb0c55c4-19f5-438d-8bb0-b3e19920ed84'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d5d6dff-4092-4abf-b6ca-9083b3bc4f30', 3, 'III', '스케르초. Moderato – Allegretto grazioso', 'III. Scherzo. Moderato – Allegretto grazioso', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '디베르티멘토 <요정의 입맞춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d5d6dff-4092-4abf-b6ca-9083b3bc4f30'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c794743-7e0a-4ec5-b3a2-ca45d3a1b291', 4, 'IV', 'Pas de deux. Adagio – Variation – Coda', 'IV. Pas de deux. Adagio – Variation – Coda', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '디베르티멘토 <요정의 입맞춤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c794743-7e0a-4ec5-b3a2-ca45d3a1b291'
);


-- K. 50 피아노와 관현악을 위한 카프리치오

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관현악을 위한 카프리치오', 'Capriccio for Piano and Orchestra', 'album', 'K. 50', NULL, NULL, 1929, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관현악을 위한 카프리치오'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '971920e5-cb70-4848-9cd6-a87d78ffc163'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '971920e5-cb70-4848-9cd6-a87d78ffc163'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '971920e5-cb70-4848-9cd6-a87d78ffc163'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13408a76-b436-438b-8146-67ed6d20d6f3', 1, 'I', 'Presto', 'I. Presto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13408a76-b436-438b-8146-67ed6d20d6f3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4baa35d4-0bda-4f4e-8fdb-2299db733377', 2, 'II', 'Andante rapsodico', 'II. Andante rapsodico', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4baa35d4-0bda-4f4e-8fdb-2299db733377'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7aea2c43-2e0f-499a-9380-89c09daf257a', 3, 'III', 'Allegro capriccioso ma tempo giusto', 'III. Allegro capriccioso ma tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 카프리치오' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7aea2c43-2e0f-499a-9380-89c09daf257a'
);


-- K. 51 관현악을 위한 4개의 연습곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 4개의 연습곡', 'Four Studies for Orchestra (Quatre études)', 'album', 'K. 51', NULL, NULL, 1928, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 4개의 연습곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '073336eb-cd63-403b-9d29-c118c818b564'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '073336eb-cd63-403b-9d29-c118c818b564'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관현악을 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '073336eb-cd63-403b-9d29-c118c818b564'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce597520-63e4-3f2b-b81e-cd4594553763', 1, NULL, 'Danse', 'Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관현악을 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce597520-63e4-3f2b-b81e-cd4594553763'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:627efcb9-efea-399a-a0ad-d8efac6f7cbe', 2, NULL, 'Excentrique', 'Excentrique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관현악을 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:627efcb9-efea-399a-a0ad-d8efac6f7cbe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:381f53e4-c22c-3cd6-9aab-66ac0745f8e3', 3, NULL, 'Cantique', 'Cantique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관현악을 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:381f53e4-c22c-3cd6-9aab-66ac0745f8e3'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7400a53b-6f1a-35cd-982e-253d4ef6ff09', 4, NULL, 'Madrid', 'Madrid', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관현악을 위한 4개의 연습곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7400a53b-6f1a-35cd-982e-253d4ef6ff09'
);


-- K. 52 시편 교향곡

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ec54673-8fe8-3a5c-b127-a110c1f5567a', 1, 'I', 'Exaudi orationem meam, Domine', 'I. Exaudi orationem meam, Domine (Psalm 39)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 312 AND p.composer_id = 81
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ec54673-8fe8-3a5c-b127-a110c1f5567a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:783e0c3d-85d9-39b5-9bbc-a4feae5d985a', 2, 'II', 'Expectans expectavi Dominum', 'II. Expectans expectavi Dominum (Psalm 40)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 312 AND p.composer_id = 81
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:783e0c3d-85d9-39b5-9bbc-a4feae5d985a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb47076d-3e7d-3294-ba32-eb111a112c90', 3, 'III', 'Alleluia, laudate Dominum', 'III. Alleluia, laudate Dominum (Psalm 150)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 312 AND p.composer_id = 81
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb47076d-3e7d-3294-ba32-eb111a112c90'
);


-- K. 53 바이올린 협주곡 D장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '바이올린 협주곡 D장조', 'Violin Concerto in D', 'album', 'K. 53', NULL, NULL, 1931, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '바이올린 협주곡 D장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53eb4c7c-a257-43f5-bef1-656abbbeaa3e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '53eb4c7c-a257-43f5-bef1-656abbbeaa3e'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '53eb4c7c-a257-43f5-bef1-656abbbeaa3e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:07b5d6f2-86e3-3c0e-88a4-2a03d4255896', 1, 'I', '토카타', 'I. Toccata', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:07b5d6f2-86e3-3c0e-88a4-2a03d4255896'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24c1a09d-0387-3ca6-8c41-438e1be12e61', 2, 'II', '아리아 I', 'II. Aria I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24c1a09d-0387-3ca6-8c41-438e1be12e61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35a8fc5a-73dd-3d0a-bfb6-1955c914b724', 3, 'III', '아리아 II', 'III. Aria II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35a8fc5a-73dd-3d0a-bfb6-1955c914b724'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88dd83e5-d026-3f99-8b08-d93f7fb89e6a', 4, 'IV', '카프리치오', 'IV. Capriccio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '바이올린 협주곡 D장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88dd83e5-d026-3f99-8b08-d93f7fb89e6a'
);


-- K. 54 협주적 2중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '협주적 2중주', 'Duo concertant', 'album', 'K. 54', NULL, NULL, 1932, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '협주적 2중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82c9d13b-ec6d-4e57-b625-ba43b18b9317'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '82c9d13b-ec6d-4e57-b625-ba43b18b9317'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '82c9d13b-ec6d-4e57-b625-ba43b18b9317'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:05dadaa0-59c0-36d8-ba91-5d54890f7865', 1, 'I', 'Cantilène', 'I. Cantilène', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:05dadaa0-59c0-36d8-ba91-5d54890f7865'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb8adf7-4a5d-3d43-bac6-4f5f78b02f06', 2, 'II', 'Eglogue I', 'II. Eglogue I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb8adf7-4a5d-3d43-bac6-4f5f78b02f06'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b3d6513-772e-3c47-8e71-026b59fdd267', 3, 'III', 'Eglogue II', 'III. Eglogue II', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b3d6513-772e-3c47-8e71-026b59fdd267'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3f5a27e-a139-3948-a17a-da51fada4640', 4, 'IV', '지그', 'IV. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3f5a27e-a139-3948-a17a-da51fada4640'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:304de6f8-5e02-3b6e-9c21-383938559fa5', 5, 'V', 'Dithyrambe', 'V. Dithyrambe', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 2중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304de6f8-5e02-3b6e-9c21-383938559fa5'
);


-- K. 55 크레도

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '크레도', 'Credo (Simvol'' very)', 'song', 'K. 55', NULL, NULL, 1932, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '크레도'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd99f4d79-5fb3-341c-a342-34701d7952da'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd99f4d79-5fb3-341c-a342-34701d7952da'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '크레도' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd99f4d79-5fb3-341c-a342-34701d7952da'
);


-- K. 56 멜로드라마 <페르세포네>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '멜로드라마 <페르세포네>', 'Perséphone', 'song', 'K. 56', NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '멜로드라마 <페르세포네>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9a60993-6e99-4c4b-9b71-5d33ad053b93'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd9a60993-6e99-4c4b-9b71-5d33ad053b93'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '멜로드라마 <페르세포네>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd9a60993-6e99-4c4b-9b71-5d33ad053b93'
);


-- K. 57 아베 마리아

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아베 마리아', 'Ave Maria (Bogoroditse Devo)', 'song', 'K. 57', NULL, NULL, 1934, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아베 마리아'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aaa7f21c-2ca8-4290-a350-e37c86a15564'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'aaa7f21c-2ca8-4290-a350-e37c86a15564'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '아베 마리아' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'aaa7f21c-2ca8-4290-a350-e37c86a15564'
);


-- K. 58 두 대의 피아노를 위한 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 협주곡', 'Concerto for Two Pianos', 'album', 'K. 58', NULL, NULL, 1935, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dc6a56e-63e8-4f22-99b2-70306e1c2d21'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '2dc6a56e-63e8-4f22-99b2-70306e1c2d21'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '2dc6a56e-63e8-4f22-99b2-70306e1c2d21'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d740d19-2767-3baf-b3a5-13dd80087bf5', 1, 'I', 'Con moto', 'I. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d740d19-2767-3baf-b3a5-13dd80087bf5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a24813eb-f61f-3f6a-ac61-7da5ca5ca9e5', 2, 'II', '녹턴. Adagietto', 'II. Notturno. Adagietto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a24813eb-f61f-3f6a-ac61-7da5ca5ca9e5'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d6ce722d-8c5b-3b0c-934a-1242e37a314b', 3, 'III', '4개의 변주', 'III. Quattro variazioni', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6ce722d-8c5b-3b0c-934a-1242e37a314b'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cdfda444-9400-3a42-a360-69870ed725a1', 4, 'IV', '전주곡과 푸가', 'IV. Preludio e fuga', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdfda444-9400-3a42-a360-69870ed725a1'
);


-- K. 59 발레 <카드 놀이>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <카드 놀이>', 'Jeu de cartes', 'song', 'K. 59', NULL, NULL, 1936, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <카드 놀이>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2fbf91c-f3a6-4667-a892-56d615f56e23'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd2fbf91c-f3a6-4667-a892-56d615f56e23'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 <카드 놀이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd2fbf91c-f3a6-4667-a892-56d615f56e23'
);


-- K. 82 재즈 앙상블을 위한 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '재즈 앙상블을 위한 전주곡', 'Preludium for Jazz Ensemble', 'song', 'K. 82', NULL, NULL, 1937, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '재즈 앙상블을 위한 전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3767217-eb47-3024-b00a-6509f2269b3f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3767217-eb47-3024-b00a-6509f2269b3f'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '재즈 앙상블을 위한 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3767217-eb47-3024-b00a-6509f2269b3f'
);


-- KN 24 성악곡 <Petit ramusianum harmonique>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '성악곡 <Petit ramusianum harmonique>', 'Petit ramusianum harmonique', 'song', 'KN 24', NULL, NULL, 1937, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '성악곡 <Petit ramusianum harmonique>'
);


-- K. 60 협주곡 E♭장조 "덤바턴 오크스"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '협주곡 E♭장조 "덤바턴 오크스"', 'Concerto in E♭ "Dumbarton Oaks"', 'album', 'K. 60', NULL, NULL, 1938, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '협주곡 E♭장조 "덤바턴 오크스"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b5ac331-e06c-4ab3-8c49-e8abb71c9b45'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '8b5ac331-e06c-4ab3-8c49-e8abb71c9b45'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주곡 E♭장조 "덤바턴 오크스"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '8b5ac331-e06c-4ab3-8c49-e8abb71c9b45'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:652c0279-da5b-395b-a38d-e1a9627fcd75', 1, 'I', 'Tempo giusto', 'I. Tempo giusto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주곡 E♭장조 "덤바턴 오크스"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:652c0279-da5b-395b-a38d-e1a9627fcd75'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bceca946-51a6-33bf-97ff-fb711ed80d3c', 2, 'II', 'Allegretto', 'II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주곡 E♭장조 "덤바턴 오크스"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bceca946-51a6-33bf-97ff-fb711ed80d3c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9197a82a-32c5-31a1-9b77-a5816d136ba2', 3, 'III', 'Con moto', 'III. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주곡 E♭장조 "덤바턴 오크스"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9197a82a-32c5-31a1-9b77-a5816d136ba2'
);


-- K. 61 교향곡 C장조

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '교향곡 C장조', 'Symphony in C', 'album', 'K. 61', NULL, NULL, 1940, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '교향곡 C장조'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5acb0fcc-1c85-4b0e-9d1f-eb0809593056'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5acb0fcc-1c85-4b0e-9d1f-eb0809593056'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5acb0fcc-1c85-4b0e-9d1f-eb0809593056'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d445d56-3a48-378f-a31a-543f9f0ed04e', 1, 'I', 'Moderato alla breve', 'I. Moderato alla breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d445d56-3a48-378f-a31a-543f9f0ed04e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:905dea02-8d58-3881-96aa-646d5027fbdb', 2, 'II', 'Larghetto concertante', 'II. Larghetto concertante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:905dea02-8d58-3881-96aa-646d5027fbdb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56a52490-1154-3a92-8c7b-2c30a6749ec1', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56a52490-1154-3a92-8c7b-2c30a6749ec1'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09a3f8a2-38a3-352f-a973-3c914594d93b', 4, 'IV', 'Largo – Tempo giusto, alla breve', 'IV. Largo – Tempo giusto, alla breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '교향곡 C장조' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09a3f8a2-38a3-352f-a973-3c914594d93b'
);


-- K. 62 탱고

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '탱고', 'Tango', 'song', 'K. 62', NULL, NULL, 1940, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '탱고'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '024369f5-90ca-3c1a-8b4d-a91bddf80da9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '024369f5-90ca-3c1a-8b4d-a91bddf80da9'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '탱고' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '024369f5-90ca-3c1a-8b4d-a91bddf80da9'
);


-- K. 63 협주적 무곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '협주적 무곡', 'Danses concertantes', 'album', 'K. 63', NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '협주적 무곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6ae803a-ee10-3f74-9f09-068a14129580'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a6ae803a-ee10-3f74-9f09-068a14129580'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a6ae803a-ee10-3f74-9f09-068a14129580'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f02385f-af87-450b-a403-c64b92046f44', 1, 'I', '행진곡 (서주)', 'I. Marche: Introduction', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f02385f-af87-450b-a403-c64b92046f44'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8058dc31-4577-4552-aaf9-69483c86172c', 2, 'II', 'Pas d''action', 'II. Pas d''action', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8058dc31-4577-4552-aaf9-69483c86172c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f08c3459-f956-46a8-9945-b483d0642555', 3, 'III', '주제와 변주', 'III. Thème varié', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f08c3459-f956-46a8-9945-b483d0642555'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a953a3ea-666c-454c-94cb-14c6abea856c', 4, 'IV', 'Pas de deux', 'IV. Pas de deux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a953a3ea-666c-454c-94cb-14c6abea856c'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68b6edca-e1d4-4651-a231-2f9979593fab', 5, 'V', '행진곡 (결말)', 'V. Marche: Conclusion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '협주적 무곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68b6edca-e1d4-4651-a231-2f9979593fab'
);


-- K. 64 서커스 폴카

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '서커스 폴카', 'Circus Polka "For a Young Elephant"', 'song', 'K. 64', NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '서커스 폴카'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '529e0f4d-c3f8-4051-a0ff-c693c6543791'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '529e0f4d-c3f8-4051-a0ff-c693c6543791'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '서커스 폴카' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '529e0f4d-c3f8-4051-a0ff-c693c6543791'
);


-- K. 65 4개의 노르웨이 무드

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 노르웨이 무드', 'Four Norwegian Moods', 'album', 'K. 65', NULL, NULL, 1942, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 노르웨이 무드'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad5b24e2-687b-4240-a15f-2cc2a345c2c4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ad5b24e2-687b-4240-a15f-2cc2a345c2c4'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 노르웨이 무드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ad5b24e2-687b-4240-a15f-2cc2a345c2c4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47fb5fdc-91e0-3282-b2ff-426f5691e8ae', 1, 'I', 'Intrada', 'I. Intrada', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 노르웨이 무드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47fb5fdc-91e0-3282-b2ff-426f5691e8ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f509f9-ffff-3a66-bd4c-696b893b2e9f', 2, 'II', 'Song', 'II. Song', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 노르웨이 무드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f509f9-ffff-3a66-bd4c-696b893b2e9f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:607a1635-43fc-3447-a995-042f0ebc2364', 3, 'III', 'Wedding Dance', 'III. Wedding Dance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 노르웨이 무드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:607a1635-43fc-3447-a995-042f0ebc2364'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2406542f-8d1e-3b93-a473-5fc6350d4510', 4, 'IV', 'Cortège', 'IV. Cortège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 노르웨이 무드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2406542f-8d1e-3b93-a473-5fc6350d4510'
);


-- K. 66 오드

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오드', 'Ode (Elegiacal Chant in Three Parts)', 'album', 'K. 66', NULL, NULL, 1943, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오드'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8d52ba3-d865-35db-b9fc-b3c2f0edfcd0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c8d52ba3-d865-35db-b9fc-b3c2f0edfcd0'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '오드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c8d52ba3-d865-35db-b9fc-b3c2f0edfcd0'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:509f5161-06ec-3e77-8112-7b15be059e65', 1, 'I', 'Eulogy', 'I. Eulogy', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '오드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:509f5161-06ec-3e77-8112-7b15be059e65'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3defdc02-6a39-367a-a502-aaeaa5e19352', 2, 'II', 'Eclogue', 'II. Eclogue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '오드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3defdc02-6a39-367a-a502-aaeaa5e19352'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8735d09e-55d8-3a3b-932a-24952b0b824b', 3, 'III', 'Epitaph', 'III. Epitaph', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '오드' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8735d09e-55d8-3a3b-932a-24952b0b824b'
);


-- K. 68 칸타타 <바벨>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타 <바벨>', 'Babel', 'song', 'K. 68', NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타 <바벨>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e19fdc4-d00a-3df9-9dda-a3f3adf61e0b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3e19fdc4-d00a-3df9-9dda-a3f3adf61e0b'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '칸타타 <바벨>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3e19fdc4-d00a-3df9-9dda-a3f3adf61e0b'
);


-- K. 70 러시아풍 스케르초

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '러시아풍 스케르초', 'Scherzo à la russe', 'song', 'K. 70', NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '러시아풍 스케르초'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '594841f7-8fae-49d1-bf7d-79df759df5c6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '594841f7-8fae-49d1-bf7d-79df759df5c6'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '러시아풍 스케르초' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '594841f7-8fae-49d1-bf7d-79df759df5c6'
);


-- K. 69 발레 <발레의 장면들>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <발레의 장면들>', 'Scènes de ballet', 'song', 'K. 69', NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <발레의 장면들>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c83864c-58b6-4a7c-b2f8-741f39201ac6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6c83864c-58b6-4a7c-b2f8-741f39201ac6'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 <발레의 장면들>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6c83864c-58b6-4a7c-b2f8-741f39201ac6'
);


-- K. 67 두 대의 피아노를 위한 소나타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '두 대의 피아노를 위한 소나타', 'Sonata for Two Pianos', 'album', 'K. 67', NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '두 대의 피아노를 위한 소나타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdf87faf-415e-4ee4-ac3c-8129815f34ab'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bdf87faf-415e-4ee4-ac3c-8129815f34ab'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bdf87faf-415e-4ee4-ac3c-8129815f34ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8047f6bd-e15d-338b-89fd-60fb83cfadad', 1, 'I', 'Moderato', 'I. Moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8047f6bd-e15d-338b-89fd-60fb83cfadad'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f710c364-a3d5-388c-a74c-4b5ecd8c5b59', 2, 'II', '주제와 변주', 'II. Theme with Variations', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f710c364-a3d5-388c-a74c-4b5ecd8c5b59'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bee2229-dadd-35f1-8676-5d374bfeb82f', 3, 'III', 'Allegretto', 'III. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '두 대의 피아노를 위한 소나타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bee2229-dadd-35f1-8676-5d374bfeb82f'
);


-- K. 72 비올라 독주를 위한 엘레지

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '비올라 독주를 위한 엘레지', 'Elegy for Solo Viola', 'song', 'K. 72', NULL, NULL, 1944, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '비올라 독주를 위한 엘레지'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7450b1b6-fcfd-4091-bf9f-8c978ab200e9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7450b1b6-fcfd-4091-bf9f-8c978ab200e9'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '비올라 독주를 위한 엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7450b1b6-fcfd-4091-bf9f-8c978ab200e9'
);


-- K. 73 3악장의 교향곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '3악장의 교향곡', 'Symphony in Three Movements', 'album', 'K. 73', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '3악장의 교향곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b76cf77-d701-4e42-b953-c69c225bdc94'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '5b76cf77-d701-4e42-b953-c69c225bdc94'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3악장의 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '5b76cf77-d701-4e42-b953-c69c225bdc94'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dea70093-a1d9-39fe-9d13-9fac8ccd215f', 1, 'I', '서곡. Allegro', 'I. Overture. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3악장의 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dea70093-a1d9-39fe-9d13-9fac8ccd215f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:189aa21a-f3b4-3fa7-bef5-17999e85839d', 2, 'II', 'Andante – 간주곡. L''istesso tempo', 'II. Andante – Interlude. L''istesso tempo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3악장의 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:189aa21a-f3b4-3fa7-bef5-17999e85839d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff057442-c7c5-3a8a-8cb3-496b6c824fd9', 3, 'III', 'Con moto', 'III. Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '3악장의 교향곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff057442-c7c5-3a8a-8cb3-496b6c824fd9'
);


-- K. 74 에보니 협주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에보니 협주곡', 'Ebony Concerto', 'album', 'K. 74', NULL, NULL, 1945, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에보니 협주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea1a9884-c10b-4c31-9006-e1e60669e650'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ea1a9884-c10b-4c31-9006-e1e60669e650'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '에보니 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ea1a9884-c10b-4c31-9006-e1e60669e650'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5c7315e-b3ad-362c-a122-bfcc92c587b9', 1, 'I', 'Allegro moderato', 'I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '에보니 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5c7315e-b3ad-362c-a122-bfcc92c587b9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d57f458f-7f31-3264-bf85-61ed683c7843', 2, 'II', 'Andante', 'II. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '에보니 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d57f458f-7f31-3264-bf85-61ed683c7843'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97c08770-e061-3a26-bb82-31e7f2fd2efe', 3, 'III', 'Moderato – Con moto', 'III. Moderato – Con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '에보니 협주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97c08770-e061-3a26-bb82-31e7f2fd2efe'
);


-- K. 75 현악 합주를 위한 협주곡 D장조 "바젤"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '현악 합주를 위한 협주곡 D장조 "바젤"', 'Concerto in D "Basle"', 'album', 'K. 75', NULL, NULL, 1946, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '현악 합주를 위한 협주곡 D장조 "바젤"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3073e61f-7b6b-4987-b79e-20abe154cef2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '3073e61f-7b6b-4987-b79e-20abe154cef2'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 합주를 위한 협주곡 D장조 "바젤"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '3073e61f-7b6b-4987-b79e-20abe154cef2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7de4e762-4093-3be7-ab51-bda3ea96c689', 1, 'I', 'Vivace', 'I. Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 합주를 위한 협주곡 D장조 "바젤"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7de4e762-4093-3be7-ab51-bda3ea96c689'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cab7268a-ea35-32d9-8aef-9615daaeeafd', 2, 'II', '아리오소. Andantino', 'II. Arioso. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 합주를 위한 협주곡 D장조 "바젤"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cab7268a-ea35-32d9-8aef-9615daaeeafd'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5aedee2a-5431-3680-b8ac-b6890bcf3760', 3, 'III', '론도. Allegro', 'III. Rondo. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '현악 합주를 위한 협주곡 D장조 "바젤"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5aedee2a-5431-3680-b8ac-b6890bcf3760'
);


-- K. 71 작은 카논

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '작은 카논', 'Little Canon', 'song', 'K. 71', NULL, NULL, 1947, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '작은 카논'
);


-- K. 76 발레 <오르페우스>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <오르페우스>', 'Orpheus', 'song', 'K. 76', NULL, NULL, 1947, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <오르페우스>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3c0e54e-99cd-43c1-9399-4097592b364d'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c3c0e54e-99cd-43c1-9399-4097592b364d'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 <오르페우스>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c3c0e54e-99cd-43c1-9399-4097592b364d'
);


-- K. 77 미사

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '미사', 'Mass', 'album', 'K. 77', NULL, NULL, 1948, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '미사'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '448d0cd3-1e1d-4b8c-b705-0205b1aa2811'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '448d0cd3-1e1d-4b8c-b705-0205b1aa2811'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '448d0cd3-1e1d-4b8c-b705-0205b1aa2811'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f5f27d5-6905-3a17-ac95-c1d78fba53d6', 1, 'I', '키리에', 'I. Kyrie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f5f27d5-6905-3a17-ac95-c1d78fba53d6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e99afd3d-ae7c-3aef-b3a3-6df7baa57c03', 2, 'II', '글로리아', 'II. Gloria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e99afd3d-ae7c-3aef-b3a3-6df7baa57c03'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58006fe8-321b-3b25-b49b-466bcde5f8ae', 3, 'III', '크레도', 'III. Credo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58006fe8-321b-3b25-b49b-466bcde5f8ae'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aee96bd2-4925-3173-a6df-eb7446e015df', 4, 'IV', '상투스', 'IV. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aee96bd2-4925-3173-a6df-eb7446e015df'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67663b05-32ad-3217-b1fa-511bf1e50471', 5, 'V', '아뉴스 데이', 'V. Agnus Dei', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '미사' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67663b05-32ad-3217-b1fa-511bf1e50471'
);


-- K. 78 오페라 <탕아의 편력>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '오페라 <탕아의 편력>', 'The Rake''s Progress', 'song', 'K. 78', NULL, NULL, 1951, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '오페라 <탕아의 편력>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f76497a-4555-49aa-b92b-7d8e201464d8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9f76497a-4555-49aa-b92b-7d8e201464d8'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '오페라 <탕아의 편력>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9f76497a-4555-49aa-b92b-7d8e201464d8'
);


-- K. 79 칸타타

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸타타', 'Cantata', 'song', 'K. 79', NULL, NULL, 1952, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸타타'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5a165fd-5a70-4d14-b3ef-7b0d848f9d3b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'c5a165fd-5a70-4d14-b3ef-7b0d848f9d3b'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '칸타타' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'c5a165fd-5a70-4d14-b3ef-7b0d848f9d3b'
);


-- K. 80 7중주

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '7중주', 'Septet', 'album', 'K. 80', NULL, NULL, 1953, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '7중주'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34d53435-626f-4324-b22e-b240d05c0086'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '34d53435-626f-4324-b22e-b240d05c0086'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '7중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '34d53435-626f-4324-b22e-b240d05c0086'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcdc032b-f884-315f-b1e9-13e98d6c4002', 1, 'I', '♩ = 88', 'I. ♩ = 88', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '7중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcdc032b-f884-315f-b1e9-13e98d6c4002'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:140f6176-1b86-3513-8b4c-9666a6dd80cb', 2, 'II', '파사칼리아', 'II. Passacaglia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '7중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:140f6176-1b86-3513-8b4c-9666a6dd80cb'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e81f01e1-50cc-3d8d-b0b6-36081ee3b1ec', 3, 'III', '지그', 'III. Gigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '7중주' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e81f01e1-50cc-3d8d-b0b6-36081ee3b1ec'
);


-- K. 81 셰익스피어의 시에 의한 3개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '셰익스피어의 시에 의한 3개의 가곡', 'Three Songs from William Shakespeare', 'album', 'K. 81', NULL, NULL, 1953, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '셰익스피어의 시에 의한 3개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'faee1512-5f48-4cea-9439-7f72681368b4'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'faee1512-5f48-4cea-9439-7f72681368b4'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '셰익스피어의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'faee1512-5f48-4cea-9439-7f72681368b4'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75b4c746-5a3c-3d70-a6a8-83c249706a86', 1, NULL, 'Music to hear', 'Music to hear', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '셰익스피어의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75b4c746-5a3c-3d70-a6a8-83c249706a86'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0de06dc6-a65b-3688-a58a-8e54674ab975', 2, NULL, 'Full fathom five', 'Full fathom five', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '셰익스피어의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0de06dc6-a65b-3688-a58a-8e54674ab975'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9211661d-bac3-3fc8-8fa4-f30ff10c1b59', 3, NULL, 'When daisies pied', 'When daisies pied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '셰익스피어의 시에 의한 3개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9211661d-bac3-3fc8-8fa4-f30ff10c1b59'
);


-- None 4개의 가곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '4개의 가곡', 'Four Songs for Voice, Flute, Harp and Guitar', 'album', NULL, NULL, NULL, 1954, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '4개의 가곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b44327b-50e1-4e19-83f6-296e4c153d09'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '9b44327b-50e1-4e19-83f6-296e4c153d09'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '9b44327b-50e1-4e19-83f6-296e4c153d09'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b17ab3f1-1108-3d9b-b4de-66812a22010d', 1, NULL, 'Selezen''', 'Selezen'' (The Drake)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b17ab3f1-1108-3d9b-b4de-66812a22010d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00c10ea6-a817-3092-8fd5-86c881b56a4a', 2, NULL, 'Sektantskaya', 'Sektantskaya (A Russian Spiritual)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00c10ea6-a817-3092-8fd5-86c881b56a4a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:21ff7c4d-9b3c-306c-81fb-f6f3f9cd4a61', 3, NULL, 'Gusi, lebedi', 'Gusi, lebedi (Geese and Swans)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:21ff7c4d-9b3c-306c-81fb-f6f3f9cd4a61'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7320f13d-1b8c-38a4-9f5c-f34d808c7efb', 4, NULL, 'Tilim-bom', 'Tilim-bom', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '4개의 가곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7320f13d-1b8c-38a4-9f5c-f34d808c7efb'
);


-- K. 84 딜런 토머스를 추모하며

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '딜런 토머스를 추모하며', 'In Memoriam Dylan Thomas', 'album', 'K. 84', NULL, NULL, 1954, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '딜런 토머스를 추모하며'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42d022c8-6183-4998-98a2-4bb405a258b2'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '42d022c8-6183-4998-98a2-4bb405a258b2'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '딜런 토머스를 추모하며' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '42d022c8-6183-4998-98a2-4bb405a258b2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:39279a42-cc31-30cb-aed9-aa5a76ef2ce7', 1, 'I', 'Dirge-Canons (Prelude)', 'I. Dirge-Canons (Prelude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '딜런 토머스를 추모하며' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:39279a42-cc31-30cb-aed9-aa5a76ef2ce7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:018f8ecf-2201-38a1-a2b6-b3f2e984fbf9', 2, 'II', 'Do not go gentle into that good night', 'II. Do not go gentle into that good night', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '딜런 토머스를 추모하며' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:018f8ecf-2201-38a1-a2b6-b3f2e984fbf9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14a7801e-a455-3c3e-839f-48d7208b2f54', 3, 'III', 'Dirge-Canons (Postlude)', 'III. Dirge-Canons (Postlude)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '딜런 토머스를 추모하며' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14a7801e-a455-3c3e-839f-48d7208b2f54'
);


-- K. 85 축하 전주곡

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '축하 전주곡', 'Greeting Prelude', 'song', 'K. 85', NULL, NULL, 1955, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '축하 전주곡'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29529026-cedd-3032-9e40-65d506dc0418'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '29529026-cedd-3032-9e40-65d506dc0418'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '축하 전주곡' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '29529026-cedd-3032-9e40-65d506dc0418'
);


-- K. 86 칸티쿰 사크룸

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '칸티쿰 사크룸', 'Canticum Sacrum ad honorem Sancti Marci nominis', 'song', 'K. 86', NULL, NULL, 1955, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '칸티쿰 사크룸'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66cc5ca7-c0ac-419c-9042-4b3609d88f6f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '66cc5ca7-c0ac-419c-9042-4b3609d88f6f'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '칸티쿰 사크룸' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '66cc5ca7-c0ac-419c-9042-4b3609d88f6f'
);


-- K. 88 발레 <아곤>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '발레 <아곤>', 'Agon', 'song', 'K. 88', NULL, NULL, 1957, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '발레 <아곤>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44ee7b2b-77ce-4048-b452-776cdbf2a79b'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '44ee7b2b-77ce-4048-b452-776cdbf2a79b'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '발레 <아곤>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '44ee7b2b-77ce-4048-b452-776cdbf2a79b'
);


-- K. 89 트레니 (예레미야 애가)

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '트레니 (예레미야 애가)', 'Threni: id est Lamentationes Jeremiae Prophetae', 'song', 'K. 89', NULL, NULL, 1958, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '트레니 (예레미야 애가)'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28cfaa9d-7f7a-404f-8f51-d134df0000a9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '28cfaa9d-7f7a-404f-8f51-d134df0000a9'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '트레니 (예레미야 애가)' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '28cfaa9d-7f7a-404f-8f51-d134df0000a9'
);


-- K. 91 피아노와 관현악을 위한 무브먼츠

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '피아노와 관현악을 위한 무브먼츠', 'Movements for Piano and Orchestra', 'album', 'K. 91', NULL, NULL, 1959, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '피아노와 관현악을 위한 무브먼츠'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5c78896-63ca-43d3-946d-2b216d559f73'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'f5c78896-63ca-43d3-946d-2b216d559f73'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 무브먼츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'f5c78896-63ca-43d3-946d-2b216d559f73'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b2d86c8f-8a0c-3bd5-8a18-e6b0961bb72e', 1, 'I', '♪ = 110', 'I. ♪ = 110', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 무브먼츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2d86c8f-8a0c-3bd5-8a18-e6b0961bb72e'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28e2b04f-aa5a-3fb3-be2c-72fd8667b76d', 2, 'II', '♩ = 52', 'II. ♩ = 52', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 무브먼츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28e2b04f-aa5a-3fb3-be2c-72fd8667b76d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d421abf2-3c26-30ad-925f-9b7f6130d5c6', 3, 'III', '♪ = 72', 'III. ♪ = 72', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 무브먼츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d421abf2-3c26-30ad-925f-9b7f6130d5c6'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f73a6538-77a3-350c-9a48-f3203092b2a9', 4, 'IV', '♪ = 80', 'IV. ♪ = 80', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 무브먼츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f73a6538-77a3-350c-9a48-f3203092b2a9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8671eff9-47e4-38c2-8fcc-ae0af582a471', 5, 'V', '♪ = 104', 'V. ♪ = 104', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '피아노와 관현악을 위한 무브먼츠' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8671eff9-47e4-38c2-8fcc-ae0af582a471'
);


-- K. 90 에피타피움

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '에피타피움', 'Epitaphium für das Grabmal des Prinzen Max Egon zu Fürstenberg', 'song', 'K. 90', NULL, NULL, 1959, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '에피타피움'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b659ceb4-f4bf-4f50-b8f8-b5aa2b5ff48c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'b659ceb4-f4bf-4f50-b8f8-b5aa2b5ff48c'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '에피타피움' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'b659ceb4-f4bf-4f50-b8f8-b5aa2b5ff48c'
);


-- K. 92 이중 카논 "라울 뒤피를 추모하며"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '이중 카논 "라울 뒤피를 추모하며"', 'Double Canon "Raoul Dufy in Memoriam"', 'song', 'K. 92', NULL, NULL, 1959, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '이중 카논 "라울 뒤피를 추모하며"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32fb4a18-a9c3-3745-8507-f5846c4c0ebe'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '32fb4a18-a9c3-3745-8507-f5846c4c0ebe'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '이중 카논 "라울 뒤피를 추모하며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '32fb4a18-a9c3-3745-8507-f5846c4c0ebe'
);


-- K. 95 설교, 이야기, 기도

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '설교, 이야기, 기도', 'A Sermon, a Narrative and a Prayer', 'song', 'K. 95', NULL, NULL, 1961, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '설교, 이야기, 기도'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27ff940c-6fde-4c54-856e-17116859b9b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '27ff940c-6fde-4c54-856e-17116859b9b9'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '설교, 이야기, 기도' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '27ff940c-6fde-4c54-856e-17116859b9b9'
);


-- K. 96 앤섬 "The Dove Descending Breaks the Air"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '앤섬 "The Dove Descending Breaks the Air"', 'Anthem "The Dove Descending Breaks the Air"', 'song', 'K. 96', NULL, NULL, 1962, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '앤섬 "The Dove Descending Breaks the Air"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a64b370a-b7b4-49bd-9ab9-be6b7671fb0e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a64b370a-b7b4-49bd-9ab9-be6b7671fb0e'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '앤섬 "The Dove Descending Breaks the Air"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a64b370a-b7b4-49bd-9ab9-be6b7671fb0e'
);


-- None 8개의 기악 미니어처

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '8개의 기악 미니어처', 'Eight Instrumental Miniatures', 'album', NULL, NULL, NULL, 1962, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '8개의 기악 미니어처'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc086edd-2192-4f5f-bddf-f43c1609cbba'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'dc086edd-2192-4f5f-bddf-f43c1609cbba'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'dc086edd-2192-4f5f-bddf-f43c1609cbba'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5e17183-3e6e-324f-b063-0e0b333d644f', 1, NULL, 'Andantino', 'Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5e17183-3e6e-324f-b063-0e0b333d644f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e33eb1df-e3cb-37f8-954f-2be33a070705', 2, NULL, 'Vivace', 'Vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e33eb1df-e3cb-37f8-954f-2be33a070705'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6402bdf0-ced0-33ae-bbab-b37bf55872a2', 3, NULL, 'Lento', 'Lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6402bdf0-ced0-33ae-bbab-b37bf55872a2'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a23f745-398e-3aae-9cc9-15a675fd9567', 4, NULL, 'Allegretto', 'Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a23f745-398e-3aae-9cc9-15a675fd9567'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a829e7e8-d173-39cd-ab76-a82cd5b8276d', 5, NULL, 'Moderato alla breve', 'Moderato alla breve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a829e7e8-d173-39cd-ab76-a82cd5b8276d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9fef44a7-d9d7-352c-a31b-3c270130b8fe', 6, NULL, 'Tempo di marcia', 'Tempo di marcia', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fef44a7-d9d7-352c-a31b-3c270130b8fe'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:24c482f1-f5fe-33cf-a393-e0bfad78de68', 7, NULL, 'Larghetto', 'Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:24c482f1-f5fe-33cf-a393-e0bfad78de68'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0a8e4582-b90b-3e02-8afb-2a01f6e6f47d', 8, NULL, 'Tempo di tango', 'Tempo di tango', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '8개의 기악 미니어처' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0a8e4582-b90b-3e02-8afb-2a01f6e6f47d'
);


-- K. 98 음악극 <대홍수>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '음악극 <대홍수>', 'The Flood', 'song', 'K. 98', NULL, NULL, 1962, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '음악극 <대홍수>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd378f9fb-d8e8-4b81-ab8a-0318e2c62e4a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'd378f9fb-d8e8-4b81-ab8a-0318e2c62e4a'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '음악극 <대홍수>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'd378f9fb-d8e8-4b81-ab8a-0318e2c62e4a'
);


-- K. 101 아브라함과 이삭

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '아브라함과 이삭', 'Abraham and Isaac', 'song', 'K. 101', NULL, NULL, 1963, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '아브라함과 이삭'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '540e3c4e-75fe-3659-a738-eaf785f1de12'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '540e3c4e-75fe-3659-a738-eaf785f1de12'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '아브라함과 이삭' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '540e3c4e-75fe-3659-a738-eaf785f1de12'
);


-- K. 100 J. F. K.를 위한 엘레지

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'J. F. K.를 위한 엘레지', 'Elegy for J.F.K.', 'song', 'K. 100', NULL, NULL, 1964, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'J. F. K.를 위한 엘레지'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6bf19490-41c2-3949-a6a7-3dff74cd6826'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '6bf19490-41c2-3949-a6a7-3dff74cd6826'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = 'J. F. K.를 위한 엘레지' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '6bf19490-41c2-3949-a6a7-3dff74cd6826'
);


-- K. 102 새 극장을 위한 팡파르

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '새 극장을 위한 팡파르', 'Fanfare for a New Theatre', 'song', 'K. 102', NULL, NULL, 1964, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '새 극장을 위한 팡파르'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbd78964-204a-40a7-8865-322cf12bbf0a'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bbd78964-204a-40a7-8865-322cf12bbf0a'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '새 극장을 위한 팡파르' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bbd78964-204a-40a7-8865-322cf12bbf0a'
);


-- K. 103 관현악을 위한 변주곡 "올더스 헉슬리를 추모하며"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '관현악을 위한 변주곡 "올더스 헉슬리를 추모하며"', 'Variations "Aldous Huxley in Memoriam"', 'song', 'K. 103', NULL, NULL, 1964, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '관현악을 위한 변주곡 "올더스 헉슬리를 추모하며"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43b0bdd6-90e4-3e6e-8320-d18741169301'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '43b0bdd6-90e4-3e6e-8320-d18741169301'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '관현악을 위한 변주곡 "올더스 헉슬리를 추모하며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '43b0bdd6-90e4-3e6e-8320-d18741169301'
);


-- K. 104 인트로이투스 "T. S. 엘리엇을 추모하며"

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '인트로이투스 "T. S. 엘리엇을 추모하며"', 'Introitus "T. S. Eliot in Memoriam"', 'song', 'K. 104', NULL, NULL, 1965, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '인트로이투스 "T. S. 엘리엇을 추모하며"'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc39269f-6d75-3373-80b7-693a09715e2e'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'bc39269f-6d75-3373-80b7-693a09715e2e'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '인트로이투스 "T. S. 엘리엇을 추모하며"' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'bc39269f-6d75-3373-80b7-693a09715e2e'
);


-- None 러시아 민요에 의한 카논

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '러시아 민요에 의한 카논', 'Canon on a Russian Popular Tune', 'song', NULL, NULL, NULL, 1965, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '러시아 민요에 의한 카논'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88fb4059-2281-4421-a9c8-70691e1e07c0'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '88fb4059-2281-4421-a9c8-70691e1e07c0'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '러시아 민요에 의한 카논' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '88fb4059-2281-4421-a9c8-70691e1e07c0'
);


-- K. 106 레퀴엠 칸티클스

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '레퀴엠 칸티클스', 'Requiem Canticles', 'album', 'K. 106', NULL, NULL, 1966, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '레퀴엠 칸티클스'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '108d5925-e86b-4cd8-951c-8b605cb6dcf7'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '108d5925-e86b-4cd8-951c-8b605cb6dcf7'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '108d5925-e86b-4cd8-951c-8b605cb6dcf7'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae50542f-e153-3da5-98cb-9b4c95082c85', 1, 'I', '전주곡', 'I. Prelude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae50542f-e153-3da5-98cb-9b4c95082c85'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:763ccac2-a53a-34af-9540-9dd7f6af478f', 2, 'II', 'Exaudi', 'II. Exaudi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:763ccac2-a53a-34af-9540-9dd7f6af478f'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7a5ff57-5a5b-316b-a087-f14915c4fe24', 3, 'III', 'Dies irae', 'III. Dies irae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7a5ff57-5a5b-316b-a087-f14915c4fe24'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d47cc193-ba1b-3946-9bb9-1d1469122901', 4, 'IV', 'Tuba mirum', 'IV. Tuba mirum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d47cc193-ba1b-3946-9bb9-1d1469122901'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d376d256-9aad-3952-9501-776fb8ca0856', 5, 'V', '간주곡', 'V. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d376d256-9aad-3952-9501-776fb8ca0856'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e9ee20e2-87d8-37fe-ad8b-299d42487e77', 6, 'VI', 'Rex tremendae', 'VI. Rex tremendae', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e9ee20e2-87d8-37fe-ad8b-299d42487e77'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3887fd5-639d-36fa-bec2-ddb96ba64474', 7, 'VII', 'Lacrimosa', 'VII. Lacrimosa', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3887fd5-639d-36fa-bec2-ddb96ba64474'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9d6e5ac4-dd8d-34f4-bd8a-ba05d52e78ab', 8, 'VIII', 'Libera me', 'VIII. Libera me', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9d6e5ac4-dd8d-34f4-bd8a-ba05d52e78ab'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09689f5e-43d3-3c50-8ea3-59dc56ad8ee5', 9, 'IX', '후주곡', 'IX. Postlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '레퀴엠 칸티클스' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09689f5e-43d3-3c50-8ea3-59dc56ad8ee5'
);


-- K. 107 가곡 <올빼미와 고양이>

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, '가곡 <올빼미와 고양이>', 'The Owl and the Pussy-Cat', 'song', 'K. 107', NULL, NULL, 1966, 'manual', 1
FROM composers c
WHERE c.id = 81
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = '가곡 <올빼미와 고양이>'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a28806b9-265a-382e-adfa-8a49ff1f3cb6'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'a28806b9-265a-382e-adfa-8a49ff1f3cb6'
FROM pieces p
WHERE p.composer_id = 81 AND p.title = '가곡 <올빼미와 고양이>' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'a28806b9-265a-382e-adfa-8a49ff1f3cb6'
);


-- 312 「시편 교향곡」은 위키백과 K 표에서 K. 52 다. K. 51 은 이번에 들어가는 <관현악을 위한 4개의 연습곡>이다.
UPDATE pieces piece
SET piece.opus_number = 'K. 52'
WHERE piece.id = 312 AND piece.composer_id = 81 AND piece.opus_number = 'K. 51';
